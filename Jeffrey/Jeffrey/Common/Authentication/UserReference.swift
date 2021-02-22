import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FacebookLogin
import GoogleSignIn
import ProgressHUD

class UserReference {
    
    static func isLogged() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
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
    
    func resetPassword(withEmail email: String, onSucess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                onSucess()
            } else {
                onError(error!.localizedDescription)
            }
        }
    }
    
    func signInWithFacebook(viewController: UIViewController) {
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile, .email], viewController: viewController) { (result) in
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
    
    func signInWithGoogle(viewController: UIViewController){
        GIDSignIn.sharedInstance()?.presentingViewController = viewController
        GIDSignIn.sharedInstance().delegate = viewController as? GIDSignInDelegate
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func showHome() {
        guard let homeViewControler = UIStoryboard(name: "HomeMain",
                                                   bundle: nil).instantiateInitialViewController() as? UITabBarController else {return}
        
        UIViewController.replaceRootViewController(viewController: homeViewControler)
    }
    
    func messageUser(title: String, message: String, viewController: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(actionCancel)
        viewController.present(alert, animated: true)
    }
}
