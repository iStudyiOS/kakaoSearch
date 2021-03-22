//
//  SearchResult.swift
//  KakaoSearch
//
//  Created by 홍경표 on 2021/03/22.
//

import Foundation

// MARK: - APIResponse
struct APIResponse: Codable {
    let documents: [SearchResult]
    let meta: SearchResultInfo
}

// MARK: - SearchResult (APIResponse.documents)
struct SearchResult: Codable {
    let collection: String
    let datetime: String
    let displaySitename: String
    let docURL: String
    let height: Int
    let imageURL: String
    let thumbnailURL: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case collection, datetime, height, width
        case displaySitename = "display_sitename"
        case docURL = "doc_url"
        case imageURL = "image_url"
        case thumbnailURL = "thumbnail_url"
    }
}

// MARK: - SearchResultInfo (APIResponse.meta)
struct SearchResultInfo: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
