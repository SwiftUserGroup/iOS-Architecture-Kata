//
//  WizardFirstStepViewController.swift
//  iOS Architecture Demo
//
//  Copyright © 2017 Italy Swift User Group. All rights reserved.
//

import UIKit

class WizardFirstStepViewController: UIViewController {

    @IBOutlet weak var numericField: UITextField!
    @IBOutlet weak var letterField: UITextField!
    @IBOutlet weak var limitedSizeField: UITextField!

    @IBOutlet weak var nextPageButton: UIButton!

    var model: WizardModel? = nil



    @IBAction func gotoNextPage(_ sender: Any) {
        if model == nil {
            model = WizardModel(firstText: numericField.text!,
                                secondText: letterField.text!,
                                thirdText: limitedSizeField.text!, textSecondStep: nil)
        } else {
            if model!.firstText != numericField.text! ||
                model!.secondText != letterField.text! ||
                model!.thirdText != limitedSizeField.text {

                model!.increaseUpdateCounter()
            }

            model?.firstText = numericField.text!
            model?.secondText = letterField.text!
            model?.thirdText = limitedSizeField.text!
        }


        self.performSegue(withIdentifier: "show_second_page", sender: nil)
    }


    func reset() {
        self.model = nil
        self.letterField.text = nil
        self.numericField.text = nil
        self.limitedSizeField.text = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        [numericField, letterField, limitedSizeField].forEach {
            $0?.addTarget(self, action: #selector(textUpated), for: .editingChanged)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // FIXME: Some code is duplicate ;) do a refactoring.
        if formIsValid() {
            enableNextPageNavigation()
        } else {
            disableNetxPageNavitagion()
        }
    }

    func textUpated(sender: UITextField) {
        if formIsValid() {
            enableNextPageNavigation()
        } else {
            disableNetxPageNavitagion()
        }
    }

    func formIsValid() -> Bool {
        let letterCharset = CharacterSet.letters
        let numberCharset = CharacterSet.decimalDigits

        guard let numericText = numericField.text,
        let letterText  = letterField.text,
        let limitedText = limitedSizeField.text,
        numericText.characters.count > 0,
        letterText.characters.count > 0,
        limitedText.characters.count > 0 else {

            return false
        }

        let numericFieldOk = numericText.components(separatedBy: numberCharset.inverted).joined() == numericText
        let textFieldOk = letterText.components(separatedBy: letterCharset.inverted).joined() == letterText
        let limitedFiedlOk = limitedText.characters.count == 5

        return numericFieldOk && textFieldOk && limitedFiedlOk

    }

    func enableNextPageNavigation() {
        nextPageButton.isEnabled = true
    }

    func disableNetxPageNavitagion() {
        nextPageButton.isEnabled = false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? WizardSecondStepViewController {
            dest.model = model
        }

    }
}


extension WizardFirstStepViewController: UITextFieldDelegate {
    
}


