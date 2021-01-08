//
//  ListasViewController.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 04/01/21.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var segmentedControlList: UISegmentedControl!
    @IBOutlet weak var tableViewList: UITableView!
    
    var customSegmentedControl = CustomSegmentControl()
    var arrayMovie : [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        customSegmentedControl.segmentControlCustom(custom: segmentedControlList, view: view)
        
        tableViewList.delegate = self
        tableViewList.dataSource = self
        
      
    }
    

    @IBAction func segmentControlList(_ sender: UISegmentedControl) {
        
        customSegmentedControl.indexChangedSegmentControll(segmentedControll: segmentedControlList, view: view)
        
        
        }
}

extension ListViewController : UITableViewDelegate{
    
}

extension  ListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMovie!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        
        cell.setup(movie: arrayMovie![indexPath.row])
        
        
        
        return cell
        
        
    }
    
    
}

