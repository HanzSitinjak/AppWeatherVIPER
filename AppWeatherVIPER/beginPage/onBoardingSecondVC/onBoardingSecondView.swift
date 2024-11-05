//
//  onBoardingSecondView.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 17/10/24.
//
import Foundation
import UIKit
import CoreData

class onBoardingSecond: UIViewController, onBoardingSecondProtocol{
    @IBOutlet weak var textFieldUsername: textFieldAsset!
    @IBOutlet weak var alertInputUser: UILabel!
    @IBOutlet weak var checkBoxValidation: checkBoxAsset!
    @IBOutlet weak var btnToHomePage: buttonAssetGlobal!
    
    var connectViewToPresenter: onBoardingSecondPreProtocol?
    var condition:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setComponent()
        checkBoxTap()
    }
    
    func setComponent() {
        //Ini modifikasi view utk textField
        guard let textFieldUsername = textFieldUsername else { return }
        textFieldUsername.frame.size.height = 50
        textFieldUsername.setProperty(
            fontColor: UIColor(hex: "#9CE0FB")!,
            borderWidth: 1.0,
            borderColor: UIColor(hex: "#9CE0FB")!,
            cornerRadius: 16.0,
            placeholder: "Tuliskan Username Disini!")
        textFieldUsername.delegate = textFieldUsername
        
        //untuk pengecekan status checkBox pada console
        checkBoxValidation.onCheckedCheckBox = { isCheckBoxChecked in
            if isCheckBoxChecked{
                print("checkBox dalam konsisi on")
            }else{
                print("checkBox dalam konsisi off")
            }
        }
        
        //Set Button to HomePage
        btnToHomePage.fontColor = UIColor.white
        btnToHomePage.titleBtn = "Selesai"
        btnToHomePage.colorBtn = UIColor(hex: "#9CE0FB")
        btnToHomePage.widthBtn = 340
        btnToHomePage.heightBtn = 60
        
        updateButtonState(isEnable: condition)
        
        btnToHomePage.addTarget(self, action: #selector(inputUsername), for: .touchUpInside)
        alertInputUser.isHidden = true
    }
    
    func updateButtonState(isEnable: Bool){
        if isEnable{
            btnToHomePage.isEnabled = true
            btnToHomePage.colorBtn = UIColor(hex: "#9CE0FB")!
            btnToHomePage.setTitleColor(.white, for: .normal)
        }else{
            btnToHomePage.isEnabled = false
            btnToHomePage.colorBtn = UIColor.lightGray
            btnToHomePage.setTitleColor(.white, for: .normal)
        }
    }
    func checkBoxTap(){
        checkBoxValidation.onCheckedCheckBox = {[weak self] isChecked in
//            self?.updateButtonState()
            self?.checkBoxStateChanged(isChecked)
        }
    }
    func checkBoxStateChanged(_ isChecked: Bool){
        self.updateButtonState(isEnable: isChecked)
    }
    
    @objc func inputUsername(){
        guard let username = textFieldUsername.text,
        !username.isEmpty else{
            print("Tidak ada inputan user!")
            self.validateUsername()
            return
        }
        print("Username yang diinput: \(username)")
        self.validateUsername()
    }
    
    func showAlert(message: String){
        alertInputUser.text = message
        alertInputUser.isHidden = false
    }
    
    private func validateUsername(){
        connectViewToPresenter?.alertInputUsername(textFieldUsername.text ?? "")
    }
}
