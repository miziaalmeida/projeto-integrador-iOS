//
//  FirebaseRealtime.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 31/01/21.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

enum TypeList: String {
    case favoritos
    case jaVistos
}

class FirebaseRealtime{
    
    
    func saveMovie(movieData: Movie, typeList: TypeList){
        
        let database = Database.database().reference()
        let user = database.child("users")
        let idUsers = Auth.auth().currentUser?.uid
        let movies = user.child(idUsers!).child(typeList.rawValue)
        
        if let idUsersIsLoggedIn = idUsers {
            let userIsLoggedIn = user.child(idUsersIsLoggedIn)
            userIsLoggedIn.observeSingleEvent(of: DataEventType.value) { (snapshot) in
                
                let movie = [
                    "nameMovie" : movieData.title ?? "",
                    "releaseData":movieData.releaseDate ?? "",
                    "voteAverage": movieData.voteAverage ?? "",
                    "urlImage": movieData.posterPath ?? "",
                    "overview": movieData.overview ?? ""
                ] as [String : Any]
                
                movies.childByAutoId().setValue(movie)
        }
    }
  }
       
    func listMovie(typeList: TypeList, completion: @escaping (Movie) -> Void) {
       
        let database = Database.database().reference()
        let user = database.child("users")
        let idUsers = Auth.auth().currentUser?.uid
        let movies = user.child(idUsers!).child(typeList.rawValue)
        
        DispatchQueue.main.async {
            movies.observe(DataEventType.childAdded) { (snapshot) in
                let snap = snapshot.value as? NSDictionary
                
                var dictionary = [String:Any]()
                dictionary["title"] = snap?["nameMovie"] as! String
                dictionary["release_date"] = snap?["releaseData"] as! String
                dictionary["poster_path"] = snap?["urlImage"] as! String
                dictionary["vote_average"] = snap?["voteAverage"] as! Double
                dictionary["overview"] = snap?["overview"] as! String
                
                completion(Movie(fromDictionary: dictionary))
            }
        }
    }
}
