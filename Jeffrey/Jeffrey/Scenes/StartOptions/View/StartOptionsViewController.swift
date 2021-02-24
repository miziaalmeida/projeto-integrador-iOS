import UIKit

//MARK: PROTOCOL EVENTS
protocol StartOptionsViewEvents: AnyObject {
    func present(viewController: UIViewController)
    func push(viewController: UIViewController)
}

//MARK: VIEW CONTROLLER
class StartOptionsViewController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    private var viewModel: StartOptionsViewModelProtocol?
    
    //MARK: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton(button: loginButton)
        setupButton(button: registerButton)
        
        self.viewModel = StartOptionsViewModel()
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
    @IBAction func login() {
        viewModel?.didTapLogin()
    }
    
    @IBAction func register() {
        viewModel?.didTapRegister()
    }
    
    func setupButton(button: UIButton){
        button.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        button.tintColor = UIColor.black
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
}

//MARK: EXTENSIONS
extension StartOptionsViewController: StartOptionsViewEvents {
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}
