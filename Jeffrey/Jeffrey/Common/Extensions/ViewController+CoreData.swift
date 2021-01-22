//
//  ViewController+CoreData.swift
//  Jeffrey
//
//  Created by Taize Carminatti on 20/01/21.
//

import UIKit
import CoreData

extension UIViewController {
    
    var context: NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
