//
//  DBStore.swift
//  ChuLoop
//
//  Created by Anna Kim on 2023/04/29.
//

import Foundation
import SwiftUI
import SQLite

protocol StoreModelProtocol {
    func itemdownloaded(items: [Store])
}

class DBStore {

    // sqlite instance
    private var db: Connection!
    
    // table instance
    private var store: SQLite.Table!
    
    // columns instances of table
//    private var id: Expression<Int64>!
//    private var name: Expression<String>!
//    private var email: Expression<String>!
//    private var age: Expression<Int64>!
    
    private let pId = Expression<Int64>("pId")
    private let pStore = Expression<String>("pStore")
    private let pAddress = Expression<String>("pAddress")
    private let pImage = Expression<Data>("pImage")
    private let pImageName = Expression<String>("pImageName")
    private let pCategory = Expression<String>("pCategory")
    private let pContent = Expression<String>("pContent")
    private let pDate = Expression<Date>("pDate")

    


    
    // constructor of this class
    init () {
        
        // exception handling
        do {
            
            // path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            // creating database connection
            db = try Connection("\(path)/my_users_product.sqlite3")
            
            print("\(path)")
            
            // creating table object
            store = Table("store")
            
            // create instances of each column
//            id = Expression<Int64>("id")
//            name = Expression<String>("name")
//            email = Expression<String>("email")
//            age = Expression<Int64>("age")
            
            
            // check if the user's table is already created
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
                
                // if not, then create the table
                try db.run(store.create { table in
                    table.column(pId, primaryKey: .autoincrement)
                    table.column(pStore)
                    table.column(pAddress)
                    table.column(pImage)
                    table.column(pImageName)
                    table.column(pCategory)
                    table.column(pContent)
                    table.column(pDate)
                })

                // set the value to true, so it will not attempt to create the table again
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
            
        } catch {
            // show error message if any
            print(error.localizedDescription)
        }
    }
    
    public func addWish(nameValue: String, addressValue: String, imageValue: UIImage, imageNameValue: String, contentValue: String, categoryValue: String) {
        let date = Date()
        let imageData = imageValue.pngData()!
        
        do {
            try db.run(
                store.insert(pStore <- nameValue, pAddress <- addressValue, pImage <- imageData,
                             pImageName <- imageNameValue, pContent <- contentValue, pCategory <- categoryValue, pDate <- date)

            )
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // return array of user models
    public func getWish() -> [Article] {
        
        // create empty array
        var storeModels: [Article] = []

        // get all users in descending order
        store = store.order(pId.desc)

        // exception handling
        do {

            // loop through all users
            for storeOne in try db.prepare(store) {

                // create new model in each loop iteration
                var storeModel: Article = Article()
                
                // set values in model from database
                storeModel.pId = storeOne[pId]
                storeModel.pStore = storeOne[pStore]
                storeModel.pAddress = storeOne[pAddress]
                storeModel.pImage = storeOne[pImage]
                storeModel.pImageName = storeOne[pImageName]
                storeModel.pContent = storeOne[pContent]
                storeModel.pCategory = storeOne[pCategory]
//                wishModel.w = wishOne[wImageName]
                
                
                // append in new array
                storeModels.append(storeModel)
            }
        } catch {
            print(error.localizedDescription)
        }

        // return array
        return storeModels
    }
    
}
