//
//  PresenterTests.swift
//  FilmAPITests
//
//  Created by Artem  on 10.08.2021.
//

import XCTest
@testable import FilmAPI

class PresenterTests: XCTestCase {

    func test_didTapButton() {
        let view = ViewMock()
        let presenter = Presenter(view: view)
        view.presenter = presenter
        presenter.didTapButton()
        XCTAssert(view.check)
    }
    
}

class ViewMock: ViewProtocol {
    
    var check = false
    
    var presenter: PresenterProtocol?
    
    func changeBackGroundColor() {
        check = true
    }
}
