//
//  onBoardingFirstPresenter.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 17/10/24.
//

import Foundation
import UIKit

class onBoardingFirstPresenter: onBoardingFirstPreProtocol{
    weak var view: onBoardingFirstProtocol?
    var router: onBoardingFirstRouterProtocol?
    
    func viewDidLoad() {
        view?.setupInitialState()
    }
    
    func nextButtonTapped() {
        router?.toOnBoarding2Page()
    }
}
