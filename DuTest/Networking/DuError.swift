//
//  DuError.swift
//  DuTest
//
//  Created by Shahid Ali on 3/9/21.
//  Copyright © 2021 Shahid. All rights reserved.
//


public enum DuError: Error {
	
	// MARK: - Internal errors
    case noInternet
    
    // MARK: - API errors
    case badAPIRequest
    
    // MARK: - Auth errors
    case unauthorized
    
    // MARK: - Unknown errors
    case unknown
}
