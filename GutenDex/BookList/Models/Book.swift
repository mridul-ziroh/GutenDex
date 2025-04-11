//
//  Book.swift
//  GutenDex
//
//  Created by mridul-ziroh on 11/04/25.
//

import Foundation

struct Book: Codable, Identifiable {
    let id: Int
    let authors: [Author]
    let title: String
    let imageURL: String
    
    enum BookCodingKeys: String, CodingKey {
        case id, title, authors, formats
    }
    
    enum FormatKeys: String, CodingKey {
        case imageURL = "image/jpeg"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: BookCodingKeys.self)
        let formatContainer = try container.nestedContainer(keyedBy: FormatKeys.self, forKey: .formats)
        id = try container.decode(Int.self, forKey: .id)
        authors = try container.decode([Author].self, forKey: .authors)
        title = try container.decode(String.self, forKey: .title)
        
        imageURL = try formatContainer.decode(String.self, forKey: .imageURL)
    }
    
    var firstTitle : String {
        let fullTitle = title
        return fullTitle.components(separatedBy: CharacterSet(charactersIn: ";:")).first ?? fullTitle
    }
    
    var publishedDateRange: String {
        return authors.map{$0.calculatedPublishingDate() }.joined(separator: ", ")
    }
    
    var authorName: String {
        return authors.map{$0.cleanAuthorName() }.joined(separator: ", ")
    }
    
    //test init remove
    init() {
        id = 123
        authors = [Author(name: "TestAuthor"),Author(name: "TestAuthor"),Author(name: "TestAuthor"), ]
        title = "TestBook"
        imageURL = "https://www.gutenberg.org/cache/epub/2701/pg2701.cover.medium.jpg"
    }
}
