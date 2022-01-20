//
//  MainView.swift
//  MusicPlayer
//
//  Created by Prakash on 15/01/22.
//

import SwiftUI
//import Combine
import AVKit
import UIKit
import GoogleMobileAds

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
         MainView()
    }
}

struct MainView: View {
    @State private var selection = 0
    @State private var playerOffset: CGFloat = 0
  
    @ObservedObject var playingMusicViewModel = PlayingMusicModel()
    @ObservedObject var musicManager = SoundManager()

    var body: some View {
        GeometryReader { geometry in
            TabView {
                NavigationView {
                    HomeTab(playerData: playingMusicViewModel.playingMusic)
                    .navigationBarTitle("Playing Music")
                }
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                
                //next tab
                NavigationView {
                    RecentTab()
                        .navigationBarTitle("Recent Music")
                }
                .tabItem {
                    Image(systemName: "clock")
                    Text("Recent")
                }
            }.overlay(PlayerOverlay(playerData: playingMusicViewModel.playingMusic, musicManager: musicManager), alignment: .bottom)
            Spacer()
        }
    }
}

//main player view at bottom navigationbar
struct PlayerOverlay: View {
    var playerData : MusicDataModel
    var musicManager : SoundManager
    var body: some View {
        
        HStack {
            Rectangle() //for background view
                      .background(Color.black)
                       .opacity(0.8)
                      .frame(width: 10, height: 55)
                      .cornerRadius(8.0)
            /////////
            ///write /call code to show ads playing song/stream method
            ////
            
            PlayerViewEx(radio: true, musicManager: musicManager)
            VStack(alignment: .leading){
                Text("Song:\(playerData.name)") // show playing song name
                    .foregroundColor(.white)
                    .font(.system(size: 12))

                Text("Artist:\(playerData.artist)") //show playing song artist
                    .foregroundColor(.white)
                    .font(.system(size: 12))
            }
            Spacer()
        }.background(Color.black)
        .opacity(0.8)
        .cornerRadius(10.0)
        .padding(55)
       
    }
}

//for Tab -> Home
struct HomeTab: View {
    var playerData : MusicDataModel

    var body: some View {
        VStack(alignment: .center){
           
            Image(uiImage: playerData.imageurl)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:100, height:100)
                .border(Color.gray.opacity(0.5))
                .cornerRadius(50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                .shadow(radius: 5)
                .padding(.horizontal, 30)

            Text(self.playerData.name)
                .font(.headline)
                .padding(.leading, 10)
                .padding(.top, 10)
        
            Text(self.playerData.artist) .font(.footnote)
                .padding(.top, 5)
                .padding(.leading, 10).foregroundColor(.gray)
        }
    } // end body
} // end View

//for Tab -> Recent
struct RecentTab: View {
    @StateObject var recentMusicViewModel = RecentMusicModel()
   // var playerData : GlobalString
    
    var body: some View {
        List(self.recentMusicViewModel.musicList , id: \.name) { music in
            
            HStack {
                // Mark - thumb image
                Image(uiImage: music.imageurl)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:100, height:100)
                    .border(Color.gray.opacity(0.5))
                    .cornerRadius(50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                    .shadow(radius: 5)
            }
            
            VStack(alignment: .leading)
            {
                Text(verbatim: music.name) .font(.headline)
                    .padding(.leading, 10)
                    .padding(.top, 5)
                
                Text(verbatim: music.artist) .font(.footnote)
                    .padding(.top, 5)
                    .padding(.leading, 10).foregroundColor(.gray)
            }
        } //end List
    } //end body
} //end View

//music manager
class SoundManager : ObservableObject {
    var audioPlayer: AVPlayer?

    func playSound(sound: String){
        if let url = URL(string: sound) {
            self.audioPlayer = AVPlayer(url: url)
        }
    }
}

//for play button -toggel play/pause
struct PlayerViewEx: View {
    @State var radio = false
    @State var musicManager:SoundManager
    //@StateObject private var soundManager = SoundManager()
    
    var body: some View {
        Image(systemName: radio ? "pause.circle.fill": "play.circle.fill")
            .font(.system(size: 25))
            .padding(.trailing)
            .onTapGesture {
                musicManager.playSound(sound: Constants.apiRadioURL)
                radio.toggle()
                
                if radio{
                    musicManager.audioPlayer?.play()
                } else {
                    musicManager.audioPlayer?.pause()
                }
            }
    }
}
// for printing logs
extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}


// for showing ads
/*final class Interstitial:NSObject, GADFullScreenContentDelegate{
    var interstitial:GADInterstitialAd = GADInterstitialAd()
    
    override init() {
        super.init()
        LoadInterstitial()
    }
    
    func LoadInterstitial(){
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/4411468910",
                                       request: request,
                             completionHandler: { [self] ad, error in
                               if let error = error {
                                 print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                 return
                               }
                                interstitial = ad!
                                interstitial.fullScreenContentDelegate = self
                             }
           )
        //self.interstitial.fullScreenContentDelegate = self
    }
    
    /// Tells the delegate that the ad failed to present full screen content.
     func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
       print("Ad did fail to present full screen content.")
     }

     /// Tells the delegate that the ad presented full screen content.
     func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
       print("Ad did present full screen content.")
     }

     /// Tells the delegate that the ad dismissed full screen content.
     func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
       print("Ad did dismiss full screen content.")
     }
    
    func showAd(){
        if self.interstitial != nil{
                    //self.rewardFunction = rewardFunction
                    let root = UIApplication.shared.windows.first?.rootViewController
            self.interstitial.present(fromRootViewController: root!)
                }
               else{
                   print("Not Ready")
               }
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitialAd) {
        self.interstitial = GADInterstitialAd()
        LoadInterstitial()
    }
}*/

