//
//  SelectedMovieController.swift
//  Jeffrey
//
//  Created by Michel dos Santos on 21/11/20.
//

import UIKit
import Alamofire

class SelectedMovieController{
    
    var movie: Movie?
    var arrayMovieFavorites = [Movie]()
    var arrayMovieSeen = [Movie]()
    var segmentindicator: UIView? = nil // view para a animação do segmentedControll
    
    
    func requestMovie(onComplete: @escaping (Bool) -> Void)  {
        let idFilme = Int.random(in: 220..<230) //
        
        AF.request("https://api.themoviedb.org/3/movie/\(idFilme)?api_key=16b776cd87d99568d7cf733de5593752&language=pt-BR").responseJSON { response in
            if let dictionary = response.value as? [String: Any] {
                let movie = Movie(fromDictionary: dictionary)
                self.setMovie(movie: movie)
                onComplete(true)
                return

            }
            onComplete(false)
        }

    }
    
    func setMovie(movie:Movie){
        self.movie = movie
    }
    
    func getMovie() -> Movie{
        return movie!
    }
    
    func setImgageFilm() -> UIImage{
        let idImage =  movie?.posterPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500/\(idImage!)")
        
        let data = try? Data(contentsOf: url!)
        
        return  UIImage(data: data!)!
  
    }
    
    func setOverView( ) -> String{
        return (movie?.overview)!
        
    }
    
    func setTitle() -> String{
        
        if let title = (movie?.title){
            return title
        }
        return "Filme Sem Titulo Disponível"
    }
    
    func setButtonImageSeen(imageButton: UIImageView) -> UIImage {
        imageButton.tintColor = UIColor.systemGreen
        if imageButton.image == UIImage(systemName: "eye"){
            return UIImage(systemName: "eye.slash")!
        }else{
            return UIImage(systemName: "eye")!
        }
        
        
    }
    
    func setButtonImageFavorite(imageButton: UIImageView) -> UIImage{
        
        imageButton.tintColor = UIColor.systemGreen
        
        if imageButton.image == UIImage(systemName: "star"){
            return UIImage(systemName: "star.fill")!
        }else{
            return UIImage(systemName: "star")!
        }
        
        
    }
    
    func addMovieArrayFavorites(){
        arrayMovieFavorites.append(movie!)
    }
    
    func addMovieArraySeen(){
        arrayMovieSeen.append(movie!)
    }
    
    func indexChangedSegmentControll(segmentedControll: UISegmentedControl, view:UIView){
        
        let numberOfSegments = CGFloat(segmentedControll.numberOfSegments)
        let selectedIndex = CGFloat(segmentedControll.selectedSegmentIndex)
        let titlecount = CGFloat((segmentedControll.titleForSegment(at: segmentedControll.selectedSegmentIndex)!.count))
        segmentindicator!.snp.remakeConstraints { (make) in
            make.top.equalTo(segmentedControll.snp.bottom).offset(3)
            make.height.equalTo(2)
            make.width.equalTo(15 + titlecount * 8)
            make.centerX.equalTo(segmentedControll.snp.centerX).dividedBy(numberOfSegments / CGFloat(3.0 + CGFloat(selectedIndex-1.0)*2.0))
        }
        
        UIView.animate(withDuration: 0.5) {
            view.layoutIfNeeded()
        }
    }
    
    
    func segmentControlCustom(custom:UISegmentedControl, view: UIView){
        custom.backgroundColor = .black
        custom.tintColor = .clear
        custom.selectedSegmentTintColor = .clear
        
        custom.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        custom.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "AvenirNextCondensed-Medium", size: 22)!, NSAttributedString.Key.foregroundColor: UIColor.green], for: .selected)
        
        segmentindicator = {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = UIColor.green
            return v
        }()
        
        
        view.addSubview(segmentindicator!)
        segmentindicator!.snp.makeConstraints { (make) in
            make.top.equalTo(custom.snp.bottom).offset(3)
            make.height.equalTo(2)
            make.width.equalTo(15 + custom.titleForSegment(at: 0)!.count * 8)
            make.centerX.equalTo(custom.snp.centerX).dividedBy(custom.numberOfSegments)
        }
    }
    
}
