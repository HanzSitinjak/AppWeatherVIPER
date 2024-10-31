//
//  newsPageInteractor.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 28/10/24.
//

import Foundation
import UIKit

class newsPageInteractor: newsPageInteractorProtocol{
    final func getDataJSON() -> [Item]? {
        guard let url = Bundle.main.url(forResource: "dataBerita", withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([Item].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}
