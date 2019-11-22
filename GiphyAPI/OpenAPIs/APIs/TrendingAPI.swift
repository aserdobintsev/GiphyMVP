//
// TrendingAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
import Alamofire



open class TrendingAPI {
    /**
     Trending gifs list
     
     - parameter apiKey: (query) GIPHY API Key 
     - parameter limit: (query) The maximum number of objects to return. Defaults to 25. (optional)
     - parameter offset: (query) Specifies the starting position of the results. Defaults to 0. (optional)
     - parameter rating: (query) Filters results by specified rating. If you do not specify a rating, you will receive results from all possible ratings. (optional)
     - parameter randomId: (query) An ID/proxy for a specific user. (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func trendingGet(apiKey: String, limit: Int? = nil, offset: Int? = nil, rating: String? = nil, randomId: String? = nil, completion: @escaping ((_ data: GifList?,_ error: Error?) -> Void)) {
        trendingGetWithRequestBuilder(apiKey: apiKey, limit: limit, offset: offset, rating: rating, randomId: randomId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }

    /**
     Trending gifs list
     - GET /gifs/trending
     - parameter apiKey: (query) GIPHY API Key 
     - parameter limit: (query) The maximum number of objects to return. Defaults to 25. (optional)
     - parameter offset: (query) Specifies the starting position of the results. Defaults to 0. (optional)
     - parameter rating: (query) Filters results by specified rating. If you do not specify a rating, you will receive results from all possible ratings. (optional)
     - parameter randomId: (query) An ID/proxy for a specific user. (optional)
     - returns: RequestBuilder<GifList> 
     */
    open class func trendingGetWithRequestBuilder(apiKey: String, limit: Int? = nil, offset: Int? = nil, rating: String? = nil, randomId: String? = nil) -> RequestBuilder<GifList> {
        let path = "/gifs/trending"
        let URLString = OpenAPIClientAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "api_key": apiKey, 
            "limit": limit?.encodeToJSON(), 
            "offset": offset?.encodeToJSON(), 
            "rating": rating, 
            "random_id": randomId
        ])

        let requestBuilder: RequestBuilder<GifList>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}