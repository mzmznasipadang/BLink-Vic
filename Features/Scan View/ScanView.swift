//
//  ScanView.swift
//  BLink-Vic
//
//  Created by Victor Chandra on 07/05/25.
//

import Foundation

import SwiftUI
import AVFoundation
import Vision
import VisionKit
import CoreImage
import SwiftData

struct ScanView: View {
    @State private var recognizedPlate: String?
    @State private var showScanResult = false
    @State private var isCameraAuthorized = false
    @State private var capturedImage: CVPixelBuffer?
    @State private var isPlateDetected = false
    @State private var isProcessing = false
    @State private var detectedPlateText = ""
    @State private var scanFrameRect = CGRect(x: 0, y: 0, width: 250, height: 150)
    @Environment(\.modelContext) private var modelContext
    @State private var matchedRoute: RouteModel? = nil

    var body: some View {
        ZStack {
            CameraView(
                recognizedPlate: $recognizedPlate,
                showScanResult: $showScanResult,
                capturedImage: $capturedImage,
                isPlateDetected: $isPlateDetected,
                detectedPlateText: $detectedPlateText,
                scanFrameRect: $scanFrameRect,
                manualCapture: false,
                matchedRoute: $matchedRoute
            )
            .ignoresSafeArea()

            VStack {
                Spacer()
                VStack(spacing: 12) {
                    if isPlateDetected {
                        Text("Detected Plate: \(detectedPlateText)")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(10)
                    } else {
                        Text("Scanning...")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black.opacity(0.5))
                            .cornerRadius(8)
                    }

                    if showScanResult {
                        if let route = matchedRoute {
//                            NavigationLink(destination: RouteResultView(
//                                viewModel: RouteResultViewModel(
//                                    route: route,
//                                    startLocation: MKMapItem.forCurrentLocation(),
//                                    destination: nil
//                                )
//                            )) {
                            Text("View Result")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
//                            }
                        }
                    }
                }
                .padding(.bottom, 40)
            }
            .padding()
        }
    }
}

// MARK: - CameraView (Copied from HomeView.swift)
struct CameraView: UIViewRepresentable {
    @Binding var recognizedPlate: String?
    @Binding var showScanResult: Bool
    @Binding var capturedImage: CVPixelBuffer?
    @Binding var isPlateDetected: Bool
    @Binding var detectedPlateText: String
    @Binding var scanFrameRect: CGRect
    var manualCapture: Bool
    @Binding var matchedRoute: RouteModel?

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        context.coordinator.setupCamera(in: view)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Update camera configuration if needed
        context.coordinator.updateScanFrame(scanFrameRect)
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(
            recognizedPlate: $recognizedPlate,
            showScanResult: $showScanResult,
            capturedImage: $capturedImage,
            isPlateDetected: $isPlateDetected,
            detectedPlateText: $detectedPlateText,
            scanFrameRect: $scanFrameRect,
            manualCapture: manualCapture,
            matchedRoute: $matchedRoute
        )
    }

    class Coordinator: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
        @Binding var recognizedPlate: String?
        @Binding var showScanResult: Bool
        @Binding var capturedImage: CVPixelBuffer?
        @Binding var isPlateDetected: Bool
        @Binding var detectedPlateText: String
        @Binding var scanFrameRect: CGRect
        var manualCapture: Bool
        @Binding var matchedRoute: RouteModel?

        private var captureSession: AVCaptureSession?
        private var previewLayer: AVCaptureVideoPreviewLayer?
        private var lastObservationTimestamp: TimeInterval = 0

        init(
            recognizedPlate: Binding<String?>,
            showScanResult: Binding<Bool>,
            capturedImage: Binding<CVPixelBuffer?>,
            isPlateDetected: Binding<Bool>,
            detectedPlateText: Binding<String>,
            scanFrameRect: Binding<CGRect>,
            manualCapture: Bool,
            matchedRoute: Binding<RouteModel?>
        ) {
            _recognizedPlate = recognizedPlate
            _showScanResult = showScanResult
            _capturedImage = capturedImage
            _isPlateDetected = isPlateDetected
            _detectedPlateText = detectedPlateText
            _scanFrameRect = scanFrameRect
            self.manualCapture = manualCapture
            _matchedRoute = matchedRoute
        }

        func setupCamera(in view: UIView) {
            let session = AVCaptureSession()
            session.sessionPreset = .high
            guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
                  let videoInput = try? AVCaptureDeviceInput(device: videoDevice) else {
                return
            }
            if session.canAddInput(videoInput) {
                session.addInput(videoInput)
            }
            let videoOutput = AVCaptureVideoDataOutput()
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "CameraBufferQueue"))
            if session.canAddOutput(videoOutput) {
                session.addOutput(videoOutput)
            }
            let previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.videoGravity = .resizeAspectFill
            previewLayer.frame = view.bounds
            view.layer.addSublayer(previewLayer)
            self.captureSession = session
            self.previewLayer = previewLayer
            session.startRunning()
        }

        func updateScanFrame(_ rect: CGRect) {
            // Optionally adjust scanning area
        }

        func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
            guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
            
            let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            let request = VNRecognizeTextRequest { [weak self] request, error in
                guard let self = self else { return }
                if let results = request.results as? [VNRecognizedTextObservation], let topResult = results.first,
                   let candidate = topResult.topCandidates(1).first {
                    DispatchQueue.main.async {
                        self.detectedPlateText = candidate.string
                        self.recognizedPlate = candidate.string
                        self.isPlateDetected = true
                        self.showScanResult = true
                        self.capturedImage = pixelBuffer
                        Task {
                            await self.matchRoute(for: candidate.string)
                        }
                    }
                }
            }
            request.recognitionLevel = .accurate
            request.usesLanguageCorrection = false

            do {
                try requestHandler.perform([request])
            } catch {
                print("Vision request error: \(error)")
            }
        }

        @MainActor
        func matchRoute(for plate: String) async {
            guard let context = try? await SwiftDataContext.current else { return }
            let busFetch = FetchDescriptor<BusInfo>(predicate: #Predicate { $0.plateNumber == plate })
            if let match = try? context.fetch(busFetch).first {
                let routeFetch = FetchDescriptor<RouteModel>(predicate: #Predicate { $0.routeCode == match.routeCode })
                if let route = try? context.fetch(routeFetch).first {
                    self.matchedRoute = route
                }
            }
        }
    }
}

@MainActor
enum SwiftDataContext {
    static var current: ModelContext? {
        try? ModelContainer(for: RouteModel.self, BusInfo.self).mainContext
    }
}

#if DEBUG
struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
#endif
