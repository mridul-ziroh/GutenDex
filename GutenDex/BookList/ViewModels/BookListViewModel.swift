//
//  BookListViewModel.swift
//  GutenDex
//
//  Created by mridul-ziroh on 11/04/25.
//

import Foundation

class BookListViewModel: ObservableObject {
    private let networkService = NetworkService.Shared
    @Published var stateLoad: ViewLoadState = .empty
    @Published var bookList = [Book]()
    private var nextPageURL: String?
    
    
    @MainActor
    func fetchAllBooks() async {
        do {
            let result: BookListResult = try await networkService.fetchBooks()
            stateLoad = .data
            nextPageURL = result.next
            bookList = result.results
        } catch {
            stateLoad = .error
        }
    }
    
    func fetchNextPage() async {
        guard let nextPageURL = nextPageURL else {
            return
        }
        stateLoad = .loadingNext
        do {
            let result: BookListResult = try await networkService.fetchBooks(nextPageURL)
            stateLoad = .dataNext
            self.nextPageURL = result.next
            bookList += result.results
        } catch {
            stateLoad = .error
        }
    }
    
}
