//
//  URLImageView.swift
//  HCollectionView-SwiftUI
//
//  Created by Juan Capponi on 10/8/20.
//

import SwiftUI


struct URLImageView: View {
    
    @ObservedObject var urlImageModel: URLImageModel
    
    init(urlString: String?){
        urlImageModel = URLImageModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? URLImageView.defaultImage!)
            .resizable()
    }
    
    static var defaultImage = UIImage(named: "loading.jpg")
    
    static var backgroundImage = UIImage(named: "background.jpg")
    
}

struct URLImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(urlString: nil)
    }
}


