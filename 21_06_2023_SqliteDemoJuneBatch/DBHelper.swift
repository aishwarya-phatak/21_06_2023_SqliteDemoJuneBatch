//
//  DBHelper.swift
//  21_06_2023_SqliteDemoJuneBatch
//
//  Created by Vishal Jagtap on 30/08/23.
//

import Foundation
import SQLite3

class DBHelper{
    let dbPath : String = "iosJune.sqlite"
    var db : OpaquePointer?
    
    init(){
      db = openDatabase()
      createTable()
    }
    
    func openDatabase()->OpaquePointer?{
        let fileUrl = try!  FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false).appendingPathComponent(dbPath)
        
        var db : OpaquePointer? = nil
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK{
            print("Error while creating the database")
            return nil
        }else{
            print("db created \(fileUrl.path)")
            return db
        }
    }
    
    func createTable(){
        let createTableQueryString = "CREATE TABLE IF NOT EXISTS Person(id INTEGER PRIMARY KEY, name TEXT, age INTEGER);"
        var createTableStatement : OpaquePointer? = nil
        if sqlite3_prepare_v2(
            db,
            createTableQueryString,
            -1,
            &createTableStatement,
            nil) == SQLITE_OK{
            
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("Table created")
            } else {
                print("Table creation failed")
            }
        } else {
            print("Create table statement failed")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insertPersonRecord(id : Int, name : String, age : Int){
        let persons = retrivePersonRecords()
        for eachPerson in persons{
            if eachPerson.id == id{
                return
            }
        }
        
        let insertStatementQueryString = "INSERT INTO Person(id,name,age) VALUES (?,?,?);"
        
        var insertStatement : OpaquePointer? = nil
         if sqlite3_prepare_v2(
            db,
            insertStatementQueryString,
            -1,
            &insertStatement,
            nil) == SQLITE_OK{
             
           sqlite3_bind_int(insertStatement, 1, Int32(id))
           sqlite3_bind_text(
                insertStatement,
                2,
                (name as NSString).utf8String,
                -1,
                nil)
           sqlite3_bind_int(insertStatement, 3, Int32(age))
            
             if sqlite3_step(insertStatement) == SQLITE_DONE{
                 print("The record is inserted successfully")
             } else {
                 print("Record insertion failed")
             }
         } else {
             print("The insert statement preparation falied")
         }
        sqlite3_finalize(insertStatement)
    }
    
    func retrivePersonRecords()->[Person]{
        let retriveQueryString = "SELECT * FROM Person;"
        var retriveStatment :OpaquePointer? = nil
        var persons1 : [Person] = []
        if sqlite3_prepare_v2(
            db,
            retriveQueryString,
            -1,
            &retriveStatment,
            nil) == SQLITE_OK{
            
            while sqlite3_step(retriveStatment) == SQLITE_ROW{
              let id = sqlite3_column_int(retriveStatment, 0)
              let name = String(describing: String(cString: sqlite3_column_text(retriveStatment, 1)))
              let year = sqlite3_column_int(retriveStatment, 2)
                
                let personObject = Person(
                    name: name,
                    id: Int(id),
                    age: Int(year))
                persons1.append(personObject)
                
//                print("Got the result of query")
//                print("\(id) -- \(name)")
            }
        } else {
            print("Insert statement preparation failed")
        }
        sqlite3_finalize(retriveStatment)
        return persons1
    }
    
    func deletePersonRecordById(id : Int){
        let deleteStatementQueryString = "DELETE FROM Person where id = ?;"
        var deleteStatement : OpaquePointer? = nil
        if sqlite3_prepare_v2(
            db,
            deleteStatementQueryString,
            -1,
            &deleteStatement, nil) == SQLITE_OK{
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE{
                print("The id \(id) is deleted")
            } else{
                print("\(id) deleteion failed")
            }
        } else {
            print("The delete statement preparaton failed")
        }
        sqlite3_finalize(deleteStatement)
    }
}
