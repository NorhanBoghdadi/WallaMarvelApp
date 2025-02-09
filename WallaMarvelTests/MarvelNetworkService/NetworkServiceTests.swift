//
//  NetworkServiceTests.swift
//  WallaMarvel
//
//  Created by Norhan Boghdadi on 09/02/2025.
//


import Testing
import Foundation
@testable import WallaMarvel

@Suite(.serialized)
class NetworkServiceTests {
    private var data: TestData

    struct TestData {
        var sut: NetworkService!
        var session: URLSession!
    }

    init() async throws {
        self.data = TestData()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        data.session = URLSession(configuration: configuration)
        data.sut = NetworkService(session: data.session)
    }

    deinit {
        MockURLProtocol.requestHandler = nil
    }

    @Test("Successfully decodes valid response")
    func testValidResponse() async throws {
        // Given
        let expectedHero = CharacterDataModel.mock()
        let jsonString = """
        {
            "code": 200,
            "status": "Ok",
            "data": {
                "offset": 0,
                "limit": 20,
                "total": 1,
                "count": 1,
                "results": [{
                    "id": \(expectedHero.id),
                    "name": "\(expectedHero.name)",
                    "description": "\(expectedHero.description)",
                    "thumbnail": {
                        "path": "\(expectedHero.thumbnail.path)",
                        "extension": "\(expectedHero.thumbnail.extension)"
                    },
                    "comics": {
                        "available": 0,
                        "items": []
                    },
                    "series": {
                        "available": 0,
                        "items": []
                    },
                    "stories": {
                        "available": 0,
                        "items": []
                    },
                    "events": {
                        "available": 0,
                        "items": []
                    }
                }]
            }
        }
        """
        let jsonData = jsonString.data(using: .utf8)!

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, jsonData)
        }

        // When
        let result: CharacterDataContainer = try await data.sut.request(endpoint: .characters(page: 0))

        // Then
        #expect(result.characters.first?.id == expectedHero.id)
        #expect(result.characters.first?.name == expectedHero.name)
        #expect(result.offset == 0)
        #expect(result.limit == 20)
    }

    @Test("Handles server error response")
    func testServerError() async throws {
        // Given
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 500,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, Data())
        }

        // When/Then
        do {
            let _: CharacterDataContainer = try await data.sut.request(endpoint: .characters(page: 0))
            Issue.record("Expected server error to be thrown")
        } catch let error as NetworkError {
            if case .serverError(let message) = error {
                #expect(message == "Status code: 500")
            } else {
                Issue.record("Expected server error but got different NetworkError")
            }
        } catch {
            Issue.record("Expected NetworkError but got different error type")
        }
    }

    @Test("Handles invalid data response")
    func testInvalidData() async throws {
        // Given
        let invalidJSON = "invalid json".data(using: .utf8)!

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, invalidJSON)
        }

        // When/Then
        do {
            let _: CharacterDataContainer = try await data.sut.request(endpoint: .characters(page: 0))
            Issue.record("Expected decoding error to be thrown")
        } catch {
            #expect(error as? NetworkError == NetworkError.decodingError)
        }
    }
}
