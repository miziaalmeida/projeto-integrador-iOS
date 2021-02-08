//
//  TipViewModel.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 04/01/21.
//

import UIKit

protocol TipViewModelProtocol: AnyObject{
    func didTapNext()
    func didTapButtonGenre(button: [UIButton],_ sender: UIButton)
    func didTapButtonStreaming(button: [UIButton],_ sender: UIButton)
    func setTip(gener: String, stream: String)
    var viewController: TipViewControllerEvents? {get set}
}

class TipViewModel: TipViewModelProtocol{
    
    var gener: String = ""
    var stream: String = ""
    var selectedMovie = SelectedMovieViewController()
    
    weak var viewController: TipViewControllerEvents?
    
    func didTapNext(){
        guard let selectedMovieView = UIStoryboard(name: "SelectedMovie", bundle: nil).instantiateInitialViewController() as? SelectedMovieViewController else {return}
        
        if gener == nameGenres.action.rawValue{
            selectedMovieView.idGenre = idGenres.action.rawValue
            
        }
        
        switch gener {
        case nameGenres.action.rawValue:
            selectedMovieView.idGenre = idGenres.action.rawValue
        case nameGenres.adventure.rawValue:
            selectedMovieView.idGenre = idGenres.adventure.rawValue
        case nameGenres.comedy.rawValue:
            selectedMovieView.idGenre = idGenres.comedy.rawValue
        case nameGenres.romance.rawValue:
            selectedMovieView.idGenre = idGenres.romance.rawValue
        case nameGenres.drama.rawValue:
            selectedMovieView.idGenre = idGenres.drama.rawValue
        case nameGenres.sciencefiction.rawValue:
            selectedMovieView.idGenre = idGenres.sciencefiction.rawValue
        case nameGenres.terror.rawValue:
            selectedMovieView.idGenre = idGenres.terror.rawValue
        case nameGenres.animation.rawValue:
            selectedMovieView.idGenre = idGenres.animation.rawValue
        case nameGenres.fantasy.rawValue:
            selectedMovieView.idGenre = idGenres.fantasy.rawValue
        default:
            selectedMovieView.idGenre = idGenres.animation.rawValue
        }
        
        switch stream {
        case nameProviders.netflix.rawValue:
            selectedMovieView.idProvider = idProviders.netflix.rawValue
        case nameProviders.HBOGo.rawValue:
            selectedMovieView.idProvider = idProviders.hbo.rawValue
        case nameProviders.telecine.rawValue:
            selectedMovieView.idProvider = idProviders.telecine.rawValue
        case nameProviders.claro.rawValue:
            selectedMovieView.idProvider = idProviders.claro.rawValue
        case nameProviders.looke.rawValue:
            selectedMovieView.idProvider = idProviders.looke.rawValue
        case nameProviders.now.rawValue:
            selectedMovieView.idProvider = idProviders.now.rawValue
        case nameProviders.disney.rawValue:
            selectedMovieView.idProvider = idProviders.disney.rawValue
        case nameProviders.globo.rawValue:
            selectedMovieView.idProvider = idProviders.globo.rawValue
        case nameProviders.tnt.rawValue:
            selectedMovieView.idProvider = idProviders.tnt.rawValue
        case nameProviders.amazon.rawValue:
            selectedMovieView.idProvider = idProviders.amazon.rawValue
        case nameProviders.apple.rawValue:
            selectedMovieView.idProvider = idProviders.apple.rawValue
        case nameProviders.netMovies.rawValue:
            selectedMovieView.idProvider = idProviders.netMovie.rawValue
            
        default:
            selectedMovieView.idGenre = idGenres.animation.rawValue
        }
        
        selectedMovie.setTip(gener: self.gener, stream: self.stream)
        viewController?.present(controller: selectedMovieView)
    }
    
    func didTapButtonGenre(button: [UIButton],_ sender: UIButton){
        button.forEach{
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
    
    func didTapButtonStreaming(button: [UIButton],_ sender: UIButton){
        button.forEach{
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
    
    func setTip(gener: String, stream: String){
    }
}
