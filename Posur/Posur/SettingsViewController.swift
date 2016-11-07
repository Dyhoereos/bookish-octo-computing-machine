//
//  SettingsViewController.swift
//  Posur
//
//  Created by arcui on 2016-11-06.
//  Copyright © 2016 Dyhoer. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet var swipe: UISwipeGestureRecognizer!
    
    @IBOutlet weak var sw_nsfw: UISwitch!
    @IBOutlet weak var sw_welcome: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideWelcome = UserDefaults.standard.bool(forKey: "hideWelcome")
        let hideNSFW = UserDefaults.standard.bool(forKey: "hideNSFW")
        sw_welcome.isOn = hideWelcome
        sw_nsfw.isOn = !hideNSFW
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "main") as! ViewController
        
        self.present(resultViewController, animated:true, completion:nil)
    }
    @IBAction func welcomeToggled(_ sender: UISwitch) {
        UserDefaults.standard.set(sw_welcome.isOn, forKey: "hideWelcome")
        print(UserDefaults.standard.bool(forKey: "hideWelcome"))
    }
    @IBAction func nsfwToggled(_ sender: UISwitch) {
        UserDefaults.standard.set(sw_nsfw.isOn, forKey: "hideNSFW")
        print(UserDefaults.standard.bool(forKey: "hideNSFW"))
    }

}
