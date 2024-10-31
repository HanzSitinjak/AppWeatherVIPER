//
//  sliderNews.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 28/10/24.
//

import Foundation
import UIKit
import Kingfisher

class NewsCarouselItem: UICollectionViewCell {
    //set gambar dr berita
    let imgNewsView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //set judul berita
    let newsTitle: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.numberOfLines = 2
        title.lineBreakMode = .byTruncatingTail
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    //digunakan untuk penginisialisasian komponen dalam storyBoard
    override init (frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    //sedangkan ini untuk code/ secara programaticly
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        addSubview(imgNewsView)
        addSubview(newsTitle)
        
        imgNewsView.translatesAutoresizingMaskIntoConstraints = false
        newsTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imgNewsView.topAnchor.constraint(equalTo: topAnchor),
            imgNewsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imgNewsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imgNewsView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            newsTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            newsTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            newsTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    //set posisi komponen
    func setComponent(with item: Item){
        if let url = URL(string: item.url_newsImg){
            imgNewsView.kf.setImage(with: url)
        }
        newsTitle.text = item.judul_berita
    }
}

