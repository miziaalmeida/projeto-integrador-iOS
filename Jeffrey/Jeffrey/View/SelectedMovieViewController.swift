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
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelSynopsis: UILabel!
    
    //MARK VAR
    var movie:  Movie?
    var requestAPI = RequestMovieAPI()
    
    // MARK: IBAction
    
    @IBAction func buttonSeen(_ sender: UIButton){
        if imageButtonSeen.image == UIImage(systemName: "eye"){
            imageButtonSeen.image = UIImage(systemName: "eye.slash")
        }else{
            imageButtonSeen.image = UIImage(systemName: "eye")
        }
       
        imageButtonSeen.tintColor = UIColor.systemGreen
    }
    
    
    
    @IBAction func buttonFavorite(_ sender: UIButton){
        if imageButtonFavorite.image == UIImage(systemName: "star"){
            imageButtonFavorite.image = UIImage(systemName: "star.fill")
        }else{
            imageButtonFavorite.image = UIImage(systemName: "star")
        }
       
        imageButtonFavorite.tintColor = UIColor.systemGreen
    }
    
    @IBAction func segmentControllDetails(_ sender: UISegmentedControl) {
        
        
    }
    
    
    //MARK: Func
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        movie = requestAPI.getFilme(id: 27)
        
       
        
        labelTitle.text = movie?.title

     
    }
    


}
