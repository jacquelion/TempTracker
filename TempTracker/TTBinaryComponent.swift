//
//  TTBinaryComponent.swift
//  TempTracker
//
//  Created by Jacqueline Sloves on 3/19/20.
//  Copyright © 2020 Jacqueline Sloves. All rights reserved.
//

import SnapKit

class TTBinaryComponent: UIView {
        
    init(text: String) {
        label.text = text
        super.init(frame: .zero)
        
        setupAppearance()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .darkText
        label.font = .boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    var binaryPicker: UIPickerView = {
        let binaryPicker = UIPickerView()
        return binaryPicker
    }()
    
    func setupAppearance() {
        self.addSubview(label)
        self.addSubview(binaryPicker)
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.trailing.equalTo(binaryPicker.snp.leading).offset(-12.0)
        }
        
        binaryPicker.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(label.snp.trailing).offset(12.0)
        }
    }
}
