//
//  ViewController.swift
//  teste-Mizia
//
//  Created by Mizia Lima on 11/10/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nomeTextField: UITextField!
    
    @IBOutlet weak var senhaTextField: UITextField!
    
    @IBOutlet weak var entrarButton: UIButton!
    @IBOutlet weak var facebookLogin: UIButton!
    
    @IBOutlet weak var googleLogin: UIButton!
    
    @IBOutlet weak var iconFacebook: UIImageView!
    
    @IBOutlet weak var iconGoogle: UIImageView!
    
    @IBOutlet weak var esqueceuSenha: UIButton!
    
    @IBOutlet weak var toolbar: UIToolbar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func entrarButton(_ sender: Any) {
        entrarButton.layer.cornerRadius = 5
    }
    
    
    @IBAction func facebookAction(_ sender: Any) {
        facebookLogin.backgroundColor = .clear
        facebookLogin.layer.cornerRadius = 5
        facebookLogin.layer.borderWidth = 1
        facebookLogin.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func googleAction(_ sender: Any) {
        googleLogin.backgroundColor = .clear
        googleLogin.layer.cornerRadius = 5
        googleLogin.layer.borderWidth = 1
        googleLogin.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func esqueceuSenhaAction(_ sender: Any) {
    }
    
    
    
    
}





