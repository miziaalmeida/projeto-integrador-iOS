//
//  UserAuth.swift
//  Jeffrey
//
//  Created by Mizia Lima on 1/27/21.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import ProgressHUD

class UserRef {
    
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
}
