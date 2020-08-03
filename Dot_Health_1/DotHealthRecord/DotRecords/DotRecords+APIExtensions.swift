//
//  DotRecords+APIExtensions.swift
//  Dot_Health_1
//
//  Created by Animesh Mohanty on 03/08/20.
//  Copyright © 2020 Animesh Mohanty. All rights reserved.
//

import Foundation
import MobileCoreServices
extension DotRecordsViewController{
func upload(files: [FileInfo], toURL url: URL,
                   withHttpMethod httpMethod: HTTPMethod,
                   completion: @escaping(_ result: Result<AnyObject?, APIError>, _ failedFiles: [String]?) -> Void) {
        
           DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//               let targetURL = self?.addURLQueryParameters(toURL: url)
            guard let boundary = self?.client.createBoundary() else { return }
            let imageFileURL = URL(string: self?.dummyModel[1].cardTitle ?? "")
           
//               self?.requestHttpHeaders.add(value: "multipart/form-data; boundary=\(boundary)", forKey: "content-type")
            self?.headers.add(value: "multipart/form-data; boundary=\(boundary)", forKey: "content-type")
            let headers = ["content-type":"multipart/form-data; boundary=\(boundary)"]
//            guard var body = try? JSONSerialization.data(withJSONObject: [:]) else { completion(Result.failure(.invalidData), nil); return }
            self?.client.httpBodyParameters.add(value: "12", forKey: "appointment_id")
            self?.client.httpBodyParameters.add(value: "CT Scan", forKey: "category")
            self?.client.httpBodyParameters.add(value: "http://104.215.179.29/v1/patients/17/medicalReports", forKey: "storage_link")
            guard var body = self?.client.getHttpBody(withBoundary: boundary) else { return }
            
            let mimType = self?.mimeType(for: self?.dummyModel[1].cardName ?? "")
            
            let _ = self?.client.add(files:  [FileInfo(withFileURL: url, filename: "sampleImage.pdf", name: "file_content", mimetype: mimType!)], toBody: &body, withBoundary: boundary)
            self?.client.close(body: &body, usingBoundary: boundary)
                let api: API = .api1
            let endpoint: Endpoint = api.getPostAPIEndpointForAll(urlString: "http://104.215.179.29/v1/patients/17/medicalReports", httpMethod: .post, queryItems: nil, headers: headers, body: body)
            self?.client.userLogin(from: endpoint) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let model2Result):
                   print(model2Result)
        
                case .failure(let error):
             
                    print("the error \(error)")
                }
            }
//               guard let request = self?.prepareRequest(withURL: targetURL, httpBody: body, httpMethod: httpMethod) else { completion(Results(withError: CustomError.failedToCreateRequest), nil); return }
//
//               let sessionConfiguration = URLSessionConfiguration.default
//               let session = URLSession(configuration: sessionConfiguration)
//               let task = session.uploadTask(with: request, from: nil, completionHandler: { (data, response, error) in
//                   completion(Results(withData: data,
//                                      response: Response(fromURLResponse: response),
//                                      error: error),
//                              failedFilenames)
//               })
//               task.resume()
           }
       }
    private func mimeType(for path: String) -> String {
        let pathExtension = URL(fileURLWithPath: path).pathExtension as NSString

        guard
            let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension, nil)?.takeRetainedValue(),
            let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue()
        else {
            return "application/octet-stream"
        }

        return mimetype as String
    }
}
