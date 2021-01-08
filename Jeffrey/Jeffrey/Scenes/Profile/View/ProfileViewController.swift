import UIKit

class ProfileViewController: UIViewController{

    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var showImagePicker: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var imagePicker: ImagePicker!
    var sections = ["Editar Perfil", "Sair da conta"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        customImage()
        nameLabel.text = "Oi Ariana!"
    }
    
    @IBAction func showImagePicker(_ sender: Any) {
        self.imagePicker.present(from: sender as! UIButton)
    }

    
    func setupButton(button: UIButton){
        button.backgroundColor = .black
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
    
    func customButtons(button: UIButton){
        button.backgroundColor = UIColor.gray
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
    }
    
    func customImage(){
        profilePhoto.layer.cornerRadius = 20
        profilePhoto.clipsToBounds = true
        profilePhoto.layer.borderColor = UIColor.clear.cgColor
    }
}

extension ProfileViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.profilePhoto.image = image
    }
}

extension ProfileViewController: UITableViewDelegate {
    
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        
        cell.textLabel?.text = sections[indexPath.row]
        return cell
    }
}

