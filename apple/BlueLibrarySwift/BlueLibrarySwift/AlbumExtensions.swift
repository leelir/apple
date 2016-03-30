//
//  AlbumExtensions.swift
//  BlueLibrarySwift
//
//  Created by 张碧贤 on 16/3/24.
//  Copyright © 2016年 Raywenderlich. All rights reserved.
//

    
    extension Album {
        func ae_tableRepresentation() -> (titles:[String], values:[String]) {
            return (["Artist", "Album", "Genre", "Year"], [artist, title, genre, year])
        }
    }
