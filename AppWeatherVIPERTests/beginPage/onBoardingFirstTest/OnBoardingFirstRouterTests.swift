//
//  OnBoardingFirstRouterTests.swift
//  AppWeatherVIPERTests
//
//  Created by Aleph-AHV2D on 01/11/24.
//

import Quick
import Nimble
@testable import AppWeatherVIPER

class OnBoardingFirstRouterTests: QuickSpec {
    override class func spec() {
        describe("Testing untuk Router:"){
            var sut: onBoardingFirstRouter!
            var mockToView: UIViewController!
            var navigationController: UINavigationController!
        
            beforeEach {
                sut = onBoardingFirstRouter()
                mockToView = UIViewController()
                navigationController = UINavigationController(rootViewController: mockToView)
                
                sut.viewController = mockToView
                UIApplication.shared.keyWindow?.rootViewController = navigationController
            }
            
            context("Hasil Navigasi kehalaman toOnboarding 2:"){
                it("Dapat berpindah ke onBoarding 2!"){
                    sut.toOnBoarding2Page()
                    expect(navigationController.topViewController).toEventually(beAnInstanceOf(onBoardingSecond.self))
                }
            }
        }
    }
}
