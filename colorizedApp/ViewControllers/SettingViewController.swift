//
//  SettingViewController.swift
//  colorizedApp
//
//  Created by Дарина Самохина on 28.09.2022.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabelCounter: UILabel!
    @IBOutlet var greenLabelCounter: UILabel!
    @IBOutlet var blueLabelCounter: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTFCounter: UITextField!
    @IBOutlet var greenTFCounter: UITextField!
    @IBOutlet var blueTFCounter: UITextField!
    
    var delegate: SettingViewControllerDelegate!
    
    var redColor: CGFloat!
    var greenColor: CGFloat!
    var blueColor: CGFloat!
    var alphaValue: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        setSlidersValue()
        setCounters()
        setColor()
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        switch sender {
        case redSlider:
            redLabelCounter.text = stringFrom(redSlider)
            redTFCounter.text = stringFrom(redSlider)
        case greenSlider:
            greenLabelCounter.text = stringFrom(greenSlider)
            greenTFCounter.text = stringFrom(greenSlider)
        default:
            blueLabelCounter.text = stringFrom(blueSlider)
            blueTFCounter.text = stringFrom(blueSlider)
        }
    }
    
    @IBAction func doneButtonPressed() {
        delegate.passColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
        dismiss(animated: true)
    }
}

//MARK: - Private Methods
extension SettingViewController {
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1)
    }
    
    private func setSlidersValue() {
        redSlider.value = Float(redColor)
        greenSlider.value = Float(greenColor)
        blueSlider.value = Float(blueColor)
    }
    
    private func setCounters() {
        redLabelCounter.text = stringFrom(redColor)
        greenLabelCounter.text = stringFrom(greenColor)
        blueLabelCounter.text = stringFrom(blueColor)
        redTFCounter.text = stringFrom(redColor)
        greenTFCounter.text = stringFrom(greenColor)
        blueTFCounter.text = stringFrom(blueColor)
    }
    
    private func stringFrom(_ slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func stringFrom(_ color: CGFloat) -> String {
        String(format: "%.2f", color)
    }
}
