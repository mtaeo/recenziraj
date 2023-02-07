//
//  ClassificationsEnum.swift
//  RecenziRAJ
//
//  Created by Mateo on 29.01.2023..
//

import Foundation

final class Classifications {
    enum ItemName: String, CaseIterable {
        case arizonaGreenTea = "Arizona Green Tea with Ginseng and Honey"
        case budLigthCan = "Bud Light - Can"
        case cocaCola = "Coca Cola"
        case doritosNachoCheese = "Doritos - Nacho Cheese"
        case drPepperOriginal = "Dr. Pepper Original"
        case ferreroRaffaello = "Ferrero - Raffaello"
        case hariboOriginal = "Haribo - Original"
        case heinzKetchup = "Heinz - Tomato Ketchup"
        case hersheysMilkChocolate = "Hersheys - Milk Chocolate"
        case laysClassic = "Lays Classic"
        case mAndMPeanutButter = "M and M - Peanut Butter"
        case monster = "Monster"
        case monsterMangoLoco = "Monster - Mango Loco"
        case nutella = "Nutella"
        case mountainDew = "Mountain Dew"
        case nesquikStrawberryPowder = "Nesquik - Strawberry Powder"
        case pepsiBlueCan = "Pepsi - Blue Can"
        case pringles = "Pringles"
        case redbullEnergyDrink = "Red Bull Energy Drink"
        case snickers = "Snickers"
        case spriteBottle = "Sprite - Bottle"
        case starbucksVanillaFrappuccino = "Starbucks - Vanilla Frappuccino"
        case werthersOriginal = "Werthers Original"
        
        static func withLabel(_ label: String) -> ItemName? {
            allCases.first{ "\($0.rawValue)".uppercased() == label.uppercased() }
        }
        
        var thumbnail: String {
            switch self {

            case .arizonaGreenTea:
                return "arizona_green_tea"
            case .budLigthCan:
                return "bud_light_can"
            case .cocaCola:
                return "coca_cola"
            case .doritosNachoCheese:
                return "doritos_nacho_cheese"
            case .drPepperOriginal:
                return "dr_pepper_original"
            case .ferreroRaffaello:
                return "ferrero_raffaello"
            case .hariboOriginal:
                return "haribo_original"
            case .heinzKetchup:
                return "heinz_ketchup"
            case .hersheysMilkChocolate:
                return "hersheys_milk_chocolate"
            case .laysClassic:
                return "lays_classic"
            case .mAndMPeanutButter:
                return "m_and_m_peanut_butter"
            case .monster:
                return "monster"
            case .monsterMangoLoco:
                return "monster_mango_loco"
            case .nutella:
                return "nutella"
            case .mountainDew:
                return "mountain_dew"
            case .nesquikStrawberryPowder:
                return "nesquik_strawberry_powder"
            case .pepsiBlueCan:
                return "pepsi_blue_can"
            case .pringles:
                return "pringles"
            case .redbullEnergyDrink:
                return "red_bull_energy_drink"
            case .snickers:
                return "snickers"
            case .spriteBottle:
                return "sprite_bottle"
            case .starbucksVanillaFrappuccino:
                return "starbucks_vanilla_frappucino"
            case .werthersOriginal:
                return "werthers_original"
            }
        }
    }
}
