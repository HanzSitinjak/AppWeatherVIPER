//
//  onBoardingSecondRouter.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 17/10/24.
//

import Foundation
import UIKit
import CoreData

class onBoardingSecondRouter: onBoardingSecondRouterProtocol{
    
    var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        //pada bagian ini seluruh Class VIPER akan dideklarasikan.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "onBoardingSecondVC") as? onBoardingSecond
        let presenter = onBoardingSecondPresenter()
        let interactor = onBoardingSecondInteractor()
        let router = onBoardingSecondRouter()
        
        //Kemadian, pada bagian ini kita akan membuat relasi antar Class yang kita deklarasikan tadi.
        //Dimana view akan meng instance(cetakan dari objekAwal)  var connectInteractor..., yang ada pada View.
        view?.connectViewToPresenter = presenter // ini adalah perwujutan Class onBoardingPresenter.
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.connectInteractorToPresenter = presenter
        
        router.viewController = view
        return view ?? UIViewController()
    }
    
    func savaUsername(username: String) {
        let dataUser = CoreDataManager.shared.context
        let user = AppUser(context: dataUser)
        user.username = username
        do{
            try dataUser.save()
            print("User berhasil disimpan!")
        }catch{
            print("Gagal menyimpan user!")
        }
    }
    
    func toHomePageBtn() {
        viewController?.navigationController?.pushViewController(homePageRouter.createModule(), animated: true)
    }
}

