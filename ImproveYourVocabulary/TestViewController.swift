//
//  TestViewController.swift
//  ImproveYourVocabulary
//
//  Created by Alihan Demir on 4.03.2019.
//  Copyright © 2019 Alihan Demir. All rights reserved.
//

import UIKit
import RealmSwift

class TestViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var imageView: UIImageView!
    var wordsArray : [Words] = []
    var randomWord = ""
    var randomMean = ""
    var randomSynonym = ""
    var randomAntonym = ""
    
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var answerText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerText.delegate = self
        
        getRandomWord()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func controlButton(_ sender: UIButton) {
        let question = answerText.text!
        
        
        if(controlAnswers(answer: question )){
            imageView.image = UIImage(named: "tick.png")
            answerText.text! = ""
            getRandomWord()
        }
        else{
            imageView.image = UIImage(named: "delete.png")
            answerText.text! = ""
        }
    }
    func getRandomWord(){
        let realm = try! Realm()
        wordsArray = Array(realm.objects(Words.self))
        
        let randomNumber = arc4random_uniform(4) + 1  // 0 between 3 random number == 1 - 4
        
         randomWord = wordsArray.randomElement()!.word
         randomMean = wordsArray.randomElement()!.mean
         randomSynonym = wordsArray.randomElement()!.synonym
         randomAntonym = wordsArray.randomElement()!.antonym
        
        if(randomNumber == 1){
            lblQuestion.text = "'" + String(randomWord) + "'" + " anlamı nedir?"
        }
        else if (randomNumber == 2){
            lblQuestion.text = "Anlamı " + "'" + String(randomMean) + "'" + " olan kelime nedir?"
        }
        else if (randomNumber == 3){
            lblQuestion.text = "Eş Anlamı " + "'" + String(randomSynonym) + "'" + " olan kelime nedir?"
        }
        else if (randomNumber == 4){
            lblQuestion.text = "Zıt Anlamı " + "'" + String(randomAntonym) + "'" + " olan kelime nedir?"
        }
    }
    func controlAnswers(answer : String) -> Bool{
        let resualt = false
        if(answer.contains(randomWord) ){
            return true
        }
        else if(answer.contains(randomMean)){
          return true
        }
        else if(answer.contains(randomSynonym)){
            return true
        }
        else if(answer.contains(randomAntonym)){
            return true
        }
        return resualt
    }
}
