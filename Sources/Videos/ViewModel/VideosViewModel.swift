//
//  VideosViewModel.swift
//  DailyMotion
//
//  Created by Hugo Coutinho on 2024-04-12.
//

import Foundation

@MainActor
public class VideosViewModel {
    // MARK: - PROPERTIES -
    @Published public var videos: VideosDisplayInfo = []
    public var hasMoreContent: Bool = true
    private var videosModel: Videos = []
    private var service: VideosServiceInput
    
    // MARK: - CONSTRUCTOR -
    public init(service: VideosServiceInput) {
        self.service = service
        fetchVideo()
    }
    
    // MARK: - EXPOSED FUNCTIONS -
    public func fetchVideo() {
        Task {
              [weak self] in
              guard let self = self else { return }
            
              let result = try await self.service.fetchVideos()
              self.hasMoreContent = result.hasMoreContent
              self.videosModel = result.list
              self.mapVideosDisplayInfo()
          }
    }
}

// MARK: - ASSISTANT -
private extension VideosViewModel {
    func mapVideosDisplayInfo() {
        videos = videosModel
            .compactMap({ (model) -> VideoDisplayInfo? in
                guard !model.description.isEmpty,
                      let videoURL = APIConstant.videoURL else { return nil }
                
                return VideoDisplayInfo(
                    title: model.title,
                    description: model.description,
                    uploadedTime: formatTimeAgo(createdTime: model.createdTime),
                    videoURL: videoURL,
                    thumbnailURL: model.thumbnailURL
                )
            })
    }
    
    func formatTimeAgo(createdTime: TimeInterval) -> String {
        guard let formattedString = createdTime.formatToMinutes() else {
            return "Unknown"
        }
        
        return "uploaded \(formattedString) ago"
    }
}

public struct VideoDisplayInfo {
    public var title, description, uploadedTime: String
    public var videoURL, thumbnailURL: URL
}

public typealias VideosDisplayInfo = [VideoDisplayInfo]
