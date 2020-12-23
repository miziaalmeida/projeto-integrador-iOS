//
//  SelectedMovieViewController.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 18/11/20.
//

import UIKit

class SelectedMovieViewController: UIViewController {
    
    //MARK: IBOutlet
    @IBOutlet var imageFilmeBackGround: UIImageView!
    //    @IBOutlet var imageFilme: UIImageView! // retirado no novo layout da página
    @IBOutlet var imageButtonSeen: UIImageView! // MARK: ARRUMAR PARA UIButton
    @IBOutlet var imageButtonFavorite: UIImageView! // MARK: ARRUMAR PARA UIButton
    @IBOutlet var imageButtonRaffle: UIImageView! // MARK: ARRUMAR PARA UIButton
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelRelease: UILabel!
    @IBOutlet var labelVoteAvarage: UILabel!
    @IBOutlet var textViewSinopse: UITextView!
    @IBOutlet var segmentedControlDetails: UISegmentedControl!
    @IBOutlet var viewBackgorund: UIView!
    @IBOutlet  var buttonProviders: UIButton!
    
    
    //MARK: Variables
    var viewModel = SelectedMovieViewModel() // Faz toda a lógica da viewController
    var customSegmentedControl = CustomSegmentControl()
    
    
    //MARK: IBACTION
    
    // abre a tela de redirecionamento para o streaming .
    @IBAction func buttonProvider(_ sender: UIButton) {
        if let screenAddMovie = UIStoryboard(name: " Redirect", bundle: nil).instantiateInitialViewController() as? RedirectViewController{
            screenAddMovie.movieName = viewModel.getTitle() // passa o nome do filme
            screenAddMovie.providerName = viewModel.getImageStreaming() // passa o nome do streaming selecionado
            navigationController?.pushViewController(screenAddMovie, animated: true)
        }
        
    }
    
    
    // MARK: Para quando criar a tela com as tableView
    // Abre a tela com os filmes Favoritos
    //    @IBAction func goFavorites(_ sender: UIButton){
    //        if let screenAddMovie = UIStoryboard(name: "SeenMovie", bundle: nil).instantiateInitialViewController() as? SeenMovieViewController{
    //
    //            screenAddMovie.arraymovieFavorites = viewModel.arrayMovieFavorites
    //
    //            navigationController?.pushViewController(screenAddMovie, animated: true)
    //        }
    //    }
    
    
    // MARK: Para quando criar a tela com as tableView
    // Abre a tela com os filmes Vistos
    //    @IBAction func goSee(_ sender: UIButton){
    //        if let screenAddMovie = UIStoryboard(name: "SeenMovie", bundle: nil).instantiateInitialViewController() as? SeenMovieViewController{
    //            screenAddMovie.arraymovieSeen = viewModel.arrayMovieSeen
    //            screenAddMovie.whichListToDisplay = "see"
    //
    //            navigationController?.pushViewController(screenAddMovie, animated: true)
    //        }
    //    }
    
    
    // altera a imagem do button quando clicado  e adiciona no array
    @IBAction func buttonSeen(_ sender: UIButton){
        // altera o icone do olho aberto/fechdo
        imageButtonSeen.image = viewModel.setButtonImageSeen(imageButton: imageButtonSeen)
        
        // adiciona o filme setado a lista de Já vistos
        viewModel.addMovieArraySeen()
    }
    
    // altera a imagem do button quando clicado  e adiciona no array
    @IBAction func buttonFavorite(_ sender: UIButton){
        // altera o icone coração
        imageButtonFavorite.image = viewModel.setButtonImageFavorite(imageButton: imageButtonFavorite)
        
        // adiciona o filme setado a lista de favoritos
        viewModel.addMovieArrayFavorites()
    }
    
    // Sortar novo filme.
    @IBAction func buttonRaffle (_ sender: UIButton){
        
        viewModel.request { loaded in
            if loaded{
                // se load for true ele checa o streaming
                
                self.viewModel.checkProvidersOfMovie() { sucess in
                    if sucess{
                        // o streaming retornando true, ou seja, confirmando que existe o filme no streaming selecionado, dai mostra pro usuário
                        self.setFields()
                    }
                }
                
            }
        }
        
        
        // Reseta  as imagens dos icones para Não visto e Não favorito
        imageButtonSeen.image = UIImage(systemName: "eye.slash")
        imageButtonSeen.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageButtonFavorite.image = UIImage(systemName: "star")
        imageButtonFavorite.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    // Mostrar respectivo ao que esta selecionado no segmentedcontrol
    @IBAction func segmentControllDetails(_ sender: UISegmentedControl) {
        
        // Verifica qual o indice que esta selecionado e seta o que for preciso mostrar pro usuario.
        checkSegmentIndex()
        
        // Chama a animação para a animacão to traço da segmentedControl
        customSegmentedControl.indexChangedSegmentControll (segmentedControll: segmentedControlDetails, view: view)
    }
    
    // Mostrar ou não a NavigationBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // faz a borda  arredonda da view  na parte superior.
        viewBackgorund.layer.cornerRadius = 60
        viewBackgorund.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        // arredondar botão sortear
        viewModel.roundImage(image: imageButtonRaffle)
        
        // esconde a navigationBar
        viewWillDisappear(false)
        
        // Chama a função que customiza o segmentControll
        customSegmentedControl.segmentControlCustom(custom: segmentedControlDetails, view: view)
        
        // Controlador faz a requisição de um filme para API
        viewModel.request { loaded in
            if loaded{
                self.setFields()
            }
        }
        
        // Checar qual é seçao que está seleciona no segmentControll
        checkSegmentIndex()
    }
    
    
    // setar o que vair ser mostrado na tela.
    func setFields(){
        labelTitle.text = viewModel.getTitle()
        labelRelease.text = viewModel.getRelease()
        //        imageFilme.image = viewModel.getImageFilm()// alterado no novo layout
        textViewSinopse.text = viewModel.getOverView()
        imageFilmeBackGround.image = viewModel.getImageFilm()
        labelVoteAvarage.text = viewModel.getVoteAverage()
        buttonProviders.setImage(UIImage(named: viewModel.getImageStreaming()), for: UIControl.State.normal)
        
    }
    
    //Checa qual index da segment e configura o que será mostrado ou não.
    func checkSegmentIndex(){
        
        if segmentedControlDetails.selectedSegmentIndex == 0{
            adjustLabelsLayout(toHideTextViewSinopse: false, toHideLabels: false, toHideStreaming: true)
            
        }else{
            adjustLabelsLayout(toHideTextViewSinopse: true, toHideLabels: false, toHideStreaming: false)
        }
    }
    
    
    
    // ajusta quais Outlets são para mostrar na tela.
    func adjustLabelsLayout(toHideTextViewSinopse: Bool , toHideLabels: Bool, toHideStreaming: Bool){
        
        textViewSinopse.isHidden = toHideTextViewSinopse
        labelTitle.isHidden = toHideLabels
        labelRelease.isHidden = toHideLabels
        labelVoteAvarage.isHidden = toHideLabels
        buttonProviders.isHidden = toHideStreaming
    }
}
