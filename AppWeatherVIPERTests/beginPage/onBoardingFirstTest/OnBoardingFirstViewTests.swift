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
        describe("OnBoardingFirstView") {
            var sut: onBoardingFirst!

            beforeEach {
                sut = onBoardingFirst()
            }

            context("when viewDidLoad is called") {
                it("should call presenter viewDidLoad") {
                    let mockPresenter = MockOnBoardingFirstPreProtocol()
                    sut.presenter = mockPresenter
                    
                    sut.viewDidLoad()
                    
                    expect(mockPresenter.viewDidLoadCalled).to(beTrue())
                }
            }
        }
    }
}

// Mock untuk presenter
class MockOnBoardingFirstPreProtocol: onBoardingFirstPreProtocol {
    var viewDidLoadCalled = false
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func nextButtonTapped() {}
}

