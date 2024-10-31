//
//  onBoardingFirstRouter.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 17/10/24.
//

import Foundation
import UIKit

class onBoardingFirstRouter: onBoardingFirstRouterProtocol{
    weak var viewController : UIViewController?
    
    static func createModule() -> UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "onBoardingFirst") as? onBoardingFirst
        let presenter = onBoardingFirstPresenter()
        let router = onBoardingFirstRouter()
        
        view?.presenter = presenter
        presenter.view = view
        presenter.router = router
        router.viewController = view
        
        return view ?? UIViewController()
    }
    
    func toOnBoarding2Page() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let secondVC = storyboard.instantiateViewController(withIdentifier: "onBoardingSecondVC") as? onBoardingSecond {
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = CATransitionType.moveIn
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            
            viewController?.view.window?.layer.add(transition, forKey: kCATransition)
            viewController?.navigationController?.pushViewController(
                onBoardingSecondRouter.createModule(), animated: false)
            
        }
    }
}
