//
//  TipViewController.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 04/01/21.
//

import UIKit

class TipViewController: UIViewController {
    
    var gener: String = ""
    var stream: String = ""
    var selectedMovie = SelectedMovieViewController()
    
    
    @IBOutlet var buttonGenre: [UIButton]!
    @IBOutlet var buttonStreaming: [UIButton]!
    @IBOutlet var buttonNext: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let customTabBarItem = UITabBarItem(title: "Dica", image: UIImage(named: "dica.png"),tag: 1)
//        self.tabBarItem = customTabBarItem

    }
    @IBAction func actionButtonNext(_ sender: Any) {
        selectedMovie.setTip(gener: self.gener, stream: self.stream)
        let storyboard = UIStoryboard(name: "SelectedMovie", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectedMovie") as! SelectedMovieViewController;
        self.present(vc, animated: true, completion: nil);
    }
    
    @IBAction func actionButtonGenre(_ sender: UIButton) {
        buttonGenre.forEach{
            $0.isSelected = false
        }
        sender.isSelected = true
        //sender.backgroundColor = UIColor.lightGray
        if let unwarappedGenre = sender.currentTitle{
            self.gener = unwarappedGenre
        }
        
    }
    
    @IBAction func actionButtonStreaming(_ sender: UIButton) {
        buttonStreaming.forEach{
            $0.isSelected = false
        }
        sender.isSelected = true
        if let unwrappedStream = sender.currentTitle {
            self.stream = unwrappedStream
    }
}
}
