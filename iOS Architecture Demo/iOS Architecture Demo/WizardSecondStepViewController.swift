//
//  WizardFirstStepViewController.swift
//  iOS Architecture Demo
//
//  Copyright © 2017 Italy Swift User Group. All rights reserved.
//

import UIKit

class WizardSecondStepViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nextPageButton: UIButton!

    var model: WizardModel!


    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        [textField].forEach {
            $0?.addTarget(self, action: #selector(textUpated), for: .editingChanged)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        textField.text = model.textSecondStep
        textUpated(sender: textField)
    }

    func textUpated(sender: UITextField) {
        //store the current value.
        model.textSecondStep = textField.text
        if formIsValid() {
            enableNextPageNavigation()
        } else {
            disableNetxPageNavitagion()
        }
    }

    func formIsValid() -> Bool {

        guard let text = textField.text else { return false }

        return text.characters.count > 0

    }


    func enableNextPageNavigation() {
        nextPageButton.isEnabled = true
    }

    func disableNetxPageNavitagion() {
        nextPageButton.isEnabled = false
    }

    @IBAction func gotoNextPage(_ sender: Any) {
        self.performSegue(withIdentifier: "show_third_page", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? WizardLastStepViewController {
            dest.model = model
        }
        
    }
}
