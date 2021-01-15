//
//  SelectedMovieViewController.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 18/11/20.
//

import UIKit

protocol SelectedViewEvents: AnyObject {
    func present(viewController: UIViewController)
    func push(viewController: UIViewController)
}

class SelectedMovieViewController: UIViewController {
    
    //MARK: IBOutlet
    @IBOutlet var imageFilmeBackGround: UIImageView!
    @IBOutlet var imageButtonSeen: UIImageView! // MARK: ARRUMAR PARA UIButton
    @IBOutlet var imageButtonFavorite: UIImageView! // MARK: ARRUMAR PARA UIButton
    @IBOutlet var imageButtonRaffle: UIButton! // MARK: ARRUMAR PARA UIButton
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelRelease: UILabel!
    @IBOutlet var labelVoteAvarage: UILabel!
    @IBOutlet var textViewGenre: UITextField!
    @IBOutlet var textViewSinopse: UITextView!
    @IBOutlet var segmentedControlDetails: UISegmentedControl!
    @IBOutlet var viewBackgorund: UIView!
    @IBOutlet  var buttonProviders: UIButton!
    
    //MARK: Variables
    var viewModel: SelectedMovieViewModelProtocol!
    var customSegmentedControl = CustomSegmentControl()
    var raffle = true
    var movieScreenHome: Movie?
    var genteHomeListSearch:String?
    var tipViewModel: TipViewModel?
    var idGenre: Int = idGenres.animation.rawValue
    var idProvider: Int = idProviders.netflix.rawValue
    
    
    
    @IBAction func buttonProvider(_ sender: UIButton) {
        
        viewModel.redirectTap()
    }
    
    @IBAction func buttonShare(_ sender: UIButton) {
        
        let titleMovie = viewModel.getTitle()
        let text = "O filme certo; na hora certa. Conheça o Jeffrey; o app que mostra o que há de melhor nos streamings! Olha só o que ele me indicou: \(titleMovie)"
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
        
        
    }
    
    
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
        
        viewModel.raffleListOfAPIMovies { sucess in
            if sucess{
                self.setFields()
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
        viewModel.viewController = self
        
        if movieScreenHome != nil{
            viewModel.setMovieSearchBar(movie: movieScreenHome!)
        }
        
        viewModel.setIdGenre(id: idGenre)
        viewModel.setIdProvider(id: idProvider)
        viewModel.setNameProvider()
        roundViewBorder() // Arredodondar a borda da view
        
        // arredondar botão sortear
        roundImageButtonRaffle(image: imageButtonRaffle)
        
        
        //        viewWillDisappear(false) // esconde a navigationBar
        
        // Chama a função que customiza o segmentControll
        customSegmentedControl.segmentControlCustom(custom: segmentedControlDetails, view: view)
        
        if raffle{
            viewModel.raffleListOfAPIMovies { sucess in
                if sucess{
                    self.setFields()
                }
            }
        }else{
            imageButtonRaffle.isEnabled = false
            imageButtonRaffle.isHidden = true
            setFieldsMovieHome()
        }
        
        
        // Checar qual é seçao que está seleciona no segmentControll
        checkSegmentIndex()
        resetColorButtonSeenAndFavorite()
    }
    
    
    // setar o que vair ser mostrado na tela.
    func setFields(){
        
        labelTitle.text = viewModel.getTitle()
        labelRelease.text = viewModel.getRelease()
        textViewSinopse.text = viewModel.getOverView()
        imageFilmeBackGround.image = viewModel.getImageFilm()
        labelVoteAvarage.text = viewModel.getVoteAverage()
        buttonProviders.setImage(UIImage(named: viewModel.getImageStreaming()), for: UIControl.State.normal)
        textViewGenre.text =  viewModel.getGenre()
        
    }
    
    func setTip(gener: String, stream: String){
        self.tipViewModel = TipViewModel(gener: gener, stream: stream)
    }
    
    
    func setFieldsMovieHome(){
        
        labelTitle.text = viewModel.getTitle()
        labelRelease.text = movieScreenHome?.releaseDate
        textViewSinopse.text = viewModel.getOverView()
        imageFilmeBackGround.image = viewModel.getImageFilm()
        labelVoteAvarage.text = String((movieScreenHome?.voteAverage)!)
        buttonProviders.setImage(UIImage(named: viewModel.getImageStreaming()), for: UIControl.State.normal)
        textViewGenre.text =  genteHomeListSearch
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

extension SelectedMovieViewController: SelectedViewEvents {
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(viewController: UIViewController) {
        present(viewController, animated: true, completion: nil)
    }
}
