//
//  AuthErrors.swift
//  RecenziRAJ
//
//  Created by Mateo on 28.08.2022..
//

import Foundation

final class ApiError {
    enum LoginError: Error {
        case invalidEmail
        case userDisabled
        case wrongPassword
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .invalidEmail:
                return NSLocalizedString("The provided email seems to be invalid.", comment: "Invalid email")
            case .userDisabled:
                return NSLocalizedString("The user account for this email seems to be disabled.", comment: "User disabled")
            case .wrongPassword:
                return NSLocalizedString("The provided password and email combination seem to be incorrect.", comment: "Wrong password")
            case .unknown:
                return NSLocalizedString("An unknown error occured.", comment: "Unknown error")
            }
        }
    }

    enum RegisterError: Error {
        case invalidEmail
        case emailAlreadyInUse
        case weakPassword
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .invalidEmail:
                return NSLocalizedString("The provided email seems to be invalid.", comment: "Invalid email")
            case .emailAlreadyInUse:
                return NSLocalizedString("The provided email seems to already be in use.", comment: "User disabled")
            case .weakPassword:
                return NSLocalizedString("The provided password is too weak.", comment: "Wrong password")
            case .unknown:
                return NSLocalizedString("An unknown error occured.", comment: "Unknown error")
            }
        }
    }
}
