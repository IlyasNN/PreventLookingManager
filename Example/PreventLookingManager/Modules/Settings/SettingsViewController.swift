//
//  SettingsViewController.swift
//  PreventLookingManager_Example
//
//  Created by Илья Соловьёв on 09.05.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import PreventLookingManager

class SettingsViewController: UIViewController {

    @IBOutlet weak var cameraPickerView: UIPickerView!
    @IBOutlet weak var timeoutSlider: UISlider!
    @IBOutlet weak var timeoutLabel: UILabel!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var speedLabel: UILabel!
    
    var timeout = Int(Constants.defaultTimeout)
    var speed = Int(Constants.defaultSpeed)
    var cameraPosition = CameraPosition.front
    let pickerData = ["Front", "Back"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        
        cameraPickerView.delegate = self
        cameraPickerView.dataSource = self
        
        timeoutSlider.setValue(Constants.defaultTimeout, animated: true)
        timeoutSlider.addTarget(self, action: #selector(timeoutSliderValueChangedFunc), for: .valueChanged)
        timeoutLabel.text = "10 sec"
        
        speedSlider.setValue(Constants.defaultSpeed, animated: true)
        speedSlider.addTarget(self, action: #selector(speedSliderValueChangedFunc), for: .valueChanged)
        speedLabel.text = "20 km/h"
    }
    
    @objc func timeoutSliderValueChangedFunc() {
        timeout = Int(timeoutSlider.value)
        timeoutLabel.text = "\(timeout) sec"
    }
    
    @objc func speedSliderValueChangedFunc() {
        speed = Int(speedSlider.value)
        speedLabel.text = "\(speed) km/h"
    }
    
    @IBAction func configureAppManagerTapped(_ sender: Any) {
        let plmConfig = PreventLookingManagerConfig(timeout: timeout,
                                                    minimumSpeed: Double(speed),
                                                    camera: cameraPosition.getAppleCameraPosition())
        PreventLookingAppManager.configure(with: plmConfig)
    }
    
}

// MARK: UIPickerViewDataSource

extension SettingsViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerData.count
    }
    
}

// MARK: UIPickerViewDelegate

extension SettingsViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.cameraPosition = CameraPosition.getByIndex(row)
    }
    
}
