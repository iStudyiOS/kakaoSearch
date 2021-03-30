//
//  ImageCollectionViewController.swift
//  KakaoSearch
//
//  Created by 홍경표 on 2021/03/29.
//

import UIKit

class ImageCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    var fetchedDatas: [SearchResult] = []
    
    // MARK: - Views
    
    private let searchController = UISearchController()

    // MARK: - Initialize
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
    }
    
    private func setUpSearchController() {
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search Images"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Methods
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedDatas.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        cell.configure(with: fetchedDatas[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.size.width-50) / 2
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell,
              let actualSize = cell.kakaoImageView.image?.size else {
            return CGSize(width: cellWidth, height: cellWidth)
        }
        return CGSize(width: cellWidth, height: actualSize.height / actualSize.width * cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.segueMainToDetail, sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Constants.segueMainToDetail,
              let indexPath = collectionView.indexPathsForSelectedItems?.first,
              let destination = segue.destination as? ImageDetailViewController else { return }
        destination.item = fetchedDatas[indexPath.row]
    }
}

// MARK: - Implement UISearchBarDelegate

extension ImageCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true, completion: nil)
        guard let text = searchBar.text else { return }
        search(text)
    }
    
    private func search(_ searchText: String) {
        KakaoSearcher.shared.search(query: searchText) { (response: APIResponse) in
            self.fetchedDatas = response.documents
            self.collectionView.reloadData()
        }
    }
    
}
