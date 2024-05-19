//
//  APIHelper.swift
//  NeoSim
//
//  Created by Karen Mirakyan on 22.04.24.
//

import Foundation
import FirebaseAuth

public class APIHelper {
    public static let shared = APIHelper()
    
    private init() { }
    
    public func voidRequest(action: () async throws -> Void) async -> Result<Void, Error> {
        do {
            try await action()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    public func codableRequest<T: Codable>(action: () async throws -> T) async -> Result<T, Error> {
        do {
            let result = try await action()
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
    
    public func authenticatedCodableRequest<T: Codable>(action: (String) async throws -> T) async -> Result<T, Error> {
        do {
            guard let userID = Auth.auth().currentUser?.uid else {
                throw CustomErrors.userNotFound
            }
            
            let result = try await action(userID)
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
