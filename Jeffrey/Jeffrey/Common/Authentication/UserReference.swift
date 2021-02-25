import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FacebookLogin
import GoogleSignIn
import ProgressHUD

class UserReference {
    
    //MARK: CHECK USER IS LOGGED
    static func isLogged() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    //MARK: SIGN IN - FIREBASE
    func signIn(withEmail email: String, password: String,
                onSucess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            if error != nil{
                onError(error!.localizedDescription)
                return
            }
            onSucess()
            print(authData?.user.uid)
        }
    }
    
    //MARK: VALIDATE SIGN IN - FIREBASE
    func validateSignIn(email: String, password: String, view: UIView, viewController: UIViewController, onSucess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil{
                if user == nil{
                    //messagem de erro para o usuário
                    self.messageUser(title: "Erro ao autenticar", message: "Senha ou E-mail inválidos, tente novamente.", viewController: viewController)
                } else {
                    self.showHome()
                }
            } else {
                //messagem de erro para o usuário
                self.messageUser(title: "Dados Inválidos", message: "Senha ou E-mail inválidos, tente novamente.", viewController: viewController)
            }
        }
    }
    
    //MARK: SIGN UP - FIREBASE
    func signUp(withUsername name: String, email: String, password: String, image: UIImage?,
                onSucess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            if let authData = authDataResult {
                print(authData.user.email)
                let dict: Dictionary<String, Any> = [
                    UID: authData.user.uid,
                    USERNAME: name,
                    EMAIL: authData.user.email,
                    PROFILE_IMAGE_URL: "",
                    STATUS: "Cadastrado no Jeffrey"
                ]
                
                guard let imageSelected = image else {
                    ProgressHUD.showError(ERROR_EMPTY_PHOTO)
                    return
                }
                
                guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else { return }
                
                let storageAvatarProfileRef = Ref().storageSpecificProfile(uid: authData.user.uid)
                
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpg"
                
                StorageService.savePhoto(username: name, uid: authData.user.uid, data: imageData, metadata: metadata, storageAvatarProfileRef: storageAvatarProfileRef, dict: dict, onSucess: {
                    onSucess()
                }, onError: { (errorMessage) in
                    onError(errorMessage)
                })
            }
        }
    }
    
    //MARK: SIGN OUT - FIREBASE
    func signOut(){
        let loginManager = LoginManager()
        if let _ = AccessToken.current {
            loginManager.logOut()
            print("~ Deu Logout no facebook!! ~")
        }
        
        do {
            try Auth.auth().signOut()
            guard let viewController = UIStoryboard(name: "Main",
                                                    bundle: nil).instantiateInitialViewController() as? PageStartViewController else { return }
            UIViewController.replaceRootViewController(viewController: viewController)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    //MARK: RESET PASSWORD - FIREBASE
    func resetPassword(withEmail email: String, onSucess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                onSucess()
            } else {
                onError(error!.localizedDescription)
            }
        }
    }
    
    //MARK: SIGN IN - FACEBOOK
    func signInWithFacebook(viewController: UIViewController) {
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile, .email, .userPhotos], viewController: viewController) { (result) in
            switch result {
            case .success(granted: let grantedPermissions, declined: let declinedPermission, token: let acessToken):
                let credential = FacebookAuthProvider.credential(withAccessToken: acessToken.tokenString)
                Auth.auth().signIn(with: credential) { (result, error) in
                    guard  let homeViewControler = UIStoryboard(name: "HomeMain", bundle: nil).instantiateInitialViewController() as? UITabBarController else { return }
                    DispatchQueue.main.async {
                        UIViewController.replaceRootViewController(viewController: homeViewControler)
                    }
                }
                print("acess Token = \(acessToken)")
            case .cancelled:
                print("Usuário cancelou o processo de Login")
                break
            case .failed(let error):
                print("Login falhou! \(error.localizedDescription)")
            }
            manager.logOut()
        }
    }
    
    //MARK: SIGN IN - GOOGLE
    func signInWithGoogle(viewController: UIViewController) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    //MARK: DELETE USER - FIREBASE
    func deleteUser(){
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let error = error {
                // An error happened.
            } else {
                // Account deleted.
            }
        }
    }
    
    //MARK: SHOW HOME
    func showHome() {
        guard let homeViewControler = UIStoryboard(name: "HomeMain",
                                                   bundle: nil).instantiateInitialViewController() as? UITabBarController else {return}
        
        UIViewController.replaceRootViewController(viewController: homeViewControler)
    }
    
    //MARK: MESSAGE FROM USER
    func messageUser(title: String, message: String, viewController: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(actionCancel)
        viewController.present(alert, animated: true)
    }
}
