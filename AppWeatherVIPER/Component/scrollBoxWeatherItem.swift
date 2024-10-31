//
//  scrollBoxWeatherItem.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 19/10/24.
//

import UIKit

class ScrollBoxWeatherItem: UIView {
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScrollView()
    }

    // Setup ScrollView dan ContentView
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true

        addSubview(scrollView)

//         Layout untuk ScrollView
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView) // Perbaikan: Tambahkan contentView ke scrollView

//         Layout untuk ContentView
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }

    // Fungsi untuk menambahkan 15 container persegi panjang ke dalam ScrollBox
    func configureItems(with items: [UIView], height: CGFloat, width: CGFloat) {
        let spacing: CGFloat = 5.0
        var previousContainer: UIView? = nil
        var heightItem = height
        var widthItem = width

        for container in items {
            contentView.addSubview(container)

            NSLayoutConstraint.activate([
                container.widthAnchor.constraint(equalToConstant: widthItem),
                container.heightAnchor.constraint(equalToConstant: heightItem),
                container.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])

            if let previous = previousContainer {
                NSLayoutConstraint.activate([
                    container.leadingAnchor.constraint(equalTo: previous.trailingAnchor, constant: spacing)
                ])
            } else {
                container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: spacing).isActive = true
            }

            previousContainer = container
        }

        if let lastContainer = previousContainer {
            contentView.trailingAnchor.constraint(equalTo: lastContainer.trailingAnchor, constant: spacing).isActive = true
        }
    }
}
