//
//  VideosService.swift
//  DailyMotion
//
//  Created by Hugo Coutinho on 2024-04-12.
//

import Foundation
import HGNetworkLayer

// MARK: - SERVICE INPUT PROTOCOL -
public protocol VideosServiceInput: AnyObject {
    // MARK: - VARIABLES -
    var baseRequest: BaseAsyncRequestInput { get set }
    
    // MARK: - INPUT METHODS -
    func fetchVideos() async throws -> VideoResult
}

public class VideosService: VideosServiceInput {
    // MARK: - VARIABLES -
    public var baseRequest: BaseAsyncRequestInput
    private var page: Int = 1
    
    // MARK: - CONSTRUCTOR -
    public init(baseRequest: BaseAsyncRequestInput) {
        self.baseRequest = baseRequest
    }
    
    public func fetchVideos() async throws -> VideoResult {
        let stringURL = String(format: APIConstant.baseURL + APIConstant.videos, page)
        
        guard let url = URLComponents(string: stringURL)?.url else { throw APIError.APIErrorCase.unknown }
        
        do {
            let result = try await JSONDecoder().decode(VideoResult.self, from: baseRequest.asyncWith(url))
            page = result.page + 1
            
            return result
            
        } catch {
            throw APIError.APIErrorCase.unknown
        }
    }
}

