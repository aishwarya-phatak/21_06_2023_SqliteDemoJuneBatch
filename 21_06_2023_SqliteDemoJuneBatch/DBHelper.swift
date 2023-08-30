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
}
