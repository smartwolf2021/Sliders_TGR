//
//  ViewController.swift
//  Sliders
//
//  Created by Васильева Ольга on 12.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: IB Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        changeColorView()
        changeLabelValue()
        
        colorView.layer.cornerRadius = 20
    }

    // MARK: - IB Actions
    @IBAction func sliderAction(_ sender: Any) {
        changeColorView()
        changeLabelValue()
    }
   
    //MARK: - Private Metods
    private func changeColorView () {
        let currentColor = UIColor (red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(1.0))
        colorView.backgroundColor = currentColor
    }
    
    private func changeLabelValue () {
        redLabel.text = String((redSlider.value * 100).rounded() / Float(100))
        greenLabel.text = String((greenSlider.value * 100).rounded() / Float(100))
        blueLabel.text = String((blueSlider.value * 100).rounded() / Float(100))
        
    }
    
}
