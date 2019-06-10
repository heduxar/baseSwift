//
//  GameViewController.swift
//  SnakeGame
//
//  Created by Юрий Султанов on 07.06.2019.
//  Copyright © 2019 Юрий Султанов. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    func NewGame() {
        
        let gameScene = GameScene(size: view.bounds.size)
        
        let skView = view as! SKView
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        gameScene.scaleMode = .resizeFill
        skView.presentScene(gameScene)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NewGame()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

