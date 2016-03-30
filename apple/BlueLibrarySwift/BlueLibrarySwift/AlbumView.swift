//
//  AlbumView.swift
//  BlueLibrarySwift
//
//  Created by 张碧贤 on 16/3/23.
//  Copyright © 2016年 Raywenderlich. All rights reserved.
//

import UIKit

class AlbumView: UIView {

    
    var coverImage: UIImageView!
    var indicator: UIActivityIndicatorView!

    
    init(frame: CGRect, albumCover: String) {
        super.init(frame: frame)
        backgroundColor = UIColor.blackColor()
        coverImage = UIImageView(frame: CGRectMake(5, 5, frame.size.width - 10, frame.size.height - 10))
        addSubview(coverImage)
        indicator = UIActivityIndicatorView()
        indicator.center = center
        indicator.activityIndicatorViewStyle = .WhiteLarge
        indicator.startAnimating()
        addSubview(indicator)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)!
    }
    
    func highlightAlbum(didHighlightView didHighlightView: Bool) {
        if didHighlightView == true {
            backgroundColor = UIColor.whiteColor()
        } else {
            backgroundColor = UIColor.blackColor()
        }
    }

}
