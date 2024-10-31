import Foundation
import UIKit

class homePageRouter: homePageRouterProtocol {
    var viewController: UIViewController?
    
    static func createModule() -> UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "homePage") as? homePageView
        let presenter = homePagePresenter()
        let interactor = HomePageInteractor()
        let router = homePageRouter()
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        view?.presenterView = presenter
        router.viewController = view
        
        return view ?? UIViewController()
    }
    
    func toNewsPage(from viewController: UIViewController?) {
        if let navPage = viewController?.navigationController{
            navPage.pushViewController(newsPageRouter.createModule(), animated: true)
        }else{
            print("View Controller tidak ditemukan!")
        }
        
    }
}
