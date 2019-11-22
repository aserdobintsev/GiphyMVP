//
// Pagination.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public struct Pagination: Codable {

    public var offset: Int?
    public var totalCount: Int?
    public var count: Int?

    public init(offset: Int?, totalCount: Int?, count: Int?) {
        self.offset = offset
        self.totalCount = totalCount
        self.count = count
    }

    public enum CodingKeys: String, CodingKey { 
        case offset
        case totalCount = "total_count"
        case count
    }


}

