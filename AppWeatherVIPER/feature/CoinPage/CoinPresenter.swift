import Foundation

protocol CoinPresenterProtocol: AnyObject {
    func fetchPrice()
}

class CoinPresenter: CoinPresenterProtocol {
    
    weak var view: CoinViewProtocol?
    var interactor: CoinInteractorProtocol?
    var router: CoinRouterProtocol?

    func fetchPrice() {
        interactor?.fetchBitcoinPrice { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let price):
                    let formattedPrice = String(format: "Bitcoin Price: $%.2f", price)
                    self?.view?.showPrice(formattedPrice)
                case .failure(let error):
                    self?.view?.showError(error.localizedDescription)
                }
            }
        }
    }
}
