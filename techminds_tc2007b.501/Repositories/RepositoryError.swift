//
//  RepositoryError.swift
//  techminds_tc2007b.501
//
//  Created by Alumno on 11/06/23.
//

import Foundation

enum RepositoryError: Error {
    case missingModelID
    case retrievalFailure
    case unauthenticated
    case alreadyExists
    case doesNotExist
    case creationError
    case invalidModel
}
