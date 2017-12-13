//
//  TouchDetectionVC.swift
//  App
//
//  Created by Gareth on 13.12.17.
//  Copyright © 2017 Gareth. All rights reserved.
//


import UIKit
import SceneKit
import ARKit

class TouchDetectionVC: UIViewController, ARSCNViewDelegate {
    
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
        
        // width height length is in meters!
        let boxGeo = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
        let boxMat = SCNMaterial()
        boxMat.diffuse.contents = UIColor.red
        boxMat.name = "Colour"
        
        let box = SCNNode()
        box.geometry = boxGeo
        if let geo = box.geometry {
            geo.materials = [boxMat]
        }
        
        // this is 0.1m above my head and half a meter in front of me!
        box.position = SCNVector3(0, 0.1, -0.5)
        
        scene.rootNode.addChildNode(box)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        
        self.sceneView.addGestureRecognizer(tapGesture)
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    @objc func tapped(recognizer: UITapGestureRecognizer) {
        // what did you tap on
        let sceneView = recognizer.view as! SCNView
        let touchWhere = recognizer.location(in: sceneView)
        // hit test on the scene view fo rthe touch location
        let hitResults = sceneView.hitTest(touchWhere, options: nil)
        
        if !hitResults.isEmpty {
            let nodeTouched = hitResults[0].node
            if let geo = nodeTouched.geometry {
                if let mat = geo.material(named: "Colour") {
                    mat.diffuse.contents = UIColor.random()
                }
            }
        }
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

