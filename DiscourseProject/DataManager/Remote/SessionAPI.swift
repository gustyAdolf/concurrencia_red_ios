//
//  SessionApi.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 13/1/21.
//

import UIKit

struct DiscourseAPIError: Codable {
    let action: String?
    let errors: [String]?
}

enum SessionAPIError: Error {
    case emptyData
}

/// Clase de utilidad para llamar al API. El método Send recibe una Request que implementa APIRequest y tiene un tipo Response asociado
final class SessionAPI {
    lazy var session: URLSession = {
        return URLSession(configuration: .default)
    }()
    
    func send<T: APIRequest>(request: T, completion: @escaping (Result<T.Response?, Error>) -> ()) {
        let request = request.requestWithBaseUrl()
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            // ERROR: si hay error en el dataTask
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            // STATUS ERROR: si el servidor devuelve un estado de error
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 400, let data = data {
                do {
                    let serverError = try JSONDecoder().decode(DiscourseAPIError.self, from: data)
                    let errorString = serverError.errors?.joined(separator: ", ") ?? "Unknow error"
                    let domainError = NSError(domain: "request", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey : errorString])
                    DispatchQueue.main.async {
                        completion(.failure(domainError))
                    }
                    return
                } catch {
                    let errorDecodingError: NSError = NSError(domain: "request", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error decoding the error"])
                    DispatchQueue.main.async {
                        completion(.failure(errorDecodingError))
                    }
                    return
                }
            }
            
            // REQUEST DATA: tratamiento del dato devuelto del servidor
            if let data = data, data.count > 0 {
                do {
                    let model = try JSONDecoder().decode(T.Response.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(model))
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(nil))
                }
            }
            
        }
        task.resume()
        
    }
    
}
