//
//  ViewController.swift
//  vibeRadio
//
//  Created by Jon Alaniz on 8/3/20.
//  Copyright © 2020 Jon Alaniz. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {
    
    var skView: SKView!
    
    override func viewWillAppear() {
        self.view.window?.aspectRatio = NSSize(width: 16, height: 10)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameScene()
    }
    
    func setupGameScene() {
        let scene = GameScene(size: CGSize(width: 1920, height: 1200))
        scene.scaleMode = .aspectFill
        scene.anchorPoint = CGPoint(x: 0, y: 0)
        
        skView = self.view as? SKView
        skView.presentScene(scene)
    }
}
