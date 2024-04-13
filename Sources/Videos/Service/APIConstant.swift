//
//  APIConstant.swift
//  DailyMotion
//
//  Created by Hugo Coutinho on 2024-04-12.
//

import Foundation

public struct APIConstant {
    public static let fields = "?fields=id,title,description,thumbnail_120_url,created_time"
    public static let channel = "&channel=news&limit=50"
    public static let page = "&page=%d"
    public static let videos = "/videos" + fields + channel + page
    public static let baseURL = "https://api.dailymotion.com"
    public static let videoURL = URL(string: "https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8")
}
