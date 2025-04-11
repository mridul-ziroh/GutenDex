//
//  BookDetailView.swift
//  GutenDex
//
//  Created by mridul-ziroh on 11/04/25.
//

import SwiftUI

struct BookDetailView: View {
    @StateObject var viewModel: BookDetailViewModel
    @State var downlaodSheet = false
    var body: some View {
        List {
            BookImage
            AlternateTitle
            AlternateName
            Description
            PublishYear
            Downloads
            
        }
        .listStyle(.plain)
        .toolbar {
            Button{
                downlaodSheet.toggle()
            } label: {
                Label("Download", systemImage: "square.and.arrow.down")
            }
        }
        .sheet(isPresented: $downlaodSheet) {
            BookDownloadView(viewModel: viewModel)
                .presentationDetents([.fraction(0.4)])
        }
        .task {
            await viewModel.fetchDetail(viewModel.book.id)
        }
        
    }
    
    var Downloads: some View {
        HStack {
            Text("Downloads: ")
                .font(.subheadline)
                .fontWeight(.bold)
            Spacer()
            Button {
                downlaodSheet.toggle()
            } label: {
                HStack {
                    Text("\(viewModel.bookDetail?.downloadCount ?? 0)")
                        .font(.body)
                        .lineLimit(1)
                    Image(systemName: "arrowshape.down.fill")
                        .font(.body)
                        .foregroundStyle(.gray)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 5)
                .background(.gray.opacity(0.3))
                .clipShape(Capsule())
            }
            
        }
    }
    
    var Description: some View {
        VStack(alignment: .leading,spacing: 10){
            Text("Description: ")
                .font(.subheadline)
                .fontWeight(.bold)
            Text(viewModel.bookDetail?.summaries.joined(separator: "\n") ?? "")
                .multilineTextAlignment(.leading)
            
                .font(.body)
        }
    }
    
    var PublishYear: some View {
        HStack {
            Text("Published: ")
                .font(.subheadline)
                .fontWeight(.bold)
            Spacer()
            Text(viewModel.book.publishedDateRange)
                .font(.body)
                .lineLimit(1)
            
        }
    }
    
    var AlternateName : some View {
        Text(viewModel.book.authorName)
            .font(.subheadline)
            .fontWeight(.bold)
    }
    
    var AlternateTitle : some View {
        Text(viewModel.book.firstTitle)
            .font(.title)
            .fontWeight(.bold)
    }
    
    @ViewBuilder
    var BookImage : some View {
        if let cacheImage = ImageCache.shared.image(forKey: viewModel.book.id) {
            cacheImage
                .resizable()
                .scaledToFit()
        } else {
            AsyncImage(url: URL(string: viewModel.book.imageURL)){ image in
                image
                    .resizable()
                    .scaledToFit()
                    .onAppear(){
                        ImageCache.shared.set(image,forKey: viewModel.book.id)
                    }
            } placeholder: {
                ZStack {
                    Color.gray.opacity(0.3)
                    ProgressView().scaleEffect(1.8)
                }
                .frame(height: 540)
                
            }
            
        }
    }
}

#Preview {
    BookDetailView(viewModel: BookDetailViewModel(book: Book()))
}
