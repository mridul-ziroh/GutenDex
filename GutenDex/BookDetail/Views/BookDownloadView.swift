//
//  BookDownloadView.swift
//  GutenDex
//
//  Created by mridul-ziroh on 12/04/25.
//

import SwiftUI

struct BookDownloadView: View {
    var viewModel: BookDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
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
                        Task {
                            let isSuccess = await viewModel.downloadBook(link.link)
                            if isSuccess {
                                dismiss()
                            }
                        }
                    } label:  {
                        HStack {
                            Text("\(link.ext)")
                                .font(.body)
                                .lineLimit(1)
                            Image(systemName: "arrowshape.down.fill")
                                .font(.body)
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 5)
                        .background(.blue)
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
