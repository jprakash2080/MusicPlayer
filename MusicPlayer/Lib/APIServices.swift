//
//  APIServices.swift
//  MusicPlayer
//
//  Created by Prakash on 15/01/22.
//

import Foundation
import SwiftUI

class APIServices {

    //API Call - Recent Music
    func apiToGetRecentMusic(completion: @escaping([PlayingMusic_Base]) ->())
    {
        let baseURL = URL(string: Constants.apiUrlPlayingMusic)!
        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  return }
            do{
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model:[PlayingMusic_Base] = try decoder.decode([PlayingMusic_Base].self, from:
                    dataResponse) //Decode JSON Response Data
                DispatchQueue.main.async {
                    completion(model)//get top record
                }
              
            } catch _ {
           }
        }
        task.resume()
    }
    
    
    // API Call - Playing music
    func apiToGetPlayingMusic(completion: @escaping(PlayingMusic_Base) ->())
    {
        let baseURL = URL(string: Constants.apiUrlPlayingMusic)!
        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
        guard let dataResponse = data,
                  error == nil else {
                  return }
            do{
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model:[PlayingMusic_Base] = try decoder.decode([PlayingMusic_Base].self, from:
                    dataResponse) //Decode JSON Response Data
                DispatchQueue.main.async {
                    if (model.count == 0 ){
                       return
                    }
                   completion(model[0])
                }
              
            } catch _ {
           }
        }
        task.resume()
    }
}
