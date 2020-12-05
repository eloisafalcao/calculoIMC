//
//  ViewController.swift
//  IMC_Calculator
//
//  Created by Eloisa Falcão on 05/12/20.
//  Copyright © 2020 Eloisa Falcão. All rights reserved.
//

import UIKit

enum Index: String {
    case underweight = "Abaixo"
    case optimalWeight = "Ideal"
    case overweight = "Sobrepeso"
    case obesity = "Obesidade"
    case severeObesity = "Obesidade Severa"
}

class ViewController: UIViewController {

    @IBOutlet weak var txtFieldWeight: UITextField!
    @IBOutlet weak var txtFieldHeight: UITextField!
    @IBOutlet weak var button: UIButton!

    @IBOutlet weak var imcValue: UILabel!
    @IBOutlet weak var imcIndex: UILabel!
    @IBOutlet weak var imcImg: UIImageView!

    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var img: UIImageView!

    var imc: Double = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboards()
        setupButtons()
        setupViews(isHidden: true)
    }

    //setting up components
    func setupKeyboards() {
        txtFieldWeight.keyboardType = .decimalPad
        txtFieldHeight.keyboardType = .decimalPad
    }

    func setupButtons() {
        button.layer.cornerRadius = 12.0
    }

    func setupViews(isHidden: Bool) {
        img.isHidden = isHidden
        stack.isHidden = isHidden
    }

    //calculate IMC
    func calculateIMC() -> Double {
        let height = Double(txtFieldHeight.text ?? "0.0") ?? 0.0
        let weight = Double(txtFieldWeight.text ?? "0.0") ?? 0.0
        return weight/(height*height)
    }

    //checking imc
    func checkingIMC() -> Index {
        let imc = calculateIMC()
        switch imc {
        case 0...18:
            return .underweight
        case 18.5...24.9:
            return .optimalWeight
        case 25...29.9:
            return .overweight
        case 30...39.9:
            return .obesity
        default:
            return .severeObesity
        }
    }

    //calculating imc
    @IBAction func calculate(_ sender: Any) {
        self.view.endEditing(true)

        let imcCalculated = calculateIMC()
        let index = checkingIMC().rawValue

        setupViews(isHidden: false)
        imcValue.text = String(format: "%.1f", imcCalculated)
        imcIndex.text = index
        imcImg.image = UIImage(named: index)
    }
}

extension ViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

