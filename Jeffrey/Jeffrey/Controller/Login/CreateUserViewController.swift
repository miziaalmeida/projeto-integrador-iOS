import Firebase
import FirebaseAuth
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseAuth
import GoogleSignIn
import UIKit

class CreateViewController: UIViewController, GIDSignInDelegate {
    
    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var createUser: UIButton!
    @IBOutlet var facebookLogin: UIButton!
    @IBOutlet var googleLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.delegate = self
        
        configureSignIn()
        configureGoogleButton()
        configureFacebookButton()
        currentUserName()
    }
    
    
    @IBAction func didTapCreate(_ sender: Any){
        let vc = (UIStoryboard(name: "Register", bundle: nil).instantiateInitialViewController() as? RegisterViewController)!
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func facebookTap(_ sender: Any) {
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
    
    @IBAction func googleTap(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func configureGoogleButton() {
        googleLogin?.backgroundColor? = .systemRed
        googleLogin?.layer.cornerRadius = 10
        googleLogin.clipsToBounds = true
    }
    
    func currentUserName()  {
        if Auth.auth().currentUser != nil {
        } else {
            print("No user.")
        }
    }
    
    func configureSignIn(){
        createUser?.backgroundColor? = .systemGreen
        createUser?.layer.cornerRadius = 10
        createUser.clipsToBounds = true
    }
    
    func configureFacebookButton() {
        facebookLogin?.backgroundColor? = .systemBlue
        facebookLogin?.layer.cornerRadius = 10
        facebookLogin.clipsToBounds = true
    }
}
