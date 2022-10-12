//
//  ColorViewController.swift
//  colorizedApp
//
//  Created by Дарина Самохина on 12.10.2022.
//

import UIKit

protocol SettingViewControllerDelegate {
    func passColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)
}

class ColorViewController: UIViewController {
    
    var redColor: CGFloat = 1
    var greenColor: CGFloat = 1
    var blueColor: CGFloat = 1
    var alphaValue: CGFloat = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundColor()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingViewController else { return }
        settingVC.redColor = redColor
        settingVC.greenColor = greenColor
        settingVC.blueColor = blueColor
        settingVC.alphaValue = alphaValue
        settingVC.delegate = self
    }
}

//MARK: - Private Methods
extension ColorViewController {
    private func setBackgroundColor() {
        view.backgroundColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: alphaValue)
    }
}

//MARK: - SettingViewControllerDelegate
extension ColorViewController: SettingViewControllerDelegate {
    func passColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        redColor = red
        greenColor = green
        blueColor = blue
        alphaValue = alpha
        setBackgroundColor()
    }
    
    
    
}
