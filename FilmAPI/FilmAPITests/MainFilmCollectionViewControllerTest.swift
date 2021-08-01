//
//  MainFilmCollectionViewControllerTest.swift
//  FilmAPITests
//
//  Created by Artem  on 29.07.2021.
//

import XCTest
@testable import FilmAPI

let film = Film(title: "Black Anaconda")

class MainFilmCollectionViewControllerTest: XCTestCase {
    
    
    
    func testExample()  {
        
        // arrange
        let serviceMock = FilmNetworkServiceMock()
        let viewController = MainFilmCollectionView(networkService: serviceMock)
        let expectedFilm = [film]
        
        //act
        _ = viewController.view
        
        //assert
        XCTAssertEqual(viewController.films, expectedFilm)
    }

    

}

class FilmNetworkServiceMock: FilmNetworkServiceProtocol {
    
    func getFilm(completion: @escaping (GetFilmAPIResponse) -> Void) {
        let response = GetFilmResponse(results: [film])
        completion(.success(response))
        
    }
    
    func getImage(path: String, completion: @escaping (Data) -> Void) {
    
    }
    
    func searchFilm(query: String, completion: @escaping (GetFilmAPIResponse) -> Void) {
    
    }
    
}


