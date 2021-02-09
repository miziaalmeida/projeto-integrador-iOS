import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FacebookLogin
import FacebookCore
import GoogleSignIn

protocol LoginViewModelProtocol: AnyObject{
    func loginEmail()
    func registerAccount()
    func openHome()
    func googleLogin()
    func appleLogin()
    func facebookLogin(viewController: UIViewController)
    var viewController: LoginViewEvents? {get set}
}

class LoginViewModel: LoginViewModelProtocol{
    weak var viewController: LoginViewEvents?
    
    func loginEmail(){
        guard let loginEmailView = UIStoryboard(name: "LoginEmail",
                                                bundle: nil).instantiateInitialViewController()
                as? LoginEmailViewController  else { return }
        viewController?.push(viewController: loginEmailView)
    }
    
    
    func registerAccount() {
        guard let registerView = UIStoryboard(name: "Register",
                                              bundle: nil).instantiateInitialViewController()
                as? RegisterViewController  else { return }
        viewController?.push(viewController: registerView)
    }
    
    func openHome(){
        guard let homeView = UIStoryboard(name: "HomeMain",
                                              bundle: nil).instantiateInitialViewController()
                as? UITabBarController  else { return }
        viewController?.push(viewController: homeView)
    }
    
    func googleLogin() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func appleLogin() {
        //abrir login via apple
    }
    
    func facebookLogin(viewController: UIViewController) {
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile, .email], viewController: viewController) { (result) in
            switch result {
            case .success(granted: let grantedPermissions, declined: let declinedPermission, token: let acessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: acessToken.tokenString)
                Auth.auth().signIn(with: credential) { (result, error) in
                    guard  let homeViewControler = UIStoryboard(name: "HomeMain", bundle: nil).instantiateInitialViewController() as? UITabBarController else { return }
                    DispatchQueue.main.async {
                        
                        UIViewController.replaceRootViewController(viewController: homeViewControler)
                    }
                }
                print("acess Token = \(acessToken)")
            case .cancelled:
                print("Usuário cancelou o processo de Login")
                break
            case .failed(let error):
                print("Login falhou! \(error.localizedDescription)")
            }
            manager.logOut()
        }
    }
}
