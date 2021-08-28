//
//  HTTPMethodType.swift
//  iOS_Challenge
//
//  Created by Dheeraj Verma on 27/08/21.
//


import Foundation

enum HTTPMethodType: String {
    case get = "GET"
}

protocol ApiResponseReceiver: AnyObject {
    func onSuccess<T: Decodable>(_ response: T) -> Void
    func onDetailError(_ error: ErrorResponse) -> Void
}

class ServiceManager {
    
    weak var apiResponseReceiver: ApiResponseReceiver?
    
    init(delegate: ApiResponseReceiver) {
        self.apiResponseReceiver = delegate
    }
    
    /// This method is being used for trigger to get request without parameter. Ex:- getting list without sending parameters.
    func requestGETWithURL<T:Codable>(_ urlString: String, returningClass: T.Type) -> Void {
        
        if Reachability.isConnectedToNetwork() == true {
            var urlRequest = URLRequest(url:  URL(string: urlString)!)
            urlRequest.httpMethod = HTTPMethodType.get.rawValue
            APIClient.connection.requestWithURL(urlRequest: urlRequest, returningClass: returningClass) { (result) in
                print(#function, "\(result)")
                self.responseWrapper(returningClass: returningClass, result: result)
            }
        } else {
            let error = ErrorResponse(code: 503, message: ErrorString.pleaseCheckInternetConnection.text(), error: "No Internet")
            apiResponseReceiver?.onDetailError(error)
        }
    }
}

//MARK:- This extension for handling response and for manipulation.
extension ServiceManager {
    
    private func responseWrapper<T: Decodable>(returningClass: T.Type, result: Result<T?, ErrorResponse>) {
        switch result {
        case .success(let success):
            if let data = success {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.apiResponseReceiver?.onSuccess(data)
                }
            }
            
        case .failure(let error):
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.apiResponseReceiver?.onDetailError(error)
            }
        }
    }
}

