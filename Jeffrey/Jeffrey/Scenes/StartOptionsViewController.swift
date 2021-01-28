import UIKit

protocol StartOptionsViewEvents: AnyObject {
    func present(viewController: UIViewController)
    func push(viewController: UIViewController)
}

class StartOptionsViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    private var viewModel: StartOptionsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton(button: loginButton)
        setupButton(button: registerButton)
        
        self.viewModel = StartOptionsViewModel()
        self.viewModel?.viewController = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

    @IBAction func login() {
        viewModel?.openLoginFrom()
    }
    
    @IBAction func register() {
        viewModel?.openRegisterFrom()
    }
    
    func setupButton(button: UIButton){
        button.backgroundColor = .red
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
}

extension StartOptionsViewController: StartOptionsViewEvents {
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}

