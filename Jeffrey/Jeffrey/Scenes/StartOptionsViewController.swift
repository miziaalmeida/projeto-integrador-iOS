import UIKit

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
    }

    @IBAction func login() {
        viewModel?.openLoginFrom(controller: self)
    }
    
    @IBAction func register() {
        viewModel?.openRegisterFrom(controller: self)
    }
    
    func setupButton(button: UIButton){
        button.backgroundColor = .red
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
}

