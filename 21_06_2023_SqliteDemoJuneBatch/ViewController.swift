//
//  ViewController.swift
//  21_06_2023_SqliteDemoJuneBatch
//
//  Created by Vishal Jagtap on 30/08/23.
//

import UIKit

class ViewController: UIViewController {
    var persons : [Person] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var dbHelper = DBHelper()
        print("The record insertion")
        
        dbHelper.insertPersonRecord(id: 10, name: "Tanaji", age: 28)
        dbHelper.insertPersonRecord(id: 11, name: "Pratahmesh", age: 25)
        dbHelper.insertPersonRecord(id: 12, name: "Sahil", age: 25)
        
        print("The record retrive method is called")
        persons = dbHelper.retrivePersonRecords()
        for eachPerson in persons{
            print("\(eachPerson.id) -- \(eachPerson.name)")
        }
    }


}

