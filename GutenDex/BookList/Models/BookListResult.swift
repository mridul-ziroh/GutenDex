//
//  Models.swift
//  GutenDex
//
//  Created by mridul-ziroh on 11/04/25.
//

struct BookListResult: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Book]
}




    
    
