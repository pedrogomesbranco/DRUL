//
//  InterfaceController.swift
//  WatchGameTeste Extension
//
//  Created by Pedro Gomes Branco on 26/09/16.
//  Copyright © 2016 Pedro Gomes Branco. All rights reserved.
//

import WatchKit
import Foundation
import SpriteKit


class InterfaceController: WKInterfaceController {
    
    var gameScene: GameScene!
    
    @IBOutlet var skInterface: WKInterfaceSKScene!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        // Load the SKScene from 'GameScene.sks'
        if let scene = GameScene(fileNamed: "GameScene") {
            
            gameScene = scene
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            // Present the scene
            self.skInterface.presentScene(scene)
            
            // Use a value that will maintain a consistent frame rate
            self.skInterface.preferredFramesPerSecond = 30
            
        }
    }
    
    @IBAction func handleSwipe(swipeGesture: WKGestureRecognizer){
        print("Swipe")
        WKInterfaceDevice.current().play(.click)
        gameScene.didSwipe(swipeGesture: swipeGesture as! WKSwipeGestureRecognizer)
    }
    
    @IBAction func handleTap(swipeGesture: WKTapGestureRecognizer){
        print("Tap")
        WKInterfaceDevice.current().play(.click)
        gameScene.didTapped(swipeGesture: swipeGesture)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
