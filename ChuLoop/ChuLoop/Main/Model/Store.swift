//
//  Store.swift
//  ChuLoop
//
//  Created by Anna Kim on 2023/04/29.
//

import Foundation

class Store{
    
    var id: Int
    var name: String
    var address: String
    var image: Data?
    var contents: String?
    var category: String
    var date: String
    var imageName: String
    
    init(id: Int, name: String, address: String, image: Data? = nil, contents: String? = nil, category: String, date: String, imageName: String) {
        self.id = id
        self.name = name
        self.address = address
        self.image = image
        self.contents = contents
        self.category = category
        self.date = date
        self.imageName = imageName
    }
    
}
