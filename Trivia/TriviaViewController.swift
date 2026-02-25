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
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetButton.isHidden = false
        triviaService.fetchQuestions { questions in
            if let questions = questions {
                self.questions = questions
                self.showQuestion()
            }
        }
    }
    
    struct Question{
        let category: String
        let text: String
        let answers: [String]
        let correctAnswerIndex: Int
    }
    
    var questions: [Question] = []
    let triviaService = TriviaQuestionService()
    var currentQuestionIndex = 0
    var score = 0

    func showQuestion(){
        let currentQuestion = questions[currentQuestionIndex]
        
        questionLabel.text = "Question \(currentQuestionIndex + 1)/\(questions.count)"
        
        categoryLabel.text = currentQuestion.category
        
        questionTextLabel.text = currentQuestion.text
        
        let answers = currentQuestion.answers

        answer1Button.setTitle(answers[0], for: .normal)
        answer2Button.setTitle(answers[1], for: .normal)

        if answers.count > 2 {
            answer3Button.setTitle(answers[2], for: .normal)
            answer4Button.setTitle(answers[3], for: .normal)
            answer3Button.isHidden = false
            answer4Button.isHidden = false
        } else {
            answer3Button.isHidden = true
            answer4Button.isHidden = true
        }
        
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
    
    @IBAction func resetTapped(_ sender: UIButton) {
        score = 0
        currentQuestionIndex = 0
        
        answer1Button.isHidden = false
        answer2Button.isHidden = false
        answer3Button.isHidden = false
        answer4Button.isHidden = false
        
        triviaService.fetchQuestions { questions in
            if let questions = questions {
                self.questions = questions
                self.showQuestion()
            }
        }
    }
    
    func showFinalScore() {
        questionLabel.text = "You got \(score) out of \(questions.count) correct!"
        categoryLabel.text = "Game Over"
        
        answer1Button.isHidden = true
        answer2Button.isHidden = true
        answer3Button.isHidden = true
        answer4Button.isHidden = true
        
        resetButton.isHidden = false
    }
}


