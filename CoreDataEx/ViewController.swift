//
//  ViewController.swift
//  CoreDataEx
//
//  Created by Tejas Jadhav on 2018-11-09.
//  Copyright © 2018 Tejas Jadhav. All rights reserved.
//

import UIKit
import CoreData                     // 1.

class ViewController: UIViewController {
    // 2. 
    
    // MARK: CoreDta variables
    @IBOutlet weak var name: UITextField!
    // ------------------------------
    var context:NSManagedObjectContext!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup your CoreData variable
        // ----------------------------------------
        
        // 1. Mandatory - copy and paste this
        // Explanation: try to create/initalize the appDelegate variable.
        // If creation fails, then quit the app
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // 2. Mandatory - initialize the context variable
        // This variable gives you access to the CoreData functions
        self.context = appDelegate.persistentContainer.viewContext

    }
   
   
     
    @IBAction func AddDataAction(_ sender: Any) {
        
      //  var m = Fruit(context: self.context)
        
        // 1. Get data from text box
        let x = name.text!
        // 2. Create a "Person" Object
        let h = Humans(context: self.context)
        
        // 3. set the properties of the Human object
        // the "properties come from the entity!
        h.age = 40
        h.name = x
        
        // 4. save the person object to the database
        do {
            try self.context.save();
            print("Saved the person to the database!")
        }
        catch {
            print("Error when saving to the database")
        }
    }
    
    
    
    @IBAction func LoadDataAction(_ sender: Any) {
        // This is the same as:  SELECT * FROM User
        let fetchRequest:NSFetchRequest<Humans> = Humans.fetchRequest()
        
        do {
            // Send the "SELECT *" to the database
            //  results = variable that stores any "rows" that come back from the db
            // Note: The database will send back an array of User objects
            // (this is why I explicilty cast results as [User]
            let results = try fetchRequest.execute() as [Humans]
            
            // Loop through the database results and output each "row" to the screen
            print("Number of items in database: \(results.count)")
            
            for x in results {
                print("Person Email: \(x.name)")
                print("Person Password: \(x.age)")
            }
        }
        catch {
            print("Error when fetching from database")
        }
    }
    
}

