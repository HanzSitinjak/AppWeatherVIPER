//
//  onBoardingFirstRouter.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 17/10/24.
//

import Foundation

protocol onBoardingFirstProtocol: AnyObject{
    func setupInitialState()
}

protocol onBoardingFirstRouterProtocol: AnyObject{
    func toOnBoarding2Page()
}

protocol onBoardingFirstPreProtocol{
    func viewDidLoad()
    func nextButtonTapped()
}

