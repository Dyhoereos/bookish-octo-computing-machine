//
//  ViewController.swift
//  Posur
//
//  Created by arcui on 2016-11-05.
//  Copyright © 2016 Dyhoer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        UIScreen.main.brightness = CGFloat(1.0)

        let imgFiles = getListOfFileNames()
        let randomIndex = Int(arc4random_uniform(UInt32(imgFiles.count)))
        let imgFile = NSURL.fileURL(withPath: imgFiles[randomIndex]).deletingPathExtension()
        if let imgPath = Bundle.main.path(forResource: imgFile.path, ofType: "png", inDirectory: "images") {
            imgView.image = UIImage(contentsOfFile: imgPath)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getListOfFileNames() -> Array<String> {
        
        let docsPath = Bundle.main.resourcePath! + "/images"
        let fileManager = FileManager.default
        var docsArray: [String] = []
        
        do {
            docsArray = try fileManager.contentsOfDirectory(atPath: docsPath)
        } catch {
            print(error)
        }
        
        return docsArray
    }


}

