import UIKit

class splashScreen: UIViewController {
    @IBOutlet weak var nameApps: UILabel!
    @IBOutlet weak var iconWeather: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 2.5, animations: {
            self.nameApps.alpha = 0.0
            self.iconWeather.alpha = 0.0
        }){ _ in
            self.toOnboardingFirst()
        }
    }
    
    func toOnboardingFirst(){
        let onBoardingFirst = onBoardingFirstRouter.createModule()
        if let navController = self.navigationController{
            navController.pushViewController(onBoardingFirst, animated: true)
        }else{
            print("Navigation Failed")
        }
    }
}
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        view.backgroundColor = .white
//        
//        let logoImageView = UIImageView(image: UIImage(named: "WeatherIcon2"))
//        logoImageView.contentMode = .scaleAspectFit
//        logoImageView.translatesAutoresizingMaskIntoConstraints = false
//        
//        let labelApp = UILabel()
//        labelApp.text = "WeatherAppVIPER"
//        labelApp.textColor = UIColor(hex: "#9CE0FB")
//        labelApp.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
//        labelApp.translatesAutoresizingMaskIntoConstraints = false
//        
//        view.addSubview(logoImageView)
//        view.addSubview(labelApp)
//        
//        NSLayoutConstraint.activate([
//            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20.0),
//            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
//            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
//            
//            labelApp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            labelApp.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 70.0),
////            labelApp.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: -10),
//        ])
//        
//        UIView.animate(withDuration: 2.5, animations: {
//            logoImageView.alpha = 0.0   // Fade out
//            labelApp.alpha = 0.0
//        }) { _ in
//            self.toOnBoardingFirst()
//        }
//    }
//    
//    func toOnBoardingFirst() {
//        let onBoardingFirst = onBoardingFirstRouter.createModule()
//        
//        if let navController = self.navigationController {
//            navController.pushViewController(onBoardingFirst, animated: true)
//        } else {
//            print("Navigation Controller is nil")
//        }
//    }
//}
