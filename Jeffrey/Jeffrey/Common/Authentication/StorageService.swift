import Foundation
import FirebaseStorage
import FirebaseAuth
import ProgressHUD
import FirebaseDatabase

class StorageService {
    
    static func savePhoto(username: String, uid: String, data: Data, metadata: StorageMetadata, storageAvatarProfileRef: StorageReference, dict: Dictionary<String, Any>, onSucess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void ) {
        
        storageAvatarProfileRef.putData(data, metadata: metadata, completion: { (storageMetaData, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            storageAvatarProfileRef.downloadURL(completion: { (url, error) in
                if let metadataImageUrl = url?.absoluteString {
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest(){
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges(completion: { (error) in
                            if let error = error {
                                ProgressHUD.showError(error.localizedDescription)
                            }
                        })
                    }
                    var dictTemp = dict
                    dictTemp[PROFILE_IMAGE_URL] = metadataImageUrl
                    
                    Ref().databaseSpecificUser(uid: uid).updateChildValues(dictTemp, withCompletionBlock: { (error, ref) in
                        if error == nil {
                            onSucess()
                        }
                        else {
                            onError(error!.localizedDescription)
                        }
                    })
                }
            })
        })
    }
}
