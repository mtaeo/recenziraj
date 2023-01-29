//
//  ClassificationsEnum.swift
//  RecenziRAJ
//
//  Created by Mateo on 29.01.2023..
//

import Foundation

final class Classifications {
    enum ItemName: String, CaseIterable {
        case monsterMangoLoco = "Monster - Mango Loco"
        case benAndJerry = "Ben and Jerry"
        case cocaCola = "Coca Cola"
        case heinzKetchup = "Heinz Ketchup"
        case kinderBueno = "Kinder Bueno"
        case kinderJoy = "Kinder Joy"
        case kitKat = "Kit Kat"
        case laysClassic = "Lays Classic"
        case nutella = "Nutella"
        case pepsiBlueCan = "Pepsi Blue Can"
        case redBull = "Red Bull"
        
        static func withLabel(_ label: String) -> ItemName? {
            allCases.first{ "\($0.rawValue)".uppercased() == label.uppercased() }
        }
        
        var thumbnail: String {
            switch self {
            case .monsterMangoLoco:
                return "monster_mango_loco"
            case .benAndJerry:
                return "ben_and_jerry"
            case .cocaCola:
                return "coca_cola"
            case .heinzKetchup:
                return "heinz_ketchup"
            case .kinderBueno:
                return "kinder_bueno"
            case .kinderJoy:
                return "kinder_joy"
            case .kitKat:
                return "kit_kat"
            case .laysClassic:
                return "lays_classic"
            case .nutella:
                return "nutella"
            case .pepsiBlueCan:
                return"pepsi_blue_can"
            case .redBull:
                return "red_bull"
            }
        }
    }
}
