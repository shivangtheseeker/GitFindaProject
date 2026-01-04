//
//  NetworkManager.swift
//  GitFinda
//
//  Created by Shivang on 29/12/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    //private init(){}
    
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void){
        let endpoint = baseURL + "\(username)/followers?per_page=60&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, "Invalid url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            if let _ = error {
                completed(nil, "there is an error")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "error from server")
                return
            }
            
            guard let data = data else {
                completed(nil, "data error")
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil , "Invalid data")
                
            }
        }
        
        task.resume()

    }
}
