//
//  ActivityIndicatorViewController.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 13/01/21.
//

import UIKit

class ActivityIndicatorViewController: UIViewController {
   func showActivityIndicator(view: UIView, targetVC: UIViewController) {
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        activityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        activityIndicator.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3519025386)
        activityIndicator.color = #colorLiteral(red: 1, green: 0.8284534456, blue: 0, alpha: 1)
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = targetVC.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.tag = 1
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        //UIApplication.shared.beginIgnoringInteractionEvents() -> Taíze
    }

   func hideActivityIndicator(view: UIView) {
        let activityIndicator = view.viewWithTag(1) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
       //UIApplication.shared.endIgnoringInteractionEvents() -> Taíze
    }
}
