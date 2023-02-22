//
//  RandomFactController.swift
//  BYOA4.3
//
//  Created by Jake Gloschat on 2/22/23.
//

import Foundation

class RandomFactController {
    
    static func fetchRandomFact(completion: @escaping ([RandomFact]?)-> Void) {
        
        //https://uselessfacts.jsph.pl/random.json?language=en
        //Construct URL
        guard let baseURL = URL(string: Constants.RandomURL.baseURL) else { completion(nil) ; return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(Constants.RandomURL.apiPath)
        urlComponents?.path.append(Constants.RandomURL.englishPath)
        guard let finalURL = urlComponents?.url else { completion(nil) ; return }
        print("Final Random Joke URL: \(finalURL)")
        
        // Fetch using URL
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil) ; return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Random Joke Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(nil) ; return }
            
            do {
                if let topLevel = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String : Any],
                   let randomFactDict = topLevel["results"] as? [[String : Any]] {
                   
                    let randomFact = randomFactDict.compactMap { RandomFact(randomFactDictionary: $0) }
                    completion(randomFact)
                }
            } catch {
                print(error.localizedDescription)
                completion(nil) ; return
            }
        }.resume()
    }
    
}
