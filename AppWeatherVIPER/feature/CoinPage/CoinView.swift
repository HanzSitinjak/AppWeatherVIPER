//
//  CoinView.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 20/10/24.
//

import Foundation
//import UIKit
//
//protocol CoinViewProtocol: AnyObject {
////    func showPrice(_ price: String)
//    func showError(_ error: String)
//}
//
//class CoinView: UIViewController, CoinViewProtocol {
//    
//    var presenter: CoinPresenterProtocol?
//
//    private let priceLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Bitcoin Price: -"
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 24)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let fetchButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Fetch Bitcoin Price", for: .normal)
//        button.backgroundColor = .systemBlue
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 8
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupLayout()
//        fetchButton.addTarget(self, action: #selector(fetchButtonTapped), for: .touchUpInside)
//        
//    }
//
//    private func setupLayout() {
//        view.addSubview(priceLabel)
//        view.addSubview(fetchButton)
//
//        NSLayoutConstraint.activate([
//            priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            priceLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
//            
//            fetchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            fetchButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
//            fetchButton.widthAnchor.constraint(equalToConstant: 200),
//            fetchButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//
//    @objc private func fetchButtonTapped() {
//        presenter?.fetchPrice() 
//    }
//
//    func showPrice(_ price: String) {
//        priceLabel.text = price
//    }
//
//    func showError(_ error: String) {
//        print("Error: \(error)")
//        priceLabel.text = error
//    }
//}

import UIKit

protocol CoinViewProtocol: AnyObject {
    func showPrice(_ price: String)
    func showError(_ error: String)
    func showLoading(_ isLoading: Bool)
}

class CoinView: UIViewController, CoinViewProtocol {

    var presenter: CoinPresenterProtocol?

    // MARK: - UI Components
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Bitcoin Price: -"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .darkGray
        return label
    }()

    private let fetchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Fetch Bitcoin Price", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemGray
        indicator.hidesWhenStopped = true
        return indicator
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
        setupLayout()
        
        fetchButton.addTarget(self, action: #selector(fetchButtonTapped), for: .touchUpInside)
    }

    // MARK: - Setup Layout
    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [priceLabel, fetchButton, activityIndicator])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            fetchButton.widthAnchor.constraint(equalToConstant: 250)
        ])
    }

    // MARK: - Button Action
    @objc private func fetchButtonTapped() {
        presenter?.fetchPrice()
    }

    // MARK: - CoinViewProtocol Methods
    func showPrice(_ price: String) {
        priceLabel.text = price
        showLoading(false)
    }

    func showError(_ error: String) {
        priceLabel.text = "Error: \(error)"
        showLoading(false)
    }

    func showLoading(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
            fetchButton.isEnabled = false
            fetchButton.alpha = 0.5
        } else {
            activityIndicator.stopAnimating()
            fetchButton.isEnabled = true
            fetchButton.alpha = 1.0
        }
    }
}

