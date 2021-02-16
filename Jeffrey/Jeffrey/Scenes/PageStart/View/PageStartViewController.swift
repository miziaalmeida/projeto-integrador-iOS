import UIKit

protocol PageStartViewEvents: AnyObject {
    func present(viewController: UIViewController)
    func push(viewController: UIViewController)
}

class PageStartViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var startLabel: UILabel!
    
    private var viewModel: PageStartOptionsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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

extension PageStartViewController: PageStartViewEvents{
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}
