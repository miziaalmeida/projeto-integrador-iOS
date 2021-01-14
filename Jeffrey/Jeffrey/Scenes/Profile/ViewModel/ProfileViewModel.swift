import UIKit

protocol ProfileViewModelProtocol: AnyObject {
    func didTapEditProfile(controller: UIViewController)
    func didTapExitAccount(controller: UIViewController)
}

class ProfileViewModel: ProfileViewModelProtocol{
    
    func didTapEditProfile(controller: UIViewController) {
        if let editProfilePassView = UIStoryboard(name: "EditProfile", bundle: nil).instantiateInitialViewController() as? EditProfileViewController {
            controller.navigationController?.pushViewController(editProfilePassView, animated: true)
        }
    }
    
    func didTapExitAccount(controller: UIViewController) {
        if let exitAccountPassView = UIStoryboard(name: "ExitAccount", bundle: nil).instantiateInitialViewController() as? ExitAccountViewController {
            controller.navigationController?.pushViewController(exitAccountPassView, animated: true)
        }
    }
}
