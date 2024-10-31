//
//  NewsDetailsVC.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 30/10/24.
//

import Foundation
import UIKit

class NewsDetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var backBtn: UIButton!
    @IBOutlet var penerbitLabel: UILabel!
    @IBOutlet var detailNews: UILabel!
    
    var newsItem: Item?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupBackBtn()
    }

    func setupBackBtn(){
        backBtn.setImage(UIImage(named: "back"), for: .normal)
        backBtn.imageView?.contentMode = .scaleAspectFit
        backBtn.contentHorizontalAlignment = .center
        backBtn.contentVerticalAlignment = .center
        
        backBtn.addTarget(self, action: #selector(toNewsPageView), for: .touchUpInside)
    }
    
    @objc func toNewsPageView(){
        navigationController?.popViewController(animated: true)
    }
    
    private func configureView() {
        guard let item = newsItem else { return }
        
        newsImageView.kf.setImage(with: URL(string: item.url_newsImg))
        newsImageView.contentMode = .scaleAspectFill
        
        titleLabel.text = item.judul_berita
        descriptionLabel.text = item.news_desc
        likesLabel.text = String((item.jumlah_like))
        dateLabel.text =  (item.tanggal_update)
        penerbitLabel.text = item.penerbit
        detailNews.text = item.desc_detail_news
    }
}

