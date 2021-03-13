//
//  ViewController.swift
//  Flashcard App
//
//  Created by Liana Adaza on 2/20/21.
//

import UIKit

class firstViewController: UIViewController {
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    func updateFlashcard(question: String, answer: String) {
        frontLabel.text = question
        backLabel.text = answer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Styling Card
        card.layer.cornerRadius = 20.0
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Destination of Segue
        let navigationController = segue.destination as! UINavigationController
        
        // navigationController Only Contains creationViewController
        let creationController = navigationController.topViewController as! creationViewController
        
        // Set flashcardsController property to self
        creationController.flashcardsController = self
    }
    
}

