//
//  JailbreakStatus.swift
//  extra_recipe
//
//  Created by AppleBetas on 2017-05-28.
//  Copyright © 2017 Ian Beer. All rights reserved.
//

import UIKit

enum JailbreakStatus: Int32 {
    case jailbroken = 0, internalError = 1, unsupported = 2, unsupportedYet = 3, ok = 42, unknown = -1
    
    static func status(from numericValue: Int32) -> JailbreakStatus {
        if let status = JailbreakStatus(rawValue: numericValue) {
            return status
        }
        return .unknown
    }
    
    var success: Bool {
        return self == .jailbroken || self == .ok
    }
    
    var ringColour: UIColor {
        switch self {
        case .jailbroken:
            return .green
        case .ok:
            return .orange
        default:
            return .red
        }
    }
    
    var shouldShowAlert: Bool {
        return self != .jailbroken
    }
    
    var shouldAlertHaveExitButton: Bool {
        return self != .ok
    }
    
    var progressState: ProgressState {
        if success {
            return ProgressState(text: "!Done!", image: UIImage(named: "success"), spinnerState: .full, overrideRingColour: self.ringColour)
        }
        return ProgressState(text: "!Error!", image: UIImage(named: "fail"), spinnerState: .full, overrideRingColour: .red)
    }
    
    var alertTitle: String {
        if success {
            return "Jailbroken!"
        }
        return "Error!"
    }
    
    var alertMessage: String {
        switch self {
        case .jailbroken:
            return "Your Device Is Jailbroken!"
        case .internalError:
            return "Internal Error Occurred Attempting To Jailbreak The Device."
        case .unsupported:
            return "Device Not Supported."
        case .unsupportedYet:
            return "Device Not Supported."
        case .ok:
            return "Device Is Jailbroken, But May Not Work Correctly."
        case .unknown:
            return "Fatal Error Occurred Attempting To Jailbreak The Device. Please Reboot."
        }
    }
}
