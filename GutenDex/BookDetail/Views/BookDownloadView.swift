//
//  BookDownloadView.swift
//  GutenDex
//
//  Created by mridul-ziroh on 12/04/25.
//

import SwiftUI

struct BookDownloadView: View {
    var viewModel: BookDetailViewModel
     @State private var downloadedLinks: Set<String> = []
    
    var body: some View {
        List {
            Text("Download")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)
            
            ForEach(viewModel.downloadLinks, id: \.link){ link in
                HStack {
                    Text("\(viewModel.book.firstTitle).\(link.ext.lowercased())")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Spacer()
                    Button {
                        guard !downloadedLinks.contains(link.link) else{
                            return
                        }
                        Task {
                            let isSuccess = await viewModel.downloadBook(link.link)
                            if isSuccess {
                                downloadedLinks.insert(link.link)
                            }
                        }
                    } label:  {
                        HStack {
                            Text("\(link.ext)")
                                .font(.body)
                                .lineLimit(1)
                                .foregroundStyle(.white)
                            Image(systemName: downloadedLinks.contains(link.link) ?
                                  "checkmark" : "arrowshape.down.fill")
                                .font(.body)
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 5)
                        .background(downloadedLinks.contains(link.link) ? .green : .blue)
                        .clipShape(Capsule())
                    }
                }
                .padding(.vertical, 4)
                
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    BookDownloadView(viewModel: BookDetailViewModel(book: Book())
    )
}
