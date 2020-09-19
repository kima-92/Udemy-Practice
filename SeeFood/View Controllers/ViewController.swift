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
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false  // Give true a try in your next app
    }
    
    // MARK: - Action
    @IBAction func cameraBarButtonTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Getting the image from the camera
        guard let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        imageView.image = userPickedImage
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

