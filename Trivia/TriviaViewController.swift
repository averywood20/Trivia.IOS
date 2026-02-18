//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Avery Wood on 2/17/26.
//

import UIKit

class TriviaViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
    }
    
    struct Question{
        let category: String
        let text: String
        let answers: [String]
        let correctAnswerIndex: Int
    }
    
    var questions: [Question] = [
        Question(category: "Entertainment: Movies", text: "What position does Harry Potter play on the Quidditch Team?", answers: ["Chaser", "Keeper", "Seeker", "Beater"], correctAnswerIndex: 2),
        Question(category: "Sports", text: "Who won the MLB world series in 2025?", answers: ["Dodgers", "Blue Jays", "Red Sox", "Yankees"], correctAnswerIndex: 0),
        Question(category: "Geography", text: "What country is the Taj Mahal Located in?", answers: ["Spain", "India", "Italy", "Eqypt"], correctAnswerIndex: 1)
    ]
    
    var currentQuestionIndex = 0
    var score = 0

    func showQuestion(){
        let currentQuestion = questions[currentQuestionIndex]
        
        questionLabel.text = "Question \(currentQuestionIndex + 1)/\(questions.count)"
        
        categoryLabel.text = currentQuestion.category
        
        questionTextLabel.text = currentQuestion.text
        
        answer1Button.setTitle(currentQuestion.answers[0], for: .normal)
        answer2Button.setTitle(currentQuestion.answers[1], for: .normal)
        answer3Button.setTitle(currentQuestion.answers[2], for: .normal)
        answer4Button.setTitle(currentQuestion.answers[3], for: .normal)
        
    }
    
    @IBAction func answerTapped( sender: UIButton){
        let currentQuestion = questions[currentQuestionIndex]
        
        if sender == answer1Button && currentQuestion.correctAnswerIndex == 0{
            score += 1
        }else if sender == answer2Button && currentQuestion.correctAnswerIndex == 1{
            score += 1
        }else if sender == answer3Button && currentQuestion.correctAnswerIndex == 2{
            score += 1
        }else if sender == answer4Button && currentQuestion.correctAnswerIndex == 3{
            score += 1
        }
        
        currentQuestionIndex += 1
        
        if currentQuestionIndex < questions.count {
            showQuestion()
        } else {
            showFinalScore()
        }
    }
    
    func showFinalScore() {
        questionLabel.text = "You got \(score) out of \(questions.count) correct!"
        categoryLabel.text = "Game Over"
        
        answer1Button.isHidden = true
        answer2Button.isHidden = true
        answer3Button.isHidden = true
        answer4Button.isHidden = true
    }
}


