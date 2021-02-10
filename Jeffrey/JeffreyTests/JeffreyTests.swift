//
//  JeffreyTests.swift
//  JeffreyTests
//
//  Created by Mizia Lima on 11/16/20.
//

import XCTest
@testable import Jeffrey

class JeffreyTests: XCTestCase {

  

    func testDataFormater() throws {
        let viewmodel = SelectedMovieViewModel()
        let date = viewmodel.formatDate(date: "2020-05-21")
        XCTAssertEqual(date, "21/05/2020")
        
    }
   
    func testeIdGenre(){
        let viewmodel = SelectedMovieViewModel()
        viewmodel.setIdGenre(id: 6)
        XCTAssertEqual(6, viewmodel.genreId)
    }

  

}
