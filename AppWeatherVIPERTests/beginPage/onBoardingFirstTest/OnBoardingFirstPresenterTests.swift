//
//  OnBoardingFirstPresenterTests.swift
//  AppWeatherVIPERTests
//
//  Created by Aleph-AHV2D on 01/11/24.
//

// OnBoardingFirstPresenterTests.swift
import XCTest
// OnBoardingFirstPresenterTests.swift
import Quick
import Nimble
@testable import AppWeatherVIPER

class OnBoardingFirstPresenterTests: QuickSpec {
    override class func spec() {
        describe("OnBoardingFirstPresenter") {
            var sut: onBoardingFirstPresenter!
            var mockView: MockOnBoardingFirstProtocol!
            var mockRouter: MockOnBoardingFirstRouterProtocol!

            beforeEach {
                sut = onBoardingFirstPresenter()
                mockView = MockOnBoardingFirstProtocol()
                mockRouter = MockOnBoardingFirstRouterProtocol()
                
                sut.view = mockView
                sut.router = mockRouter
            }

            context("when viewDidLoad is called") {
                it("should call setupInitialState on the view") {
                    sut.viewDidLoad()
                    expect(mockView.setupInitialStateCalled).to(beTrue())
                }
            }

            context("when nextButtonTapped is called") {
                it("should call toOnBoarding2Page on the router") {
                    sut.nextButtonTapped()
                    expect(mockRouter.toOnBoarding2PageCalled).to(beTrue())
                }
            }
        }
    }
}

// Mock untuk view
class MockOnBoardingFirstProtocol: onBoardingFirstProtocol {
    var setupInitialStateCalled = false
    
    func setupInitialState() {
        setupInitialStateCalled = true
    }
}

// Mock untuk router
class MockOnBoardingFirstRouterProtocol: onBoardingFirstRouterProtocol {
    var toOnBoarding2PageCalled = false
    
    func toOnBoarding2Page() {
        toOnBoarding2PageCalled = true
    }
}
