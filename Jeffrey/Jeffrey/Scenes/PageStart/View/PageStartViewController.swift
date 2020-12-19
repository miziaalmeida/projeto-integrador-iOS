import UIKit

class PageStartViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var startLabel: UILabel!
    
    private var viewModel: PageStartOptionsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabel()
        
    }
    
    @IBAction func next() {
        if let startOptionsView = UIStoryboard(name: "StartOptions", bundle: nil).instantiateInitialViewController() as? UINavigationController {
            startOptionsView.modalPresentationStyle = .fullScreen
            self.present(startOptionsView, animated: true, completion: nil)
        }
        
    }
    
    func configureLabel(){
        self.startLabel.numberOfLines = 0
        startLabel.text = "Vamos \ncomeçar?"
    }
}
