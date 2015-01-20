//
//  ViewController.m
//  Capture
//
//  Created by Bobby Towers on 1/20/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//

#import "ViewController.h"
#import "FilterViewController.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic) UIImagePickerController * cameraPickerController;
@property (nonatomic) UIImagePickerController * libraryPickerController;

@property (weak, nonatomic) IBOutlet UIButton *openPhotoLibraryButton;
@property (weak, nonatomic) IBOutlet UIButton *takeMediaButton;

@property (weak, nonatomic) IBOutlet UIView *cameraView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.openPhotoLibraryButton addTarget:self action:@selector(openPhotoLibrary) forControlEvents:UIControlEventTouchUpInside];

    self.cameraPickerController = [[UIImagePickerController alloc] init];
    self.cameraPickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.cameraPickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    self.cameraPickerController.showsCameraControls = NO;
    self.cameraPickerController.delegate = self;
    
    // gets the width and height from the origin 0,0
    // a better name for cameraView would be cameraHolderView
    self.cameraPickerController.view.frame = self.cameraView.bounds;
    
    [self.cameraView addSubview:self.cameraPickerController.view];
    
    
//    [self.takeMediaButton addTarget:self action:@selector(takeMedia) forControlEvents:UIControlEventTouchUpInside];
    // (takePicture) showed up because it is a method on UIImagePickerController when we changed our target from self to self.cameraPickerController
    [self.takeMediaButton addTarget:self.cameraPickerController action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    
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