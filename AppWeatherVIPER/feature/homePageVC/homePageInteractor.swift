//
//  homePageInteractor.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 17/10/24.
//

import Foundation
import UIKit
//import Alamofire
//import SwiftyJSON

class HomePageInteractor: homePageInteractorProtocol {
    weak var presenterInteractor: homePagePreProtocol?
    private var lokasiDetails: [LokasiInfo] = []
    private var cuacaDetails: [WeatherInfo] = []
    final func fetchWeatherAPI(completion: @escaping (Result<([LokasiInfo],[WeatherInfo]), Error>) -> Void) {
        let urlData = "https://api.bmkg.go.id/publik/prakiraan-cuaca?adm4=31.74.05.1001"
        guard let url = URL(string: urlData) else { return }
        
        let getData = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Gagal mendapatkan data!!: \(String(describing: error))")
                return
            }
            
            do {
                if let dataCuaca = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let dataCuacaArray = dataCuaca["data"] as? [[String: Any]] {
                    
                    if let lokasiArray = dataCuaca["lokasi"] as? [String: Any] {
                        if let provinsi = lokasiArray["provinsi"] as? String,
                           let kabupaten = lokasiArray["kota"] as? String,
                           let kecamatan = lokasiArray["kecamatan"] as? String {
                            print("Ini Provinsi: \(provinsi), Kota: \(kabupaten), Kecamatan: \(kecamatan)")
                            
                            let lokasiInfo = LokasiInfo(provinsi: provinsi, kabupaten: kabupaten, kecamatan: kecamatan)
                            self.lokasiDetails.append(lokasiInfo)
                            
                            for cuaca in dataCuacaArray{
                                if let cuacaArray = cuaca["cuaca"] as? [[Any]]{
                                    let cuacas = cuacaArray.flatMap({ $0 })
                                    for cuaca in cuacas{
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                                        
                                        if let detailCuaca = cuaca as? [String: Any]{
                                            if let temperatur = detailCuaca["t"] as? Int,
                                               let humidity = detailCuaca["hu"] as? Int,
                                               let weather = detailCuaca["weather"] as? Int,
                                               let rainfall = detailCuaca["tp"] as? Double,
                                               let arahAngin = detailCuaca["wd_deg"] as? Int,
                                               let kecAngin = detailCuaca["ws"] as? Double,
                                               let totalCloudCover = detailCuaca["tcc"] as? Double,
                                               let ketCuaca = detailCuaca["weather_desc"] as? String,
                                               let desCuaca = detailCuaca["weather_desc_en"] as? String,
                                               let localDatetime = detailCuaca["local_datetime"] as? String,
                                               let date = dateFormatter.date(from: localDatetime){
                                                dateFormatter.dateFormat = "d MMMM yyyy"
                                                let dateString = dateFormatter.string(from: date)
                                                dateFormatter.dateFormat = "HH:mm"
                                                let timeString = dateFormatter.string(from: date)
                                            
                                                let weatherInfo = WeatherInfo(temperature: temperatur, humidity: humidity, weather: weather, rainfall: rainfall, date: dateString, time: timeString, arahAngin: arahAngin, kecAngin: kecAngin, totalCloudCover: totalCloudCover, ketCuaca: ketCuaca, desCuaca: desCuaca
                                                )
                                                self.cuacaDetails.append(weatherInfo)
                                            }
                                        }
                                    }
                                }
                            }
                            completion(.success((self.lokasiDetails, self.cuacaDetails)))
                        } else {
                            print("Gagal mengambil data lokasi")
                        }
                    }
                }
            } catch {
                print("Error saat parsing JSON: \(error)")
            }
        }
        
        getData.resume()
    }
}
