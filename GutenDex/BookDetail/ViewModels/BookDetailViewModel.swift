//
//  BookDetailViewModel.swift
//  GutenDex
//
//  Created by mridul-ziroh on 11/04/25.
//
import Foundation

class BookDetailViewModel: ObservableObject {
    var networkService =  NetworkService.Shared
    var book: Book
    @Published var bookDetail: BookDetailModel?
    
    init(book: Book){
        self.book = book
    }
    
    
    @MainActor
    func fetchDetail(_ id: Int) async {
        do {
            let url = NetworkService.baseURL + "/\(id)/"
            bookDetail = try await networkService.fetchBooks(url)
        } catch {
            print(error)
        }
    }
    
    func downloadBook(_ link: String) async -> Bool {
        do {
            let cleanedFileName = link
                .components(separatedBy: "/").last? // get to the file name from the URL
                .replacingOccurrences(of: ".images", with: "")
                .replacingOccurrences(of: ".utf-8", with: "")
                .replacingOccurrences(of: "\(book.id)", with: book.firstTitle) ?? ""
            
            let path = try await networkService.downloadBook(link, cleanedFileName)
            print(path)
            
            return path.isEmpty ? false : true
        } catch {
            print(error)
        }
        return false
    }
    
    var downloadLinks: [(ext: String, link: String)] {
        var result: [(ext: String, link: String)] = []
        guard let bookDetail = bookDetail else {
            return result
        }
        
        for link in  bookDetail.formats.downloadLinks {
            let ext = link
                .components(separatedBy: "/").last? // get to the file name from the URL
                .replacingOccurrences(of: ".images", with: "")
                .replacingOccurrences(of: ".utf-8", with: "")
                .replacingOccurrences(of: "\(book.id)", with: "")
                .replacingOccurrences(of: ".", with: "")
                .replacingOccurrences(of: "-", with: "")
                .uppercased()
            ?? "KCC"
            result.append((ext: ext, link: link))
        }
        return result
    }
    
    
}
