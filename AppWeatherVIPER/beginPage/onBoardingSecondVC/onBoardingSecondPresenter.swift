//
//  onBoardingSecondPresenter.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 17/10/24.
//

import Foundation

class onBoardingSecondPresenter: onBoardingSecondPreProtocol {    
    weak var view: onBoardingSecondProtocol?
    var interactor: onBoardingSecondInteractorProtocol?
    var router: onBoardingSecondRouterProtocol?
    
    func alertInputUsername(_ username:String){
        let userInput = username.trimmingCharacters(in: .whitespacesAndNewlines)
        if userInput.isEmpty{
            view?.showAlert(message: "Username tidak boleh kosong!")
        }else{
            router?.savaUsername(username: username)
            router?.toHomePageBtn()
        }
    }
}
