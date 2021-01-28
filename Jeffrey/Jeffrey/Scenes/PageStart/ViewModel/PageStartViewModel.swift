import Foundation
import UIKit

protocol PageStartOptionsViewModelProtocol: AnyObject {
    func next()
    var viewController: PageStartViewEvents? {get set}
}

class PageStartViewModel: PageStartOptionsViewModelProtocol {
    weak var viewController: PageStartViewEvents?
    
    func next(){
        if let startOptionsView = UIStoryboard(name: "StartOptions",
                                               bundle: nil).instantiateInitialViewController() as? UINavigationController {
            viewController?.present(viewController: startOptionsView)
        }
    }
}
