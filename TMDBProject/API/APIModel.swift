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

