//
//  Error.swift
//  ACCI_Cricket
//
//  Created by Gaurav Govilkar on 9/2/17.
//  Copyright © 2017 webdunia. All rights reserved.
//

import Foundation

enum Errorbase : Error {
    case ConnectionFaild
    case UploadingFaild ([Data : AnyObject])
    case DownloadingFaild
    case GenericDefault
}
