//
//  ViewController.swift
//  TempTracker
//
//  Created by Jacqueline Sloves on 3/19/20.
//  Copyright © 2020 Jacqueline Sloves. All rights reserved.
//

import SnapKit
import CoreLocation

class TTRecordViewController: UIViewController {
    let locationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D?

    var tempPickerData: [String] = ["\u{00B0}F", "\u{00B0}C"]
    var binaryPickerData: [String] = ["Yes", "No"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupFormFields()
        setupAppearance()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.requestWhenInUseAuthorization()
        getLocation()
    }
    
    
    func getLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func setupFormFields() {
        tempField.tempTypePicker.dataSource = self
        tempField.tempTypePicker.delegate = self
        tempField.tempTextField.delegate = self
        canWorkBox.binaryPicker.dataSource = self
        canWorkBox.binaryPicker.delegate = self
    }
    
    func setupAppearance() {
        containerView.addSubview(dateComponent)
        containerView.addSubview(tempField)
        containerView.addSubview(canWorkBox)
        containerView.addSubview(symptomsSection)
        containerView.addSubview(submitButton)
        view.addSubview(containerView)
    }
        
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        dateComponent.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18.0)
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-18.0)
            make.height.equalTo(180.0)
        }
        
        tempField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18.0)
            make.top.equalTo(dateComponent.snp.bottom).offset(6.0)
            make.trailing.equalToSuperview().offset(-18.0)
            make.height.equalTo(100.0)
        }
        
        canWorkBox.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18.0)
            make.top.equalTo(tempField.snp.bottom).offset(6.0)
            make.trailing.equalToSuperview().offset(-18.0)
            make.height.equalTo(100.0)
        }
        
        symptomsSection.snp.makeConstraints { make in
            make.leading.trailing.equalTo(dateComponent)
            make.top.equalTo(canWorkBox.snp.bottom)
            make.bottom.equalTo(submitButton.snp.top)
        }

        
        submitButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18.0)
            make.top.equalTo(symptomsSection.snp.bottom)
            make.bottom.trailing.equalToSuperview().offset(-18.0)
            make.height.equalTo(60.0)
        }
    }
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let dateComponent: TTDatePickerComponent = {
        let datePicker = TTDatePickerComponent()
        return datePicker
    }()
    
    private let tempField: TTTemperatureComponent = {
        let tempField = TTTemperatureComponent()
        tempField.tempTypePicker.tag = 0
        return tempField
    }()
    
    private let canWorkBox: TTBinaryComponent = {
        let canWorkComponent = TTBinaryComponent(text: "Are you able to work?")
        canWorkComponent.binaryPicker.tag = 1
        return canWorkComponent
    }()
    
    private let symptomsSection: TTSymptomsComponent = {
        return TTSymptomsComponent()
    }()
    
    private let alertController: UIAlertController = {
         return UIAlertController(title: "Invalid Temp", message: "Please enter your temperature.", preferredStyle: .alert)
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        button.backgroundColor = .blue
        button.setTitle("Submit Temp", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    func setButtonEnabledState() {
        submitButton.isEnabled = validateEntries()
    }
    
    @objc func submitButtonTapped() {
        if validateEntries() {
            logEntry()
        }
        clearForm()
    }
    
    func validateEntries() -> Bool {
        return true
    }
    
    func logEntry() {
        print("Date: \(dateComponent.datePicker.date)")
        print("Temp: \(String(describing: tempField.tempTextField.text)) \(tempPickerData[tempField.tempTypePicker.selectedRow(inComponent: 0)])")
        print("Can work? \(binaryPickerData[canWorkBox.binaryPicker.selectedRow(inComponent: 0)])")
        print("Symptoms: \(selectedSymptoms())")
        print("Location: \(userLocation?.latitude) \(userLocation?.longitude)")
    }
    
    func selectedSymptoms() -> [String] {
        var selectedSymptoms: [String] = []
        for s in symptomsSection.symptomCheckBoxes {
            if s.isChecked {
                selectedSymptoms.append(s.titleLabel?.text ?? "")
            }
        }
        return selectedSymptoms
    }

    func clearForm() {
        
    }
}

extension TTRecordViewController: UIPickerViewDelegate, UIPickerViewDataSource {
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return tempPickerData.count
        default:
            return binaryPickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return tempPickerData[row]
        default:
            return binaryPickerData[row]
        }
    }
}

extension TTRecordViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("text field did finish editing")
        validateEntry(text: textField.text as NSString?)
    }
    
    func validateEntry(text: NSString?) {
        guard let textInput = text, (textInput.floatValue > 55.0 && textInput.floatValue < 115.0) else {
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                self?.alertController.dismiss(animated: true)
            }))
                
            self.present(alertController, animated: true, completion: nil)
            return
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension TTRecordViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        userLocation = locValue
    }
}


