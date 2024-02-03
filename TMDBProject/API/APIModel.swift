//
//  APIModel.swift
//  TMDBProject
//
//  Created by Jae hyung Kim on 2/2/24.
//

import UIKit

//MARK: - 검색 화면 (시작화면) 모델
/// 필요한것 정리
/// 1. 이미지 포스터 -> 포스터 가 없다면 이름이 나오게 하는것도 좋은 생각이라는 생각
/// 2. 이름 받아와야함
/// 3. id 필요 이미지 눌렀을때 바로 결과 화면으로 보내기 위함
///  2-------
///  서치 관련해서는
///  1. id가 일단 위에랑 다름 그래서 다른 화면으로 쏴야해
///  2. 사실 서치에서는 id만 필요하다고 판단
///  종합하면
///  해당 뷰에서는
///  image, name, id 3개를 받는 모델이 필요하다고 느낌
///
// MARK: https://api.themoviedb.org/3/ -> BASE URL
/* Search API .GET
 results ->
    backdrop_path
    id
    original_language X
    original_title
    poster_path
    title (name과 비슷해 보임)
 */

/* Trend
 results ->
    backdrop_path
    id
    name
    original_name
 */
/* TOP + POP
results ->
    backdrop_path
    poster_path
    name
    original_name
    id
 */

// MARK : 서치뷰 전용 모델
struct SearchModel: Decodable {
    let results: [Searchs]
}
struct Searchs: Decodable {
    let id : Int
    let title: String?
    let name: String?
    let backdrop_path: String?
    let poster_path: String?
}

// MARK : Detail 전용 모델
struct DetailModel: Decodable {
    let id : Int
    // 뒷배경 위해
    let backdropPath: String?
    // 프로필 사진위해
    let profilePath: String?
    let poster_path: String?
    let name: String
    let overView: String
    let voteAverage : Double?
    
    enum CodingKeys:String, CodingKey{
        case id, name, poster_path
        case backdropPath = "backdrop_path"
        case profilePath = "profile_path"
        case overView = "overview"
        case voteAverage = "vote_average"
    }
}
// MARK: Detail에서는 모델이 두개 정도 사용될 예정이다. 디테일이랑 리코멘드
// 아니 새벽에 짜서 그런가 이거 왜있는 거지 일단 킵
struct DetailModels: Decodable {
    let results : [DetailModel]
}

struct Role: Decodable {
    let character: String
}

struct Casts: Decodable{
    let name : String
    let roles: [Role]
}
// 이거 한글 적용 안됨 그냥 영어로 받게 해놔야 할듯
struct CastModel: Decodable {
    let cast : [Casts]
    let id : Int
}
