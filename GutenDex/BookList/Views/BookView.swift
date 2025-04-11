//
//  BookView.swift
//  GutenDex
//
//  Created by mridul-ziroh on 11/04/25.
//

import SwiftUI

struct BookView: View {
    var book: Book
    var body: some View {
        HStack {
            thumbnail
            VStack(alignment: .leading, spacing: 10){
                Text(book.firstTitle)
                    .font(.headline)
                    .fontWeight(.medium)
                    .lineLimit(1)
                
                Text("\(book.publishedDateRange)")
                    .font(.callout)
                    .foregroundStyle(.black.opacity(0.7))
                    .lineLimit(1)
                
                Text("\(book.authorName)")
                    .font(.subheadline)
                    .foregroundStyle(.black.opacity(0.7))
                    .lineLimit(1)
                
            }
        }
    }
    
    @ViewBuilder
    var thumbnail : some View {
        if let cacheImage = ImageCache.shared.image(forKey: book.id) {
            cacheImage
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 90)
                .cornerRadius(4)
        } else {
            AsyncImage(url: URL(string: book.imageURL)){ image in
                let cacheImage = image
                cacheImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 90)
                    .cornerRadius(4)
                    .onAppear(){
                        ImageCache.shared.set(image,forKey: book.id)
                    }
            } placeholder: {
                ProgressView()
                    .frame(width: 60, height: 90)
                    .cornerRadius(4)
                    .background(.gray.opacity(0.4))
                
            }
            
        }
    }
}

#Preview {
    BookView(book: Book())
}
