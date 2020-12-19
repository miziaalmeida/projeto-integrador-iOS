import Foundation
import UIKit

protocol StartOptionsViewModelProtocol: AnyObject {
    func openLoginFrom(controller: UIViewController)
    func openRegisterFrom(controller: UIViewController)
}

class StartOptionsViewModel: StartOptionsViewModelProtocol {
        
    func openLoginFrom(controller: UIViewController) {
        if let loginView = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as? LoginViewController {
            controller.navigationController?.pushViewController(loginView, animated: true)
        }
    }
    
    func openRegisterFrom(controller: UIViewController) {
        if let registerView = UIStoryboard(name: "Register", bundle: nil).instantiateInitialViewController() as? RegisterViewController {
            controller.navigationController?.pushViewController(registerView, animated: true)
        }
    }
}
