import UIKit

//MARK: PROTOCOL VIEW MODEL
protocol StartOptionsViewModelProtocol: AnyObject {
    func didTapLogin()
    func didTapRegister()
    var viewController: StartOptionsViewEvents? { get set }
}

//MARK: VIEW MODEL
class StartOptionsViewModel: StartOptionsViewModelProtocol {
    weak var viewController: StartOptionsViewEvents?
    
    func didTapLogin() {
        guard let loginView = UIStoryboard(name: "Login",
                                           bundle: nil).instantiateInitialViewController() as? LoginViewController else { return }
        viewController?.push(viewController: loginView)
    }
    
    func didTapRegister() {
        guard let registerView = UIStoryboard(name: "Register",
                                              bundle: nil).instantiateInitialViewController() as? RegisterViewController else { return }
        viewController?.push(viewController: registerView)
    }
}
