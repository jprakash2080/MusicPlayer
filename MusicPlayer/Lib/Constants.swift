//
//  Constants.swift
//  MusicPlayer
//
//  Created by Prakash on 15/01/22.
//

import Foundation
import UIKit

// Userdefaults
var userdefaults = UserDefaults.standard
var noImageName = "noimage"

// Navigation Title Name
var listViewName = "Playing Music"
var recentViewName = "Recent Played Music"

// Application API Request
var applicationJosn = "application/json"
var acceptType = "Accept"
//admob
var AdUnitID = "ca-app-pub-3940256099942544/4411468910"

struct Constants {
    static let versionApi = "v3"
    static let apiUrlPlayingMusic = "https://api.itmwpb.com/nowplaying/\(versionApi)/935/testapi"
    static let apiUrlRecentPlayingMusic = "https://api.itmwpb.com/nowplaying/\(versionApi)/935/testapi"
    static let apiRadioURL = "https://rfcmedia.streamguys1.com/70hits.aac"
}

class CellName {
    static let musicTableviewCell = "MusicTableviewCell"
}
