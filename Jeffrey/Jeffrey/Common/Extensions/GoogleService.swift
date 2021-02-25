//
//  GoogleService.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 09/02/21.
//

import UIKit
import GoogleSignIn
import Firebase

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
            }
//            let userId = user.userID ?? ""
//            print(userId)
//
//            var name = user.profile.name ?? ""
//            print("\(name)")
//            self.nameUser = name
//
//            let email = user.profile.email ?? ""
//            print("\(email)")
//            self.emailUser = email
            
            print("Login Successful.")
            
            guard  let homeViewControler = UIStoryboard(name: "HomeMain",
                                                        bundle: nil).instantiateInitialViewController() as? UITabBarController else { return }
            DispatchQueue.main.async {
                UIViewController.replaceRootViewController(viewController: homeViewControler)
            }
        }
    }
}
