//
//  TTRadioButton.swift
//  TempTracker
//
//  Created by Jacqueline Sloves on 3/19/20.
//  Copyright © 2020 Jacqueline Sloves. All rights reserved.
//

import SnapKit

protocol TTCheckmarkButtonDelegate: AnyObject {
    func checkmarkChanged(symptom: TTCheckmarkButton)
}

class TTCheckmarkButton: UIButton {
    
    // Images
    let checkedImage = UIImage(imageLiteralResourceName: "checkbox_selected")
    let uncheckedImage = UIImage(imageLiteralResourceName: "checkbox_unselected")

    // Private Props
    private weak var delegate: TTCheckmarkButtonDelegate?
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    init(delegate: TTCheckmarkButtonDelegate, title: String) {
        self.delegate = delegate
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.titleLabel?.textAlignment = .left

        self.setImage(uncheckedImage, for: .normal)
        self.addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonClicked() {
        isChecked = !isChecked
        delegate?.checkmarkChanged(symptom: self)
    }
    
}
