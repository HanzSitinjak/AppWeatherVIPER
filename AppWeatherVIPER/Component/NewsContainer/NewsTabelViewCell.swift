//
//  NewsTabelViewCell.swift
//  AppWeatherVIPER
//
//  Created by Aleph-AHV2D on 30/10/24.
//

import Foundation
import Kingfisher

class NewsTabelViewCell: UITableViewCell{
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet var totalLiked: UILabel!
    @IBOutlet var dateUpdate: UILabel!
    @IBOutlet var newsDesc: UILabel!
    
    func configure(with item: Item){
        titleLabel.text = item.judul_berita
        titleLabel.font = .boldSystemFont(ofSize: 13)
        titleLabel.numberOfLines = 3
        
        newsDesc.text = item.news_desc
        newsDesc.font = .systemFont(ofSize: 11)
        newsDesc.numberOfLines = 3
        newsDesc.textColor = .lightGray
        
        dateUpdate.text = item.tanggal_update
        dateUpdate.font = .systemFont(ofSize: 10)
        dateUpdate.numberOfLines = 0
        
        totalLiked.text = String(item.jumlah_like)
        totalLiked.font = .systemFont(ofSize: 10)
        totalLiked.numberOfLines = 0
        
        newsImageView.kf.setImage(with: URL(string: item.url_newsImg))
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.clipsToBounds = true
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsImageView.widthAnchor.constraint(equalToConstant: 135).isActive = true
        newsImageView.heightAnchor.constraint(equalToConstant: 135).isActive = true
        
        stackView.frame = self.contentView.bounds
        stackView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    
        stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    }
}
