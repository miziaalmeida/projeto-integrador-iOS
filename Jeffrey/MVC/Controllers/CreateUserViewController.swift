import Firebase
import UIKit

class CreateUserViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var senhaField: UITextField!
    
    var userReference: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userReference = Database.database().reference().child("users")
    }
   
    @IBAction func createUser(_ sender: Any) {
        guard let key = userReference.childByAutoId().key
        else {return}
        
        let user = ["id": key,
                    "username": emailField.text! as String,
                    "password": senhaField.text! as String
        ]
        userReference.child(key).setValue(user)
    }
    
}
