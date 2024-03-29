//
// Images.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public struct Images: Codable {

    public var fixedHeight: Image?
    public var fixedHeightStill: Image?

    public init(fixedHeight: Image?, fixedHeightStill: Image?) {
        self.fixedHeight = fixedHeight
        self.fixedHeightStill = fixedHeightStill
    }

    public enum CodingKeys: String, CodingKey { 
        case fixedHeight = "fixed_height"
        case fixedHeightStill = "fixed_height_still"
    }


}

