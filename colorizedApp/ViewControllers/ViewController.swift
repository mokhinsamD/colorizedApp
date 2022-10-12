//
//  SettingViewController.swift
//  colorizedApp
//
//  Created by Дарина Самохина on 28.09.2022.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redCounter: UILabel!
    @IBOutlet var greenCounter: UILabel!
    @IBOutlet var blueCounter: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 15
        setCounter()
        setColor()
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        setColor()
        
        switch sender {
        case redSlider:
            redCounter.text = string(from: redSlider)
        case greenSlider:
            greenCounter.text = string(from: greenSlider)
        default:
            blueCounter.text = string(from: blueSlider)
        }
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
    
    private func setCounter() {
        redCounter.text = string(from: redSlider)
        greenCounter.text = string(from: greenSlider)
        blueCounter.text = string(from: blueSlider)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
}
