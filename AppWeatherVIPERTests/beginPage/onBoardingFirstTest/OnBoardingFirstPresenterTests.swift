//
//  OnBoardingFirstPresenterTests.swift
//  AppWeatherVIPERTests
//
//  Created by Aleph-AHV2D on 01/11/24.
//

import XCTest
import Nimble
import Quick
@testable import AppWeatherVIPER

class OnBoardingFirstPresenterTests: QuickSpec {
    override class func spec(){
        describe("Testing unit untuk presenter FirstOnBoarding!"){
            var routerOnBoardingFirst: mockOnBoardingRouter!
            var viewOnBoardingFirst: mockOnBoardingView!
            var sut: onBoardingFirstPresenter!
            
            beforeEach {
                //Persiapan komponen dan relation untuk contexy nanti.
                sut = onBoardingFirstPresenter()
                viewOnBoardingFirst = mockOnBoardingView()
                routerOnBoardingFirst = mockOnBoardingRouter()
                
                sut.view = viewOnBoardingFirst
                sut.router = routerOnBoardingFirst
            }
            
            context("Test uji koneksi Presenter -> View!!") {
                it("Hasil test case Presenter -> View") {
                    sut.viewDidLoad()
                    expect(viewOnBoardingFirst.isViewSuccess).to(beTrue())
                }
            }
            
            context("Test uji koneksi Presenter -> Router!!") {
                it("Hasil test case Presenter -> Router") {
                    sut.nextButtonTapped()
                    expect(routerOnBoardingFirst.isBtnIsConnection).to(beTrue())
                }
            }
        }
    }
    
    class mockOnBoardingView: onBoardingFirstProtocol {
        var isViewSuccess = false
        func setupInitialState() {
            isViewSuccess = true
        }
    }
    
    class mockOnBoardingRouter: onBoardingFirstRouterProtocol{
        var isBtnIsConnection = false
        func toOnBoarding2Page() {
            isBtnIsConnection = true
        }
    }
}
