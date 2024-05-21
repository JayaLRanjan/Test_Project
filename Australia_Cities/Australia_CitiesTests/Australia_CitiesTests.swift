//
//  Australia_CitiesTests.swift
//  Australia_CitiesTests
//
//  Created by Jaya Lakshmi on 21/05/24.
//

import XCTest
@testable import Australia_Cities

class BackendServiceTests: XCTestCase {

    // Test fetchCities() method when data fetch is successful
    func testFetchCities_Success() {

        let expectation = XCTestExpectation(description: "Fetch Cities Success")
        let mockData = try? JSONEncoder().encode([WelcomeElement(city: "Sydney", lat: "-33.8678", lng: "151.2100", country: .australia, iso2: .au, adminName: .newSouthWales, capital: .admin, population: "4840600", populationProper: "4840600")])
        let mockResponse = HTTPURLResponse(url: URL(string: "https://dummy-api.com/cities")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let mockSession = MockURLSession(data: mockData, response: mockResponse, error: nil)

        BackendService.fetchCities { result in
            switch result {
            case .success(let cities):
                // Assert
                XCTAssertEqual(cities.count, 1)
                XCTAssertEqual(cities.first?.city, "Sydney")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Unexpected failure: \(error)")
            }
        }

        wait(for: [expectation], timeout: 5.0)

    }

    // Test fetchCities() method when data fetch fails
    func testFetchCities_Failure() {
        
        let expectation = XCTestExpectation(description: "Fetch Cities Failure")
        let mockError = NSError(domain: "MockError", code: 500, userInfo: nil)
        let mockSession = MockURLSession(data: nil, response: nil, error: mockError)
        //let backendService = BackendService()

        BackendService.fetchCities { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                // Assert
                XCTAssertEqual((error as NSError).domain, "MockError")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }
}

// Mock URLSession for testing
class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        let task = MockURLSessionDataTask()
        task.completionHandler = { completionHandler(self.data, self.response, self.error) }
        return task
    }
}

// Mock URLSessionDataTask for testing
class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    var completionHandler: (() -> Void)?

    func resume() {
        completionHandler?()
    }
}

// Protocol to mock URLSession
protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

// Protocol to mock URLSessionDataTask
protocol URLSessionDataTaskProtocol {
    func resume()
}

