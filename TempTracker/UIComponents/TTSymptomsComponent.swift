//
//  TTSymptomsComponent.swift
//  TempTracker
//
//  Created by Jacqueline Sloves on 3/19/20.
//  Copyright © 2020 Jacqueline Sloves. All rights reserved.
//

import SnapKit

class TTSymptomsComponent: UIView, TTCheckmarkButtonDelegate {
    
    var symptoms: [String] = ["Coughing", "Fever", "Sore Throat", "Headache", "Nausea", "None"]
    var symptomCheckBoxes: [TTCheckmarkButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupCheckmarks()
        setupAppearance()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Symptoms - check all that apply", comment: "Self-reported symptoms.")
        label.textAlignment = .left
        label.textColor = .darkText
        label.font = .boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    func setupCheckmarks() {
        for s in symptoms {
            let checkmarkBox = TTCheckmarkButton(delegate: self, title: s)
            self.addSubview(checkmarkBox)
            symptomCheckBoxes.append(checkmarkBox)
        }
    }
    
    func setupAppearance() {
        self.addSubview(label)
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(30.0)
        }
        
        for (i, b) in symptomCheckBoxes.enumerated() {
            b.snp.makeConstraints { make in
                make.leading.trailing.equalTo(label)
                if i == 0 {
                    make.top.equalTo(label.snp.bottom)
                } else {
                    make.top.equalTo(symptomCheckBoxes[i-1].snp.bottom)
                }
                make.height.equalTo(30.0)
            }
        }
    }
    
    func checkmarkChanged(symptom: TTCheckmarkButton) {
        if symptom.titleLabel?.text == "None" {
            for b in symptomCheckBoxes {
                if b.titleLabel?.text != "None" {
                    b.isChecked = false
                }
            }
        } else {
            for b in symptomCheckBoxes {
                if b.titleLabel?.text == "None" {
                    b.isChecked = false
                }
            }
        }
    }
}
