import Foundation
import UIKit

protocol StartOptionsViewModelProtocol: AnyObject {
    func openLoginFrom()
    func openRegisterFrom()
    var viewController: StartOptionsViewEvents? { get set }
}

class StartOptionsViewModel: StartOptionsViewModelProtocol {
    weak var viewController: StartOptionsViewEvents?
    
    func openLoginFrom() {
        guard let loginView = UIStoryboard(name: "Login",
                                           bundle: nil).instantiateInitialViewController() as? LoginViewController else { return }
        viewController?.push(viewController: loginView)
    }
    
    func openRegisterFrom() {
        if let registerView = UIStoryboard(name: "Register",
                                           bundle: nil).instantiateInitialViewController() as? RegisterViewController {
            viewController?.push(viewController: registerView)
        }
    }
}
