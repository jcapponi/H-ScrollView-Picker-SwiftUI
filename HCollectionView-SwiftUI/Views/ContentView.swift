//
//  ContentView.swift
//  HCollectionView-SwiftUI
//
//  Created by Juan Capponi on 10/8/20.
//

import SwiftUI
import Combine


struct ContentView: View {
    @ObservedObject private var viewModel = PictureListViewModel()
    
    func changeUrl(urlString: String, photographerName: String)
        {
        self.urlValue = urlString
        self.photographerName = photographerName
        }

    
    @State var urlValue: String = ""
    @State var photographerName: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
            ScrollView(.horizontal) {
            HStack{
            if let counts = viewModel.viewModelPictures?.count {
                ForEach(0..<counts) {
                    row in
                       let img = viewModel.viewModelPictures![row].medium
                    VStack{
                    URLImageView(urlString: img).cornerRadius(8).frame(width: 80.0, height: 80.0)
                        .aspectRatio(contentMode: .fit)
                        .onTapGesture {
                            changeUrl(urlString: viewModel.viewModelPictures![row].medium, photographerName: viewModel.viewModelPictures![row].photographerName)
                            }
                        }
                    }
                }
            }
        }.onAppear(){
            self.viewModel.fetchPicts()
        }.navigationTitle("Horizontal Scroll View")
                Spacer()
                Text(photographerName).bold()
                if(urlValue == "") {
                    Spacer()
                    Image(uiImage: URLImageView.backgroundImage!).frame(width: UIScreen.main.bounds.size.width-20, height: 400.0)
                        .aspectRatio(1.0, contentMode: .fit)
                        .animation(.linear)
                        .padding(.bottom)
                } else {
                    URLImageView(urlString: urlValue).cornerRadius(8).frame(width: UIScreen.main.bounds.size.width-20, height: 400.0)
                        .aspectRatio(1.0, contentMode: .fit)
                        .animation(.linear)
                        .padding(.bottom)
                }
            }
        }
    }
}


class PictureListViewModel : ObservableObject {
    private let viewModelService = ViewModelDataSource()
    //@Published var viewModelPictures = [ViewModelPictures]() //? = nil
    @Published var viewModelPictures : [ViewModelPictures]? = nil
    var cancellable : AnyCancellable?
    
    func fetchPicts() {
        cancellable = viewModelService.fetchPictures().sink(receiveCompletion: {
            _ in
        },
        receiveValue:  { pictsContainer in
            self.viewModelPictures = pictsContainer.photos.map { ViewModelPictures(photographerName: $0.photographer, urlSmall: $0.src.small, medium: $0.src.large, large: $0.src.large2x)
            }
        })
    }
}



