//
//  SettingsViewController.swift
//  Sliders
//
//  Created by Васильева Ольга on 12.12.2021.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: IB Outlets
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet weak var redTF: UITextField!
    @IBOutlet weak var greenTF: UITextField!
    @IBOutlet weak var blueTF: UITextField!
        
    //MARK: - Public Properties
    var delegate: ScreenSettingsDelegate!
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeSliderValue(slider: redSlider, value: Float(delegate.screenSettings.backgroundColorRedValue))
        changeSliderValue(slider: greenSlider, value: Float(delegate.screenSettings.backgroundColorGreenValue))
        changeSliderValue(slider: blueSlider, value: Float(delegate.screenSettings.backgroundColorBlueValue))
        
        changeColorView()
        
        colorView.layer.cornerRadius = 20
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        redTF.delegate = self
        greenTF.delegate = self
        blueTF.delegate = self
    }

    //MARK: - Override Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
   
    @IBAction func sliderAction(_ sender: UISlider) {
        changeColorView()
        changeLabelValue(slider: sender)
    }
    
    @IBAction func doneButtonePressed() {
        delegate.screenSettings.backgroundColorRedValue = CGFloat(redSlider.value)
        delegate.screenSettings.backgroundColorGreenValue = CGFloat(greenSlider.value)
        delegate.screenSettings.backgroundColorBlueValue = CGFloat(blueSlider.value)
        
        delegate.updateUIFromScreenSettings()
        navigationController?.popViewController(animated: true)
    }
    //MARK: - Public Methods
    
    
    //MARK: - Private Metods
    private func changeColorView () {
        let currentColor = UIColor (red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(1.0))
        colorView.backgroundColor = currentColor
    }
    
    private func changeLabelValue (slider: UISlider) {
        switch slider {
        case redSlider:
            redLabel.text = String(format: "%0.2f", redSlider.value)
            redTF.text = redLabel.text
        case greenSlider:
            greenLabel.text = String(format: "%0.2f", greenSlider.value)
            greenTF.text = greenLabel.text
        case blueSlider:
            blueLabel.text = String(format: "%0.2f", blueSlider.value)
            blueTF.text = blueLabel.text
        default:
            break
        }
    }
    
    private func changeSliderValue (slider: UISlider, value: Float) {
        slider.setValue(value, animated: true)
        changeLabelValue(slider: slider)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ОК", style: .default)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case redTF:
            greenTF.becomeFirstResponder()
        case greenTF:
            blueTF.becomeFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        let keypadToolbar: UIToolbar = UIToolbar()
        
        keypadToolbar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
            
            //не получилось вызвать textFieldShouldReturn, поэтому просто view.endEditing
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: textField, action: #selector(view.endEditing))
        ]
        keypadToolbar.sizeToFit()
        textField.inputAccessoryView = keypadToolbar
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let value = Double(textField.text ?? "0"), value >= 0.0, value <= 1.0 else {
            
            showAlert(title: "Incorrect value", message: "Correct value in 0...1")
            
            //возвращаем значение поля из лейбла
            switch textField {
            case redTF:
                textField.text = redLabel.text
            case greenTF:
                textField.text = greenLabel.text
            case blueTF:
                textField.text = blueLabel.text
            default:
                return
            }
            return
        }
        
        switch textField {
        case redTF:
            changeSliderValue(slider: redSlider, value:Float(value))
        case greenTF:
            changeSliderValue(slider: greenSlider, value:Float(value))
        case blueTF:
            changeSliderValue(slider: blueSlider, value:Float(value))
        default:
            return
        }
        
        changeColorView()
        
    }
    
    //чтобы нельзя было ввести несколько точек в поле
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(string == "," || string == "." ){
            
            if ((textField.text?.contains(","))! || (textField.text?.contains("."))!){
                return false
            }
        }
        return true
    }
    
}
