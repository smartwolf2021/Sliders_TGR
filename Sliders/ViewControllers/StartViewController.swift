//
//  StartViewController.swift
//  Sliders
//
//  Created by Васильева Ольга on 26.12.2021.
//

import UIKit

class StartViewController: UIViewController, ScreenSettingsDelegate {
    
    //MARK: - Private Properties
    var screenSettings = ScreenSettings()
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIFromScreenSettings()
        
    }
        
    //MARK: - Public Methods
    func updateUIFromScreenSettings() {
        view.backgroundColor = screenSettings.screenBackgroundColor
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.delegate = self
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
