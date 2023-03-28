//
//  LoginManager.swift
//  LegoMinifig
//
//  Created by Nicola Rigoni on 23/03/23.
//

import Foundation

struct LoginManager {
    
    let urlSession = URLSession.shared
    
    
    func fetchUserToken(email: String, password: String) async throws -> String? {
        var baseURL = URLComponents(string: "https://rebrickable.com")
        baseURL?.path = "/api/v3/users/_token/"
        baseURL?.queryItems = [
            URLQueryItem(name: "key", value: "91d5dc698499d14ed4ebfedd4d337f17")
        ]
        
        guard let url = baseURL?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        var parameters: [String: Any] { [
            "username": email,
            "password": password
            ]
          }

        request.httpBody = parameters.percentEncoded()
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, _) = try await urlSession.data(for: request)
            let userToken = try JSONDecoder().decode([String:String].self, from: data)
            print(userToken)
            for (key, value) in userToken {
                if key == "user_token" {
                    print("token: \(value)")
                    return value
                } else {
                    print("error: \(value)")
                    throw LoginError.invalidCredential
                }
            }
            return nil
        }
        catch {
            print("Error loading \(url): \(String(describing: error))")
            throw error
        }
        
    }
    
    enum LoginError: String, Error {
        case invalidCredential = "Invalid credential"
    }
}

extension Dictionary {
  func percentEncoded() -> Data? {
    return map { key, value in
      let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
      let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
      return escapedKey + "=" + escapedValue
    }
    .joined(separator: "&")
    .data(using: .utf8)
  }
}

extension CharacterSet {
  static let urlQueryValueAllowed: CharacterSet = {
    let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
    let subDelimitersToEncode = "!$&'()*+,;="

    var allowed = CharacterSet.urlQueryAllowed
    allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
    return allowed
  }()
}
