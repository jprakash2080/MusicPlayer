//
//  Music.swift
//  MusicPlayer
//
//  Created by Prakash on 15/01/22.
//

import Foundation
import SwiftUI

struct MusicDataModel:Decodable{
    var musicData: PlayingMusic_Base!
    init(music: PlayingMusic_Base? = nil){
        
        
        if music != nil{
            self.musicData = music!
        }else{
            self.musicData = PlayingMusic_Base()
        }
        
    }
    
    var imageurl: UIImage {
        //return  ImageStore.shared.image(name:((self.music.image_url?.first?!)!))
        if self.musicData.image_url == "" || self.musicData.image_url == nil{
            return  UIImage(imageLiteralResourceName:"noimage")
        }
        return  ImageStore.shared.image(name:((self.musicData.image_url)!))
     
    }
    var name: String {
        let namev = self.musicData.name != nil ? self.musicData.name! : ""
        return namev
    }
    var artist: String {
        let artistv = self.musicData.artist != nil ? self.musicData.artist! : ""
        return artistv
    }
}
struct PlayingMusic_Base : Decodable {
    var sid : String?
    var album : String?
    var name : String?
    var artist : String?
    var image_url : String?
    var link_url : String?
    var preview_url : String?
    var played_at : String?

    enum CodingKeys: String, CodingKey {

        case sid = "sid"
        case album = "album"
        case name = "name"
        case artist = "artist"
        case image_url = "image_url"
        case link_url = "link_url"
        case preview_url = "preview_url"
        case played_at = "played_at"
    }
}


