import UIKit
import ProgressHUD
import FirebaseAuth

//MARK: PROTOCOL VIEW MODEL
protocol ForgotPasswordViewModelProtocol: AnyObject {
    func validateEmailField(email: String, view: UIView)
    func didTapLogin()
    var viewController: ForgotPasswordViewEvents? { get set }
}

//MARK: VIEW MODEL
class ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {
    weak var viewController: ForgotPasswordViewEvents?
    
    func validateEmailField(email: String, view: UIView){
        AuthUser.User.resetPassword(withEmail: email, onSucess: {
            self.alertSend()
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    }
    
    func didTapLogin() {
        guard let loginView = UIStoryboard(name: "Login",
                                           bundle: nil).instantiateInitialViewController() as? LoginViewController else { return }
        let navigationController = UINavigationController(rootViewController: loginView)
        UIViewController.replaceRootViewController(viewController: navigationController)
    }
    
    func alertSend(){
        let alert = UIAlertController(title: "Email enviado com sucesso!", message: "Nós enviamos um reset de senha para o seu email, verifique sua caixa de entrada.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
        viewController?.present(viewController: alert)
    }
}
