//
//  TextVC.swift
//  App
//
//  Created by Gareth on 13.12.17.
//  Copyright © 2017 Gareth. All rights reserved.
//


import UIKit
import SceneKit
import ARKit

class TextVC: UIViewController, ARSCNViewDelegate {
    
    var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dynamically inject scene view into here
        self.sceneView = ARSCNView(frame: self.view.frame)
        // add to the main view
        self.view.addSubview(self.sceneView)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // @HERE do some shizzle
        let textGeo = SCNText(string: "Gareth rocks", extrusionDepth: 1.0)
        textGeo.firstMaterial?.diffuse.contents = UIColor.black
        
        let textNode = SCNNode(geometry: textGeo)
        textNode.position = SCNVector3(0, 0.1, -0.5)
        textNode.scale = SCNVector3(0.02, 0.02, 0.02)
        
        scene.rootNode.addChildNode(textNode)
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
}
