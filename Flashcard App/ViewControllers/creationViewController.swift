//
//  creationViewController.swift
//  Flashcard App
//
//  Created by Liana Adaza on 3/6/21.
//

import UIKit

class creationViewController: UIViewController {

    var flashcardsController: firstViewController!

    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        // Get the text in the question text field
        let questionText = questionTextField.text
        
        // Get the text in the answer text field
        let answerText = answerTextField.text
        
        // Call the function to update the flashcard
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
        
        // Dismiss
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
