//
//  APIRequest.swift
//  DiscourseProject
//
//  Created by Gustavo A Ramírez Franco on 13/1/21.
//

import Foundation

let apiUrl = "https://mdiscourse.keepcoding.io"

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

protocol APIRequest {
    associatedtype Response: Codable
    var method: Method { get }
    var path: String { get }
    var parameters: [String : String] { get }
    var body: [String : Any] { get }
    var headers: [String : String] { get }
}

// Default implementation of the protocol
extension APIRequest {
    
    var baseURL: URL {
        guard let baseURL = URL(string: apiUrl) else { fatalError("URL not valid") }
        return baseURL
    }
    
    func requestWithBaseUrl() -> URLRequest {
        
        // 1. montar url de llamada con la url base
        let url = baseURL.appendingPathComponent(path)
        
        // 2. añadir parámetros a la url
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { fatalError("Not able to create components") }
        if !parameters.isEmpty {
            components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1)}
        }
        guard let finalUrl = components.url else { fatalError("Unable to retrieve final URL") }
        
        // 3. creación de la URLRequest partiendo de la url montada con parámetros
        var request = URLRequest(url: finalUrl)
        
        // 4. asignación del verbo de a usar: GET, POST...
        request.httpMethod = method.rawValue
        
        // 5. añadimos el body si la llamada lo trae (para los casos POST, PUT..)
        if !body.isEmpty {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        // 6. Añadimos las cabeceras que utilizarán para todas las peticiones a la API
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("699667f923e65fac39b632b0d9b2db0d9ee40f9da15480ad5a4bcb3c1b095b7a", forHTTPHeaderField: "Api-Key")
        request.addValue("gustyAdolf", forHTTPHeaderField: "Api-Username")
        return request
        
        
    }
}
