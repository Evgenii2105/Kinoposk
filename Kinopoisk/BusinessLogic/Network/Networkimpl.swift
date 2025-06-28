//
//  Networkimpl.swift
//  Kinopoisk
//
//  Created by Евгений Фомичев on 07.06.2025.
//

import UIKit

//protocol Network {
//    func request<T: Decodable>(endPoint: Networkimpl.EndPoint, completion: @escaping (Result<T, NetworkError>) -> Void)
//}

final class Networkimpl {
    
    enum BaseUrl {
        static let baseURL = "kinopoiskapiunofficial.tech"
    }
    
    enum APIMethod: String {
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
    }
    
    enum EndPoint {
        case films
        case detailsFilm(id: Int)
        case picturesFilm(id: Int)
        case similarsFilm(id: Int)
        
        var scheme: String {
            return "https"
        }
        
        var path: String {
            switch self {
            case .films:
                return "/api/v2.2/films"
            case .detailsFilm(let id):
                return "/api/v2.2/films/\(id)"
            case .picturesFilm(let id):
                return "/api/v2.2/films/\(id)/images"
            case .similarsFilm(let id):
                return "/api/v2.2/films/\(id)/similars"
            }
        }
        
        var method: APIMethod {
            switch self {
            case .films:
                return .get
            case .detailsFilm(_):
                return .get
            case .picturesFilm(_):
                return .get
            case .similarsFilm(_):
                return .get
            }
        }
    }
    
    static func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data,
                  error == nil,
                  let image = UIImage(data:  data)
            else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
    
    func request<T: Decodable>(endPoint: EndPoint, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let urlRequest = createRequest(endPoint: endPoint) else {
            return completion(.failure(.invalidURL))
        }
        request(urlReuest: urlRequest, completion: completion)
    }
}

private extension Networkimpl {
    
    func request<T: Decodable>(urlReuest: URLRequest, completion: @escaping (Result<T, NetworkError>) -> ()) {
        let task = URLSession.shared.dataTask(with: urlReuest) {
            data, _, error in
            guard let data else { return completion(.failure(.noData)) }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            }
            catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        task.resume()
    }
    
    func createRequest(endPoint: EndPoint) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = endPoint.scheme
        urlComponents.host = BaseUrl.baseURL
        urlComponents.path = endPoint.path
        
        guard let url = urlComponents.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endPoint.method.rawValue
        urlRequest.setValue("dfb1b814-db03-4878-bcf4-c54787098b5a", forHTTPHeaderField: "X-API-KEY")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}

