//
//  HTTPClientInterface.swift
//  DummyAPILive
//
//  Created by Russell Yeo on 13/05/2023.
//

import Combine
import Foundation

struct HTTPClient {
    private let baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(
        baseURL: URL = URL(string: "https://dummyjson.com/")!,
        session: URLSession = .shared,
        decoder: JSONDecoder = .init()
    ) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = decoder
    }
    
    func fetch<Output: Decodable>(resource: HTTPResource) -> AnyPublisher<Output, Error> {
        let url = baseURL
            .appending(path: resource.path)
            .appending(queryItems: resource.queryItems)
        
        return session
            .dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    resource.checkStatusCode(httpResponse.statusCode)
                else {
                    throw HTTPClientError.invalidResponse
                }
                return data
            }
            .decode(type: Output.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
