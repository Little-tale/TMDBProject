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
        return "https://image.tmdb.org/t/p/w500"
    }
    
    /// 여기에는 image! 를 주었는데 다른 뷰들이 이미지 상태에 따라 레이아웃이 변경되기에 수정합니다.
    static func getImage(imageCase: ImageManager, image: String?) -> URL?{
       // let emptyImage = URL(string: "https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg")!
        if image != nil {
            switch imageCase {
            case .trend:
                return URL(string: "\(baseImageUrl)\(image!)")
            case .top:
                return URL(string: "\(baseImageUrl)\(image!)")
            case .popular:
                return URL(string: "\(baseImageUrl)\(image!))")
            case .detail:
                //print(URL(string: "\(baseImageUrl)\(String(describing: image))"))
                return URL(string: "\(baseImageUrl)\(image!)")
            }
        }
        return nil
    }
}
