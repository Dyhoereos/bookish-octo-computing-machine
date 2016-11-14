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
    @IBOutlet var swipe: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.changeImage), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        changeImage()
        
        self.view.addGestureRecognizer(swipe)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let hideWelcome = UserDefaults.standard.bool(forKey: "hideWelcome")
        if !hideWelcome {
            let tutBox = UIAlertController(title: "Welcome to Posur", message: "Use this app when you can't think of a good pose for your hands when you are having your photo taken. ", preferredStyle: .alert)
            
            let next = UIAlertAction(title: "Instructions", style: .default, handler: {(UIAlertAction) in

                let instructions = UIAlertController(title: "Instructions", message: "Keep your phone in portrait mode for single hand poses, flip your phone to landscape for double hand poses! \n\nIf you don't like what you see, tap the screen to get another pose. \n\n Swipe left to access the option menu.", preferredStyle: .alert)
                let getStarted = UIKit.UIAlertAction(title: "Let's get started", style: .default, handler: nil)
                instructions.addAction(getStarted)
                UserDefaults.standard.set(true, forKey: "hideWelcome")
                
                self.present(instructions, animated: true, completion: nil)
            } )
            
            tutBox.addAction(next)
            present(tutBox, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc private func changeImage() {
        let imgFiles = getListOfFileNames()
        let randomIndex = Int(arc4random_uniform(UInt32(imgFiles.count)))
        let imgFileName = NSURL.fileURL(withPath: imgFiles[randomIndex]).deletingPathExtension()

        if (!UserDefaults.standard.bool(forKey: "showNSFW") && imgFileName.path[imgFileName.path.index(imgFileName.path.startIndex, offsetBy: 1)] == "n"){
            changeImage()
            return
        }
        
        let dir = isLandscape() ? "h_images" : "p_images"
        let imgPath = Bundle.main.path(forResource: imgFileName.path, ofType: "png", inDirectory: dir)
            
        imgView.image = UIImage(contentsOfFile: imgPath!)
    }
    
    private func getListOfFileNames() -> Array<String> {
        
        let docsPath = isLandscape() ?
            Bundle.main.resourcePath! + "/h_images" :
            Bundle.main.resourcePath! + "/p_images"
        
        let fileManager = FileManager.default
        var docsArray: [String] = []
        docsArray = try! fileManager.contentsOfDirectory(atPath: docsPath)
        
        return docsArray
    }

    @IBAction func tapped(_ sender: AnyObject) {
        changeImage()
    }
    
    private func isLandscape() -> Bool{
        return UIDevice.current.orientation.isLandscape
    }
    
    @IBAction func swiped(_ sender: UISwipeGestureRecognizer) {
        
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "settings") as! SettingsViewController
            
            self.present(resultViewController, animated:true, completion:nil)
            
        
    }

}

