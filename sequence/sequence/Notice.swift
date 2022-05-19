//
//  Notice.swift
//  sequence
//
//  Created by 윤소희 on 2022/05/16.
//

import Foundation



struct Writer : Codable {
    var _id: String?
    var name: String?
}

struct Notice : Codable {

    var _id: String?
    var title: String?
    var category1: String?
    var category2: String?
    var content: String?
    var writer: Writer?
    var files: Array<String>?
    var images: Array<String>?
    var createdAt: String?
    var updatedAt: String?
    var __v: Int?

}

struct APIResponse: Codable {
    let data: [Notice]
    var status: Int
    var message: String
    var success: String
    var count: Int
}




