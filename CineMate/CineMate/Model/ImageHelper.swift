//
//  ImageHelper.swift
//  CineMate
//
//  Created by Ryan Lee on 8/9/24.
//  Credit to by Arthur Roolfs on 11/28/23.

import Foundation
import UIKit

/*
 From Apple:
    async enables a function to suspend
    await marks where an async function may suspend execution
    other work can happen during a suspension
    once an awaited async call completes, execution resumes.
 */

class ImageHelper: ObservableObject {

    enum ImageFetchError: Error {
        case invalidURL
        case badResponse
        case badImageData
    }

    func fetchImage(url: String) async throws -> UIImage {
        guard let url = URL(string: url) else {
            throw ImageFetchError.invalidURL
        }

        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ImageFetchError.badResponse
        }
        
        guard let image = UIImage(data: data) else {
            throw ImageFetchError.badImageData
        }
        
        return image
    }
    
}
