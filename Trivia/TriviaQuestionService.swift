//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Avery Wood on 2/25/26.
//

import Foundation

struct TriviaAPIResponse: Decodable {
    let results: [TriviaAPIQuestion]
}

struct TriviaAPIQuestion: Decodable {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}

class TriviaQuestionService {
    
    func fetchQuestions(completion: @escaping ([TriviaViewController.Question]?) -> Void) {
        
        let questionCount = Int.random(in: 5...10)
        let urlString = "https://opentdb.com/api.php?amount=\(questionCount)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode(TriviaAPIResponse.self, from: data)
                    
                    let convertedQuestions = decoded.results.map { apiQuestion -> TriviaViewController.Question in
                        
                        var answers = apiQuestion.incorrect_answers.map { $0.htmlDecoded }
                        let correct = apiQuestion.correct_answer.htmlDecoded
                        answers.append(correct)
                        answers.shuffle()
                        
                        let correctIndex = answers.firstIndex(of: apiQuestion.correct_answer) ?? 0
                        
                        return TriviaViewController.Question(
                            category: apiQuestion.category.htmlDecoded,
                            text: apiQuestion.question.htmlDecoded,
                            answers: answers,
                            correctAnswerIndex: correctIndex
                        )
                    }
                    
                    DispatchQueue.main.async {
                        completion(convertedQuestions)
                    }
                    
                } catch {
                    print("Decoding error:", error)
                    completion(nil)
                }
            }
            
        }.resume()
    }
}

extension String {
    var htmlDecoded: String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        return (try? NSAttributedString(data: data, options: options, documentAttributes: nil))?.string ?? self
    }
}
