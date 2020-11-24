//
//  MenuViewController.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 20/11/20.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var tableViewListMenu: UITableView!
    var arrayMenu = [Menu]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewListMenu.delegate = self
        tableViewListMenu.dataSource = self

      
    
        
        arrayMenu.append(Menu(name: "Perfil", image: "person_outline_black_48dp.png"))
        arrayMenu.append(Menu(name: "Favoritos", image: "star_outline_black_48dp.png"))
        arrayMenu.append(Menu(name: "Já Vistos", image: "visibility_black_48dp.png"))
        
 }
}

extension MenuViewController: UITableViewDelegate{
    
}
extension MenuViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.setup(menu: arrayMenu[indexPath.row])
        
        return cell
    }
    
    
}

