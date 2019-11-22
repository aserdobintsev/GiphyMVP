//
// Meta.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public struct Meta: Codable {

    public var msg: String?
    public var status: Int?
    public var responseId: String?

    public init(msg: String?, status: Int?, responseId: String?) {
        self.msg = msg
        self.status = status
        self.responseId = responseId
    }

    public enum CodingKeys: String, CodingKey { 
        case msg
        case status
        case responseId = "response_id"
    }


}
