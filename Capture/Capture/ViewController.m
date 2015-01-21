//
//  ViewController.m
//  Capture
//
//  Created by Bobby Towers on 1/20/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

// importing from a header file
#import "ViewController.h"
#import "FilterViewController.h"

// importing from a framework
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) UIImagePickerController * cameraPickerController;
@property (nonatomic) UIImagePickerController * libraryPickerController;

@property (weak, nonatomic) IBOutlet UIButton *openPhotoLibraryButton;
@property (weak, nonatomic) IBOutlet UIButton *takeMediaButton;
@property (weak, nonatomic) IBOutlet UIButton *stopRecordingButton;

@property (weak, nonatomic) IBOutlet UIView *cameraView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *mediaChoiceButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cameraChoiceButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.openPhotoLibraryButton addTarget:self action:@selector(openPhotoLibrary) forControlEvents:UIControlEventTouchUpInside];

    
    self.cameraPickerController = [[UIImagePickerController alloc] init];
    self.cameraPickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.cameraPickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    self.cameraPickerController.showsCameraControls = NO;
    self.cameraPickerController.delegate = self;
    self.cameraPickerController.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie];
    
    // gets the width and height from the origin 0,0
    // a better name for cameraView would be cameraHolderView
    self.cameraPickerController.view.frame = self.cameraView.bounds;
    
    [self.cameraView addSubview:self.cameraPickerController.view];
    
    
    // this is commented out because of the next line
//    [self.takeMediaButton addTarget:self action:@selector(takeMedia) forControlEvents:UIControlEventTouchUpInside];
    
    // (takePicture) showed up because it is a method on UIImagePickerController when we changed our target from self to self.cameraPickerController
    [self.takeMediaButton addTarget:self.cameraPickerController action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    // this is for our toggle segmented control (Photo/Video)
    [self.mediaChoiceButton addTarget:self action:@selector(changeMediaType) forControlEvents:UIControlEventValueChanged];
    
    // this is to toggle the rear and front camera
    [self.cameraChoiceButton addTarget:self action:@selector(changeCameraType) forControlEvents:UIControlEventValueChanged];
    
    
}

- (void)changeMediaType {
    
    self.cameraPickerController.cameraCaptureMode = (self.mediaChoiceButton.selectedSegmentIndex == 0) ? UIImagePickerControllerCameraCaptureModePhoto : UIImagePickerControllerCameraCaptureModeVideo;
    
    switch (self.mediaChoiceButton.selectedSegmentIndex) {
        case 0: // Photo
            
            // remove video capture
            [self.takeMediaButton removeTarget:self.cameraPickerController action:@selector(startVideoCapture) forControlEvents:UIControlEventTouchUpInside];
            
            [self.mediaChoiceButton addTarget:self action:@selector(changeMediaType) forControlEvents:UIControlEventValueChanged];
        
            
            break;
            
        case 1: // Video
            // add video capture, end video capture (probably delegates
        
            // removes takePicture from takeMediaButton
            [self.takeMediaButton removeTarget:self.cameraPickerController action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
            
            [self.takeMediaButton addTarget:self action:@selector(changeMediaType) forControlEvents:UIControlEventValueChanged];
            
            // stop video capture
            [self.stopRecordingButton addTarget:self action:@selector(stopVideoCapture) forControlEvents:UIControlEventTouchUpInside];
            
            
            break;
            
        default:
            break;
    }
    
    // we move this code to case 1 to remove picture mode so we can set up for video mode
//    [self.takeMediaButton removeTarget:self.cameraPickerController action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)changeCameraType {
    
    self.cameraPickerController.cameraDevice = (self.cameraChoiceButton.selectedSegmentIndex == 0) ? UIImagePickerControllerCameraDeviceRear : UIImagePickerControllerCameraDeviceFront;
    
    
}

//- (void)takeMedia {
//    
//    // object and method
//    [self.cameraPickerController takePicture];
//    
//}

- (void)openPhotoLibrary {
    
    // alloc inits it
    self.libraryPickerController = [[UIImagePickerController alloc] init];
    
    // if you set a delegate, we need to create a dismiss in the imagePickerController method
    self.libraryPickerController.delegate = self;
    // the delegate is so that the view controller libraryPickerController can talk to self
    
    // presents view controller
    [self presentViewController:self.libraryPickerController animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // this runs after you select the picture
    
    NSLog(@"%@", info);
    
    // info is a dictionary, but it's not accepting a string (at least, it doesn't look like it)
    // actually click option + UIImagePickerControllerOriginalImage, then go to the .h
    // it actually IS a string
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    
    // moving this line to completion block below
    [self gotoFilterWithImage:image];
    
    // it finishes the dismiss animation, then runs the gotoFilterWithImage push method
    // the completion block just stays frozen until it is come acrossed
    [picker dismissViewControllerAnimated:YES completion:^{
        
//        [self gotoFilterWithImage:image];
        
    }];
    
}

- (void)gotoFilterWithImage:(UIImage *)image {
    // push filter view controller
    
    FilterViewController * filterVC = [self.storyboard instantiateViewControllerWithIdentifier:@"filterVC"];
    
    filterVC.originalImage = image;
    
    // .filterImageView is no accessible because it is not in the .h
//    filterVC.filterImageView;
    
    [self.navigationController pushViewController:filterVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//    self.pickerController = [[UIImagePickerController alloc] init];

// sourceType changes their functionality
// show us the photo library or the live camera view (UIImagePickerControllerSourceTypeCamera)
// photo library is the default type
//    self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

// since this is a controller, we're adding the pickerController's view
//    [self.view addSubview:self.pickerController.view];