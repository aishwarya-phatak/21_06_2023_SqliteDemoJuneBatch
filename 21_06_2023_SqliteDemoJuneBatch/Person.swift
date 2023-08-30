//
//  Person.swift
//  21_06_2023_SqliteDemoJuneBatch
//
//  Created by Vishal Jagtap on 30/08/23.
//

import Foundation
struct Person {
    var name : String
    var id : Int
    var age : Int
    
    init(name: String, id: Int, age: Int) {
        self.name = name
        self.id = id
        self.age = age
    }
}
