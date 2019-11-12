//
//  GiphyService.swift
//  GiphyMVP
//
//  Created by Alexander Serdobintsev on 11/6/19.
//

import Foundation

enum GiphyServiceLoadResult {
    case success([GiphyGif])
    case failure
}

class GiphyService {
    private let scheme = "https"
    private let host = "api.giphy.com"
    private let version = "/v1"
    private let apiKey = "sGuAouEARvFnKZUKZsmgT4Ae01L7A30u"
    private let perPage = 20
    private let searchPath = "/gifs/search"
    private let trendingPath = "/gifs/trending"
    private let gifsPath = "/gifs"

    private func apiCall(url: URL?, completionHandler:@escaping (GiphyServiceLoadResult) -> Void) {
        guard let url = url else {
            fatalError("URL can't be constructed")
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            guard
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data
                else {
                    completionHandler(.failure)
                    return
            }
            if let serviceResponse = try? JSONDecoder().decode(GiphyResponse.self, from: data) {
                if serviceResponse.meta.status == 200 {
                    completionHandler(.success(serviceResponse.data))
                    return
                }
            }
            completionHandler(.failure)
        }
        task.resume()
    }

    private func baseComponents(path: String, aditionalQueryItems: [URLQueryItem]) -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = version + path
        let baseQueryItems = [
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        urlComponents.queryItems = baseQueryItems + aditionalQueryItems
        return urlComponents
    }

    func search(query: String, page: Int, completionHandler:@escaping (GiphyServiceLoadResult) -> Void) {
        let quertyItems = [
            URLQueryItem(name: "offset", value: String(page * perPage)),
            URLQueryItem(name: "limit", value: String(perPage)),
            URLQueryItem(name: "q", value: query)
        ]
        let urlComponents = baseComponents(
            path: searchPath,
            aditionalQueryItems: quertyItems
        )
        apiCall(url: urlComponents.url, completionHandler: completionHandler)
    }

    func getTrending(page: Int, completionHandler:@escaping (GiphyServiceLoadResult) -> Void) {
        let quertyItems = [
            URLQueryItem(name: "offset", value: String(page * perPage)),
            URLQueryItem(name: "limit", value: String(perPage))
        ]
        let urlComponents = baseComponents(
            path: trendingPath,
            aditionalQueryItems: quertyItems)
        apiCall(url: urlComponents.url, completionHandler: completionHandler)
    }

    func get(ids: [String], completionHandler:@escaping (GiphyServiceLoadResult) -> Void) {
        let comaJoined = ids.joined(separator: ",")
        let urlComponents = baseComponents(
            path: trendingPath,
            aditionalQueryItems: [URLQueryItem(name: "ids", value: comaJoined)])
        apiCall(url: urlComponents.url, completionHandler: completionHandler)
    }
}
