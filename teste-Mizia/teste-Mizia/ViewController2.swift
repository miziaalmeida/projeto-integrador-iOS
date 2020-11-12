import FBSDKLoginKit
import GoogleSignIn
import UIKit


class ViewController2: UIViewController, LoginButtonDelegate {
    
    @IBOutlet var signGoogleButton: GIDSignInButton!
    @IBOutlet weak var signFacebookButton: FBLoginButton!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var entrarButton: UIButton!
    @IBOutlet weak var esqueceuSenhaButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        personalizeTextField()
        personalizeButtonEntrar()
        
        //Facebook
        if let token = AccessToken.current,
           !token.isExpired {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email, name"], tokenString: token, version: nil, httpMethod: .get)
            
            request.start(completionHandler: {connection, result, error in
                            print("result\(String(describing: result))")})
        } else {
            openFacebookLogin()
        }
        
        
        //Google
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    private func openFacebookLogin(){
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        loginButton.delegate = self
        loginButton.permissions = ["public_profile", "email"]
        view.addSubview(loginButton)
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email, name"], tokenString: token, version: nil, httpMethod: .get)
        
        request.start(completionHandler: {connection, result, error in
                        print("\(String(describing: result))")})
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }

    
    private func personalizeTextField(){
        //Cria o bottom line
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textFieldName.frame.height-2, width: textFieldName.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.init(red: 52/255, green: 52/255, blue: 52/255, alpha: 1).cgColor
        
        //Removendo as bordas
        textFieldName.borderStyle = .none
        
        //Add a bottomLine como borda textField
        textFieldName.layer.addSublayer(bottomLine)
        
        textFieldName.placeholder = "Email"
        textFieldName.textColor = UIColor(white: 100.00, alpha: 1)
    }
    
    private func personalizeButtonEntrar(){
        entrarButton.backgroundColor = UIColor.init(red: 0/255, green: 180/255, blue: 0/255, alpha: 1)
        entrarButton.tintColor = UIColor.white
        entrarButton.layer.cornerRadius = 10
        entrarButton.clipsToBounds = true
    }
    
    @IBAction func entrarButton(_ sender: Any) {
    }
}

    
