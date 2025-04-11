//
//  Untitled.swift
//  GutenDex
//
//  Created by mridul-ziroh on 11/04/25.
//
import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse(Int)
    case decodingError
}

protocol BookService {
    func fetchBooks<T: Decodable>(_ url: String) async throws -> T
}

class NetworkService: BookService {
    static let Shared = NetworkService()
    
    static let baseURL = "https://gutendex.com/books"
    
    func fetchBooks<T: Decodable>(_ urlString: String = baseURL) async throws -> T {
        guard !urlString.isEmpty, let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse  =  response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
            throw NetworkError.invalidResponse(httpResponse.statusCode)
        }
        
        do {
            let data = try JSONDecoder().decode(T.self,from: data)
            return data
        } catch {
            print(error)
            throw NetworkError.decodingError
        }
    }
    
    func downloadBook(_ urlString: String,_ orignalFileName: String) async throws -> String {
        guard !urlString.isEmpty, let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (tempPathURL, response) = try await URLSession.shared.download(from: url)
        
        if let httpResponse  =  response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
            throw NetworkError.invalidResponse(httpResponse.statusCode)
        }
        
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsURL.appendingPathComponent(orignalFileName)
        
        try? fileManager.removeItem(at: destinationURL)
        do {
            try fileManager.moveItem(at: tempPathURL, to: destinationURL)
        } catch {
            return ""
        }
        return destinationURL.path()
    }
}

