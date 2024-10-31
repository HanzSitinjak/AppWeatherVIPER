//
//  newsPageRouter.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 28/10/24.
//

import Foundation
import UIKit

class newsPageRouter: newsPageRouterProtocol{
    static func createModule() -> UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "newsPage") as? newsPageView
        let presenter = newsPagePresenter()
        let interactor = newsPageInteractor()
        let router = newsPageRouter()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view?.presenterToView = presenter
        
        return view ?? UIViewController()
    }
}
