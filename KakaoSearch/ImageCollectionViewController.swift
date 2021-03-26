import UIKit

private let reuseIdentifier = "Cell"

class ImageCollectionViewController: UICollectionViewController {
    
   
    @IBAction func unwindToMain(segue: UIStoryboardSegue){
        
    }
    
    private var imagesList : [Image] = [Image(image: "apeach", name: "apeach"),
                                    Image(image: "con", name: "con"),
                                    Image(image: "mugi", name: "mugi"),
                                    Image(image: "neo", name: "neo"),
                                    Image(image: "prodo", name: "prodo"),
                                    Image(image: "ryan", name: "ryan"),
                                    Image(image: "tube", name: "tube")
                                   ]
    var filteredArr: [String] = []
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let ImageSearchBar = UISearchBar()
        ImageSearchBar.placeholder = "Insert text here"
        self.navigationItem.titleView = ImageSearchBar
//        self.setupSearchController()
//        self.setupTableView()
    }
//    func setupSearchController() {
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.placeholder = "Search Dj"
//        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.searchResultsUpdater = self
//        self.navigationItem.searchController = searchController
//        self.navigationItem.title = "Search"
//        self.navigationItem.hidesSearchBarWhenScrolling = false
//    }
    
//    func setupTableView() {
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dataCell", for: indexPath) as! ImageCollectionViewCell
    
    
        let img = imagesList[indexPath.row]
        cell.kakaoImageView.image = UIImage(named: img.image)
        cell.kakaoNameLabel.text = img.name
        cell.kakaoImageView.layer.cornerRadius = 8
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPaths = collectionView.indexPathsForSelectedItems{
                let destinationController = segue.destination as! ImageDetailViewController
                destinationController.city = imagesList[indexPaths[0].row]
                collectionView.deselectItem(at: indexPaths[0], animated: false)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width-50) / 2
        let height = (UIImage(named: imagesList[indexPath.item].image)?.size.height)! / (UIImage(named: imagesList[indexPath.row].image)?.size.width)! * width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
}
