//
//  AppDelegate.swift
//  Genre-SwiftUI
//
//  Created by Ryan David Forsyth on 2020-06-26.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        checkIfCsvHasBeenLoadedIntoCoreData()
        return true
    }

// MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "WordModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
// MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func checkIfCsvHasBeenLoadedIntoCoreData() {
        if (!WordManager.sharedInstance.checkIfCSVHasBeenLoaded()) {
            WordManager.sharedInstance.loadCsvIntoCoreData()
        }
        else { print("CSV already loaded into Core Data") }
    }

}

