//
//  VideosEntity.swift
//  DailyMotion
//
//  Created by Hugo Coutinho on 2024-04-12.
//

import Foundation

// MARK: - VideoResult
public struct VideoResult: Codable {
    public let page: Int
    public let hasMoreContent: Bool
    public let list: Videos
    
    public enum CodingKeys: String, CodingKey {
        case page, list
        case hasMoreContent = "has_more"
    }
}

public struct Video: Codable {
    public let id: String
    public let title: String
    public let description: String
    public let thumbnailURL: URL
    public let createdTime: TimeInterval
    
    public enum CodingKeys: String, CodingKey {
        case id, title, description
        case thumbnailURL = "thumbnail_120_url"
        case createdTime = "created_time"
    }
}

public typealias Videos = [Video]

