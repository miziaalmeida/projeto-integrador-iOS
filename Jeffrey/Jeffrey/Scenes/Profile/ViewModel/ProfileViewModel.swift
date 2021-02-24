import UIKit

protocol ProfileViewModelProtocol: AnyObject {
    func didTapExitAccount(controller: UIViewController)
}

class ProfileViewModel: ProfileViewModelProtocol{
    
    func didTapExitAccount(controller: UIViewController) {
        if let exitAccountPassView = UIStoryboard(name: "ExitAccount", bundle: nil).instantiateInitialViewController() as? ExitAccountViewController {
            controller.navigationController?.pushViewController(exitAccountPassView, animated: true)
        }
    }
}
