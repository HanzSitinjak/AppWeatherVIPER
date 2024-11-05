//
//  homePageViewProtocol.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 19/10/24.
//

import Foundation
import UIKit

protocol homePageViewProtocol: AnyObject {
    var presenterView: homePagePreProtocol? {get set}
    
    func showUsername(usernames: [String])
//    func showWeatherData(_ data: [LokasiInfo])
    func showError(_ message: String)
    func updateData(lokasiInfo: [LokasiInfo],cuacaInfo: [WeatherInfo])
    func showScrollBox(weatherData: [WeatherInfo]?)
    func updateDataCuaca(with weatherInfo: WeatherInfo)
    func hideSkeletons()
    func showSkeletons()
    func setupIconNewsButton()
}

protocol homePagePreProtocol:AnyObject{
    var view: homePageViewProtocol? {get set}
    var router: homePageRouterProtocol? {get set}
    var interactor: homePageInteractorProtocol? {get set}
    
    func itemContent(weatherInfo: WeatherInfo, index: Int) -> UIView
    func getWeatherAPI()
    func fetchItems(weatherData: [WeatherInfo]) -> [UIView]
    func itemContentPlaceholder(index: Int) -> UIView
    func getInfoTapped()
    func getUsername()
    
}

protocol homePageInteractorProtocol: AnyObject{
    var presenterInteractor: homePagePreProtocol? {get set}
    func fetchWeatherAPI(completion: @escaping (Result<([LokasiInfo],[WeatherInfo]), Error>) -> Void)
    func fetchUsername() -> [String]
}

protocol homePageRouterProtocol:AnyObject{
    static func createModule() -> UIViewController
    func toNewsPage(from view: UIViewController?)
}


