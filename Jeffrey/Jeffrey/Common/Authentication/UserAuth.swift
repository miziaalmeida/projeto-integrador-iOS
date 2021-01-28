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

class UserAuth {
    func signUp(withUsername name: String, email: String, password: String, image: UIImage?,
                onSucess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            if let authData = authDataResult {
                print(authData.user.email)
                var dict: Dictionary<String, Any> = [
                    "uid": authData.user.uid,
                    "username": name,
                    "email": authData.user.email,
                    "profileImageUrl": "",
                    "status": "Cadastrado no Jeffrey"
                ]
                
                guard let imageSelected = image else {
                    ProgressHUD.showError("Por favor escolha uma foto")
                    return
                }
                
                guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else { return }
                
                //PAREI AQUI
                
                let storageRef = Storage.storage().reference().child("gs://jeffrey-296200.appspot.com")
                
                let storageAvatarProfileRef = storageRef.child("profileAvatar").child(authData.user.uid)
                
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpg"
                
                StorageService.savePhoto(username: name, uid: authData.user.uid, data: imageData, metadata: metadata, storageAvatarProfileRef: storageAvatarProfileRef, dict: dict, onSucess: {
                    onSucess()
                }, onError: {
                    (errorMessage) in
                    onError(errorMessage)
                })
            }
        }
    }
}
