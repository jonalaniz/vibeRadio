//
//  Track.swift
//  Nightwave Plaza
//
//  Created by Jon Alaniz on 11/29/18.
//  Copyright © 2018 Jon Alaniz. All rights reserved.
//

import AppKit

struct Track {
    var artist: String?
    var name: String?
    var artistInfo: String?
    var space = " "
    
    init(artist: String? = nil, name: String? = nil) {
        self.name = name
        self.artist = artist
    }
    
    mutating func getSongInfo() -> String {
        if let name = name, let artist = artist {
            artistInfo = artist + space + name
            return artistInfo!
        } else {
            return "no song playing"
        }
        
    }
}
