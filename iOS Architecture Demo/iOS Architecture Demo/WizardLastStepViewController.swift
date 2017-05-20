//
//  WizardFirstStepViewController.swift
//  iOS Architecture Demo
//
//  Copyright © 2017 Italy Swift User Group. All rights reserved.
//

import UIKit

class WizardLastStepViewController: UIViewController {

    var model: WizardModel!

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!

    @IBOutlet weak var secondPage: UILabel!

    @IBOutlet weak var editCount: UILabel!



    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        firstLabel.text = "Only numbers: \(model.firstText)"
        secondLabel.text = "Only letters: \(model.secondText)"
        thirdLabel.text = "5 Chars: \(model.thirdText)"

        secondPage.text = "Free text: \(model.textSecondStep!)"

        editCount.text = "Update count: \(model.updatedCount)"
    }

    @IBAction func restart(_ sender: Any) {
        if let vc = self.navigationController?.viewControllers.first as? WizardFirstStepViewController {
            vc.reset()
        }
        self.navigationController?.popToRootViewController(animated: true)
    }

}
