//
//  ColorViewController.swift
//  colorizedApp
//
//  Created by Дарина Самохина on 12.10.2022.
//

import UIKit

protocol SettingViewControllerDelegate {
    func passColor(_ color: UIColor)
}

class ColorViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVC = segue.destination as? SettingViewController else { return }
        settingVC.delegate = self
        settingVC.viewColor = view.backgroundColor
    }
}


//MARK: - SettingViewControllerDelegate
extension ColorViewController: SettingViewControllerDelegate {
    func passColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
