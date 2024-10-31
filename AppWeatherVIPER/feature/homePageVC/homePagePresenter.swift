//
//  homePagePresenter.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 17/10/24.
//

import Foundation
import UIKit
import CoreData

class homePagePresenter: homePagePreProtocol{
    
    weak var view: homePageViewProtocol?
    var router: homePageRouterProtocol?
    var interactor: homePageInteractorProtocol?
    var detailCuaca: [WeatherInfo] = []
    
    final func fetchUsername() -> [String] {
        var usernames: [String] = []
        let context = CoreDataManager.shared.context
        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        do{
            let result = try context.fetch(fetchRequest)
            usernames = result.compactMap{$0.username}
        }catch{
            print("Gagal mengambil username!: \(error.localizedDescription)")
        }
        return usernames
    }
    
    func itemContent(weatherInfo: WeatherInfo, index: Int) -> UIView{
            let container = UIView()
            let labelTemperatur = UILabel()
            let labelTime = UILabel()
            let imgWeather = UIImageView()
            
            container.translatesAutoresizingMaskIntoConstraints = false
            container.layer.cornerRadius = 8
            container.backgroundColor = UIColor(hex: "#9CE0FB")
            
            labelTemperatur.translatesAutoresizingMaskIntoConstraints = false
            labelTemperatur.text = "\(weatherInfo.temperature)°C"
            labelTemperatur.textAlignment = .center
            labelTemperatur.textColor = .white
            container.addSubview(labelTemperatur)
            
            labelTime.translatesAutoresizingMaskIntoConstraints = false
            labelTime.text = "\(weatherInfo.time)"
            labelTime.textColor = .white
            labelTime.textAlignment = .center
            labelTime.font = UIFont.systemFont(ofSize: 12.0)
            container.addSubview(labelTime)
            
            imgWeather.contentMode = .scaleAspectFit
            imgWeather.translatesAutoresizingMaskIntoConstraints = false
            container.addSubview(imgWeather)
            switch weatherInfo.weather{
                case 0, 1:
                    imgWeather.image = UIImage(named: "cerah")
                case 2:
                    imgWeather.image = UIImage(named: "cerahBerawan")
                case 3:
                    imgWeather.image = UIImage(named: "berawan")
                case 61:
                    imgWeather.image = UIImage(named: "hujan")
                default:
                    imgWeather.image = UIImage(named: "cerah")
            }
            
            NSLayoutConstraint.activate([
                imgWeather.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
                imgWeather.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                imgWeather.heightAnchor.constraint(equalToConstant: 40),

                labelTemperatur.topAnchor.constraint(equalTo: imgWeather.bottomAnchor, constant: 5),
                labelTemperatur.centerXAnchor.constraint(equalTo: container.centerXAnchor),

                labelTime.topAnchor.constraint(equalTo: labelTemperatur.bottomAnchor, constant: 5),
                labelTime.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                labelTime.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8)
            ])
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(itemTapped))
            container.addGestureRecognizer(tapGesture)
            container.tag = detailCuaca.firstIndex(of: weatherInfo) ?? -1
        
            return container
        }
    
    func itemContentPlaceholder(index: Int) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
//        container.layer.cornerRadius =
        container.backgroundColor = .lightGray
        container.showSkeletonLoader()
        
//        NSLayoutConstraint.activate([
//            container.heightAnchor.constraint(equalToConstant: 104),
//            container.widthAnchor.constraint(equalToConstant: 77)
//        ])
        
        return container
    }
    
    func fetchItems(weatherData: [WeatherInfo]) -> [UIView] {
        return weatherData.enumerated().map { index, weather in
            itemContent(weatherInfo: weather, index: index)
        }
    }
    
//    @objc func itemTapped(_ sender: UITapGestureRecognizer) {
//            guard let container = sender.view else { return }
//            let index = container.tag
//            if index >= 0 && index < detailCuaca.count {
//                let weatherInfo = detailCuaca[index]
//                view?.updateDataCuaca(with: weatherInfo)
//            }
//        }
    @objc func itemTapped(_ sender: UITapGestureRecognizer) {
        guard let container = sender.view else { return }
        let index = container.tag
        if index >= 0 && index < detailCuaca.count {
            let weatherInfo = detailCuaca[index]
            view?.updateDataCuaca(with: weatherInfo)
        }
    }
    
    func getWeatherAPI(){
        view?.showSkeletons()
        view?.showScrollBox(weatherData: nil)
        interactor?.fetchWeatherAPI{[weak self] result in
            switch result{
            case .success(let (lokasiInfo, cuacaInfo)):
                DispatchQueue.main.async{
                    self?.detailCuaca = cuacaInfo
                    self?.view?.updateData(lokasiInfo: lokasiInfo, cuacaInfo: cuacaInfo)
                    self?.view?.showScrollBox(weatherData: cuacaInfo)
                    if let firstItem = cuacaInfo.first{
                        self?.view?.updateDataCuaca(with: firstItem)
                    }
                    self?.view?.hideSkeletons()
//                    self?.printTemperatures(weatherData: cuacaInfo)
                }
            case .failure(let data):
                DispatchQueue.main.async{
                    self?.view?.showError("Gagal mendapatkan data!")
                    self?.view?.hideSkeletons()
                }
            }
        }
    }
    
    @objc func getInfoTapped() {
            print("Button Tapped - Navigating to News Page")
            view?.setupIconNewsButton()
            
            // Panggil fungsi router dengan meneruskan view controller saat ini
            if let currentVC = view as? UIViewController {
                router?.toNewsPage(from: currentVC)
            } else {
                print("Current view is not a UIViewController")
            }
        }
    
//    func printTemperatures(weatherData: [WeatherInfo]) {
//        for (index, weather) in weatherData.enumerated() {
//            print("Data \(index + 1): Temperatur = \(weather.temperature)°C")
//        }
//    }
}
