import Foundation
import UIKit

//MARK: PROTOCOL VIEW MODEL
protocol RegisterViewModelProtocol: AnyObject {
    func didTapRegister(view: UIView)
    func didTapLogin()
    var viewController: RegisterViewEvents? { get set }
}

//MARK: VIEW MODEL
class RegisterViewModel: RegisterViewModelProtocol {
    weak var viewController: RegisterViewEvents?
    var activityIndicator = ActivityIndicatorViewController()
    
    func didTapRegister(view: UIView) {
        activityIndicator.hideActivityIndicator(view: view)
        guard  let homeViewControler = UIStoryboard(name: "HomeMain",
                                                    bundle: nil).instantiateInitialViewController() as? UITabBarController else { return }
        
        viewController?.push(viewController: homeViewControler)
    }
    
    func didTapLogin() {
        guard  let loginView = UIStoryboard(name: "Login",
                                            bundle: nil).instantiateInitialViewController() as? LoginViewController else { return }
        viewController?.push(viewController: loginView)
    }
}
