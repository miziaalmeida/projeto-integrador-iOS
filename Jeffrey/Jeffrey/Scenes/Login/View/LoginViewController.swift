import UIKit
import Firebase
import FirebaseAuth
import FacebookLogin
import FacebookCore
import GoogleSignIn

protocol LoginViewEvents: AnyObject {
    func present(viewController: UIViewController)
    func push(viewController: UIViewController)
}

class LoginViewController: UIViewController {
    @IBOutlet weak var socialMediaView: UIView!
    //@IBOutlet weak var videoLayerView: UIView!
    @IBOutlet weak var emailAcess: UIButton!
    @IBOutlet weak var registerAcess: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    
    private var viewModel: LoginViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigationItem()
        
        configView()
        
        configButtons(button: emailAcess)
        configButtons(button: registerAcess)
        
        configButtonsMedia(button: facebookBtn)
        configButtonsMedia(button: googleBtn)
        
        self.viewModel = LoginViewModel()
        self.viewModel?.viewController = self
        
        configGoogle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController!.navigationBar.barStyle = .black
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configGoogle(){
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
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
    
    func configView(){
        socialMediaView.backgroundColor = UIColor(white: 0.2, alpha: 0.2)
        socialMediaView.layer.borderWidth = 0.5
        socialMediaView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func didTapLoginFacebook(_ sender: Any) {
        viewModel?.facebookLogin(viewController: self)
    }
    
    @IBAction func didTapGoogleLogin(_ sender: Any) {
        viewModel?.googleLogin()
    }
    
    @IBAction func loginEmail(_ sender: Any) {
        viewModel?.loginEmail()
    }
    
    @IBAction func registerAccount(_ sender: Any) {
        viewModel?.registerAccount()
    }

    func configNavigationItem(){
        let backButton = UIBarButtonItem()
        backButton.title = "Voltar"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

extension LoginViewController: LoginViewEvents {
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}
