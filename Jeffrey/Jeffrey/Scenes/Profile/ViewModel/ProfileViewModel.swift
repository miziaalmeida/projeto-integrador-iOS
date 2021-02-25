import UIKit
import Firebase
import GoogleSignIn

protocol ProfileViewModelProtocol: AnyObject {
    func didTapExitAccount()
    func showDataFromGoogle(name: String, email: String)
    var viewController: ProfileViewEvents? { get set }
}

class ProfileViewModel: ProfileViewModelProtocol{
    weak var viewController: ProfileViewEvents?
    
    func didTapExitAccount(){
        AuthUser.User.signOut()
    }
    
    func showDataFromGoogle(name: String, email: String){
        
    }
}
