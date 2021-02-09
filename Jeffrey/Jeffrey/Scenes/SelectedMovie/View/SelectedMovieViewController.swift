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
    @IBOutlet var imageFilmeBackground: UIImageView!
    @IBOutlet var imageButtonSeen: UIImageView!
    @IBOutlet var imageButtonFavorite: UIImageView!
    @IBOutlet var imageButtonRaffle: UIButton!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelRelease: UILabel!
    @IBOutlet var labelVoteAvarage: UILabel!
    @IBOutlet var labelGenre: UILabel!
    @IBOutlet var textViewSinopse: UITextView!
    @IBOutlet var segmentedControlDetails: UISegmentedControl!
    @IBOutlet var viewBackground: UIView!
    @IBOutlet  var buttonProviders: UIButton!

    //MARK: Variables
    var viewModel: SelectedMovieViewModelProtocol!
    var customSegmentedControl = CustomSegmentedControl()
    var raffle = true
    var movieScreenHome: Movie?
    var genreHomeListSearch:String?
    var tipViewModel: TipViewModel?
    var idGenre: Int = idGenres.animation.rawValue
    var idProvider: Int = idProviders.netflix.rawValue
    var storageRealtime = FirebaseRealtime()

    //MARK: Action
    @IBAction func buttonProvider(_ sender: UIButton) {
        viewModel.redirectTap()
    }

    @IBAction func buttonSeen(_ sender: UIButton){
        imageButtonSeen.image = setButtonImageSeen(imageButton: imageButtonSeen) // altera o icone do olho aberto/fechdo
        viewModel.addMovieArraySeen() // adiciona o filme setado a lista de Já vistos
    }


    @IBAction func buttonFavorite(_ sender: UIButton){
        imageButtonFavorite.image = setButtonImageFavorite(imageButton: imageButtonFavorite) // altera o icone coração
        viewModel.addMovieArrayFavorites() // adiciona o filme setado a lista de favoritos
    }

    @IBAction func buttonRaffle (_ sender: UIButton){   // Sortear novo filme.
        viewModel.raffleListOfAPIMovies { sucess in
            if sucess{
                self.setFields()
            }
        }
        resetColorButtonSeenAndFavorite()
    }

    @IBAction func segmentControllDetails(_ sender: UISegmentedControl) {
        checkSegmentIndex() // Verifica qual o indice que esta selecionado e seta o que for preciso mostrar pro usuario.
        // Chama a animação para a animacão do traço da segmentedControl
        customSegmentedControl.indexChangedSegmentedControl (segmentedControl: segmentedControlDetails, view: view)
    }

    @IBAction func buttonShare(_ sender: UIButton) {
        viewModel.showActivityIndicator(view: self.view)
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
        roundImageButtonRaffle(image: imageButtonRaffle)// arredondar botão sortear
        customSegmentedControl.segmentedControlCustom(custom: segmentedControlDetails, view: view)

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
        checkSegmentIndex()// Checar qual é seçao que está seleciona no segmentControll
        resetColorButtonSeenAndFavorite()
    }

    func setFields(){  // setar o que vair ser mostrado na tela.
        labelTitle.text = viewModel.getTitle()
        labelRelease.text = viewModel.getRelease()
        textViewSinopse.text = viewModel.getOverView()
        imageFilmeBackground.image = viewModel.getImageFilm()
        labelVoteAvarage.text = viewModel.getVoteAverage()
        buttonProviders.setImage(UIImage(named: viewModel.getImageStreaming()), for: UIControl.State.normal)
        labelGenre.text = viewModel.getGenre()
    }

    func setTip(gener: String, stream: String){
        self.tipViewModel?.setTip(gener: gener, stream: stream)
        //self.tipViewModel = TipViewModel(gener: gener, stream: stream)
    }

    func setFieldsMovieHome(){
        labelTitle.text = viewModel.getTitle()
        labelRelease.text = viewModel.getRelease()
        textViewSinopse.text = viewModel.getOverView()
        imageFilmeBackground.image = viewModel.getImageFilm()
        let nota = String((movieScreenHome?.voteAverage)!)
        labelVoteAvarage.text = "⭐ \(nota)"
        buttonProviders.setImage(UIImage(named: viewModel.getImageStreaming()), for: UIControl.State.normal)
        labelGenre.text = genreHomeListSearch
    }

    func setTip(gener: String, stream: String){
           self.tipViewModel?.setTip(gener: gener, stream: stream)
       }

    func checkSegmentIndex(){ //Checa qual index da segment e configura o que será mostrado ou não.
        if segmentedControlDetails.selectedSegmentIndex == 0{
            adjustLabelsLayout(toHideTextViewSinopse: false, toHideLabels: false, toHideStreaming: true)
        }else{
            adjustLabelsLayout(toHideTextViewSinopse: true, toHideLabels: false, toHideStreaming: false)
        }
    }

    // ajusta quais Outlets são para mostrar na tela.
    func adjustLabelsLayout(toHideTextViewSinopse: Bool , toHideLabels: Bool, toHideStreaming: Bool){
        textViewSinopse.isHidden = toHideTextViewSinopse
        labelGenre.isHidden = toHideLabels
        labelTitle.isHidden = toHideLabels
        labelRelease.isHidden = toHideLabels
        labelVoteAvarage.isHidden = toHideLabels
        buttonProviders.isHidden = toHideStreaming
    }

    func resetColorButtonSeenAndFavorite(){ // Reseta  as imagens dos icones para Não visto e Não favorito
        imageButtonSeen.image = UIImage(systemName: "eye.slash")
        imageButtonSeen.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imageButtonFavorite.image = UIImage(systemName: "star")
        imageButtonFavorite.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }

    func roundImageButtonRaffle(image:UIButton){ // Arredonda a imagem do botão Sortear
        imageButtonRaffle.layer.cornerRadius = image.frame.size.width/2
        imageButtonRaffle.clipsToBounds = true
    }

    func setButtonImageSeen(imageButton: UIImageView) -> UIImage { // Seta a imagem do botão Vistos
        if imageButtonSeen.image == UIImage(systemName: "eye"){
            imageButtonSeen.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            return UIImage(systemName: "eye.slash")!
        }else{
            imageButtonSeen.tintColor = #colorLiteral(red: 1, green: 0.7568627451, blue: 0.02745098039, alpha: 1)
            return UIImage(systemName: "eye")!
        }
    }

    func setButtonImageFavorite(imageButton: UIImageView) -> UIImage{ // Seta a imagem do botão Favoritos
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
        viewBackgorund.layer.cornerRadius = 30
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
