//
//  onBoardingSecondViewTest.swift
//  AppWeatherVIPERTests
//
//  Created by Aleph-AHV2D on 04/11/24.
//

import XCTest
import Quick
import Nimble
@testable import AppWeatherVIPER

final class onBoardingSecondViewTest: QuickSpec {
    override class func spec() {
            describe("Unit Test dari onBoardingSecond:") {
                var sut: onBoardingSecond!
                var mockPresenter: MockPresenterOnBoardingSecond!

                beforeEach {
    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    sut = storyboard.instantiateViewController(withIdentifier: "onBoardingSecondVC") as? onBoardingSecond
                    mockPresenter = MockPresenterOnBoardingSecond()
                    sut.connectViewToPresenter = mockPresenter
                    sut.loadViewIfNeeded()
                }

                context("Pengecekan ketika checkBox ditekan, namun textField Kosong!") {
                    beforeEach {
                        sut.checkBoxValidation.isChecked = true
                        sut.textFieldUsername.text = ""
                        sut.btnToHomePage.sendActions(for: .touchUpInside)
                    }

                    it("Akan muncul alert: Username tidak boleh kosong!") {
                        expect(mockPresenter.alertCalled).to(beTrue())
                    }
                }
                
                context("Pengecekan ketika semuanya dilakukan dengan benar!") {
                    beforeEach{
                        sut.checkBoxValidation.isChecked = true
                        sut.textFieldUsername.text = "Hans Agung"
                        sut.btnToHomePage.sendActions(for: .touchUpInside)
                    }
                    it("Tidak akan muncul alert!!") {
                        expect(mockPresenter.alertCalled).to(beFalse())
                    }
                }
                
                context("checkBox tidak diupdate statusnya"){
                    beforeEach{
                        sut.checkBoxValidation.isChecked = false
                        sut.btnToHomePage.sendActions(for: .touchUpInside)
                    }
                    
                    it("Button tidak akan bisa ditekan/ diberi aksi"){
                        expect(sut.btnToHomePage.isEnabled).to(beFalse())
                    }
                }
            }
            
            class MockPresenterOnBoardingSecond: onBoardingSecondPreProtocol {
                var view: onBoardingSecondProtocol?
                var interactor: onBoardingSecondInteractorProtocol?
                var router: onBoardingSecondRouterProtocol?

                var alertCalled = false
                func alertInputUsername(_ username: String) {
                    if username.isEmpty {
                        alertCalled = true
                    }
                }
            }
        }
    }
