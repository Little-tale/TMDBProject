//
//  youtubeAssistance.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/9/24.
//

import UIKit

/*
 //print(self.youtubeKeys.results.first?.key)
//            let url = URL(string: <#T##String#>)
//
//            let urlRequest = URLRequest(url: <#URL#>)
//
 */

struct YoutubeAssistance {
    // 과제 에선 이밑 주소로 하라고 하셨지만 유튜브 화면이 깨지는 이슈가 발생하여수정하려고 한다
    let defaultBaseUrl = "https://www.youtube.com/watch?v="
    let baseUrl = "https://www.youtube.com/embed/"
    // 태그언어로 크기 조절이 가능하다고 한다 잠시 vsCode좀 갔다오겠다.
    // https://www.youtube.com/embed/XZ8daibM3AE
    let youtubeSettingHeml = """
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
</head><body>
<iframe width="100%" height="100%" src="%@youtubeLink%" frameborder="0" allowfullscreen></iframe>
</body>
</html>
"""
// width = iframe 부모요소 100%
// heigh 마찬가지
    
    func getYouteLink(_ forKey: String) -> String {
        // let url = URL(string: forKey)
        // let beforeUrl = baseUrl + forKey
        let url = youtubeSettingHeml.replacingOccurrences(of: "%@youtubeLink%", with: baseUrl + forKey)
       
        return url
    }
    
    func requestyoutube(forKey: String) -> Result<URLRequest,URLError> {
        
        let url = URL(string: defaultBaseUrl + forKey)
        
        guard let url = url else {
            print("url 생성 실패")
            return .failure(.unknownError)
        }
        
        let urlRequest = URLRequest(url: url)
        return .success(urlRequest)
    }
    
}
// <!DOCTYPE html>
