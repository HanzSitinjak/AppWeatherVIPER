//
//  onBoardingSecondRouterTest.swift
//  AppWeatherVIPERTests
//
//  Created by Aleph-AHV2D on 04/11/24.
//

import XCTest
import Quick
import Nimble
@testable import AppWeatherVIPER

final class onBoardingSecondRouterTest: QuickSpec {
    override class func spec() {
        var sut: onBoardingSecondRouter!
        var mockToView: UIViewController!
        var navigationController: UINavigationController!
        
        beforeEach {
            sut = onBoardingSecondRouter()
            mockToView = UIViewController()
            navigationController = UINavigationController(rootViewController: mockToView)
            
            sut.viewController = mockToView
            UIApplication.shared.keyWindow?.rootViewController = navigationController
        }
        
        context("Target navigasi adalah mainPage!"){
            it("Berhasil berpindah ke halamana mainpage!"){
                sut.toHomePageBtn()
                expect(navigationController.topViewController).toEventually(beAnInstanceOf(homePageView.self))
            }
        }
    }
}
