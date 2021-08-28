//
//  APIClient.swift
//  iOS_Challenge
//
//  Created by Dheeraj Verma on 27/08/21.
//

import Foundation

class APIClient {
    
    static var connection: APIClient = {
        let connection = APIClient()
        return connection
    }()

    var requestTask: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(60)
        let session = URLSession(configuration: configuration)
        return session
    }()

    func requestWithURL<T:Codable>(urlRequest: URLRequest, returningClass: T.Type, completionHandler: @escaping(Result<T?, ErrorResponse>) -> Void) {
        self.performOperation(requestUrl: urlRequest, responseType: T.self) { (result) in
            completionHandler(result)
        }
    }

    private func performOperation<T: Codable>(requestUrl: URLRequest, responseType: T.Type, completionHandler: @escaping(Result<T?, ErrorResponse>) -> Void) {

        let task = requestTask.dataTask(with: requestUrl) { [weak self] (data, httpUrlResponse, error) in
            guard let self = self else { return }

            let statusCode = (httpUrlResponse as? HTTPURLResponse)?.statusCode

            print("********* \n\n Before Decode API url = \(String(describing: httpUrlResponse?.url)) \n\n status code = \(String(describing: statusCode ?? 000)) \n\n error = \(String(describing: error?.localizedDescription)) \n\n data = \(String(data: data ?? Data(), encoding: .utf8)!) \n\n ************")

            if error == nil && data != nil && data?.count != 0 {
                if statusCode ?? 0 >= 200 && statusCode ?? 0 <= 300 {
                    let response = self.decodeJsonResponse(data: data!, responseType: responseType)
                    completionHandler(.success(response))
                } else {
                    var error = self.decodeJsonResponse(data: data!, responseType: ErrorResponse.self)
                    error?.code = String(describing: statusCode!)
                    completionHandler(.failure(error!))
                }
            } else {
                let networkError = ErrorResponse(code: statusCode, message: nil, error: error?.localizedDescription)
                completionHandler(.failure(networkError))
            }
        }
        task.resume()
    }
}

//Mark:- This extension is being used for data manipulation.
extension APIClient {
    private func decodeJsonResponse<T: Codable>(data: Data, responseType: T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(responseType, from: data)
        } catch let error {
            debugPrint("deocding error =>\(error.localizedDescription)")
        }
        return nil
    }
}
