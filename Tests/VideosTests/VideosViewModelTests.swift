//
//  File.swift
//  
//
//  Created by Hugo Coutinho on 2024-04-13.
//

import XCTest
import Combine
import HGNetworkLayer
@testable import Videos

final class VideosViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    @MainActor
    func test_viewModelNotRetained() async {
        // 1. GIVEN
        var sut: VideosViewModel? = makeSUT()
        
        // 2. WHEN
        sut?.fetchVideo()
        weak var sutWeak = sut
        sut = nil
        
        // 3. THEN
        XCTAssertNil(sutWeak, "ViewModel not deallocated. Potential memory leak!")
    }
    
    @MainActor
    func test_shouldLoadBets() async {
        // 1. GIVEN
        let expectedFirstTitle = "Gualtieri \"Baglioni ha trasposto nelle canzoni suo rapporto con Roma\""
        let expectedSecondTitle = "Janasena Party Official YouTube Channel Hack.. ఇది ఎవరి పని.. ?? | Oneindia Telugu"
        let sut: VideosViewModel = makeSUT()
        let expectation = self.expectation(description: "VideosViewModel")
        
        // 2. WHEN
        sut.$videos
            .sink(receiveCompletion: {_ in }, receiveValue: { videos in
                guard videos.count > 1 else { return }
                
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 10)
        
        // 3. THEN
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.videos.count, 18)
        XCTAssertEqual(sut.videos.first?.title, expectedFirstTitle)
        XCTAssertEqual(sut.videos[1].title, expectedSecondTitle)
    }
    
    @MainActor
    func test_shouldLoadBetsFail() async {
        // 1. GIVEN
        let sut: VideosViewModel = makeSUTErrorHandler()
        let expectation = self.expectation(description: "VideosViewModel")
        
        // 2. WHEN
        sut.$videos
            .map(\.first?.title)
            .removeDuplicates()
            .sink(receiveCompletion: {_ in }, receiveValue: { odds in
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 10)
        
        // 3. THEN
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.videos.count, 0)
    }
}

// MARK: - MAKE SUT -
extension VideosViewModelTests {
    @MainActor
    private func makeSUT() -> VideosViewModel {
        let service = VideosService(baseRequest: BaseRequestSuccessHandlerSpy(service: .videos))
        return VideosViewModel(service: service)
    }
    
    @MainActor
    private func makeSUTErrorHandler() -> VideosViewModel {
        let service = VideosService(baseRequest: BaseRequestErrorHandlerSpy())
        return VideosViewModel(service: service)
    }
}

