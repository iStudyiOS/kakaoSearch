//
//  ImgCell.swift
//  APIDemo
//
//  Created by 임수정 on 2021/03/16.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String { String(describing: Self.self) }
    
    @IBOutlet weak var kakaoImageView: UIImageView!
    
    func configure(with item: SearchResult) {
        DispatchQueue.global().async {
            guard let url = URL(string: item.thumbnailURL),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.kakaoImageView.image = image
                self.kakaoImageView.layer.cornerRadius = 5
            }
        }
    }
    
    override func prepareForReuse() {
        kakaoImageView.image = UIImage(systemName: "hourglass")
        kakaoImageView.tintColor = .systemGray2
    }
}
