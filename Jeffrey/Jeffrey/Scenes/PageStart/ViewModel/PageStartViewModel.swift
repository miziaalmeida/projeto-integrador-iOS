import UIKit

//MARK: PROTOCOL VIEW MODEL
protocol PageStartOptionsViewModelProtocol: AnyObject {
    func didTapNext()
    var viewController: PageStartViewEvents? {get set}
}

//MARK: VIEW MODEL
class PageStartViewModel: PageStartOptionsViewModelProtocol {
    weak var viewController: PageStartViewEvents?
    
    func didTapNext(){
        guard let startOptionsView = UIStoryboard(name: "StartOptions",
                                                  bundle: nil).instantiateInitialViewController()
                as? UINavigationController else { return }
        UIViewController.replaceRootViewController(viewController: startOptionsView)
    }
}
