import UIKit

class StartViewController: UIViewController {
    
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var logarButton: UIButton!
    @IBOutlet weak var cadastrarButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGradientView()
        configureButton(button: logarButton)
        configureButton(button: cadastrarButton)
    }
    
    @IBAction func logar(_ sender: Any) {
    }
    
    
    @IBAction func cadastrar(_ sender: Any) {
    }
    
    
    func setGradientView(){
        let colorTop =  UIColor(red: 56.0/255.0, green: 35.14/255.0, blue: 78.0/255.0, alpha: 1.0).cgColor
        let colorMiddle =  UIColor(red: 45.0/255.0, green: 44.14/255.0, blue: 101.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 44.0/255.0, green: 34.0/255.0, blue: 82.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorMiddle, colorBottom]
        gradientLayer.locations = [0.0, 0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func configureButton(button: UIButton){
        button.backgroundColor = .white
        button.tintColor = .black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.cornerCurve = .continuous
        button.layer.cornerRadius = 8.0
        button.clipsToBounds = true
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
    }
}
