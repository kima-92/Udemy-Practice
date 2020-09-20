//
//  ViewController.swift
//  ARDicee
//
//  Created by macbook on 9/19/20.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    // MARK: - DidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        //displayApplesPlane()
        //displayCube()
        //displayMoon()
        //displayDice()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Enable plane detection -> horizontally
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // When the app detects a horizontal plane, it will call this method
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // This method gives us an ARAnchor,
        // which is a real-world position and orientation that can be used to place objects in a AR scene.
        // - It contain coordinates
        // - There's a LOT of ARAnchor types, so in this case we need the ARPlaneSnchor one
        
        if anchor is ARPlaneAnchor {
            print("plane detected")
        } else {
            return
        }
    }
    
    // MARK: - Methods
    
    // Apple's free code
    func displayApplesPlane() {
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    func displayCube() {
        // Creating a simple red Cube
        
        // Cube dimentions
        let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
        
        // Material
        let material = SCNMaterial()
        
        material.diffuse.contents = UIColor.red
        cube.materials = [material]
        
        // Node
        let node = SCNNode()
        
        node.position = SCNVector3(x: 0, y: 0.1, z: -0.5)
        node.geometry = cube
        
        /*
         
         1.   The node by itself does nothing, but you can give it a point in space (position), and an object (geometry) to hold at that point in space
         
         2.   x -> Horizontal
         y -> Vertical   (in this case we put is slightly elevated using 0.1)
         z -> away (-) and towards (+) you   (in this case we put it slighly away from us
         
         */
        
        // Add it to the sceneView to display at runtime
        sceneView.scene.rootNode.addChildNode(node)
        
        // Adding lighting to look more 3D
        sceneView.autoenablesDefaultLighting = true
    }
    
    func displayMoon() {
        
        // Moon Dimentions
        let sphere = SCNSphere(radius: 0.2)
        
        // Moon material
        let material = SCNMaterial()
        
        material.diffuse.contents = UIImage(named: "art.scnassets/moon.jpg")
        sphere.materials = [material]
        
        // Node
        let node = SCNNode()
        
        node.position = SCNVector3(x: 0, y: 0.1, z: -0.5)
        node.geometry = sphere
        
        // Add it to the sceneView to display at runtime
        sceneView.scene.rootNode.addChildNode(node)
        // Give it some light
        sceneView.autoenablesDefaultLighting = true
    }
    
    func displayDice() {
        
        // Dice's Dimentions
        let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
        
        // If we can get the rootNode of the diceScene that has the ID "Dice"
        if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true) {
            
            // Add the position, and put this diceNode in the sceneView
            diceNode.position = SCNVector3(0, 0, -0.1)
            sceneView.scene.rootNode.addChildNode(diceNode)
        }
        // Add light
        sceneView.autoenablesDefaultLighting = true
    }
}
