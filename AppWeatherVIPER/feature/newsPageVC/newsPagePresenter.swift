//
//  newsPagePresenter.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 28/10/24.
//

import Foundation
import UIKit

class newsPagePresenter: newsPagePreProtocol{
    weak var view: newsPageViewProtocol?
    var router: newsPageRouterProtocol?
    var interactor: newsPageInteractorProtocol?
    
    func getDataNews() -> [Item]?{
        guard let success = interactor?.getDataJSON() else {
            print("Gagal fetch data JSON!!")
            return nil
        }
        print("Data berhasil diambil!!")
        return success
    }
}
