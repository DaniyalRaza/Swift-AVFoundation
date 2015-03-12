//
//  ViewController.swift
//  FaceFeatureDetection
//
//  Created by PanaCloud on 04/03/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {

    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var faceFrameView:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        
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
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeFace]
        
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)
        
        
        captureSession?.startRunning()
        
        faceFrameView = UIView()
        faceFrameView?.layer.borderColor = UIColor.greenColor().CGColor
        faceFrameView?.layer.borderWidth = 2
        view.addSubview(faceFrameView!)
        view.bringSubviewToFront(faceFrameView!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            faceFrameView?.frame = CGRectZero
            
            
            println("No face detected")
            
            return
        }
        
        
        let metadataObj = metadataObjects[0] as AVMetadataFaceObject
        
        if metadataObj.type == AVMetadataObjectTypeFace {
            
            let faceObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataFaceObject) as AVMetadataFaceObject
            faceFrameView?.frame = faceObject.bounds;
            
        }
        
        let faceObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataFaceObject) as AVMetadataFaceObject
        
        faceFrameView?.frame = faceObject.bounds
        

    
    }

}

