//
//  ViewController.swift
//  Flashcard App
//
//  Created by Liana Adaza on 2/20/21.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class firstViewController: UIViewController {
    
    // Variables
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // Actions
    @IBAction func didTapOnPrev(_ sender: Any) {
        // Decrease Current Index
        currentIndex = currentIndex - 1
        
        // Update Labels
        updateLabels()
        
        // Update Buttons
        updateNextPrevButtons()
        
        // Animations
        animatePrevCardOut()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        // Increase Current Index
        currentIndex = currentIndex + 1
        
        // Update Labels
        updateLabels()
        
        // Update Buttons
        updateNextPrevButtons()
        
        // Animations
        animateNextCardOut()
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard() {
        frontLabel.isHidden = true
        
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.frontLabel.isHidden = true
        })
    }
    
    // Array to Hold Flashcards
    var flashcards = [Flashcard]()
    
    // Current Flashcard Index
    var currentIndex = 0
    
    // Functions
    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        
        // Adding FLashcard in Flashcards Array
        flashcards.append(flashcard)
        
        // Update Current Index
        currentIndex = flashcards.count - 1
        
        // Update Buttons
        updateNextPrevButtons()
        
        // Update Labels
        updateLabels()
        
        // Save Cards
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButtons() {
        // Disable Next Button if at End
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        
        // Disable Prev Button if at Start
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels() {
        // Get Current Flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        // Update Labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    func saveAllFlashcardsToDisk() {
        // From Flashcard Array to Dictionary Array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in return ["question": card.question, "answer": card.answer]
        }
        
        // Save Array on Disk
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
    }
    
    func readSavedFlashcards() {
        // Read Dictionary Array from Disk (If Any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            // Put all Cards in Flashcards Array
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    // Animations
    func animatePrevCardOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        }, completion: { finished in
            
            // Update Labels
            self.updateLabels()
            
            // Run Other Animation
            self.animatePrevCardIn()
        })
    }
    
    func animatePrevCardIn() {
        // Start on the Right Side
        card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        
        // Animate Card Going back to Original Position
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func animateNextCardOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: { finished in
            
            // Update Labels
            self.updateLabels()
            
            // Run Other Animation
            self.animateNextCardIn()
        })
    }
    
    func animateNextCardIn() {
        // Start on the Right Side
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        // Animate Card Going back to Original Position
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Read Saved Flashcards
        readSavedFlashcards()
        
        // Adding Initial FLashcard if Needed
        if flashcards.count == 0 {
            updateFlashcard(question: "What is Animal Crossing?", answer: "The Best Game Ever!")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
        
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
