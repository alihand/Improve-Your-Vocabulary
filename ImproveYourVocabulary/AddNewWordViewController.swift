//
//  AddNewWordViewController.swift
//  ImproveYourVocabulary
//
//  Created by Alihan Demir on 4.03.2019.
//  Copyright © 2019 Alihan Demir. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewWordViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var wordText : UITextField!
    @IBOutlet weak var meanText : UITextField!
    @IBOutlet weak var synonymText : UITextField!
    @IBOutlet weak var antonymText : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordText.delegate = self
        meanText.delegate = self
        synonymText.delegate = self
        antonymText.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func saveButton(_ sender: UIButton) {
        var word = wordText.text!
        var mean = meanText.text!
        var synonym = synonymText.text!
        var antonym = antonymText.text!
        
        if(word == String() || mean == String() || synonym == String() || antonym == String()){
            let alert = UIAlertController(title: "Hatalı İşlem", message: "Lütfen Kelime Giriniz!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            AddNewWordToDatabase(word: word,mean: mean,synonym: synonym,antonym: antonym)
            let alert = UIAlertController(title: "Başarılı İşlem", message: "Başarıyla Kaydedildi!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            word = ""
            mean = ""
            synonym = ""
            antonym = ""
        }
    }
    func AddNewWordToDatabase(word:String,mean:String,synonym:String,antonym:String){
        let newWord = Words()
        newWord.setValue(word, forKey: "word")
        newWord.setValue(mean, forKey: "mean")
        newWord.setValue(synonym, forKey: "synonym")
        newWord.setValue(antonym, forKey: "antonym")
        
        let realm = try! Realm()
        do{
            try! realm.write {
                realm.add(newWord)
                print("Added \(newWord.word)")
                self.wordText.text! = ""
                self.meanText.text! = ""
                self.synonymText.text! = ""
                self.antonymText.text! = ""
            }
        }
    }
}
