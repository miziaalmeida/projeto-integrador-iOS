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
    @IBOutlet var imageButtonSeen: UIImageView! // MARK: ARRUMAR PARA UIButton
    @IBOutlet var imageButtonFavorite: UIImageView! // MARK: ARRUMAR PARA UIButton
    @IBOutlet var imageButtonRaffle: UIButton! // MARK: ARRUMAR PARA UIButton
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelRelease: UILabel!
    @IBOutlet var labelVoteAvarage: UILabel!
    @IBOutlet var textViewSinopse: UITextView!
    @IBOutlet var segmentedControlDetails: UISegmentedControl!
    @IBOutlet var viewBackgorund: UIView!
    @IBOutlet  var buttonProviders: UIButton!
    
    
    
    //MARK: Variables
    var viewModel: SelectedMovieViewModelProtocol! 
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
        imageButtonSeen.image = setButtonImageSeen(imageButton: imageButtonSeen)
        
        // adiciona o filme setado a lista de Já vistos
        viewModel.addMovieArraySeen()
    }
    
    // altera a imagem do button quando clicado  e adiciona no array
    @IBAction func buttonFavorite(_ sender: UIButton){
        // altera o icone coração
        imageButtonFavorite.image = setButtonImageFavorite(imageButton: imageButtonFavorite)
        
        // adiciona o filme setado a lista de favoritos
        viewModel.addMovieArrayFavorites()
    }
    
    // Sortar novo filme.
    @IBAction func buttonRaffle (_ sender: UIButton){
        
        viewModel.raffle { sucess in
            if sucess{
                self.setFields()
            }else{
                //                self.buttonRaffle(sender)
            }
        }
        
        resetColorButtonSeenAndFavorite()
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
        viewModel = SelectedMovieViewModel()
        
        roundViewBorder() // Arredodondar a borda da view

        // arredondar botão sortear
        roundImageButtonRaffle(image: imageButtonRaffle)
        
        
        viewWillDisappear(false) // esconde a navigationBar
        
        // Chama a função que customiza o segmentControll
        customSegmentedControl.segmentControlCustom(custom: segmentedControlDetails, view: view)
   
        
      viewModel.raffle { sucess in
        if sucess{
            self.setFields()
        }else{
            //                self.buttonRaffle(sender)
        }
    }
        
        // Checar qual é seçao que está seleciona no segmentControll
        checkSegmentIndex()
        resetColorButtonSeenAndFavorite()
    }
    
    
    // setar o que vair ser mostrado na tela.
    func setFields(){
        print(String(viewModel.getTitle()))
        labelTitle.text = viewModel.getTitle()
        labelRelease.text = viewModel.getRelease()
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
    
    //
    func resetColorButtonSeenAndFavorite(){
        // Reseta  as imagens dos icones para Não visto e Não favorito
        imageButtonSeen.image = UIImage(systemName: "eye.slash")
        imageButtonSeen.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageButtonFavorite.image = UIImage(systemName: "star")
        imageButtonFavorite.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
    // Arredonda a imagem do botão Sortear
    func roundImageButtonRaffle(image:UIButton){
        imageButtonRaffle.layer.cornerRadius = image.frame.size.width/2
        imageButtonRaffle.clipsToBounds = true
        
        imageButtonRaffle.setImage(UIImage(named: "novofilme"), for: .normal)
        imageButtonRaffle.backgroundColor = #colorLiteral(red: 1, green: 0.7568627451, blue: 0.02745098039, alpha: 1)
        
    }
    
    // Seta a imagem do botão Vistos
    func setButtonImageSeen(imageButton: UIImageView) -> UIImage {
        
        if imageButtonSeen.image == UIImage(systemName: "eye"){
            imageButtonSeen.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            return UIImage(systemName: "eye.slash")!
        }else{
            
            imageButtonSeen.tintColor = #colorLiteral(red: 1, green: 0.7568627451, blue: 0.02745098039, alpha: 1)
            return UIImage(systemName: "eye")!
        }
    }
    // Seta a imagem do botão Favoritos
    func setButtonImageFavorite(imageButton: UIImageView) -> UIImage{
        
        if imageButtonFavorite.image == UIImage(systemName: "star"){
            imageButtonFavorite.tintColor = #colorLiteral(red: 1, green: 0.7568627451, blue: 0.02745098039, alpha: 1)
            return UIImage(systemName: "star.fill")!
        }else{
            imageButtonFavorite.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            return UIImage(systemName: "star")!
        }
    }
    
    // faz a borda  arredonda da view  na parte superior.
    func roundViewBorder(){
        viewBackgorund.layer.cornerRadius = 60
        viewBackgorund.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    
}
