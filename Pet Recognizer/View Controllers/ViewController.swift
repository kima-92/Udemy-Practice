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
    var didFinishLoading = false
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePicker()
        didFinishLoading = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tryDisplayCamera()
    }
    
    // MARK: - Actions
    
    @IBAction func cameraBarButtonTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true)
    }
    
    // MARK: - Methods
    
    func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        // Setup the ImageView to display what you recieve from the Picker
        imageView.image = pickedImage
        imagePicker.dismiss(animated: true, completion: nil)
        
        guard let ciImage = CIImage(image: pickedImage) else {
            NSLog("Failed to convert pickedImage into a CIImage")
            return
        }
        detect(image: ciImage)
    }
    
    func detect(image: CIImage) {
        
        // Try to create a model
        guard let model = try? VNCoreMLModel(for: PetRecognizer().model) else {
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
            if let firstResult = results.first {
                
                if firstResult.confidence > 0.70 {
                    self.navigationItem.title = firstResult.identifier
                } else {
                    self.navigationItem.title = "I can't tell what this is.."
                }
                
                //print(results) // if you want to the confidence property and all the other classifications
            }
        }
        let handler = VNImageRequestHandler(ciImage: image)
        
        // Try to perform the request with this handler
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    private func tryDisplayCamera() {
        if didFinishLoading == true {
            present(imagePicker, animated: true)
            didFinishLoading = false
        }
    }
}

