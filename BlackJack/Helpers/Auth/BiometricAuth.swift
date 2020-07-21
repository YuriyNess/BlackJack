//
//  BiometricAuth.swift
//  AMobileWallet
//
//  Created by YuriyFpc on 12/29/19.
//  Copyright © 2019 YuriyFpc. All rights reserved.
//

import Foundation
import LocalAuthentication

final class BiometricAuth {
    
    static func biometricType() -> BiometricType {
        let authContext = LAContext()
        if #available(iOS 11, *) {
            let _ = authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
            switch(authContext.biometryType) {
            case .none:
                return .none
            case .touchID:
                return .touch
            case .faceID:
                return .face
            @unknown default:
                return .none
            }
        } else {
            return authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) ? .touch : .none
        }
    }
    
    enum BiometricType {
        case none
        case touch
        case face
    }
    
    var compltion: (Bool)->Void
    init(compltion: @escaping (Bool)->Void) {
        self.compltion = compltion
    }
    
    func handleAuth() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = "Пожалуйста, введите ваш пароль"//"Please use your Passcode"
        var authorizationError: NSError?
        let reason = "Для продолжения требуется авторизация"//"Authentication is required for you to continue"
        if localAuthenticationContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authorizationError) {
            localAuthenticationContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] (success, evaluationError) in

                if let errorObj = evaluationError {
                    let messageToDisplay = self?.getErrorDescription(errorCode: errorObj._code)
                    print("Error \(evaluationError!)")
                    print(messageToDisplay ?? "evaluationError")
                }
                DispatchQueue.main.async {
                    self?.compltion(success)
                }
            }
        } else {
            print("User has not enrolled into using Biometrics")
            DispatchQueue.main.async {
                self.compltion(false)
            }
        }
    }
    
    func getErrorDescription(errorCode: Int) -> String {
        
        switch errorCode {
            
        case LAError.authenticationFailed.rawValue:
            return "Authentication was not successful, because user failed to provide valid credentials."
            
        case LAError.appCancel.rawValue:
            return "Authentication was canceled by application (e.g. invalidate was called while authentication was in progress)."
            
        case LAError.invalidContext.rawValue:
            return "LAContext passed to this call has been previously invalidated."
            
        case LAError.notInteractive.rawValue:
            return "Authentication failed, because it would require showing UI which has been forbidden by using interactionNotAllowed property."
            
        case LAError.passcodeNotSet.rawValue:
            return "Authentication could not start, because passcode is not set on the device."
            
        case LAError.systemCancel.rawValue:
            return "Authentication was canceled by system (e.g. another application went to foreground)."
            
        case LAError.userCancel.rawValue:
            return "Authentication was canceled by user (e.g. tapped Cancel button)."
            
        case LAError.userFallback.rawValue:
            return "Authentication was canceled, because the user tapped the fallback button (Enter Password)."
            
        default:
            return "Error code \(errorCode) not found"
        }
    }
}

