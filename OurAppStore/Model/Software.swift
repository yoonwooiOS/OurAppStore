//
//  Software.swift
//  OurAppStore
//
//  Created by 김윤우 on 8/9/24.
//

import Foundation

struct Software: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let artworkUrl60: String
    let artworkUrl512: String
    let trackName: String
    let artistName: String
}
