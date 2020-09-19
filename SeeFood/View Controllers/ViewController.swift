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
        
        // Create a Core Image Image which is what CoreML uses
        guard let ciImage = CIImage(image: userPickedImage) else {
            fatalError("Couldn't convert image to a CIImage")
        }
        detect(image: ciImage)
    }
    
    func detect(image: CIImage) {
        
        // Try to create a model
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Failed loading CoreML Model")
        }
        
        // Create a Request
        // which will return an array of classifications of the given image
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            // Request an array of classifications of
            // An array of ClassificationObservations AFTER the image has been processed
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            print(results)
        }
        let handler = VNImageRequestHandler(ciImage: image)
        
        // Try to perform the request with this handler
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
}

