import Foundation
import UIKit

protocol PageStartOptionsViewModelProtocol: AnyObject {
    func next(controller: UIViewController)
}

class PageStartViewModel: PageStartOptionsViewModelProtocol {
    func next(controller: UIViewController){
        if let startOptionsView = UIStoryboard(name: "StartOptions", bundle: nil).instantiateInitialViewController() as? UINavigationController {
            startOptionsView.modalPresentationStyle = .fullScreen
            startOptionsView.present(startOptionsView, animated: true, completion: nil)
        }
    }
}
