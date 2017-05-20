//
//  WizardModel.swift
//  iOS Architecture Demo
//
//  Created by Calo, Ignazio on 20/05/2017.
//  Copyright © 2017 Italy Swift User Group. All rights reserved.
//

import Foundation

class WizardModel {
    var firstText: String
    var secondText: String
    var thirdText: String

    var textSecondStep: String?

    private(set) var updatedCount: Int = 0

    init(firstText: String, secondText: String, thirdText: String, textSecondStep: String?) {
        self.firstText = firstText
        self.secondText = secondText
        self.thirdText = thirdText
        self.textSecondStep = textSecondStep
    }

    func increaseUpdateCounter() {
        updatedCount = updatedCount + 1
    }
    
}
