//
//  GameScene.swift
//  WatchGame
//
//  Created by Lucas Ferraço on 29/09/16.
//  Copyright © 2016 Lucas Ferraço. All rights reserved.
//

import SpriteKit
import UIKit

class GameScene: SKScene {
    
    var label: SKLabelNode = SKLabelNode()
    let direcoes = ["Direita", "Esquerda", "Cima", "Baixo"]
    var fundo: SKSpriteNode = SKSpriteNode(texture: SKTexture(imageNamed: "fundo"),
                                           color: UIColor.clear,
                                           size: UIScreen.main.bounds.size)
    var userScore = UserDefaults.standard
    var timer = Clock()
    
    override func sceneDidLoad() {
        //Acha o node correspondente ao que vai indicar a direção do swipe a ser feito
        for node in self.children {
            if(node.name == "labelDirecao") {
                if  let someLabel: SKLabelNode = node as? SKLabelNode {
                    label = someLabel
                }
            }
        }
        
        //Configura o fundo da tela com as barras coloridas
        fundo.position = CGPoint(x: 0, y: 0)
        fundo.zPosition = -1
        fundo.size = CGSize(width: size.width, height: size.height)
        self.addChild(fundo)
        
        //Cria o score do jogador
        if userScore.value(forKey: "score") == nil {
            userScore.set(0, forKey: "score")
        }
        
        label.text = direcoes[Int(arc4random_uniform(4))]
        
        //Começa o timer
        timer.startWithDuration(1.5)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if timer.hasFinished() {
            label.setScale(0.8)
            label.text = "Você perdeu."
        }
    }
    
    func didSwipe(swipeGesture: UISwipeGestureRecognizer) {
        switch swipeGesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            if (label.text == "Direita") {
                swipeCorreto()
            }
            else {
                swipeErrado()
            }
        case UISwipeGestureRecognizerDirection.left:
            if (label.text == "Esquerda") {
                swipeCorreto()
            }
            else {
                swipeErrado()
            }
        case UISwipeGestureRecognizerDirection.up:
            if (label.text == "Cima") {
                swipeCorreto()
            }
            else {
                swipeErrado()
            }
        case UISwipeGestureRecognizerDirection.down:
            if (label.text == "Baixo") {
                swipeCorreto()
            }
            else {
                swipeErrado()
            }
        default: break
        }
    }
    
    func swipeCorreto () {
        let last = userScore.value(forKey: "score") as! Int
        userScore.set((last+1), forKey: "score")
        label.text = direcoes[Int(arc4random_uniform(4))]
        label.setScale(1.0)
        let growAction = SKAction.scale(by: 1.2, duration: 0.2)
        label.run(growAction)
        
        timer.startWithDuration(1.5)
    }
    
    func swipeErrado() {
        label.setScale(0.8)
        label.text = "Você perdeu."
        
        if((userScore.value(forKey: "score") as! Int) > (userScore.value(forKey: "recorde") as! Int)) {
            userScore.set((userScore.value(forKey: "score") as! Int), forKey: "recorde")
        }
        
        userScore.set(0, forKey: "temp")
    }
    
    func canRestart() -> Bool {
        if label.text == "Você perdeu." {
            userScore.set(-1, forKey: "score")
            swipeCorreto()
            return true
        }
        
        return false
    }
    
    
}
