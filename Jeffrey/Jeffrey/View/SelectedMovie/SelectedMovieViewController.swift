//
//  SelectedMovieViewController.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 18/11/20.
//

import UIKit
import Alamofire
import SnapKit


class SelectedMovieViewController: UIViewController {

    //MARK: IBOutlet
    @IBOutlet var imageFilmeBackGround: UIImageView!
    @IBOutlet var imageFilme: UIImageView!
    @IBOutlet var imageButtonSeen: UIImageView!
    @IBOutlet var imageButtonFavorite: UIImageView!
    @IBOutlet var imageButtonRaffle: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelSynopsis: UITextView!
    @IBOutlet var segmentControlDetails: UISegmentedControl!
    
    var controller = SelectedMovieController() // Controlador
    
    // MARK: IBAction
    @IBAction func goFavorites(_ sender: UIButton){
        if let screenAddMovie = UIStoryboard(name: "SeenMovie", bundle: nil).instantiateInitialViewController() as? SeenMovieViewController{
            screenAddMovie.arraymovieFavorites = controller.arrayMovieFavorites
            
            navigationController?.pushViewController(screenAddMovie, animated: true)
            
        }
        
    }
    
    @IBAction func goSee(_ sender: UIButton){
        if let screenAddMovie = UIStoryboard(name: "SeenMovie", bundle: nil).instantiateInitialViewController() as? SeenMovieViewController{
            screenAddMovie.arraymovieSeen = controller.arrayMovieSeen
            screenAddMovie.whichListToDisplay = "see"
            
            navigationController?.pushViewController(screenAddMovie, animated: true)
            
        }
        
    }
    
    @IBAction func buttonSeen(_ sender: UIButton){
        // altera o icone
        imageButtonSeen.image = controller.setButtonImageSeen(imageButton: imageButtonSeen)
        
        controller.addMovieArraySeen()
        print(controller.arrayMovieSeen.count)
        
    }
    
    
    @IBAction func buttonFavorite(_ sender: UIButton){
        // altera o icone
        imageButtonFavorite.image = controller.setButtonImageFavorite(imageButton: imageButtonFavorite)
        
        // adiciona o filme setado a lista de favoritos
        controller.addMovieArrayFavorites()
        print(controller.arrayMovieFavorites.count)
        
    }
    
    @IBAction func buttonRaffle (_ sender: UIButton){
        request()
        imageButtonSeen.image = UIImage(systemName: "eye.slash")
        imageButtonFavorite.image = UIImage(systemName: "star")
        
    }
    
    // SegmenteControll
    @IBAction func segmentControllDetails(_ sender: UISegmentedControl) {
        
        segmentControlCheck(segmentControll: sender)
        
    }
    
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
        
        // arredondar botão sortear
        imageButtonRaffle.layer.cornerRadius = imageButtonRaffle.frame.size.width/2
        imageButtonRaffle.clipsToBounds = true
        
        // esconde a navigationBar
        viewWillDisappear(true)
        
        // Chama a função que customiza o segmentControll
        
        controller.segmentControlCustom(custom: segmentControlDetails, view: view)
        
        // Controlador faz a requisição de um filme para API
        request()
        
        // Checar qual é seçao que está seleciona no segmentControll
        segmentControlCheck(segmentControll: segmentControlDetails )
    }
    
    // Verefica qual segmente esta selecionado
    func segmentControlCheck(segmentControll: UISegmentedControl){
        //        indexChanged(segmentedControll: segmentControll)
        controller.indexChangedSegmentControll(segmentedControll: segmentControlDetails, view: view)
        
        if segmentControll.selectedSegmentIndex == 0{
            labelSynopsis.alpha = 0
            labelTitle.alpha = 1
        }
        if segmentControll.selectedSegmentIndex == 1{
            labelSynopsis.alpha = 1
            labelTitle.alpha = 0
        }
        if segmentControll.selectedSegmentIndex == 2{
            labelSynopsis.alpha = 0
            labelTitle.alpha = 0
        }
    }
    
    
    func request(){
        controller.requestMovie { succes in
            self.labelTitle.text = self.controller.setTitle()
            self.imageFilme.image = self.controller.setImgageFilm()
            self.imageFilmeBackGround.image = self.controller.setImgageFilm()
            self.imageFilmeBackGround.alpha = 0.4
            self.labelSynopsis.text = self.controller.setOverView()
            
        }
    }
}
