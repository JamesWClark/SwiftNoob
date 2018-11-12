//
//  GameScene.swift
//  StockBubblesGame
//
//  Created by J.W. Clark on 5/3/18.
//  Copyright © 2018 J.W. Clark. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var bspeedx: CGFloat = 15
    private var bspeedy: CGFloat = 15
    private var bounce : SKShapeNode?
    
    private var streaker: SKShapeNode?
    
    private var circle : SKShapeNode?
    
    // like Processing's setup
    override func didMove(to view: SKView) {
        let startx = (self.frame.maxX / 2 + self.frame.minX / 2) / 2 // center
        let starty = self.frame.minY / 2 // bottom ?
        
        circle = SKShapeNode.init(circleOfRadius: 40)
        circle?.position = CGPoint(x: startx, y: starty)
        circle?.fillColor = UIColor(colorLiteralRed: 0, green: 0, blue: 1, alpha: 1)
        circle?.strokeColor = UIColor(colorLiteralRed: 0, green: 0, blue: 1, alpha: 1)
        
        bounce = SKShapeNode.init(circleOfRadius: 20)
        bounce?.position = CGPoint(x: 0, y: 0)
        bounce?.fillColor = UIColor(colorLiteralRed: 1, green: 0, blue: 0, alpha: 1)
        bounce?.strokeColor = UIColor(colorLiteralRed: 1, green: 0, blue: 0, alpha: 1)
        
        streaker = SKShapeNode.init(circleOfRadius: 30)
        streaker?.position = CGPoint(x: 512, y: 512)
        streaker?.fillColor = UIColor(colorLiteralRed: 1, green: 1, blue: 0, alpha: 1)
        streaker?.strokeColor = UIColor(colorLiteralRed: 1, green: 1, blue: 0, alpha: 1)
        
        addChild(circle!)
        addChild(bounce!)
        addChild(streaker!)
    }
    
    // like Processing's draw
    override func update(_ currentTime: TimeInterval) {
        var by = (bounce?.position.x)!
        var bx = (bounce?.position.y)!
        if bx > self.self.frame.maxX || bx < 0 {
            bspeedx *= -1
        }
        if by < 0 || by > self.frame.maxY {
            bspeedy *= -1
        }
        bounce?.position.x += bspeedx
        bounce?.position.y += bspeedy
        
        if (streaker?.position.x)! > self.frame.maxX {
            streaker?.position.x = 0
        }
        streaker?.position.x += 7
        
    }
    
    // everything else is like Processing's keyboard and mouse events
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
}
