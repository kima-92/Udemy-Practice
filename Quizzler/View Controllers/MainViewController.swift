//
//  MainViewController.swift
//  Quizzler
//
//  Created by macbook on 9/17/20.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Action
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
    }
    
    // MARK: - Methods
    
    private func updateViews() {
        trueButton.layer.borderColor = UIColor(red: 76/255, green: 100/255, blue: 146/255, alpha: 1).cgColor
        falseButton.layer.borderColor = UIColor(red: 76/255, green: 100/255, blue: 146/255, alpha: 1).cgColor
        trueButton.layer.borderWidth = 5
        falseButton.layer.borderWidth = 5
        trueButton.layer.cornerRadius = 15
        falseButton.layer.cornerRadius = 15
    }
}
