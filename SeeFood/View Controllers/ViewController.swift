//
//  ViewController.swift
//  SeeFood
//
//  Created by macbook on 9/19/20.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Properties
    let imagePicker = UIImagePickerController()
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action
    @IBAction func cameraBarButtonTapped(_ sender: UIBarButtonItem) {
    }
}

