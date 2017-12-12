//
//  GameViewController.swift
//  Galaxy
//
//  Created by Ibram Uppal on 11/14/15.
//  Copyright (c) 2015 Ibram Uppal. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import ARKit

class GameViewController: UIViewController, ARSCNViewDelegate {

    var scene = GalaxyScene(create: true)
    var sceneView = ARSCNView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView = ARSCNView(frame: self.view.frame)
        self.view.addSubview(self.sceneView)
        
//        scene.rootNode.position = SCNVector3(0, 0.1, -5000)
        //scene.rootNode.scale = SCNVector3(0.001, 0.001, 0.001)
        
        sceneView.scene = scene
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
