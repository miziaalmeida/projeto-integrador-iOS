import UIKit

//MARK: PROTOCOL EVENTS
protocol LoginViewEvents: AnyObject {
    func present(viewController: UIViewController)
    func push(viewController: UIViewController)
}

//MARK: VIEW CONTROLLER
class LoginViewController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var socialMediaView: UIView!
    @IBOutlet weak var emailAcess: UIButton!
    @IBOutlet weak var registerAcess: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    
    private var viewModel: LoginViewModelProtocol?
    
    //MARK: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configButtons(button: emailAcess)
        configButtons(button: registerAcess)
        configButtonsMedia(button: facebookBtn)
        configButtonsMedia(button: googleBtn)
        configNavigationItem()
        configureView()
        
        self.viewModel = LoginViewModel()
        self.viewModel?.viewController = self
        
    }
    
    //MARK: VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
    }
    //MARK: VIEW WILL DISAPPEAR
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: ACTIONS
    @IBAction func didTapLoginFacebook(_ sender: Any) {
        viewModel?.didTapFacebookLogin(viewController: self)
    }
    
    @IBAction func didTapGoogleLogin(_ sender: Any) {
        viewModel?.didTapGoogleLogin(viewController: self)
    }
    
    @IBAction func loginEmail(_ sender: Any) {
        viewModel?.didTapLoginWithEmail()
    }
    
    @IBAction func registerAccount(_ sender: Any) {
        viewModel?.didTapRegisterAccount()
    }

    func configNavigationItem(){
        let backButton = UIBarButtonItem()
        backButton.title = "Voltar"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func configButtons(button: UIButton?){
        button?.backgroundColor = UIColor.white.withAlphaComponent(1.0)
        button?.tintColor = UIColor.black
        button?.layer.cornerRadius = 10
        button?.clipsToBounds = true
    }
    
    func configButtonsMedia(button: UIButton?){
        button?.layer.cornerRadius = (button?.layer.frame.size.height)!/2
        button?.layer.borderColor = UIColor.clear.cgColor
        button?.layer.borderWidth = 0.5
        button?.clipsToBounds = true
    }
    
    func configureView(){
        socialMediaView.backgroundColor = UIColor(white: 0.2, alpha: 0.2)
        socialMediaView.layer.borderWidth = 0.5
        socialMediaView.layer.borderColor = UIColor.lightGray.cgColor
    }
}

//MARK: EXTENSIONS
extension LoginViewController: LoginViewEvents {
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}
