//
//  CoinInteractor.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 20/10/24.
//

import Foundation
//import Alamofire

protocol CoinInteractorProtocol: AnyObject {
    func fetchBitcoinPrice(completion: @escaping (Result<Double, Error>) -> Void)
}

protocol CoinInteractorOutputProtocol: AnyObject {
//    func bitcoinPriceFetched(_ coin: Coin)
//    func bitcoinPriceFetchFailed(_ error: Error)
}

class CoinInteractor: CoinInteractorProtocol {
    weak var presenter: CoinInteractorProtocol?

    func fetchBitcoinPrice(completion: @escaping (Result<Double, Error>) -> Void) {
            let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice/BTC.json")!

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                    return
                }

                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let bpi = json["bpi"] as? [String: Any],
                       let usd = bpi["USD"] as? [String: Any],
                       let rate = usd["rate_float"] as? Double {
                        print("Bitcoin Price: \(rate)") // Cetak di console
                        completion(.success(rate))
                    } else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON"])))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
}

