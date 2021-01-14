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
        buttonStreaming.forEach{
            $0.isSelected = false
            $0.alpha = 0.3
        }
        
//        let customTabBarItem = UITabBarItem(title: "Dica", image: UIImage(named: "dica.png"),tag: 1)
//        self.tabBarItem = customTabBarItem

    }
    @IBAction func actionButtonNext(_ sender: Any) {
        selectedMovie.setTip(gener: self.gener, stream: self.stream)
        let storyboard = UIStoryboard(name: "SelectedMovie", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectedMovie") as! SelectedMovieViewController;
        if gener == nameGenres.action.rawValue{
            vc.idGenre = idGenres.action.rawValue
            
        }
        
        
        switch gener {
        case nameGenres.action.rawValue:
            vc.idGenre = idGenres.action.rawValue
        case nameGenres.adventure.rawValue:
            vc.idGenre = idGenres.adventure.rawValue
        case nameGenres.comedy.rawValue:
            vc.idGenre = idGenres.comedy.rawValue
        case nameGenres.romance.rawValue:
            vc.idGenre = idGenres.romance.rawValue
        case nameGenres.drama.rawValue:
            vc.idGenre = idGenres.drama.rawValue
        case nameGenres.sciencefiction.rawValue:
            vc.idGenre = idGenres.sciencefiction.rawValue
        case nameGenres.terror.rawValue:
            vc.idGenre = idGenres.terror.rawValue
        case nameGenres.animation.rawValue:
            vc.idGenre = idGenres.animation.rawValue
        case nameGenres.fantasy.rawValue:
            vc.idGenre = idGenres.fantasy.rawValue
        default:
            vc.idGenre = idGenres.animation.rawValue
        }
        
        
        switch stream {
        case nameProviders.netflix.rawValue:
            vc.idProvider = idProviders.netflix.rawValue
        case nameProviders.HBOGo.rawValue:
            vc.idProvider = idProviders.hbo.rawValue
        case nameProviders.telecine.rawValue:
            vc.idProvider = idProviders.telecine.rawValue
        case nameProviders.claro.rawValue:
            vc.idProvider = idProviders.claro.rawValue
        case nameProviders.looke.rawValue:
            vc.idProvider = idProviders.looke.rawValue
        case nameProviders.now.rawValue:
            vc.idProvider = idProviders.now.rawValue
        case nameProviders.disney.rawValue:
            vc.idProvider = idProviders.disney.rawValue
        case nameProviders.globo.rawValue:
            vc.idProvider = idProviders.globo.rawValue
        case nameProviders.tnt.rawValue:
            vc.idProvider = idProviders.tnt.rawValue
        case nameProviders.amazon.rawValue:
            vc.idProvider = idProviders.amazon.rawValue
        case nameProviders.apple.rawValue:
            vc.idProvider = idProviders.apple.rawValue
        case nameProviders.netMovies.rawValue:
            vc.idProvider = idProviders.netMovie.rawValue
       
        default:
            vc.idGenre = idGenres.animation.rawValue
        }
        
        
        
        
        self.present(vc, animated: true, completion: nil);
    }
    
    @IBAction func actionButtonGenre(_ sender: UIButton) {
        buttonGenre.forEach{
            $0.isSelected = false
            $0.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.07450980392, blue: 0.2196078431, alpha: 1)
        }
        sender.isSelected = true
        sender.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        if let unwarappedGenre = sender.currentTitle{
            self.gener = unwarappedGenre
            print(gener)
        }
        
    }
    
    
    
   
    
    @IBAction func actionButtonStreaming(_ sender: UIButton) {
        buttonStreaming.forEach{
            $0.isSelected = false
            $0.alpha = 0.3
        }
        sender.isSelected = true
        sender.alpha = 1
        if let unwrappedStream = sender.currentTitle {
            self.stream = unwrappedStream
    }
        print(stream)
}
}
