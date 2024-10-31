//
//  Coin.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 20/10/24.
//

import Foundation

struct Coin: Codable {
    let bitcoin: Bitcoin
}

struct Bitcoin: Codable {
    let usd: Double
}
