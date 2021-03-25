//
//  ViewController.swift
//  APIDemo
//
//  Created by 임수정 on 2021/03/15.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    let imgList = ["FTS","1","2","3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        KakaoSearcher.shared.search(query: "말티즈") { (response: APIResponse) in
            for searchResult in response.documents {
                print(searchResult.thumbnailURL)
            }
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ImgCell  else { return UICollectionViewCell() }
        cell.imgView.image = UIImage(named: imgList[indexPath.item])
        cell.imgView.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width-30) / 2
        let height = (UIImage(named: imgList[indexPath.item])?.size.height)! / (UIImage(named: imgList[indexPath.item])?.size.width)! * width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
}
