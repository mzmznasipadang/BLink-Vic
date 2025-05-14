//
//  DataSeeder.swift
//  BLink
//
//  Created by reynaldo on 27/03/25.
//

import Foundation
import SwiftData
import CoreLocation

class DataSeeder {
   static func seedInitialData(modelContext: ModelContext) {
    print("Starting data seeding...")
    
    // Station Coordinates
    let stationCoordinates: [String: (Double, Double)?] = [
    "The Breeze": (-6.3012904, 106.6533863),
    "CBD Timur 1": (-6.30352, 106.65011),
    "CBD Selatan": (-6.3004279, 106.6433561),
    "AEON Mall 1": (-6.3052093, 106.6432014),
    "AEON Mall 2": (-6.3052093, 106.6432014),
    "CDB Utara 3": (-6.3129284, 106.6948669),
    "ICE 1": (-6.3004202, 106.6364517),
    "ICE 2": (-6.3004202, 106.6364517),
    "ICE Business Park": (-6.3033518, 106.6343743),
    "ICE 6": (-6.3004202, 106.6364517),
    "ICE 5": (-6.3005375, 106.6361094),
    "CBD Barat 1": (-6.302359999999999, 106.64208),
    "CBD Barat 2": (-6.302359999999999, 106.64208),
    "Lobby AEON Mall": (-6.3052093, 106.6432014),
    "CBD Timur 2": nil,
    "Navapark 1": (-6.2968496, 106.6499741),
    "Green cove": (-6.302239999999999, 106.6593189),
    "Greenwich Park": (-6.276974999999999, 106.6324609),
    "Halte Sektor 1.3": (-6.305779999999999, 106.67995),
    "Cosmo": (-6.3115606, 106.648598),
    "Verdan View": (-6.3151812, 106.6500659),
    "Eternity": (-6.3149356, 106.6443156),
    "Simplicity 2": (-6.311206299999999, 106.6456896),
    "Edutown 1": (-6.302451800000001, 106.6417452),
    "Edutown 2": (-6.3027092, 106.6412063),
    "GOP 1": (-6.3016198, 106.6506262),
    "SML Plaza": (-6.301582, 106.6511396),
    "SWA 2": nil,
    "Giant": (-6.29851, 106.66724),
    "Eka Hostpital 1": (-6.2989741, 106.669916),
    "Puspita Loka": (-6.2918508, 106.6749133),
    "Polsek Serpong": (-6.294746399999999, 106.6809921),
    "Pasmod Timur": (-6.3045281, 106.6848223),
    "Griyaloka 1": (-6.2972825, 106.6790009),
    "Icon Ncentro": (-6.3147579, 106.6476114),
    "Horizon Broadway": (-6.3147579, 106.6476114),
    "Extreme Park": (-6.309597999999999, 106.653496),
    "Saveria": (-6.3071658, 106.6520804),
    "Casa De Parco 1": (-6.306180299999999, 106.6521992),
    "Simpang Foresta": (-6.29923, 106.64793),
    "Allenvare": (-6.3052093, 106.6432014),
    "Fiore": (-6.296955, 106.6438626),
    "Studento 1": (-6.2951614, 106.6407945),
    "Naturale": (-6.2914204, 106.6418288),
    "Fresco": (-6.2890175, 106.6448524),
    "Primavera": (-6.290895099999999, 106.647864),
    "Foresta 2": (-6.2927402, 106.6398134),
    "De Park 1": (-6.286872, 106.6448763),
    "De Frangipani": (-6.286396, 106.6428903),
    "De Heliconia 1": (-6.2855012, 106.6406138),
    "De Brassia": (-6.2799434, 106.6391138),
    "Jadeite": (-6.277034599999999, 106.6395383),
    "Greenwich Park 1": (-6.276974999999999, 106.6324609),
    "QBIG 2": (-6.284320399999999, 106.6367915),
    "QBIG 3": (-6.284320399999999, 106.6367915),
    "BCA": (-6.2952584, 106.6658593),
    "FBL 2": (-6.2927402, 106.6398134),
    "FBL 1": (-6.2954905, 106.6407136),
    "QBIG 1": (-6.284320399999999, 106.6367915),
    "Lulu": (-6.2828699, 106.6358737),
    "Greenwich Park Office": (-6.27691, 106.63404),
    "Lobby House of Tiktokers": (-6.283176399999999, 106.6367474),
    "Digital Hub 1": (-6.3065511, 106.6543984),
    "Digital Hub 2": (-6.3065511, 106.6543984),
    "Prestigia": (-6.298271600000001, 106.6302558),
    "The Mozia 1": (-6.2921414, 106.6282163),
    "Piazza Mozia": (-6.29118, 106.6269791),
    "Tabebuya": (-6.2919851, 106.6230008),
    "Vanya Park": (-6.295901199999999, 106.6213069),
    "The Mozia 2": (-6.2944104, 106.6282488),
    "Illustria": (-6.2938603, 106.6357923),
    "Court Mega Store": (-6.288471899999999, 106.6396024),
    "Astra": (-6.2898526, 106.639551),
    "Gramedia": (-6.291305899999999, 106.6392835),
    "Froggy": (-6.2978311, 106.6403045),
    "Casa De Parco 2": (-6.306180299999999, 106.6521992),
    "Simplicity 1": (-6.3123293, 106.6431974),
    "AEON Mall / Sky House": (-6.3052093, 106.6432014),
]

    // Seed bus routes
    let busRoutes = [
        BusRoute(
            routeName: "The Breeze - AEON - ICE - The Breeze Loop Line",
            startPoint: "The Breeze",
            endPoint: "The Breeze",
            stations: [
                Station(name: "The Breeze", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Timur 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Selatan", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "AEON Mall 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "AEON Mall 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CDB Utara 3", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE Business Park", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 6", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 5", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Barat 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Barat 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Lobby AEON Mall", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Timur 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Navapark 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Green cove", isCurrentStation: false, isPreviousStation: false, isNextStation: false)
            ],
            routeCode: "BC",
            color: "BadgeBC",
            estimatedTime: 65,
            distance: 6.9,
            routeDescription: "The Breeze → AEON → ICE → The Breeze Loop Line"
        ),
        BusRoute(
            routeName: "Greenwich - Sektor 1.3 Loop Line",
            startPoint: "Greenwich Park",
            endPoint: "Halte Sektor 1.3",
            stations: [
                Station(name: "Greenwich Park", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Timur 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Selatan", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "AEON Mall 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "AEON Mall 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CDB Utara 3", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE Business Park", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 6", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 5", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Barat 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Barat 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Lobby AEON Mall", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Timur 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Navapark 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Green cove", isCurrentStation: false, isPreviousStation: false, isNextStation: false)
            ],
            routeCode: "GS",
            color: "BadgeGS",
            estimatedTime: 65,
            distance: 6.9,
            routeDescription: "Greenwich - Sektor 1.3 Loop Line"
        ),
        BusRoute(
            routeName: "Intermoda - Halte Sektor 1.3",
            startPoint: "Intermoda",
            endPoint: "Halte Sektor 1.3",
            stations: [
                Station(name: "Intermoda", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Cosmo", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Verdan View", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Eternity", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Simplicity 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Edutown 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Edutown 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 6", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 5", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "GOP 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "SML Plaza", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "The Breeze", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Timur 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Timur 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Navapark 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "SWA 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Giant", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Eka Hostpital 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Puspita Loka", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Polsek Serpong", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Pasmod Timur", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Griyaloka 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Halte Sektor 1.3", isCurrentStation: false, isPreviousStation: false, isNextStation: false)
            ],
            routeCode: "IS",
            color: "BadgeIS", // Changed from "black" to "teal" for better visibility in dark mode
            estimatedTime: 69,
            distance: 6.9,
            routeDescription: "Intermoda - Sektor 1.3 Loop Line"
        ),
        BusRoute(
            routeName: "Intermoda - De Park 1",
            startPoint: "Intermoda",
            endPoint: "Intermoda",
            stations: [
                Station(name: "Intermoda", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Edutown 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Edutown 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 6", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 5", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Froggy", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Gramedia", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Astra", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Court Mega Store", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "QBIG 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Lulu", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Greenwich Park 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Greenwich Park Office", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Jadeite", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "De Maja", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "De Heliconia 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "De Nara", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Navapark 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "GOP 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "SML Plaza", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "The Breeze", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Casa De Parco 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Lobby House of Tiktokers", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Digital Hub 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Digital Hub 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Verdant View", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Eternity", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Intermoda", isCurrentStation: false, isPreviousStation: false, isNextStation: false)
            ],
            routeCode: "ID1",
            color: "BadgeID1",
            estimatedTime: 47,
            distance: 6.9,
            routeDescription: "Intermoda - De Park 1 Loop Line"
        ),
        BusRoute(
            routeName: "Intermoda - De Park 2",
            startPoint: "Intermoda",
            endPoint: "Intermoda",
            stations: [
                Station(name: "Intermoda", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Icon Ncentro", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Horizon Broadway", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Extreme Park", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Saveria", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Casa De Parco 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "SML Plaza", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "The Breeze", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Timur 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "AEON Mall 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "AEON Mall 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Timur 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Simpang Foresta", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Allenvare", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Fiore", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Studento 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Naturale", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Fresco", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Primavera", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Foresta 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "De Park 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "De Frangipani", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "De Heliconia 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "De Brassia", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Jadeite", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Greenwich Park 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "QBIG 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "QBIG 3", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "BCA", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "FBL 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "FBL 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 6", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 5", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Barat 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Barat 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Simplicity 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Intermoda", isCurrentStation: false, isPreviousStation: false, isNextStation: false)
            ],
            routeCode: "ID2",
            color: "BadgeID2",
            estimatedTime: 50,
            distance: 6.9,
            routeDescription: "Intermoda - De Park 2 Loop Line"
        ),
        BusRoute(
            routeName: "Intermoda - Vanya",
            startPoint: "Intermoda",
            endPoint: "Intermoda",
            stations: [
                Station(name: "Intermoda", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Simplicity 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Edutown 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Edutown 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 6", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Prestigia", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "The Mozia 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Piazza Mozia", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Tabebuya", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Vanya Park", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "The Mozia 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Illustria", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 6", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 5", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Barat 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Barat 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Simplicity 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Intermoda", isCurrentStation: false, isPreviousStation: false, isNextStation: false)
            ],
            routeCode: "IV",
            color: "BadgeIV",
            estimatedTime: 35,
            distance: 6.9,
            routeDescription: "Intermoda - Vanya Park Loop Line"
        ),
        BusRoute(
            routeName: "Electric Line",
            startPoint: "Intermoda",
            endPoint: "Intermoda",
            stations: [
                Station(name: "Intermoda", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Simplicity 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Edutown 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Edutown 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 6", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 5", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Froggy", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Gramedia", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Astra", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Court Mega Store", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "QBIG 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Lulu", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "QBIG 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "QBIG 3", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "BCA", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "FBL 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "FBL 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "GOP 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "SML Plaza", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "The Breeze", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Casa De Parco 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Lobby House of Tiktokers", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Digital Hub 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Saveria", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Casa De Parco 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Timur 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Lobby AEON Mall", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Barat 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Simplicity 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Intermoda", isCurrentStation: false, isPreviousStation: false, isNextStation: false)
            ],
            routeCode: "EC",
            color: "BadgeEC",
            estimatedTime: 53,
            distance: 6.9,
            routeDescription: "Electric Line | Intermoda - ICE - QBIG - Ara Rasa - The Breeze - Digital Hub - AEON Mall Loop Line"
        ),
        BusRoute(
            routeName: "Big Bus Line",
            startPoint: "Intermoda",
            endPoint: "Intermoda",
            stations: [
                Station(name: "Intermoda", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Simplicity 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Edutown 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Edutown 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 6", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "ICE 5", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Froggy", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Gramedia", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Astra", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Court Mega Store", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "QBIG 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Lulu", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "QBIG 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "QBIG 3", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "BCA", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "FBL 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "FBL 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "GOP 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "SML Plaza", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "The Breeze", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Timur 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "AEON Mall / Sky House", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "CBD Barat 2", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Simplicity 1", isCurrentStation: false, isPreviousStation: false, isNextStation: false),
                Station(name: "Intermoda", isCurrentStation: false, isPreviousStation: false, isNextStation: false)
            ],
            routeCode: "BB",
            color: "BadgeBB",
            estimatedTime: 53,
            distance: 6.9,
            routeDescription: "The Big Bus Electric | INTERMODA - I C E - QBIG - ARA RASA -THE BREEZE - SKY HOUSE / AEON MALL - INTERMODA"
        ),
    ]
    

    let busInfos = [
        BusInfo(plateNumber: "B7566PAA", routeCode: "GS", routeName: "Greenwich - Sektor 1.3 Loop Line"),
        BusInfo(plateNumber: "B7266JF", routeCode: "GS", routeName: "Greenwich - Sektor 1.3 Loop Line"),
        BusInfo(plateNumber: "B7466PAA", routeCode: "GS", routeName: "Greenwich - Sektor 1.3 Loop Line"),
        BusInfo(plateNumber: "B7366JE", routeCode: "ID1", routeName: "Intermoda - De Park 1"),
        BusInfo(plateNumber: "B7366PAA", routeCode: "ID2", routeName: "Intermoda - De Park 2"),
        BusInfo(plateNumber: "B7866PAA", routeCode: "ID2", routeName: "Intermoda - De Park 2"),
        BusInfo(plateNumber: "B7666PAA", routeCode: "IS", routeName: "Intermoda - Halte Sektor 1.3"),
        BusInfo(plateNumber: "B7966PAA", routeCode: "IS", routeName: "Intermoda - Halte Sektor 1.3"),
        BusInfo(plateNumber: "B7002PGX", routeCode: "EC", routeName: "Electric Line | Intermoda - ICE - QBIG - Ara Rasa - The Breeze - Digital Hub - AEON Mall Loop Line"),
        BusInfo(plateNumber: "B7166PAA", routeCode: "BC", routeName: "The Breeze - AEON - ICE - The Breeze Loop Line"),
        BusInfo(plateNumber: "B7866PAA", routeCode: "BC", routeName: "The Breeze - AEON - ICE - The Breeze Loop Line"),
        BusInfo(plateNumber: "B7766PAA", routeCode: "IV", routeName: "Intermoda - Vanya"),
        
    ]
    
    // Migrate old BusRoute into new RouteModel
    for oldRoute in busRoutes {
        let stationModels = oldRoute.stations.map { oldStation in
            let coord = stationCoordinates[oldStation.name] ?? nil
            return StationModel(
                name: oldStation.name,
                arrivalTime: oldStation.arrivalTime,
                isCurrentStation: oldStation.isCurrentStation,
                isPreviousStation: oldStation.isPreviousStation,
                isNextStation: oldStation.isNextStation,
                latitude: coord?.0,
                longitude: coord?.1
            )
        }

        let routeModel = RouteModel(
            routeCode: oldRoute.routeCode,
            routeName: oldRoute.routeName,
            startPoint: oldRoute.startPoint,
            endPoint: oldRoute.endPoint,
            colorName: oldRoute.color,
            estimatedTime: oldRoute.estimatedTime,
            distance: oldRoute.distance,
            routeDescription: oldRoute.routeDescription,
            stations: stationModels
        )

        modelContext.insert(routeModel)
        print("Inserted RouteModel: \(routeModel.routeCode)")
    }
    
    for busInfo in busInfos {
        modelContext.insert(busInfo)
    }
    
    // Try to save changes immediately
    do {
        try modelContext.save()
        print("Successfully saved model context after seeding")
    } catch {
        print("Error saving model context: \(error)")
    }
    
    // Print debug info
    print("Data seeding completed successfully")
    print("Seeded bus infos: \(busInfos.map { $0.plateNumber })")
    print("Seeded routes: \(busRoutes.map { $0.routeCode })")
    
    // Verify routes were added
    do {
        let descriptor = FetchDescriptor<RouteModel>()
        let count = try modelContext.fetchCount(descriptor)
        print("After seeding, database has \(count) routes")
    } catch {
        print("Error verifying route count: \(error)")
    }

    let allStationNames = Set(busRoutes.flatMap { $0.stations.map { $0.name } })

    geocodeStationNames(Array(allStationNames)) { nameToCoord in
        // Now, when creating StationModel, use:
        // let coord = nameToCoord[station.name] ?? (nil, nil)
        // latitude: coord?.0, longitude: coord?.1
    }
}


   // Function to clear all existing data
   static func clearAllData(modelContext: ModelContext) {
       do {
           // Clear BusInfo
           let busInfoDescriptor = FetchDescriptor<BusInfo>()
           let busInfos = try modelContext.fetch(busInfoDescriptor)
           for busInfo in busInfos {
               modelContext.delete(busInfo)
           }
           
           // Clear BusRoute
           let routeDescriptor = FetchDescriptor<BusRoute>()
           let routes = try modelContext.fetch(routeDescriptor)
           for route in routes {
               modelContext.delete(route)
           }
           
           // Try to save changes immediately
           try modelContext.save()
           print("All existing data cleared successfully")
       } catch {
           print("Error clearing data: \(error)")
       }
   }
    
    // Add a function to update station status based on current time
    static func updateStationStatus(route: BusRoute) {
        // Get the current time
        let currentTime = Date()
        let calendar = Calendar.current
        let currentHour = calendar.component(.hour, from: currentTime)
        let currentMinute = calendar.component(.minute, from: currentTime)
        
        // Calculate the total minutes since midnight
        let currentTotalMinutes = currentHour * 60 + currentMinute
        
        // Determine which station is current based on time
        // This is a simplified algorithm - in a real app, you'd use actual bus schedules
        let totalStations = route.stations.count
        let cycleTime = route.estimatedTime // minutes for a full cycle
        
        // Calculate which station in the cycle we're at
        let minutesIntoDay = currentTotalMinutes % cycleTime
        let stationIndex = Int(Double(minutesIntoDay) / Double(cycleTime) * Double(totalStations)) % totalStations
        
        // Update station statuses
        for i in 0..<route.stations.count {
            route.stations[i].isCurrentStation = (i == stationIndex)
            route.stations[i].isPreviousStation = (i == (stationIndex - 1 + totalStations) % totalStations)
            route.stations[i].isNextStation = (i == (stationIndex + 1) % totalStations)
            
            // Set arrival times
            let minutesFromNow = ((i - stationIndex + totalStations) % totalStations) * (cycleTime / totalStations)
            route.stations[i].arrivalTime = calendar.date(byAdding: .minute, value: minutesFromNow, to: currentTime)
        }
    }

    // Add a function to get the nearest bus stop
    static func getNearestBusStop(latitude: Double, longitude: Double) -> Station? {
        // This would normally use actual geolocation data
        // For this demo, we'll just return a fixed station
        return Station(
            name: "The Breeze",
            arrivalTime: Date(),
            isCurrentStation: true,
            isPreviousStation: false,
            isNextStation: false
        )
    }

    static func geocodeStationNames(_ names: [String], completion: @escaping ([String: (Double, Double)?]) -> Void) {
        let geocoder = CLGeocoder()
        var results: [String: (Double, Double)?] = [:]
        let group = DispatchGroup()

        for name in names {
            group.enter()
            geocoder.geocodeAddressString(name + ", BSD City, Indonesia") { placemarks, error in
                if let coordinate = placemarks?.first?.location?.coordinate {
                    results[name] = (coordinate.latitude, coordinate.longitude)
                } else {
                    results[name] = nil
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            completion(results)
        }
    }
}
