//MARK: Librarys
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseAuth
import SwiftyGif
import GoogleSignIn
import UIKit

//MARK: ViewController
class ViewController: UIViewController, GIDSignInDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var nameUserField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    
    //MARK: Variables
    let logoAnimationView = LogoAnimationView()
    private let database = Database.database().reference()
    
    //MARK: DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Logo
        view.addSubview(logoAnimationView)
        logoAnimationView.pinEdgesToSuperView()
        logoAnimationView.logoGifImageView.delegate = self
        
        GIDSignIn.sharedInstance()?.delegate = self
        
        //MARK: View
        viewOne?.backgroundColor = .black
        
        
        configureGoogleButton()
        configureFacebookButton()
        
        currentUserName()
    }
    
    //MARK: DidAppear
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        logoAnimationView.logoGifImageView.startAnimatingGif()
    }
    
    
    @IBAction func nameUserAction(_ sender: Any) {
    }
    
    @IBAction func passwordAction(_ sender: Any) {
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        forgotPasswordButton.tintColor = .clear
    }
    
    @IBAction func signInAction(_ sender: Any) {
        let vc = UIStoryboard(name: "CreateUser", bundle: nil).instantiateInitialViewController() as! CreateUserViewController
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func facebookAction(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            guard let acessToken = AccessToken.current else {
                print("Failed to get acess token")
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: acessToken.tokenString)
            
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                } else {
                    self.currentUserName()
                }
            })
        }
    }
    
    func currentUserName()  {
        if Auth.auth().currentUser != nil {
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            return
        }
        guard let authentication = user.authentication else {return}
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.idToken)
        
        //
        Auth.auth().signIn(with: credential, completion: { (authResult, error) in
            if (error != nil){
                return
            } else {
                self.currentUserName()
            }
        })
    }
    
    func configureFacebookButton() {
        facebookButton?.backgroundColor? = .systemBlue
        facebookButton?.layer.cornerRadius = 10
        facebookButton.clipsToBounds = true
    }
    
    
    @IBAction func googleAction(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func configureGoogleButton() {
        googleButton?.backgroundColor? = .systemRed
        googleButton?.layer.cornerRadius = 10
        googleButton.clipsToBounds = true
    }
}

//MARK: SwiftyGif
extension ViewController: SwiftyGifDelegate{
    func gifDidStop(sender: UIImageView){
        logoAnimationView.isHidden = true
    }
}
