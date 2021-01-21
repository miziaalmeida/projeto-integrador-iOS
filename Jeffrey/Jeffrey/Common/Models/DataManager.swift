//
//  DataManager.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 21/01/21.
//

import CoreData

class DataManager {
    
    static let shared = DataManager()
    var moviesData: [MovieData] = []
    
    func saveData(textSearch: String, with context: NSManagedObjectContext){
        let movieData = MovieData(context: context)
        movieData.textSearch = textSearch
        
        try? context.save()
    }
    
    
    func loadData(with context: NSManagedObjectContext) {
        let fetchRequest : NSFetchRequest<MovieData> = MovieData.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "textSearch", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        moviesData = try! context.fetch(fetchRequest)
        }
    
    func deleteData(index: Int, context: NSManagedObjectContext){
        let movieData = moviesData[index]
        context.delete(movieData)
        try? context.save()
    }
    
    
    private init(){}
}

