import Foundation
import UIKit

protocol RegisterViewModelProtocol: AnyObject {
    func registerTapped(controller: UIViewController)
    func loginTapped(controller: UIViewController)
}

class RegisterViewModel: RegisterViewModelProtocol {
    
    func registerTapped(controller: UIViewController) {
        print("Usuário cadastrado com sucesso!")
        
    }
    
    func loginTapped(controller: UIViewController) {
        if let loginView = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController() as? LoginViewController {
            controller.navigationController?.pushViewController(loginView, animated: true)
            
        }
    }
}
