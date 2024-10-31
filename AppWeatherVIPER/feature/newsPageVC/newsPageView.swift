//
//  newsPageView.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 28/10/24.
//

import Foundation
import UIKit
import Kingfisher

class newsPageView: UIViewController, newsPageViewProtocol, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var newsCarouselView: NewsCarouselView!
    @IBOutlet var returnBtn: UIButton!
    
    
    var presenterToView: newsPagePreProtocol?
    var items: [Item] = []
    var newsData: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataCarousel()
        newsCarouselView.startAutoScroll()
        setupTableView()
        loadNewsData()
        setupRetunBtn()
    }
    
    private func loadDataCarousel() {
        let items = presenterToView?.getDataNews() ?? []
        newsCarouselView.setItems(Array(items.suffix(3)))
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }

    private func loadNewsData() {
        items = presenterToView?.getDataNews() ?? []
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTabelViewCell else {
            fatalError("Failed to dequeue NewsTabelViewCell")
        }
        
        let item = items[indexPath.row]
        cell.configure(with: item)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        
        if let detailNews = storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as? NewsDetailsViewController {
            detailNews.newsItem = selectedItem
            navigationController?.pushViewController(detailNews, animated: true)
        }
    }
    
    func setupRetunBtn(){
        returnBtn.setImage(UIImage(named: "return"), for: .normal)
        returnBtn.contentVerticalAlignment = .center
        returnBtn.contentHorizontalAlignment = .center
        returnBtn.imageView?.contentMode = .scaleAspectFit
        
        returnBtn.addTarget(self, action: #selector(toPreviousPage), for: .touchUpInside)
    }
    
    @objc func toPreviousPage(){
        navigationController?.popViewController(animated: true)
    }
}
