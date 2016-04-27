//
//  MeMe.swift
//  Meme_Me
//
//  Created by kavita patel on 4/12/16.
//  Copyright © 2016 kavita patel. All rights reserved.
//

import Foundation
import UIKit

struct MeMe
{
    var _topText: String?
    var _bottomText: String?
    var _image: UIImage?
    
    var TopText: String{
        return _topText!
    }
    var BottomText: String{
        return _bottomText!
    }
    var memeImage: UIImage
    {
        return _image!
    }
    init(toptext: String, bottomtext: String, image: UIImage)
    {
        self._topText = toptext
        self._bottomText = bottomtext
        self._image = image
    }

    
}