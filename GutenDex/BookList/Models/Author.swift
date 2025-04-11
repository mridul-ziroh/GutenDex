//
//  Author.swift
//  GutenDex
//
//  Created by mridul-ziroh on 11/04/25.
//


struct Author: Codable {
    let name: String
    let birthYear, deathYear: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
        case deathYear = "death_year"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthYear = try container.decodeIfPresent(Int.self, forKey: .birthYear)
        self.deathYear = try container.decodeIfPresent(Int.self, forKey: .deathYear)
    }
    
    func calculatedPublishingDate() -> String {
        guard let birthYear = birthYear, let deathYear = deathYear else {
            return "NA"
        }
        
        return "(\(birthYear + 10) - \(deathYear))"
    }
    
    
    func cleanAuthorName() -> String {
        // Remove parentheses and their contents
        let noParentheses = name.replacingOccurrences(of: "\\s*\\(.*?\\)", with: "", options: .regularExpression)

        // Split by comma and trim
        let parts = noParentheses.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }

        if parts.count == 2 {
            return "\(parts[1]) \(parts[0])"
        } else {
            return name
        }
    }
    
    //test int remove
    init(name: String) {
        self.name = name
        birthYear = 123
        deathYear = 1233
        
    }
}
