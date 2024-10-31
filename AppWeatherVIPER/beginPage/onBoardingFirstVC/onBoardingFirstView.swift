//
//  onBoardingFirstView.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 17/10/24.
//

import Foundation
import UIKit

class onBoardingFirst: UIViewController, onBoardingFirstProtocol{
    
    @IBOutlet weak var toOnBoardingSecondBtn: buttonAssetGlobal!
    @IBOutlet weak var textGreeting: UILabel!
    @IBOutlet weak var textWelcome: UILabel!
    
    var presenter: onBoardingFirstPreProtocol?
    var router: onBoardingFirstRouter?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        presenter?.viewDidLoad()
    }
    
    @objc func btnOnBoarding2Pressed() {
        presenter?.nextButtonTapped()
    }
    
    func setupInitialState() {
        toOnBoardingSecondBtn.translatesAutoresizingMaskIntoConstraints = false
        toOnBoardingSecondBtn.fontColor = UIColor.white
        toOnBoardingSecondBtn.titleBtn = "Selanjutnya"
        toOnBoardingSecondBtn.colorBtn = UIColor(hex: "#9CE0FB")
        toOnBoardingSecondBtn.widthBtn = 320
        toOnBoardingSecondBtn.heightBtn = 60
        toOnBoardingSecondBtn.addTarget(self, action: #selector(btnOnBoarding2Pressed), for: .touchUpInside)
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        let fontSize = screenHeight / 20
        let sizeNext = screenHeight / 37
        let trailling = screenWidth / 6
        
        textGreeting.font = UIFont(name: "Arial Rounded MT Bold", size: fontSize)
        
        textGreeting.font = UIFont(name: "Arial Rounded MT Bold", size: sizeNext)
    }
    
    func toOnBoarding2Page() {
        presenter?.nextButtonTapped()
    }
}
