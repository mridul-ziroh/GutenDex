//
//  BookListView.swift
//  GutenDex
//
//  Created by mridul-ziroh on 11/04/25.
//

import SwiftUI

struct BookListView: View {
    @StateObject var viewModel = BookListViewModel()
    var body: some View {
        NavigationView {
            switch viewModel.stateLoad {
            case .error:
                Text("BookFetchError")
            case .empty:
                BookListSkeleton()
                    .task{
                        await viewModel.fetchAllBooks()
                    }
            default:
                Content
            }
        }
        .refreshable {
            Task {
                await viewModel.fetchAllBooks()
                ImageCache.shared.clear()
            }
        }
    }
    
    var Content: some View {
        List {
            listItems
            switch viewModel.stateLoad {
            case .loadingNext:
                LoadingProgressView()
            case .data, .dataNext:
                LoadingProgressView()
                    .onAppear(){
                        Task {
                            await viewModel.fetchNextPage()
                        }
                    }
            default:
                EmptyView()
                
            }
        }
        .navigationTitle("Books")
        .listStyle(.plain)
    }
    
    var listItems: some View{
        ForEach(viewModel.bookList){book in
            NavigationLink {
                BookDetailView(viewModel: BookDetailViewModel(book: book))
            } label: {
                BookView(book: book)
            }
        }
    }
}

#Preview {
    BookListView()
}
