//
//  ShowAllWordsTableViewController.swift
//  ImproveYourVocabulary
//
//  Created by Alihan Demir on 6.03.2019.
//  Copyright © 2019 Alihan Demir. All rights reserved.
//

import UIKit
import RealmSwift

class ShowAllWordsTableViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var myTable: UITableView!
    var wordsArray : [Words] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        myTable.dataSource = self
        myTable.delegate = self
        myTable.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : WordTableViewCell = myTable.dequeueReusableCell(withIdentifier: "Cell") as! WordTableViewCell
        let getElemans = wordsArray[indexPath.row]
        cell.wordSet.text! = getElemans.word
        cell.meanSet.text! = getElemans.mean
        cell.synonymSet.text! = getElemans.synonym
        cell.antonymSet.text! = getElemans.antonym
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let word = wordsArray[indexPath.row]
        let realm = try! Realm()
        do{
            try! realm.write {
                realm.delete(word)
                wordsArray.remove(at: indexPath.row)
            }
            myTable.reloadData()
        }
    }
    func fetchData(){
        let realm = try! Realm()
        wordsArray = Array(realm.objects(Words.self))
        
        for i in wordsArray {
            print("word : \(i.word) mean : \(i.mean)  synonym : \(i.synonym) antonym : \(i.antonym)")
        }
    }
}
