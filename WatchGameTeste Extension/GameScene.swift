//
//  GameScene.swift
//  WatchGameTeste Extension
//
//  Created by Pedro Gomes Branco on 26/09/16.
//  Copyright © 2016 Pedro Gomes Branco. All rights reserved.
//

import SpriteKit
import WatchKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var label: SKLabelNode = SKLabelNode()
    let directions = ["CIMA", "BAIXO", "DIREITA", "ESQUERDA"]
    var userScore = UserDefaults.standard
    var timer = Clock()
    
    override func sceneDidLoad() {
        
        for node in self.children{
            if(node.name == "helloLabel"){
                if  let someLabel:SKLabelNode = node as? SKLabelNode{
                    label = someLabel
                }
            }
        }
        
        scene?.backgroundColor = UIColor.clear
        
        if userScore.value(forKey: "score") == nil{
            userScore.set(0, forKey: "score")
        }
        
        label.text = directions[Int(arc4random_uniform(4))]
        label.fontColor = UIColor.white
        timer.startWithDuration(1.5)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if(timer.hasFinished()){
            label.setScale(0.8)
            label.text = "VOCÊ PERDEU"
        }
    }
    
    func swipeCorreto(){
        WKInterfaceDevice.current().play(.success)
        let last =  userScore.value(forKey: "score") as! Int
        userScore.set((last+1), forKey: "score")
        label.text = directions[Int(arc4random_uniform(4))]
        label.setScale(1.0)
        let growAction = SKAction.scale(by: 1.2, duration: 0.2)
        label.run(growAction)
        label.fontColor = UIColor.white
        timer.startWithDuration(1)
    }
    
    func swipeErrado(){
        WKInterfaceDevice.current().play(.failure)
        label.setScale(0.8)
        label.text = "VOCÊ PERDEU"
        label.color = UIColor.white
        if((userScore.value(forKey: "score") as! Int) > (userScore.value(forKey: "recorde") as! Int)){
            userScore.set((userScore.value(forKey: "score") as! Int), forKey: "recorde")
        }
        userScore.set(0, forKey: "temp")
    }
    
    func didSwipe(swipeGesture: WKSwipeGestureRecognizer){
        if(swipeGesture.direction == .right){
            if(label.text == "DIREITA"){
                swipeCorreto()
            }
            else{
                swipeErrado()
            }
        }
        else if(swipeGesture.direction == .left){
            if(label.text == "ESQUERDA"){
                swipeCorreto()
            }
            else{
                swipeErrado()
            }
        }
        else if(swipeGesture.direction == .up){
            if(label.text == "CIMA"){
                swipeCorreto()
            }
            else{
                swipeErrado()
            }
        }
        else if(swipeGesture.direction == .down){
            if(label.text == "BAIXO"){
                swipeCorreto()
            }
            else{
                swipeErrado()
            }
        }
    }
    
    func didTapped(swipeGesture: WKTapGestureRecognizer){
        if (label.text == "VOCÊ PERDEU"){
            userScore.set(-1, forKey: "score")
            swipeCorreto()
            timer.startWithDuration(1.3)
        }
    }
}
