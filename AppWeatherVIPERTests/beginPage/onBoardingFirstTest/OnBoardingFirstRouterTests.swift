//
//  OnBoardingFirstRouterTests.swift
//  AppWeatherVIPERTests
//
//  Created by Aleph-AHV2D on 01/11/24.
//

import XCTest
// OnBoardingFirstRouterTests.swift
import Quick
import Nimble
@testable import AppWeatherVIPER

class OnBoardingFirstRouterTests: QuickSpec {
    override class func spec() {
        describe("OnBoardingFirstRouter") {
            var sut: onBoardingFirstRouter!
            var mockViewController: UIViewController!

            beforeEach {
                sut = onBoardingFirstRouter()
                mockViewController = UIViewController()
                sut.viewController = mockViewController
            }

            context("when navigating to OnBoarding2Page") {
                it("should navigate to the second onboarding page") {
                    sut.toOnBoarding2Page()
                    
                    // Verifikasi bahwa viewController navigasi ke halaman yang benar
                    expect(mockViewController.navigationController).toNot(beNil())
                }
            }
        }
    }
}
