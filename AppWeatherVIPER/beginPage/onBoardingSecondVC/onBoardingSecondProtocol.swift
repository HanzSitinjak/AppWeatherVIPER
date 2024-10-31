//
//  onBoardingSecondProtocol.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 17/10/24.
//

import Foundation

protocol onBoardingSecondProtocol: AnyObject{
    var connectViewToPresenter: onBoardingSecondPreProtocol? {get set}
    func setComponent()
    func showAlert(message: String)
//    func validateUsername(_ username: String)
}

protocol onBoardingSecondPreProtocol: AnyObject{
    var view: onBoardingSecondProtocol? {get set}
    var interactor: onBoardingSecondInteractorProtocol? {get set}
    var router: onBoardingSecondRouterProtocol? {get set}
    
    func alertInputUsername(_ username:String)
}

protocol onBoardingSecondRouterProtocol: AnyObject {
    func savaUsername(username: String)
    func toHomePageBtn()
}

protocol onBoardingSecondInteractorProtocol:AnyObject{
    var connectInteractorToPresenter: onBoardingSecondPreProtocol? {get set}
}
