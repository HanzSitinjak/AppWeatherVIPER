//
//  homePageViewTest.swift
//  AppWeatherVIPERTests
//
//  Created by Aleph-AHV2D on 06/11/24.
//

import XCTest
import Nimble
import Quick
@testable import AppWeatherVIPER

final class homePageViewTest: QuickSpec {
    override class func spec() {
            describe("Unit Testing untuk menguji apakah data pada item scrollBox dapat ditampilkan pada view") {
                var sut: homePageView!
                var mockPresenterController: MockPresenter!
                
                beforeEach {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    sut = storyboard.instantiateViewController(withIdentifier: "homePage") as? homePageView
                    mockPresenterController = MockPresenter()
                    sut.presenterView = mockPresenterController
                    sut.loadViewIfNeeded()
                }

                context("Menguji apakah data yang dipilih dalam scrollBox ditampilkan pada view") {
                    beforeEach {
                        mockPresenterController.dataItemScrollBox = [
                            WeatherInfo(
                                temperature: 23,
                                humidity: 39,
                                weather: 2,
                                rainfall: 45.3,
                                date: "2024-11-05",
                                time: "07:00:00",
                                arahAngin: 23,
                                kecAngin: 11.3,
                                totalCloudCover: 23.1,
                                ketCuaca: "Sunny",
                                desCuaca: "Cerah"
                            )
                        ]
                        sut.showScrollBox(weatherData: mockPresenterController.dataItemScrollBox)
                        sut.setupScrollView()
                    }
                    
                    it("Data berhasil diambil dan ditampilkan pada scrollBox") {
                        // Memeriksa apakah subview di contentView sudah sesuai dengan jumlah yang diharapkan
                        expect(sut.contentView.subviews.count).to(equal(1))
                        if let firstItem = sut.contentView.subviews.first {
                            expect(firstItem.tag).to(equal(0))
                        }
                    }
                    
                    it("Data item scrollBox berhasil ditampilkan") {
                        // Mengambil label yang berisi temperatur
                        let container = sut.contentView.subviews.first
                        if let lblWeatherTemp = container?.viewWithTag(100) as? UILabel {
                            // Memastikan bahwa label berisi temperatur yang benar
                            expect(lblWeatherTemp.text).to(equal("23"))
                        } else {
                            fail("lblWeatherTemp tidak ditemukan")
                        }
                    }
                }
            }
        }
    
        class MockPresenter: homePagePreProtocol {
            var view: homePageViewProtocol?
            var router: homePageRouterProtocol?
            var interactor: homePageInteractorProtocol?
            var dataItemScrollBox: [WeatherInfo] = []
            var scrollBox: UIScrollView = UIScrollView()
            var lblWeatherTemp: UILabel = UILabel()
            var isItemPressed: Bool = true

            func itemContent(weatherInfo: WeatherInfo, index: Int) -> UIView {
                let container = UIView()
                container.tag = index

                lblWeatherTemp.tag = 100
                lblWeatherTemp.text = "\(weatherInfo.temperature)"

                container.addSubview(lblWeatherTemp)

                return container
            }

            func getWeatherAPI() {
                dataItemScrollBox = [
                    WeatherInfo(
                        temperature: 23,
                        humidity: 39,
                        weather: 2,
                        rainfall: 45.3,
                        date: "2024-11-05",
                        time: "07:00:00",
                        arahAngin: 23,
                        kecAngin: 11.3,
                        totalCloudCover: 23.1,
                        ketCuaca: "Sunny",
                        desCuaca: "Cerah"
                    )
                ]
            }

            func fetchItems(weatherData: [WeatherInfo]) -> [UIView] {
                var views: [UIView] = []
                for (index, weatherInfo) in weatherData.enumerated() {
                    let itemView = itemContent(weatherInfo: weatherInfo, index: index)
                    views.append(itemView)
                }
                return views
            }

            func itemContentPlaceholder(index: Int) -> UIView {
                return UIView()
            }
            
            func getInfoTapped() {}
            func getUsername() {}
        }
    }
