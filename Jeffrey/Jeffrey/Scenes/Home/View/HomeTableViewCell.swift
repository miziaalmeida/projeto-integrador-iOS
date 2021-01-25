//
//  HomeTableViewCell.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 19/12/20.
//

import UIKit

class HomeTableViewCell: UITableViewCell, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    var numberOfIten:Int = 0 
    // MARK: Outlets
    
    
    @IBOutlet weak var collectionViewHome : UICollectionView!
    
    var arrayMovies = [Movie]()
    var sectionInTableView = 0
    var controller:UIViewController?
    var genre:String?
    
   
    
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.collectionViewHome.delegate = self
        self.collectionViewHome.dataSource = self
       
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
     
        
        let storyboard = UIStoryboard(name: "SelectedMovie", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectedMovie") as! SelectedMovieViewController;
        vc.raffle = false
        vc.movieScreenHome = arrayMovies[indexPath.row]
        vc.genteHomeListSearch = genre
        controller!.present(vc, animated: true, completion: nil);
        
        
        
        
       
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfIten
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionViewCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? HomeCollectionViewCell)!
        
        cell.setup(movie: arrayMovies[indexPath.row])
        
        
        
        return cell
    }
    
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
           return CGSize(width: ((self.frame.size.width/2) - 10), height: collectionView.frame.height)
        }
 
   }
