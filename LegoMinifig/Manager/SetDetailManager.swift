//
//  SetDetailManager.swift
//  LegoMinifig
//
//  Created by Nicola Rigoni on 27/03/23.
//

import Foundation

struct SetDetailManager {
    let urlSession = URLSession.shared
    let userToken = UserDefaults.standard.string(forKey: "user_token")
    
    
//    func fetchCompletedDetail(setNum: String?, listID: Int?) async throws -> SetDetailModel? {
//
//
//        guard var set = try await fetchSetAndComponents(setNum: setNum) else { throw URLError(.badURL) }
//
//        for setIndex in 0..<set.results.count {
//            set.results[setIndex].coverImage = try await fetchImageForSet(imageUrl: set.results[setIndex].setImgURL)
//            set.results[setIndex].userHas = try await checkIfUserHasSet(setNum: set.results[setIndex].setNum, listID: listID)
//        }
//
//        return set
//    }
    
    func fetchCompletedDetail(setNum: String?) async throws -> [SetPropertyModel] {
        
        print("fetchCompletedDetail \(setNum)")
        
        var originalSets = try await fetchOriginalSetAndComponents(setNum: setNum)
        
        let userSets = try await fetchUserSetAndComponents(setNum: setNum)
        
        for setIndex in 0..<originalSets.count {
            if (userSets.first(where: { $0.propertySet.setNum == originalSets[setIndex].setNum }) != nil) {
                originalSets[setIndex].userHas = true
            }
            
            
            
            let imageData = try await fetchImageForSet(imageUrl: originalSets[setIndex].setImgURL)
            originalSets[setIndex].coverImage = imageData
        }
        
        return originalSets
    }
    
    private func fetchOriginalSetAndComponents(setNum: String?) async throws -> [SetPropertyModel] {
        guard let setNum else { throw URLError(.badURL) }
        
        var setNumber = setNum
        setNumber.until("-")
        
        print("setOriginalNumber \(setNumber)")
        
        
        let baseURL = "https://rebrickable.com/api/v3/lego/sets/?key=91d5dc698499d14ed4ebfedd4d337f17&search=\(setNumber)"
        
        guard let originalSet: SetDetailModel = try await fetchSet(urlString: baseURL) else { return [] }
        
        return originalSet.results
        
        
    }
    
    private func fetchUserSetAndComponents(setNum: String?) async throws -> [Result] {
        guard let setNum else { throw URLError(.badURL) }
        
        guard let userToken else { return [] }
        
        var setNumber = setNum
        setNumber.until("-")
        
        print("setUserNumber \(setNumber)")
        
        let baseURL = "https://rebrickable.com/api/v3/users/\(userToken)/sets/?key=91d5dc698499d14ed4ebfedd4d337f17&search=\(setNumber)"
        
        guard let userSet: SetModel = try await fetchSet(urlString: baseURL) else { return [] }
        
        return userSet.results
    }
    
    
    private func fetchSet<T: Codable>(urlString: String) async throws -> T? {
        print("fetchSet \(urlString)")
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let set = try JSONDecoder().decode(T.self, from: data)
            print("set \(set)")
            return set
        } catch {
            print("fetch set error \(error)")
            throw error
        }
    }
    
    private func fetchImageForSet(imageUrl: String) async throws -> Data {
        guard let url = URL(string: imageUrl) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            return data
        } catch {
            throw error
        }
    }
    
//    private func checkIfUserHasSet(setNum: String, listID: Int?) async throws -> Bool {
//
//        guard let userToken, let listID else { throw URLError(.badURL) }
//
//        let urlString = "https://rebrickable.com/api/v3/users/\(userToken)/setlists/\(listID)/sets/\(setNum)/?key=91d5dc698499d14ed4ebfedd4d337f17"
//
//        guard let url = URL(string: urlString) else {
//            throw URLError(.badURL)
//        }
//
//        do {
//            let (data, _) = try await urlSession.data(from: url)
//            let userToken = try JSONDecoder().decode([String:String].self, from: data)
//            print(userToken)
//            for (key, value) in userToken {
//                if key == "detail" {
//                    print("error check: \(value)")
//                    return false
//                } else {
//                    return true
//                }
//            }
//            return true
//        }
//        catch {
//            print("Error loading \(url): \(String(describing: error))")
//            throw error
//        }
//    }
}
