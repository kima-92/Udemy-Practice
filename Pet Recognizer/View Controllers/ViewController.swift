//
//  ViewController.swift
//  Pet Recognizer
//
//  Created by macbook on 9/19/20.
//

import UIKit
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()

    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePicker()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        present(imagePicker, animated: true)
        // ^^ for some reazon I cant present it inside viewDidLoad
    }
    
    // MARK: - Methods
    
    func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        imageView.image = userPickedImage
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

