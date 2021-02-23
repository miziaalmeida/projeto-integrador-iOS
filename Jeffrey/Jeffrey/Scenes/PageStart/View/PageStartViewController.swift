import UIKit

//MARK: PROTOCOL EVENTS
protocol PageStartViewEvents: AnyObject {
    func present(viewController: UIViewController)
    func push(viewController: UIViewController)
}

//MARK: VIEW CONTROLLER
class PageStartViewController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var startLabel: UILabel!
    
    private var viewModel: PageStartOptionsViewModelProtocol?
    
    //MARK: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabel()
        
        self.viewModel = PageStartViewModel()
        self.viewModel?.viewController = self
    }
    
    //MARK: VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: VIEW WILL DISAPPEAR
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: ACTIONS
    @IBAction func next() {
        viewModel?.didTapNext()
    }
    
    func configureLabel(){
        self.startLabel.numberOfLines = 0
        startLabel.text = "Vamos \ncomeçar?"
    }
}

//MARK: EXTENSIONS
extension PageStartViewController: PageStartViewEvents{
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}
