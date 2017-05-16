//
//  HomeInterfaceController.swift
//  WatchGame
//
//  Created by Pedro Gomes Branco on 28/09/16.
//  Copyright © 2016 Pedro Gomes Branco. All rights reserved.
//

import WatchKit
import Foundation

class HomeInterfaceController: WKInterfaceController {

    var userRecord = UserDefaults.standard
    
    @IBOutlet var recorde: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if userRecord.value(forKey: "recorde") == nil{
            userRecord.set(0, forKey: "recorde")
        }
        
        recorde.setText("RECORDE: \(userRecord.value(forKey: "recorde") as! Int)")
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if userRecord.value(forKey: "recorde") == nil{
            userRecord.set(0, forKey: "recorde")
        }
        recorde.setText("RECORDE: \(userRecord.value(forKey: "recorde") as! Int)")
    }
    
    override func didAppear() {
        super.didAppear()
        
        if userRecord.value(forKey: "recorde") == nil{
            userRecord.set(0, forKey: "recorde")
        }
        recorde.setText("RECORDE: \(userRecord.value(forKey: "recorde") as! Int)")
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
}
