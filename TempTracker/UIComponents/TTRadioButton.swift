//
//  TTRadioButton.swift
//  TempTracker
//
//  Created by Jacqueline Sloves on 3/19/20.
//  Copyright © 2020 Jacqueline Sloves. All rights reserved.
//

import SnapKit

class TTRadioButton: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupAppearance()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Temp", comment: "Self-reported temperature.")
        label.textAlignment = .left
        label.textColor = .darkText
        label.font = .boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    var tempTypeTextField: UITextField = {
        let tempTypeTextField = UITextField()
        tempTypeTextField.borderStyle = .roundedRect
        tempTypeTextField.keyboardType = .numbersAndPunctuation
        return tempTypeTextField
    }()
    
    var tempTypePicker: UIPickerView = {
        let tempTypePicker = UIPickerView()
        return tempTypePicker
    }()
    
    func setupAppearance() {
        self.addSubview(label)
        self.addSubview(tempTypeTextField)
        self.addSubview(tempTypePicker)
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width/3)
            make.trailing.equalTo(tempTypeTextField.snp.leading).offset(-12.0)
        }
        
        tempTypeTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(40.0)
            make.leading.equalTo(label.snp.trailing).offset(12.0)
            make.width.equalTo(tempTypePicker)
            make.trailing.equalTo(tempTypePicker.snp.leading).offset(-12.0)
        }
        
        tempTypePicker.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalTo(tempTypeTextField)
            make.leading.equalTo(tempTypeTextField.snp.trailing).offset(12.0)
        }
    }
}
