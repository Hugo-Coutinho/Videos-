//
//  BaseRequestSpy.swift
//  SpaceXTests
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

import Videos
import Combine
import HGNetworkLayer
import Foundation

public class BaseRequestSuccessHandlerSpy {
    // MARK: - ENUM -
    public enum ServiceEnum {
        case videos
    }
    
    // MARK: - DECLARATIONS -
    public var service: ServiceEnum
    
    public init(service: ServiceEnum) {
        self.service = service
    }
}

// MARK: - BaseAsyncRequestInput -
extension BaseRequestSuccessHandlerSpy: BaseAsyncRequestInput {
    public func asyncWith(_ url: URL) async throws -> Data {
        if let data = readLocalFile(forName: getLocalFileNameByService()) {
            return data
        } else {
            fatalError("should return json data")
        }
    }
}

// MARK: - ASSISTANT -
extension BaseRequestSuccessHandlerSpy {
    private func getLocalFileNameByService() -> String {
        switch self.service {
        case .videos:
            return "videos_data"
        }
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            print("bundle")
            if let bundlePath = Bundle.module.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}

// MARK: - BaseAsyncRequestInput -
public class BaseRequestErrorHandlerSpy: BaseAsyncRequestInput {
    public func asyncWith(_ url: URL) async throws -> Data {
        throw APIError.APIErrorCase.unknown
    }
}
