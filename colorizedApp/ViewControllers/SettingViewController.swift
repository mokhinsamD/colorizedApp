//
//  SettingViewController.swift
//  colorizedApp
//
//  Created by Дарина Самохина on 28.09.2022.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var delegate: SettingViewControllerDelegate!
    var viewColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        colorView.layer.cornerRadius = 15
        
        colorView.backgroundColor = viewColor
        
        setValue(for: redSlider, greenSlider, blueSlider)
        setValue(for: redLabel, greenLabel, blueLabel)
        setValue(for: redTextField, greenTextField, blueTextField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(for: redLabel)
            setValue(for: redTextField)
        case greenSlider:
            setValue(for: greenLabel)
            setValue(for: greenTextField)
        default:
            setValue(for: blueLabel)
            setValue(for: blueTextField)
        }
        setColor()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.passColor(colorView.backgroundColor ?? .white)
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
            alpha: 1
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel: label.text = stringFrom(redSlider)
            case greenLabel: label.text = stringFrom(greenSlider)
            default: label.text = stringFrom(blueSlider)
            }
        }
    }
    
    private func setValue(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTextField: textField.text = stringFrom(redSlider)
            case greenTextField: textField.text = stringFrom(greenSlider)
            default: textField.text = stringFrom(blueSlider)
            }
        }
    }
    
    private func setValue(for colorSliders: UISlider...) {
        let ciColor = CIColor(color: viewColor)
        colorSliders.forEach { slider in
            switch slider {
            case redSlider: redSlider.value = Float(ciColor.red)
            case greenSlider: greenSlider.value = Float(ciColor.green)
            default: blueSlider.value = Float(ciColor.blue)
            }
        }
    }
    
    private func stringFrom(_ slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func showAlert(
        with title: String,
        andMessage message: String,
        textField: UITextField? = nil
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = "1.00"
            textField?.becomeFirstResponder() //  возвращает клавиатуру и внимание курсора в текстфилд
        }
        alert.addAction(okAction)
        present(alert, animated: true) // вызываем алерт
    }
}

//MARK: - UITextFieldDelegate
extension SettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else {
            showAlert(with: "Wrong format", andMessage: "Please enter correct value")
            return
        }
        guard let currentValue = Float(text), (0...1).contains(currentValue) else {
            showAlert(
                with: "Wrong format",
                andMessage: "Please enter correct value",
                textField: textField
            )
            return
        }
        
        switch textField {
        case redTextField:
            redSlider.setValue(currentValue, animated: true)
            setValue(for: redLabel)
        case greenTextField:
            greenSlider.setValue(currentValue, animated: true)
            setValue(for: greenLabel)
        default:
            blueSlider.setValue(currentValue, animated: true)
            setValue(for: blueLabel)
        }
        setColor()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // создать тул бар
        let keyBoardToolbar = UIToolbar()
        
        // подстроить под размер клавиатуры
        keyBoardToolbar.sizeToFit()
        
        textField.inputAccessoryView = keyBoardToolbar
        //показать тулбар, когда нажимаешь на текстфилд 
        
        // размещаем кнопку дан
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder) // метод этого класса, который скрывает клавиатуру
            // по нажатию на кнопку мы реализовываем метод resignFirstResponder,
            // который находится в textField
            // по нажатию на кнопку дан
        )
        
        //чтобы заполнить пустое пространство слева
        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        keyBoardToolbar.items = [flexBarButton, doneButton]
    }
    
}
