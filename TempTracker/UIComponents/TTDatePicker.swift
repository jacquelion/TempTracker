//
//  TTDatePicker.swift
//  TempTracker
//
//  Created by Jacqueline Sloves on 3/19/20.
//  Copyright © 2020 Jacqueline Sloves. All rights reserved.
//

import SnapKit

class TTDatePickerComponent: UIView {
    
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
        label.text = NSLocalizedString("Date/Time of Temp", comment: "Date and Time person takes their temperature.")
        label.textAlignment = .left
        label.textColor = .darkText
        label.font = .boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.maximumDate = Date()
        return picker
    }()
    
    func setupAppearance() {
        self.addSubview(label)
        self.addSubview(datePicker)

    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width/3)
            make.trailing.equalTo(datePicker.snp.leading).offset(12.0)
            
        }
        
        datePicker.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(datePicker.snp.trailing).offset(-12.0)
        }
    }
}
