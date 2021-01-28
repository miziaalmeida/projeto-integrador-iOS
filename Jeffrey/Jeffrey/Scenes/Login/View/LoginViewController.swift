import UIKit
import Firebase
import FBSDKLoginKit
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
    @IBOutlet weak var appleBtn: UIButton!
    
    private var viewModel: LoginViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNavigationItem()
        
        configView()
        
        configButtons(button: emailAcess)
        configButtons(button: registerAcess)
        
        configButtonsMedia(button: facebookBtn)
        configButtonsMedia(button: googleBtn)
        configButtonsMedia(button: appleBtn)
        
        self.viewModel = LoginViewModel()
        self.viewModel?.viewController = self
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
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
        let loginManager = LoginManager()
        
        if let _ = AccessToken.current {
            loginManager.logOut()
            print("~ Deu Logout!! ~")
        } else {
            loginManager.logIn(permissions: [], viewController: self) { (result) in
                switch result {
                case .success(granted: let permissions,
                              declined: let declined,
                              token: let token):
                    
                    guard  let homeViewControler = UIStoryboard(name: "HomeMain",
                                                                bundle: nil).instantiateInitialViewController() as? UITabBarController else { return }
                    
                    self.navigationController?.pushViewController(homeViewControler, animated: true)
                    
                    print("#SUCESSO#")
                    print(permissions)
                    print(declined)
                    print(token)
                case .cancelled:
                    print("#CANCELADO#")
                case .failed(let error):
                    print("#FALHA#")
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func didTapGoogleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    @IBAction func loginEmail(_ sender: Any) {
        viewModel?.loginEmail()
    }
    
    @IBAction func registerAccount(_ sender: Any) {
        viewModel?.registerAccount()
    }
    
    
    @IBAction func appleLogin(_ sender: Any) {
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

extension LoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        request.start(completionHandler: { connection, result, error in
            print("\(String(describing: result))")
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Login Successful.")
                 guard  let homeViewControler = UIStoryboard(name: "HomeMain",
                                                              bundle: nil).instantiateInitialViewController() as? UITabBarController else { return }
                  
                  self.navigationController?.pushViewController(homeViewControler, animated: true)
            }
        }
    }
}
