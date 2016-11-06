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
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.changeImage), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        UIScreen.main.brightness = CGFloat(1.0)
        changeImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc private func changeImage(){
        let imgFiles = getListOfFileNames()
        let randomIndex = Int(arc4random_uniform(UInt32(imgFiles.count)))
        let imgFile = NSURL.fileURL(withPath: imgFiles[randomIndex]).deletingPathExtension()
        
        if (isLandscape()) {
            if let imgPath = Bundle.main.path(forResource: imgFile.path, ofType: "png", inDirectory: "h_images") {
                imgView.image = UIImage(contentsOfFile: imgPath)
            }
        } else {
            if let imgPath = Bundle.main.path(forResource: imgFile.path, ofType: "png", inDirectory: "p_images") {
                imgView.image = UIImage(contentsOfFile: imgPath)
            }
        }
    }
    
    private func getListOfFileNames() -> Array<String> {
        
        let docsPath = isLandscape() ?
            Bundle.main.resourcePath! + "/h_images": Bundle.main.resourcePath! + "/p_images"
        let fileManager = FileManager.default
        var docsArray: [String] = []
        
        do {
            docsArray = try fileManager.contentsOfDirectory(atPath: docsPath)
        } catch {
            print(error)
        }
        return docsArray
    }

    @IBAction func tapped(_ sender: AnyObject) {
        changeImage()
    }
    
    private func isLandscape() -> Bool{
        return UIDevice.current.orientation.isLandscape
    }

}

