//
//  URLImageModel.swift
//  HCollectionView-SwiftUI
//
//  Created by Juan Capponi on 10/8/20.
//

import SwiftUI

class URLImageModel : ObservableObject {
    @Published var image: UIImage?
    var urlString : String?
    
    init(urlString: String? ){
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage() {
        guard let urlString = urlString else {
            return
        }
        
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!, completionHandler: getImageFromREsponse(data:response:error:))
        task.resume()
    }
    
    func getImageFromREsponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            //print("error..:\(error?.localizedDescription)")
            return
        }
        guard let data = data else {
            print("No data found")
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            self.image = loadedImage
        }
    }
}

