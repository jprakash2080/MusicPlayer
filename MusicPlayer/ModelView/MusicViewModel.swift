//
//  MusicPlayingViewModel.swift
//  MusicPlayer
//
//  Created by Prakash on 15/01/22.
//

import Foundation
import Combine
import SwiftUI

//get current playing music
final class PlayingMusicModel: ObservableObject {
    
    // Music View Model ObsevebleObject
    let didChange = PassthroughSubject<Void, Never>()
        
    @Published var playingMusic: MusicDataModel = MusicDataModel(music:nil) {
        didSet { didChange.send() }
    }
  
    init(){ //Webservice load function
        loadPlayingMusic()
    }
    
    func loadPlayingMusic() {
        APIServices().apiToGetPlayingMusic{ playingmusic in
            DispatchQueue.main.async {
                //getter and setter call for MusicDataModel
                self.playingMusic = MusicDataModel(music:playingmusic)
            }
        }
    }
}

//Load recent played music
final class RecentMusicModel: ObservableObject {
    
    // Music View Model ObsevebleObject
    let didChange = PassthroughSubject<Void, Never>()
    @Published var musicList = [MusicDataModel]() {
        didSet { didChange.send() }
    }
  
    init(){ //Webservice load function
       loadRecentMusic()
    }
    
    private func loadRecentMusic() {
        APIServices().apiToGetRecentMusic{ music in
            DispatchQueue.main.async {
                //getter and setter call for MusicDataModel
                self.musicList = music.map(MusicDataModel.init)
            }
        }
    }
}


