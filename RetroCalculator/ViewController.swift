//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Dino Musliu on 27/06/2016.
//  Copyright © 2016 Dino Musliu. All rights reserved.
//

import UIKit
import AVFoundation // audio video player

class ViewController: UIViewController {

    @IBOutlet weak var outputlbl: UILabel!
    var btnSound : AVAudioPlayer!
    
    var runningNumber = ""
    var leftVarStr = ""
    var rightVarStr = ""
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtruct = "-"
        case Empty = ""
    
    }
    
    var currentOperation : Operation = Operation.Empty
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer (contentsOfURL: soundURL)
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    @IBAction func numberPressed(btn : UIButton!){
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputlbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        proccessOperation(Operation.Divide)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        proccessOperation(Operation.Subtruct)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        proccessOperation(Operation.Multiply)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        proccessOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        proccessOperation(currentOperation)
        
    }
    
    @IBAction func btnClear(sender: AnyObject) {
        playSound()
        leftVarStr = "0"
        outputlbl.text = "0"
        proccessOperation(currentOperation)
    }
    
    func proccessOperation (op: Operation){
        playSound()
        
        if currentOperation != Operation.Empty{
        // racun
            
            if( runningNumber != ""){
                
                rightVarStr = runningNumber
                runningNumber = ""
      
                if(currentOperation == Operation.Multiply)
                {
                    result = "\(Double(leftVarStr)! * Double(rightVarStr)!)"
                }
                else if(currentOperation == Operation.Add)
                {
                    result = "\(Double(leftVarStr)! + Double(rightVarStr)!)"
                }
                else if(currentOperation == Operation.Divide){
                    result = "\(Double(leftVarStr)! / Double(rightVarStr)!)"
                }
                else if(currentOperation == Operation.Subtruct){
                    result = "\(Double(leftVarStr)! - Double(rightVarStr)!)"
                }
            
                leftVarStr = result
                outputlbl.text = result
                
                } // if runningnumber
            
            currentOperation = op
        
        }//if currentOperation !=
            
        else {
        // prvi puta je operator pretisnut
           leftVarStr = runningNumber
           runningNumber = ""
           currentOperation = op
        }
        
    
    }
    
    func playSound()
    {
        if btnSound.playing
        {
            btnSound.stop()
        }
        btnSound.play()
    
    }

}

