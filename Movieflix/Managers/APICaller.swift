//
//  APICaller.swift
//  Movieflix
//
//  Created by Macbook Pro on 11.02.2023.
//

import Foundation


struct Constants {
    
    static let API_KEY = "91299f081c874c650af4b2706eb970f8"
    static let Base_Url = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyDJ0sEUIr9I9iOpBCEedsbiEuqt9GQhn9A"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (Result<[Title],Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.Base_Url)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                
                return
                
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
                
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTvData(completion: @escaping (Result<[Title],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.Base_Url)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getUpcomingData(completion: @escaping (Result<[Title],Error> )-> Void) {
        guard let url = URL(string: "\(Constants.Base_Url)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getPopularData(completion: @escaping (Result<[Title],Error>)->Void) {
        guard let url = URL(string: "\(Constants.Base_Url)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getRatedData(completion: @escaping (Result<[Title],Error>)->Void) {
        guard let url = URL(string: "\(Constants.Base_Url)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData ))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Title],Error>)->Void){
        guard let url = URL(string: "\(Constants.Base_Url)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {return}
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
        
    }
    
    func search(with query: String, completion: @escaping ( Result <[Title], Error>) -> Void ){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.Base_Url)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return}
                let task = URLSession.shared.dataTask(with: url) { data, _, error in
                    guard let data = data, error == nil else {
                        return
                    }
                    
                    do{
                        let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                        completion(.success(result.results))
                    }catch{
                        completion(.failure(APIError.failedToGetData))
                    }
                }
        task.resume()
        
    }
    
    func getMovies(with query:String, completion: @escaping (Result <VideoElement,Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let result = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                completion(.success(result.items[0]))
                
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
