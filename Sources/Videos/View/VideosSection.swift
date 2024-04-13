//
//  VideosSection.swift
//  DailyMotion
//
//  Created by Hugo Coutinho on 2024-04-12.
//

import Foundation
import UIKit
import HGUIComponent
import Combine

// MARK: - LAUNCH SECTION OUTPUT -
public protocol VideosSectionOutput: SectionOutput {
    func openVideoWith(videoLink: URL)
}

public final class VideosSection: Section {
    
    // MARK: - VARIABLE DELCARATIONS -
    public weak var delegate: VideosSectionOutput?
    public var viewModel: VideosViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - CONSTRUCTORS -
    public override init() {
        super.init()
        self.items = [NSObject()]
    }
    
    // MARK: - INPUT METHODS -
    @MainActor
    public func startSection() {
        fetchData()
    }
}

// MARK: - ASSISTANT METHODS -
extension VideosSection {
    @MainActor
    private func fetchData() {
        viewModel?.$videos
            .receive(on: DispatchQueue.main)
            .sink { [weak self] videos in
                guard let self = self else { return }
                
                if self.items.first as? VideoDisplayInfo == nil && !self.items.isEmpty { self.items.removeFirst() }
                self.items.append(contentsOf: videos)
                self.scene = .sceneSuccess
                self.delegate?.reloadSection(section: self, animation: .automatic)
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    private func handleScroll(row: Int) {
        if let viewModel,
           row == items.count - 1 && viewModel.hasMoreContent {
            viewModel.fetchVideo()
        }
    }
}

// MARK: - TABLEVIEW SECTION INPUT -
extension VideosSection: TableSectionCellInput {
    public func didSelectCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        guard let video = items[indexPath.row] as? VideoDisplayInfo else { return }
        delegate?.openVideoWith(videoLink: video.videoURL)
    }
    
    public func cell(for indexPath: IndexPath) -> UITableViewCell.Type {
        switch self.scene {
        case .sceneloading:
            return LoadingTableViewCell.self
        default:
            return VideosTableViewCell.self
        }
    }
    
    @MainActor
    public func willDisplayCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        guard let cell = cell as? VideosTableViewCell else { return }
        handleScroll(row: indexPath.row)
        if items.count > 0,
           indexPath.row < items.count,
           let video = items[indexPath.row] as? VideoDisplayInfo {
            cell.setup(video: video)
        }
    }
}
