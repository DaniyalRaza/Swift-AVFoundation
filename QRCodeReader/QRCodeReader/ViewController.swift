//
//  ViewController.swift
//  QRCodeReader
//
//  Created by PanaCloud on 04/03/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit
import AVFoundation

var detectedUrl:String!

class ViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var centerView: UIView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var codeFrameView:UIView?
    let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
        
        
        var error:NSError?
        let input: AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error)
        
        if (error != nil) {
           
            println("\(error?.localizedDescription)")
            return
        }
        
        
        captureSession = AVCaptureSession()
        
        captureSession?.addInput(input as AVCaptureInput)
        
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
       
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code]
        
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-40)
        view.layer.addSublayer(videoPreviewLayer)
        
        
        captureSession?.startRunning()
        
        view.bringSubviewToFront(messageLabel)
        
        centerView.layer.borderColor=UIColor.blueColor().CGColor
        centerView.layer.borderWidth=10
        
        self.view.bringSubviewToFront(centerView)
        
        codeFrameView = UIView()
        codeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
        codeFrameView?.layer.borderWidth = 2
        view.addSubview(codeFrameView!)
        view.bringSubviewToFront(codeFrameView!)


        
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            codeFrameView?.frame = CGRectZero
            messageLabel.text = "No  code is detected"
            
            println("No code is detected")
            
            return
        }
        
        
        let metadataObj = metadataObjects[0] as AVMetadataMachineReadableCodeObject
        
        
        
        if (metadataObj.type != nil) {
            
           
            
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as AVMetadataMachineReadableCodeObject
            codeFrameView?.frame = barCodeObject.bounds;
            
            if metadataObj.stringValue != nil {
               messageLabel.text = metadataObj.stringValue
                
                
                
                println(metadataObj.stringValue)
                
               
                
                
            
               
                
            
            }
        }
        
        let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as AVMetadataMachineReadableCodeObject
        
        codeFrameView?.frame = barCodeObject.bounds
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func torchButtonClick(sender: AnyObject) {
        
        turnTorchOn()
        
    }
    
  
    
    func turnTorchOn(){
        if(captureDevice.hasTorch && captureDevice.hasFlash){
            captureDevice.lockForConfiguration(nil)
            if(!captureDevice.torchActive){
                captureDevice.torchMode=AVCaptureTorchMode.On
                }
            else{
                captureDevice.torchMode=AVCaptureTorchMode.Off
            }
        }
    }
    
    
    
  

}

