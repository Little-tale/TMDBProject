//
//  ImageManager.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/2/24.
//

import UIKit

enum ImageManager {
    case trend
    case top
    case popular
    case detail
    
    static var baseImageUrl : String {
        return "https://image.tmdb.org/t/p/w500/"
    }
    
    static func getImage(imageCase: ImageManager, image: String) -> URL{
        let emptyImage = URL(string: "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg")!
        switch imageCase {
        case .trend:
            return URL(string: "\(baseImageUrl)\(image)") ?? emptyImage
        case .top:
            return URL(string: "\(baseImageUrl)\(image)") ?? emptyImage
        case .popular:
            return URL(string: "\(baseImageUrl)\(image)") ?? emptyImage
        case .detail:
            return URL(string: "\(baseImageUrl)\(image)") ?? emptyImage
        }
        
    }
}
