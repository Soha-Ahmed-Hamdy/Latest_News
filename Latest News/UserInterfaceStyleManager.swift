//
//  UserInterfaceStyleManager.swift
//  Latest News
//
//  Created by Soha Ahmed Hamdy on 31/07/2023.
//

import Foundation
import UIKit

class UserInterfaceStyleManager {
    static let shared = UserInterfaceStyleManager()

    func setUserInterfaceStyle(_ style: UIUserInterfaceStyle) {
        if let window = UIApplication.shared.windows.first {
            window.overrideUserInterfaceStyle = style
        }
    }
}
