//
//  GameViewDataSource.swift
//  Genre-SwiftUI
//
//  Created by Ryan David Forsyth on 2020-06-28.
//  Copyright © 2020 Ryan David Forsyth. All rights reserved.
//

import SwiftUI
import Foundation

struct Answer {
    var correct: Bool
    var gender: Bool
}

class GameViewDataSource: ObservableObject {
    
    @Published var words = [Word]() {
        didSet {
            resetGameState()
        }
    }

    @Published var dragAmount = [CGSize]()
    @Published var degrees = [Double]()
    @Published var currentQuestionIndex = 0
    @Published var counter = 0
    var timer = Timer()
    
    var userScore = 0
    
    var numberOfQuestionsForGame = 0
    var masculineCorrect : Int = 0
    var masculineIncorrect : Int = 0
    var feminineCorrect: Int = 0
    var feminineIncorrect: Int = 0
    
    func updateCardDragOnChanged(atIndex wordIndex:Int, with translation:CGSize) {
        dragAmount[wordIndex] = translation
        
        if abs(translation.width) > 20 {
            degrees[wordIndex] = 5 * (translation.width > 0 ? 1 : -1)
        }
        else { degrees[wordIndex] = 0 }
    }
    
    func updateCardDragOnEnded(atIndex wordIndex:Int, with translation:CGSize) {
        if translation.width > 0 {
            
            if translation.width > 100 {
                dragAmount[wordIndex].width = 500
                degrees[wordIndex] = 15
                
                checkAnswer(pickedAnswer: true) ? print("Correct!") : print("Incorrect!")
                currentQuestionIndex -= 1
            }
            else { // Reset card position
                dragAmount[wordIndex] = .zero
                degrees[wordIndex] = 0
            }
        }
        else {
            if translation.width < -100 {
                dragAmount[wordIndex].width = -500
                degrees[wordIndex] = -15
                
                checkAnswer(pickedAnswer: false) ? print("Correct!") : print("Incorrect!")
                currentQuestionIndex -= 1
            }
            else { // Reset card position
                dragAmount[wordIndex] = .zero
                degrees[wordIndex] = 0
            }
        }
    }
    
    func restartGame(withNewWords toggle:Bool) {
        
        loadSettings()
        
        toggle ?
            loadNewGameWords() :
            resetGameState()
        
        startTimer()
    }
    
    func resetGameState() {
        dragAmount = Array(repeating: .zero, count: words.count)
        degrees = Array(repeating: 0.0, count: words.count)
        currentQuestionIndex = words.count - 1
        userScore = 0
        
        masculineCorrect = 0
        masculineIncorrect = 0
        feminineCorrect = 0
        feminineIncorrect = 0
    }
    
    func finishGame() {
        self.timer.invalidate()
    }
    
    func startTimer() {
        self.counter = 0
        self.timer = Timer()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        counter += 1
        //        if self.gameViewDelegate?.timerLabel != nil {
        //            self.gameViewDelegate?.timerLabel.text = String(format:"%.0f",counter)
        //        }
    }

    //MARK:- Loading
    
    func loadSettings() {
        numberOfQuestionsForGame = 10 // options.integer(forKey: kWordCount)
//        showHints = options.bool(forKey: kHints)
//        showTimer = options.bool(forKey: kTimer)
//        showProgressBar = options.bool(forKey: kProgress)
    }
    
    func loadNewGameWords() {
        words = WordManager.sharedInstance.getRandomWordsFor(count: numberOfQuestionsForGame)
    }
    
    //MARK:- Game State
    
    func addAnswerToEngine(_ answer:Answer) {
        answer.gender ? (answer.correct ? (self.masculineCorrect+=1) : (self.masculineIncorrect+=1)) : (answer.correct ? (self.feminineCorrect+=1) : (self.feminineIncorrect+=1))
    }
    
    func saveGameAndUpdateStats() {
        
        let incorrectCount: Int = (numberOfQuestionsForGame - userScore)
        let newTotalIncorrectCount: Int = options.integer(forKey: kIncorrectCount) + incorrectCount
        let newTotalCorrectCount: Int = options.integer(forKey: kCorrectCount) + userScore
        
        let newIncorrectMasculineCount: Int = options.integer(forKey: kMascIncorrectCount) + masculineIncorrect
        let newCorrectMasculineCount: Int = options.integer(forKey: kMascCorrectCount) + masculineCorrect
        let newIncorrectFeminineCount: Int = options.integer(forKey: kFemIncorrectCount) + feminineIncorrect
        let newCorrectFeminineCount: Int = options.integer(forKey: kFemCorrectCount) + feminineCorrect
        
        options.set(newTotalIncorrectCount, forKey: kIncorrectCount)
        options.set(newTotalCorrectCount, forKey: kCorrectCount)
        options.set(newIncorrectMasculineCount, forKey: kMascIncorrectCount)
        options.set(newCorrectMasculineCount, forKey: kMascCorrectCount)
        options.set(newIncorrectFeminineCount, forKey: kFemIncorrectCount)
        options.set(newCorrectFeminineCount, forKey: kFemCorrectCount)
        
        SessionManager.sharedInstance.registerNewSessionWith(withScore: Int32(userScore), outOf: Int32(numberOfQuestionsForGame))
    }
    
    func incrementUserScore() {
        userScore += 1
    }
    
    //MARK:- Current word properties
    
    func getCurrentWord() -> Word {
        return words[currentQuestionIndex]
    }
    
    func getCurrentWordString() -> String {
        return words[currentQuestionIndex].word!
    }
    
    func getCurrentWordGender() -> Bool {
        return words[currentQuestionIndex].gender
    }
    
    func getCurrentWordHint() -> String? {
        return words[currentQuestionIndex].hint
    }
    
    //MARK:- Check Answer
    func checkAnswer(pickedAnswer: Bool) -> Bool {
        
        let currentWord = words[currentQuestionIndex]
        let correctAnswer = currentWord.gender
        let correctResult = pickedAnswer == correctAnswer
        let answer = Answer(correct: correctResult, gender: pickedAnswer)
        
        addAnswerToEngine(answer)
        
        if correctResult {
            incrementUserScore()
            incrementCountFor(word: currentWord, correct: true)
            if (options.bool(forKey: kHaptics)) {
                if #available(iOS 13.0, *) { Haptics.impact(forStyle: .soft) }
                else { Haptics.impact(forStyle: .light) }
            }
            
            return true
        }
        else{
            incrementCountFor(word: currentWord, correct: false)
            if options.bool(forKey: kHaptics) {
                options.bool(forKey: kSuddenDeath) ? Haptics.impact(forStyle: .heavy) :  Haptics.notification(forType: .warning)
            }
            return false
        }
    }
    
    func incrementCountFor(word: Word, correct: Bool) {
        
        let wordToIncrement = WordManager.sharedInstance.getWordFor(string: word.word!)!
        
        if (correct) {
            wordToIncrement.correctCount += 1
        }
        else {
            wordToIncrement.incorrectCount += 1
        }
        
        WordManager.sharedInstance.saveChangesToCoreData()
    }
}
