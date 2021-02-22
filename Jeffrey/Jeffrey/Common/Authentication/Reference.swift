import Foundation
import Firebase


//References
let REF_USER = "users"
let URL_STORAGE_ROOT = "gs://jeffrey-296200.appspot.com"
let STORAGE_PROFILE = "profileAvatar"
let PROFILE_IMAGE_URL = "profileImageUrl"

//AuthData
let UID = "uid"
let USERNAME = "username"
let EMAIL = "email"
let STATUS = "status"

//Messages
let ERROR_EMPTY_PHOTO = "Por favor escolha uma foto"
let ERROR_EMPTY_USERNAME = "Por favor preencha o campo de nome"
let ERROR_EMPTY_EMAIL = "Por favor preencha o campo de email"
let ERROR_EMPTY_PASSWORD = "Por favor escolha uma senha entre 6 e 12 caracteres"
let ERROR_EMPTY_EMAIL_RESET = "Por favor entre com um email para envio de reset de senha"

class Ref {
    
    //Database
    let databaseRoot: DatabaseReference = Database.database().reference()
    
    var databaseUsers: DatabaseReference {
        return databaseRoot.child(REF_USER)
    }
    
    func databaseSpecificUser(uid: String) -> DatabaseReference {
        return databaseUsers.child(uid)
    }
    
    //Storage
    let storageRoot = Storage.storage().reference(forURL: URL_STORAGE_ROOT)
    
    var storageProfile: StorageReference {
        return storageRoot.child(STORAGE_PROFILE)
    }
    
    func storageSpecificProfile(uid: String) -> StorageReference {
        return storageProfile.child(uid)
    }
}
