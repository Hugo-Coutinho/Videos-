//
//  VideosCoordinator.swift
//  DailyMotion
//
//  Created by Hugo Coutinho on 2024-04-12.
//

import Foundation
import HGNetworkLayer

public protocol VideosCoordinatorInput {
    func make(output: VideosSectionOutput) -> VideosSection
}

public class VideosCoordinator: VideosCoordinatorInput {
    
    // MARK: - CONSTRUCTOR -
    public init() {}
    
    @MainActor
    public func make(output: VideosSectionOutput) -> VideosSection {
        let section = VideosSection()
        let viewModel = makeViewModel()
        section.viewModel = viewModel
        section.delegate = output
        section.output = output
        section.startSection()
        return section
    }
    
    @MainActor
    private func makeViewModel() -> VideosViewModel {
        let service = VideosService(baseRequest: BaseRequest())
        return VideosViewModel(service: service)
    }
}

