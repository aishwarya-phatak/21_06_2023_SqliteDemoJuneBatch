//
//  ViewController.swift
//  21_06_2023_SqliteDemoJuneBatch
//
//  Created by Vishal Jagtap on 30/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var personTableView: UITableView!
    
    var persons : [Person] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        registerCellWithTableView()
        
//        var dbHelper = DBHelper()  //object of DBHelper cannot be created because we have made it singleton
        
        print("The record insertion")
        
        DBHelper.shared.insertPersonRecord(id: 10, name: "Tanaji", age: 28)
        DBHelper.shared.insertPersonRecord(id: 11, name: "Pratahmesh", age: 25)
        DBHelper.shared.insertPersonRecord(id: 12, name: "Sahil", age: 25)
        DBHelper.shared.insertPersonRecord(id: 13, name: "Vaishnavi", age: 25)
        DBHelper.shared.insertPersonRecord(id: 14, name: "Vaibhav", age: 24)
        
        
        print("_____________________")
        print("The record retrive method is called before deletion")
        persons = DBHelper.shared.retrivePersonRecords()
        for eachPerson in persons{
            print("\(eachPerson.id) -- \(eachPerson.name)")
        }
        
        print("_____________________")
        DBHelper.shared.deletePersonRecordById(id: 11)
        
       
        print("The records after deleting record with id 11")
        persons = DBHelper.shared.retrivePersonRecords()
        for person in persons{
            print("\(person.id) -- \(person.name) -- \(person.age)")
        }
    }
    
    func initialize(){
        personTableView.dataSource = self
        personTableView.delegate = self
    }
    
    func registerCellWithTableView(){
        let uiNib = UINib(nibName: "PersonTableViewCell", bundle: nil)
        self.personTableView.register(uiNib, forCellReuseIdentifier: "PersonTableViewCell")
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let personTableViewCell = self.personTableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as! PersonTableViewCell
        
        personTableViewCell.personIdLabel.text = String(persons[indexPath.row].id)
        personTableViewCell.personAgeLabel.text = String(persons[indexPath.row].age)
        personTableViewCell.personNameLabel.text = persons[indexPath.row].name
        
        return personTableViewCell
    }
}

 
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
    }
}
