//
//  onBoardingSecondPresenterTest.swift
//  AppWeatherVIPERTests
//
//  Created by Aleph-AHV2D on 04/11/24.
//

import XCTest
import Quick
import Nimble
@testable import AppWeatherVIPER

final class onBoardingSecondPresenterTest: QuickSpec {
    override class func spec() {
        var sut: onBoardingSecondPresenter!
        var mockViewController: mockView!
        var mockRouterController: mockRouter!

        beforeEach {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            sut = storyboard.instantiateViewController(withIdentifier: "onBoardingSecondVC") as? onBoardingSecond
//            sut.loadViewIfNeeded()
            sut = onBoardingSecondPresenter()
            mockViewController = mockView()
            mockRouterController = mockRouter()
            
            
            sut.view = mockViewController
            sut.router = mockRouterController
        }
        
        
        context("Alert berhasil digunakan!"){
            it("Menampilkan alert ketika username kosong!") {
                sut.alertInputUsername("")
                
                expect(mockViewController.showAlertCalled).to(beTrue())
            }
        }
        
        context("Button ditekan, useraname sudah benar dan menuju kelaman router"){
            beforeEach {
                mockViewController.showAlertCalled = false
            }
            
            it("Berhasil Berpindah kehalaman utama!"){
                mockRouterController.toHomePageBtn()
                expect(mockRouterController.isBtnPressed).to(beTrue())
            }
        }
    }
    
    class mockView: onBoardingSecondProtocol{
        var connectViewToPresenter: AppWeatherVIPER.onBoardingSecondPreProtocol?
        var showAlertCalled = false
        
        func showAlert(message: String) {
            showAlertCalled = true
        }
    }
    
    class mockRouter: onBoardingSecondRouterProtocol{
        var isBtnPressed = false
        
        func savaUsername(username: String) {}
        func toHomePageBtn() {
            isBtnPressed = true
        }
    }
}
