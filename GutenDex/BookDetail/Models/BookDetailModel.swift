//
//  BookDetailModel.swift
//  GutenDex
//
//  Created by mridul-ziroh on 11/04/25.
//

struct BookDetailModel: Codable {
    let summaries: [String]
    let downloadCount: Int
    let formats: Formats
    
    enum CodingKeys: String, CodingKey {
        case  summaries, formats
        case downloadCount = "download_count"
    }
}

struct Formats: Codable {
    let textHTML, applicationEpubZip, applicationXMobipocketEbook: String?
    let textPlainCharsetUsASCII: String?
    let applicationRDFXML: String?
    let applicationOctetStream: String?
    
    enum CodingKeys: String, CodingKey {
        case textHTML = "text/html"
        case applicationEpubZip = "application/epub+zip"
        case applicationXMobipocketEbook = "application/x-mobipocket-ebook"
        case textPlainCharsetUsASCII = "text/plain; charset=us-ascii"
        case applicationRDFXML = "application/rdf+xml"
        case applicationOctetStream = "application/octet-stream"
    }
    
    var count: Int {
        [
            textHTML,
            applicationEpubZip,
            applicationXMobipocketEbook,
            textPlainCharsetUsASCII,
            applicationRDFXML,
            applicationOctetStream
        ].compactMap { $0 }.count
    }
   
    var downloadLinks: [String] {
        [
            textHTML,
            applicationEpubZip,
            applicationXMobipocketEbook,
            textPlainCharsetUsASCII,
            applicationRDFXML,
            applicationOctetStream
        ].compactMap { $0 }
    }
}
