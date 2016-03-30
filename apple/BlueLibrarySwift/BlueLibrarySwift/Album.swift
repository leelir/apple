//
//  Album.swift
//  BlueLibrarySwift
//
//  Created by 张碧贤 on 16/3/23.
//  Copyright © 2016年 Raywenderlich. All rights reserved.
//

import UIKit

class Album: NSObject {
    var title : String!
    var artist : String!
    var genre : String!
    var coverUrl : String!
    var year : String!
    init(title: String, artist: String, genre: String, coverUrl: String, year: String) {
        super.init()
        self.title = title
        self.artist = artist
        self.genre = genre
        self.coverUrl = coverUrl
        self.year = year
    }
    
    func descripte() -> String {
        return "title: \(title)" +
            "artist: \(artist)" +
            "genre: \(genre)" +
            "coverUrl: \(coverUrl)" +
        "year: \(year)"
    }
}
