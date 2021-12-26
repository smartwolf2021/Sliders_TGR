//
//  ScreenSettingsModel.swift
//  Sliders
//
//  Created by Васильева Ольга on 26.12.2021
//

import Foundation
import UIKit

protocol ScreenSettingsDelegate {
    var screenSettings: ScreenSettings { get set }
    func updateUIFromScreenSettings()
}

struct ScreenSettings {
    
    var backgroundColorRedValue: CGFloat = 1
    var backgroundColorBlueValue: CGFloat = 1
    var backgroundColorGreenValue: CGFloat = 1
    
    var screenBackgroundColor: UIColor {
        UIColor (red: CGFloat(backgroundColorRedValue), green: CGFloat(backgroundColorGreenValue), blue: CGFloat(backgroundColorBlueValue), alpha: CGFloat(1.0))
    }
    
}
