//
//  File.swift
//  
//
//  Created by Nanashi Li on 2022/10/25.
//

import GoogleCloud
import Vapor

func uploadImage(req: Request, uploadRequest: UploadRequest) async throws -> String {
    let uploadObject = try await req.gcs.object.createSimpleUpload(bucket: Constants.GOOGLE_BUCKET_ID,
                                                                   data: uploadRequest.data,
                                                                   name: UUID().uuidString,
                                                                   contentType: uploadRequest.contentType).get()

    return uploadObject.mediaLink ?? ""
}

func deleteImage(_ req: Request, imageUrl: String) async throws -> HTTPStatus {
    let _ = req.gcs.object.delete(bucket: Constants.GOOGLE_BUCKET_ID, object: imageUrl.pathComponents[7].description)

    return .accepted
}
