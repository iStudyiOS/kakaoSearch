//
//  ImageDetailViewController.swift
//  KakaoSearch
//
//  Created by 홍경표 on 2021/03/29.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    var item: SearchResult?
    
    @IBOutlet var imageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImageView()
    }
    
    private func setUpImageView() {
        guard let item = item else { return }
        DispatchQueue.global().async {
            guard let url = URL(string: item.thumbnailURL),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    @IBAction func touchedCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
