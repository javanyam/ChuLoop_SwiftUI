//
//  Article.swift
//  ChuLoop
//
//  Created by Anna Kim on 2023/04/29.
//

import SwiftUI

struct Article {
    
    var pId: Int64 = 0
    var pCategory: String = ""
    var pStore: String = ""
    var pAddress: String = ""
    var pContent: String = ""
    var pImage: Data? = UIImage(named: "star")?.pngData()!
    var pImageName: String = ""
    var pDate: String = ""

}
