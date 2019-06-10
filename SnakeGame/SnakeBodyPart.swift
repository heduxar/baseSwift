//
//  SnakeBodyPart.swift
//  SnakeGame
//
//  Created by Юрий Султанов on 07.06.2019.
//  Copyright © 2019 Юрий Султанов. All rights reserved.
//

import UIKit
import SpriteKit

class SnakeBodyPart: SKShapeNode {
    
    let diameter = 10.0
    
    init(atPoint point: CGPoint) {
        super.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: diameter+2, height: diameter+2)).cgPath
        
        fillColor = UIColor.darkGray
        strokeColor = UIColor.green
        
        lineWidth = 3
        
        self.position = point
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diameter - 8), center: CGPoint(x: 5, y: 5))
        
        self.physicsBody?.isDynamic = true
        
        self.physicsBody?.categoryBitMask = CollisionCategories.Snake
        self.physicsBody?.contactTestBitMask = CollisionCategories.EdgeBody | CollisionCategories.Apple
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
