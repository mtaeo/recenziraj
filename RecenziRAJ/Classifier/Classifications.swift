//
//  ClassificationsEnum.swift
//  RecenziRAJ
//
//  Created by Mateo on 29.01.2023..
//

import Foundation

final class Classifications {
    enum ItemName: String, CaseIterable {
        case cocaCola = "Coca Cola"
        case doritosNachoCheese = "Doritos - Nacho Cheese"
        case drPepperOriginal = "Dr. Pepper Original"
        case hariboOriginal = "Haribo - Original"
        case heinzKetchup = "Heinz Ketchup"
        case laysClassic = "Lays Classic"
        case monster = "Monster"
        case monsterMangoLoco = "Monster - Mango Loco"
        case nutella = "Nutella"
        case pepsiBlueCan = "Pepsi Blue Can"
        case redbullEnergyDrink = "Red Bull Energy Drink"
        
        
        static func withLabel(_ label: String) -> ItemName? {
            allCases.first{ "\($0.rawValue)".uppercased() == label.uppercased() }
        }
        
        var thumbnail: String {
            switch self {
            case .monsterMangoLoco:
                return "monster_mango_loco"
                //        case .benAndJerry:
                //            return "ben_and_jerry"
            case .cocaCola:
                return "coca_cola"
            case .heinzKetchup:
                return "heinz_ketchup"
                //        case .kinderBueno:
                //            return "kinder_bueno"
                //        case .kinderJoy:
                //            return "kinder_joy"
                //        case .kitKat:
                //            return "kit_kat"
            case .laysClassic:
                return "lays_classic"
            case .nutella:
                return "nutella"
            case .pepsiBlueCan:
                return"pepsi_blue_can"
            case .redbullEnergyDrink:
                return "red_bull_energy_drink"
            case .doritosNachoCheese:
                return "doritos_nacho_cheese"
            case .drPepperOriginal:
                return "dr_pepper_original"
            case .hariboOriginal:
                return "haribo_original"
            case .monster:
                return "monster"
            }
        }
    }
}
