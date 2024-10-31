//
//  NewsCarouselView.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 29/10/24.
//

import Foundation
import UIKit
import Kingfisher

@IBDesignable
class NewsCarouselView: UIView {
    
    private let collectionView: UICollectionView
    private var items: [Item] = []
    private var timer: Timer?

    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)

        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(coder: coder)
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(NewsCarouselItem.self, forCellWithReuseIdentifier: "NewsCarouselItem")

        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setItems(_ items: [Item]) {
        self.items = items
        collectionView.reloadData()
        // Memulai auto-scroll setelah item dimuat
        if !items.isEmpty {
            startAutoScroll()
        }
    }

    func startAutoScroll(interval: TimeInterval = 6.0) {
        print("Auto scroll started")
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }

    deinit {
        timer?.invalidate()
    }

    @objc func autoScroll() {
        let visibleItems = collectionView.indexPathsForVisibleItems
        guard let currentItemIndex = visibleItems.first?.row else { return }
                
        let nextItemIndex = (currentItemIndex + 1) % items.count // Looping ke item pertama setelah yang terakhir
        collectionView.scrollToItem(at: IndexPath(row: nextItemIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension NewsCarouselView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCarouselItem", for: indexPath) as? NewsCarouselItem else {
            fatalError("Unable to dequeue NewsCarouselItem")
        }
        
        let item = items[indexPath.row]
        cell.setComponent(with: item)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
