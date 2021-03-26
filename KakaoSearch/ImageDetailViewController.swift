import UIKit

class ImageDetailViewController: UIViewController {
    
    var city: Image?
    
    @IBOutlet var cityImageView:UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityImageView.image = UIImage(named: city?.image ?? "")
        
    }
    


}
