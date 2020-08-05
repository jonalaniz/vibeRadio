//
//  GameScene.swift
//  vibeRadio
//
//  Created by Jon Alaniz on 8/3/20.
//  Copyright © 2020 Jon Alaniz. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, FRadioPlayerDelegate {
    var moving: SKNode!
    var spaceshipTimer: Timer?
    
    var titleLabel = SKLabelNode(fontNamed: "Jorolks")
    var artistLabel = SKLabelNode(fontNamed: "Minecraft")
    var songLabel = SKLabelNode(fontNamed: "Minecraft")
    
    let player = FRadioPlayer.shared
    
    var track: Track? {
        didSet {
            artistLabel.text = track?.artist
            songLabel.text = track?.name
        }
    }
    
    override func didMove(to view: SKView) {
        setupBackground()
        setupTitleLabel()
        
        player.delegate = self
        player.radioURL = URL(string: "http://radio.jonalaniz.com/live")
        player.play()
        
        spaceshipTimer = Timer.scheduledTimer(timeInterval: 260, target: self, selector: #selector(spawnSpaceship), userInfo: nil, repeats: true)
        //spawnSpaceship()
    }
    
    @objc func spawnSpaceship() {
        let shipSprite = SKSpriteNode(imageNamed: "ship")
        shipSprite.texture?.filteringMode = .nearest
        shipSprite.setScale(4.0)
        shipSprite.position = CGPoint(x: frame.minX - shipSprite.size.width, y: frame.midY + 240)
        
        let move = SKAction.move(by: CGVector(dx: 2100, dy: 0), duration: 18)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([move, remove])
        
        addChild(shipSprite)
        
        shipSprite.run(sequence)
    }
    
    func setupTitleLabel() {
        titleLabel.text = "Saint Vibe Radio"
        titleLabel.alpha = 0.8
        titleLabel.horizontalAlignmentMode = .left
        titleLabel.fontSize = 50
        titleLabel.position = CGPoint(x: frame.minX + 100, y: frame.maxY - 190)
        
        artistLabel.text = "Loading..."
        artistLabel.alpha = 0.8
        artistLabel.horizontalAlignmentMode = .left
        artistLabel.fontSize = 60
        artistLabel.position = CGPoint(x: frame.minX + 100, y: 260)
        
        songLabel.text = "PLEASE WAIT"
        songLabel.alpha = 0.8
        songLabel.horizontalAlignmentMode = .left
        songLabel.fontSize = 110
        songLabel.position = CGPoint(x: frame.minX + 100, y: 140)
        
        addChild(titleLabel)
        addChild(artistLabel)
        addChild(songLabel)
    }
    
    func setupBackground() {
        backgroundColor = NSColor(displayP3Red: 77/255, green: 77/255, blue: 124/255, alpha: 1)
        moving = SKNode()
        self.addChild(moving)
        
        // Land
        let landTexture = SKTexture(imageNamed: "buildings")
        landTexture.filteringMode = .nearest
        
        let moveLandSprite = SKAction.moveBy(x: -landTexture.size().width * 4.0, y: 0, duration: TimeInterval(0.05 * landTexture.size().width * 4.0))
        let resetLandSprite = SKAction.moveBy(x: landTexture.size().width * 4.0, y: 0, duration: 0.0)
        let moveGroundSpritesForever = SKAction.repeatForever((SKAction.sequence([moveLandSprite, resetLandSprite])))
        
        for i in 0 ..< 2 + Int(self.frame.size.width / ( landTexture.size().width * 2 )) {
            let i = CGFloat(i)
            let sprite = SKSpriteNode(texture: landTexture)
            sprite.setScale(4.0)
            sprite.position = CGPoint(x: i * sprite.size.width, y: sprite.size.height / 2.0)
            sprite.run(moveGroundSpritesForever)
            moving.addChild(sprite)
        }
        
        // Sky
        let skyTexture = SKTexture(imageNamed: "background")
        skyTexture.filteringMode = .nearest
        
        let moveSkySprite = SKAction.moveBy(x: -skyTexture.size().width * 4.0, y: 0, duration: TimeInterval(0.5 * skyTexture.size().width * 4.0))
        let resetSkySprite = SKAction.moveBy(x: skyTexture.size().width * 4.0, y: 0, duration: 0.0)
        let moveSkySpritesForever = SKAction.repeatForever(SKAction.sequence([moveSkySprite,resetSkySprite]))
        
        for i in 0 ..< 2 + Int(self.frame.size.width / ( skyTexture.size().width * 2 )) {
            let i = CGFloat(i)
            let sprite = SKSpriteNode(texture: skyTexture)
            sprite.setScale(4.0)
            sprite.zPosition = -1
            sprite.position = CGPoint(x: i * sprite.size.width, y: frame.maxY - skyTexture.size().height * 2)
            sprite.run(moveSkySpritesForever)
            moving.addChild(sprite)
        }
        
        // Moon
        let moonSprite = SKSpriteNode(imageNamed: "moon")
        moonSprite.texture?.filteringMode = .nearest
        moonSprite.setScale(4.0)
        moonSprite.position = CGPoint(x: 1600, y: 920)
        addChild(moonSprite)
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

extension GameScene {
    func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
        print(state.description)
    }
    
    func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
        // wee wee
    }
    
    func radioPlayer(_ player: FRadioPlayer, metadataDidChange artistName: String?, trackName: String?) {
        track = Track(artist: artistName, name: trackName)
    }
    
    
}
