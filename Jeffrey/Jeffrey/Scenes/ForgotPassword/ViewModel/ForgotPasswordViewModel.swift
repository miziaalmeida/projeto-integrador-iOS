import Foundation
import UIKit

protocol ForgotPasswordViewModelProtocol: AnyObject {
    func sendTapped(controller: UIViewController)
    func loginTapped(controller: UIViewController)
}

class ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {
    
    func sendTapped(controller: UIViewController){
        print("Botao enviar tap")
    }
    
    func loginTapped(controller: UIViewController) {
        if let loginView = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as? LoginViewController {
            controller.navigationController?.pushViewController(loginView, animated: true)
        }
    }
}
