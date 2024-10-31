//
//  homePageEntity.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 17/10/24.
//

import Foundation

struct WeatherInfo:Equatable{
    let temperature: Int
    let humidity: Int
    let weather: Int
    let rainfall: Double
    let date: String
    let time: String
    let arahAngin: Int
    let kecAngin: Double
    let totalCloudCover: Double
    let ketCuaca: String
    let desCuaca: String
}

struct LokasiInfo{
    let provinsi: String
    let kabupaten: String
    let kecamatan: String
}

