//
//  homePagePresenterTest.swift
//  AppWeatherVIPERTests
//
//  Created by Aleph-AHV2D on 05/11/24.
//

import XCTest
import Nimble
import Quick
@testable import AppWeatherVIPER

final class homePagePresenterTest: QuickSpec {
    override class func spec() {
            var sut: homePagePresenter!
            var mockViewController: MockView!
            var mockInteractorController: MockInteractor!
            var mockRouterController: MockRouter!

            describe("Unit testing for presenter HomePage") {
                beforeEach {
                    sut = homePagePresenter()
                    mockViewController = MockView()
                    mockInteractorController = MockInteractor()
                    mockRouterController = MockRouter()
                    
                    sut.view = mockViewController
                    sut.interactor = mockInteractorController
                    sut.router = mockRouterController
                }
                
                context("Menguji apakah username yang diinput berhasil dipanggil?") {
                    beforeEach {
                        sut.getUsername()
                    }
                    
                    it("Username berhasil dipanggil menggunakan dummy data!") {
                        expect(mockViewController.usernameLabel.text).to(equal("Anto"))
                    }
                }
                
                context("Menguji apakah data API berhasil di-fetch pada ScrollBox view!") {
                    beforeEach {
                        mockInteractorController.mockWeatherInfo = [WeatherInfo(temperature: 23, humidity: 39, weather: 2, rainfall: 45.3, date: "2024-11-05", time: "07:00:00", arahAngin: 23, kecAngin: 11.3, totalCloudCover: 23.1, ketCuaca: "Sunny", desCuaca: "Cerah")]
                        sut.getWeatherAPI()
                    }
                    
                    it("Data cuaca berhasil di-update pada view!") {
                        waitUntil { done in
                            DispatchQueue.main.async {
                                expect(mockViewController.updatedWeatherData?.first?.temperature).to(equal(23))
                                done()
                            }
                        }
                    }
//                    it("Data cuaca berhasil di-update pada view!") {
//                        sut.getWeatherAPI()
//                        expect(mockViewController.updatedWeatherData?.first?.temperature).to(equal(23))
//                    }
                }
            }
        
        class MockView: homePageViewProtocol {
            var presenterView: homePagePreProtocol?
            var usernameLabel: UILabel = UILabel()
            var updatedWeatherData: [WeatherInfo]?

            func showUsername(usernames: [String]) {
                usernameLabel.text = usernames.last ?? "Tidak ada username"
            }
            
            
            func showError(_ message: String) {
                
            }
            
            func updateData(lokasiInfo: [LokasiInfo], cuacaInfo: [WeatherInfo]) {
//
            }
            
            func showScrollBox(weatherData: [WeatherInfo]?) {
                updatedWeatherData = weatherData
            }
            
            func updateDataCuaca(with weatherInfo: WeatherInfo) {
                
            }
            
            func hideSkeletons() {
                // Implementasi kosong untuk keperluan pengujian
            }
            
            func showSkeletons() {
                // Implementasi kosong untuk keperluan pengujian
            }
            
            func setupIconNewsButton() {
                // Implementasi kosong untuk keperluan pengujian
            }
        }
        
        class MockInteractor: homePageInteractorProtocol {
            var mockUsernames: [String] = ["Hans", "Anto"]
            let mockLokasiInfo = [LokasiInfo(provinsi: "Aceh", kabupaten: "Nutilima", kecamatan: "Kuta Cane")]
            var mockWeatherInfo: [WeatherInfo] = []
            var presenterInteractor: homePagePreProtocol?
            
            func fetchUsername() -> [String] {
                return mockUsernames
            }
            
            func fetchWeatherAPI(completion: @escaping (Result<([LokasiInfo], [WeatherInfo]), Error>) -> Void) {
                completion(.success((mockLokasiInfo, mockWeatherInfo)))
                }
            }
        }
        
        class MockRouter: homePageRouterProtocol {
            static func createModule() -> UIViewController {
                return UIViewController() // Implementasi contoh
            }
            
            func toNewsPage(from view: UIViewController?) {
                // Implementasi kosong untuk keperluan pengujian
            }
        }
    }
