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
    
    
    func streamingRedirect(){
        var url = self.viewModel.searchInNetflix(movieName: self.movieName!)
        
        if providerName == "NOW"{
            url = self.viewModel.searchInNow(movieName: self.movieName!)
        }
        
        if providerName == "Telecine Play"{
            url = self.viewModel.searchInTelecinePlay(movieName: self.movieName!)
        }
        
        
        
        let seconds = 2.0 // tempo que a tela ficara mostrando a imagem do streaming
        // antes de fazer o redirecionamento.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            guard let url = URL(string: url) else { return }
            UIApplication.shared.open(url)
        }
        
    }
}
