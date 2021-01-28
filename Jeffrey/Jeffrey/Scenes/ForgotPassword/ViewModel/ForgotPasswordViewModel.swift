import Foundation
import UIKit
import FirebaseAuth

protocol ForgotPasswordViewModelProtocol: AnyObject {
    func sendTapped()
    func loginTapped()
    var viewController: ForgotPasswordViewEvents? { get set }
}

class ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {    
    weak var viewController: ForgotPasswordViewEvents?
    
    func sendTapped() {
        
        
        alertSend()
        
        
    }
    
    func loginTapped() {
        guard  let loginView = UIStoryboard(name: "Login",
                                            bundle: nil).instantiateInitialViewController() as? LoginViewController else { return }
        viewController?.push(viewController: loginView)
    }
    
    func alertSend(){
        let alert = UIAlertController(title: "Email enviado com sucesso!", message: "Seu email foi enviado com sucesso, verifique sua caixa de entrada.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
        viewController?.present(viewController: alert)
    }
}
