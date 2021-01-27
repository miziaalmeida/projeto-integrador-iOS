//import Foundation
//import UIKit
//
//protocol LoginEmailViewModelProtocol: AnyObject{
//        func signInTapped()
//        func registerTap(controller: UIViewController)
//        var viewController: LoginEmailViewEvents? {get set}
//}
//
//class LoginEmailViewModel: LoginEmailViewModelProtocol{
//    weak var viewController: LoginEmailViewEvents?
//    
//    
//
//    func signInTapped() {
//        guard  let homeViewControler = UIStoryboard(name: "HomeMain",
//                                                    bundle: nil).instantiateInitialViewController() as? UITabBarController else { return }
//        
//        viewController?.push(viewController: homeViewControler)
//    }
//    
//   
//    
//    func forgotPasswordTap(controller: UIViewController) {
//        if let forgotPassView = UIStoryboard(name: "ForgotPassword", bundle: nil).instantiateInitialViewController() as? ForgotPasswordViewController {
//            controller.navigationController?.pushViewController(forgotPassView, animated: true)
//        }
//    }
//    
//    func registerTap(controller: UIViewController) {
//        if let registerView = UIStoryboard(name: "Register", bundle: nil).instantiateInitialViewController() as? RegisterViewController {
//            controller.navigationController?.pushViewController(registerView, animated: true)
//        }
//    }
//}
//
