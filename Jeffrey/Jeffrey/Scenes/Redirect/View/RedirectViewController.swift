//
//  RedirectViewController.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 09/12/20.
//

import UIKit

class RedirectViewController: UIViewController {
    
    var movieName: String?
    let viewModel = RedirectViewModel()
    var providerName: String?
    
    @IBOutlet weak var imageStreaming: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // seta a imagem do streaming selecionado
        imageStreaming.image = UIImage(named: providerName!)
        
        // chama função para abertura do streaming selecionado
        streamingRedirect()
        
    }
    
    // fazer HBO Go, OldFlix, Amazon
    //    func streamingRedirect(){
    //        var url: String!
    //        switch providerName {
    //        case nameProviders.looke.rawValue:
    //            url = self.viewModel.searchInLook(movieName: self.movieName!)
    //        case nameProviders.now.rawValue:
    //            url = self.viewModel.searchInNow(movieName: self.movieName!)
    //        case nameProviders.telecine.rawValue:
    //            url = self.viewModel.searchInTelecinePlay(movieName: self.movieName!)
    //        case nameProviders.claro.rawValue:
    //            url = self.viewModel.searchInClaroVideo(movieName: self.movieName!)
    //        case nameProviders.netflix.rawValue:
    //            url = self.viewModel.searchInNetflix(movieName: self.movieName!)
    //        default:
    //            print("nenhum provedor")
    //        }
    //
    //
    //
    //        if providerName == nameProviders.claro.rawValue{
    //            url = self.viewModel.searchInClaroVideo(movieName: self.movieName!)
    //        }
    //
    //
    //
    //
    //
    //        let seconds = 2.0 // tempo que a tela ficara mostrando a imagem do streaming
    //        // antes de fazer o redirecionamento.
    //
    //        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
    //            guard let url = URL(string: url) else { return }
    //            UIApplication.shared.open(url)
    //        }
    //
    //    }
    //}
    
    
    func streamingRedirect(){
    
        var url: String!
        
        if let movie = self.movieName{
            switch providerName {
            case nameProviders.looke.rawValue:
                url = self.viewModel.searchInLook(movieName: movie)
            case nameProviders.now.rawValue:
                url = self.viewModel.searchInNow(movieName: movie)
            case nameProviders.telecine.rawValue:
                url = self.viewModel.searchInTelecinePlay(movieName: movie)
            case nameProviders.claro.rawValue:
                url = self.viewModel.searchInClaroVideo(movieName: movie)
            case nameProviders.netflix.rawValue:
                url = self.viewModel.searchInNetflix(movieName: movie)
            case    nameProviders.HBOGo.rawValue:
                url = self.viewModel.searchInHBO()
            case    nameProviders.netMovies.rawValue:
                url = self.viewModel.searchInNetMovie(movieName: movie)
            case    nameProviders.globo.rawValue:
                url = self.viewModel.searchInGloboPlay(movieName: movie)
            case    nameProviders.disney.rawValue:
                url = self.viewModel.searchInDisney(movieName: movie)
            case    nameProviders.amazon.rawValue:
                url = self.viewModel.searchInAmazonPrime()
            case    nameProviders.apple.rawValue:
                url = self.viewModel.searchInApple()
            case    nameProviders.tnt.rawValue:
                url = self.viewModel.searchInTnt()
            default:
                print("nenhum provedor")
            }
        }
        
        let seconds = 2.0 // tempo que a tela ficara mostrando a imagem do streaming
                // antes de fazer o redirecionamento.
        
                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                    guard let url = URL(string: url) else { return }
                    UIApplication.shared.open(url)
                }
    }
}
