//
//  OnBoardingFirstViewTests.swift
//  AppWeatherVIPERTests
//
//  Created by Aleph-AHV2D on 01/11/24.
//

// OnBoardingFirstViewTests.swift
import Quick
import Nimble
@testable import AppWeatherVIPER

class OnBoardingFirstViewTests: QuickSpec {
    override class func spec() {
        describe("Pengujian View OnBoarding1!") {
            var sut: onBoardingFirst!
            
            beforeEach {
                sut = onBoardingFirst()
            }
            
            context("Uji Coba View onBoardingFirst()!") {
                it("onBoardingfirstView ditampilkan!!") {
                    let mockPresenter = MockPresenterProtocol()
                    sut.presenter = mockPresenter
                    
                    sut.viewDidLoad()
                    expect(mockPresenter.isViewShow).to(beTrue())
                }
            }
        }
        
        class MockPresenterProtocol: onBoardingFirstPreProtocol {
            var isViewShow = false
            func viewDidLoad() {
                isViewShow = true
            }
            
            func nextButtonTapped() {}
        }
    }
}
