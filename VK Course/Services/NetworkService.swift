//
//  NetworkService.swift
//  VK Course
//
//  Created by Алексей Пархоменко on 22/01/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import Foundation


final class NetworkService {
    
    private let authService: AuthService
    
    // только ради token
    init(authService: AuthService) {
        self.authService = authService
    }

    // эта функция универсальна в плане того, что
    // функция, которая вытаскивает из инета всю информацию о постах в формате JSON
    func getFeed(completion: @escaping (FeedResponse) -> Void, failure: @escaping () -> Void) {
        
        let params = ["filters": "post,photo,photo_tag,wall_photo"]
        
        
        // что то я не могу понять где у меня фигурируют параметры из файла FeedResponse
        sendDataRequest(path: API.newsFeed, params: params, completion: { (feed: Feed) -> Void in
            completion(feed.response)
        }, failure: failure)
    }
    
    // 2 функции ниже работают с запросом информации из инета, чтобы не загромождать метод выше
    private func sendDataRequest<T: Decodable>(path: String,
                                               params: [String: String],
                                               completion: @escaping (T) -> Void,
                                               failure: @escaping () -> Void) {
        
        guard let token = authService.token else { return }
        let session = URLSession.init(configuration: .default)
        
        // ["filters": "post,photo,photo_tag,wall_photo"] + token + version
        var paramsWithTokenAndVerion = params
        paramsWithTokenAndVerion["access_token"] = token
        paramsWithTokenAndVerion["version"] = API.version
        
        // создаем URL
        let url = self.url(from: path, params: paramsWithTokenAndVerion)
        print(url)
        
        // и при таком запросе с такими параметрами ["filters": "post,photo,photo_tag,wall_photo"] + token + version я на выходе получу:
        //
        // что произсодит с параметрами из файла FeedResponse?
        // видимо ответ кроектся в completion(decodedResponse)
        let dataTask = session.dataTask(with: url) { (data, response, error) in
        
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedResponse = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedResponse)
                    }
                } catch let deserialiationError {
                    print("deserialiationError: \(deserialiationError)")
                    DispatchQueue.main.async {
                        failure()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    failure()
                }
            }
        }
        dataTask.resume()
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    
    
    
    
}
