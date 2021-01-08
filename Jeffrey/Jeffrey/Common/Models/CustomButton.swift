//
//  CustomButton.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 07/01/21.
//

import UIKit

class CustomButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            if (isHighlighted) {
                alpha = 0.5
            }
            else {
                alpha = 1
            }
        }
    }

}
