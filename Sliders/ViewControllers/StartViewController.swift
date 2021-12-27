//
//  StartViewController.swift
//  Sliders
//
//  Created by Васильева Ольга on 26.12.2021.
//

import UIKit

class StartViewController: UIViewController, ScreenSettingsDelegate {
    
    //MARK: - Public Methods
    func updateUIFromScreenSettings(color: UIColor) {
        view.backgroundColor = color
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        settingsVC.color = view.backgroundColor
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
