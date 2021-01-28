import Foundation
import UIKit

protocol RegisterViewModelProtocol: AnyObject {
    func registerTapped()
    func loginTapped()
    var viewController: RegisterViewEvents? { get set }
}

class RegisterViewModel: RegisterViewModelProtocol {
    weak var viewController: RegisterViewEvents?
    
    func registerTapped() {
        guard  let homeViewControler = UIStoryboard(name: "HomeMain",
                                                    bundle: nil).instantiateInitialViewController() as? UITabBarController else { return }
        
        viewController?.push(viewController: homeViewControler)
    }
    
    func loginTapped() {
        guard  let loginView = UIStoryboard(name: "Login",
                                            bundle: nil).instantiateInitialViewController() as? LoginViewController else { return }
        viewController?.push(viewController: loginView)
    }
}
