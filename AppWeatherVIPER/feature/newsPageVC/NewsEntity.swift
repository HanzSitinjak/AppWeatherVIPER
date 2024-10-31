//
//  NewsEntity.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 28/10/24.
//

import Foundation

struct Item: Codable {
    let id: Int
    let judul_berita: String
    let news_desc: String
    let jumlah_like: Int
    let tanggal_update: String
    let url_newsImg: String
    let penerbit: String
    let desc_detail_news: String
}
