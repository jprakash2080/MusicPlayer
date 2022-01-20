//
//  ImageExtention.swift
//  MusicPlayer
//
//  Created by Prakash on 15/01/22.
//

import Foundation
import Combine
import SwiftUI

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
    
    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:100, height:100)
                .border(Color.gray.opacity(0.5))
                .cornerRadius(50)
        }.onReceive(imageLoader.didChange) { img in
            self.image = img
        }
    }
    
}

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<UIImage, Never>()
    var image = UIImage() {
        didSet {
            didChange.send(image)
        }
    }
    init(urlString:String) {
        DispatchQueue.main.async {
            self.image = ImageStore.shared.image(name:((urlString)))
        }
    }
}

final class ImageStore {
    fileprivate static var scale = 2
    static var shared = ImageStore()
    func image(name: String) -> UIImage {
        guard
            let url = URL(string: name),
            let imageSource = CGImageSourceCreateWithURL(url as NSURL, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
            else {
                fatalError("Couldn't load image \(name).jpg from main bundle.")
        }
        let img = UIImage(cgImage: image)
        return img
    }
}

