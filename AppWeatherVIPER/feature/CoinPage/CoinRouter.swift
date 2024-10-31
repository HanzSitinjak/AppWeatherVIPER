//
//  CoinRouter.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 20/10/24.
//

import Foundation
import UIKit

protocol CoinRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

class CoinRouter: CoinRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "CoinViewVC") as? CoinView
//        let view = CoinView()
        let interactor = CoinInteractor()
        let presenter = CoinPresenter()
        let router = CoinRouter()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view?.presenter = presenter
        
        return view ?? UIViewController()
    }
}

