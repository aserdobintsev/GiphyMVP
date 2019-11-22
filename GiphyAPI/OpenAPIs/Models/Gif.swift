//
// Gif.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public struct Gif: Codable {

    public var type: String?
    public var id: String?
    public var title: String?
    public var url: String?
    public var bitlyUrl: String?
    public var username: String?
    public var source: String?
    public var trendingDatetime: String?
    public var contentUrl: String?
    public var images: Images?

    public init(type: String?, id: String?, title: String?, url: String?, bitlyUrl: String?, username: String?, source: String?, trendingDatetime: String?, contentUrl: String?, images: Images?) {
        self.type = type
        self.id = id
        self.title = title
        self.url = url
        self.bitlyUrl = bitlyUrl
        self.username = username
        self.source = source
        self.trendingDatetime = trendingDatetime
        self.contentUrl = contentUrl
        self.images = images
    }

    public enum CodingKeys: String, CodingKey { 
        case type
        case id
        case title
        case url
        case bitlyUrl = "bitly_url"
        case username
        case source
        case trendingDatetime = "trending_datetime"
        case contentUrl = "content_url"
        case images
    }


}

