//
//  GameScene.swift
//  supersecrettechnologies Shared
//
//  Created by Jacob Pålsson on 2018-01-25.
//  Copyright © 2018 Jacob Pålsson. All rights reserved.
//

import SpriteKit
#if os(iOS)
import CoreMotion
#endif

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    fileprivate var label : SKLabelNode?
    fileprivate var spinnyNode : SKShapeNode?
    fileprivate var ball: SKSpriteNode?
    let cam = SKCameraNode()
    
    #if os(iOS)
    let motionManager = CMMotionManager()
    #endif

    func didBegin(_ contact: SKPhysicsContact) {
        //print(contact.bodyB.collisionBitMask)
    }
    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .fill
        
        return scene
    }
    
    func setUpScene() {
        self.camera = cam

        let backgroundSound = SKAudioNode(fileNamed: "bgmusic.wav")
        self.addChild(backgroundSound)
        physicsWorld.contactDelegate = self
        #if os(iOS)
        motionManager.startAccelerometerUpdates()
        #endif

        self.ball = (self.childNode(withName: "//ball") as? SKSpriteNode)!
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
    }
    
    #if os(watchOS)
    override func sceneDidLoad() {
        self.setUpScene()
    }
    #else
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    #endif

    
    override func update(_ currentTime: TimeInterval) {
        //cam.position = (ball?.position)!
        //let diff = CGPoint(x: (ball?.position.x)! - cam.position.x, y: (ball?.position.y)! - cam.position.y)
        //cam.position = CGPoint(x: cam.position.x + diff.x/10, y: cam.position.y + diff.y/10)
        
        #if os(iOS)
        if let data = motionManager.accelerometerData {
            // 3
            if fabs(data.acceleration.y) > 0.2 {
                print(motionManager.deviceMotion!.attitude)
                // 4 How do you move the ship?
                ball?.physicsBody!.applyForce(CGVector(dx: -90 * CGFloat(data.acceleration.y), dy: 0))
            }
        }
        #endif
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
   
}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {

    override func mouseDown(with event: NSEvent) {

    }
    
    override func mouseDragged(with event: NSEvent) {

    }
    
    override func mouseUp(with event: NSEvent) {

    }

}
#endif

