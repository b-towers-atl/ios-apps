//
//  FilterViewController.m
//  Capture
//
//  Created by Bobby Towers on 1/20/15.
//  Copyright (c) 2015 Bobby Towers. All rights reserved.
//


// Add segment control for choosing front or rear camera
    // Add target method that changes the camera device

// Add methods to allow for video capture and stopping

// Add a UICollectionView to filterVC (storyboard) at the bottom
    // take inspiration from instagram filter scroller (1 row of square filters)

// Extra: find out how to flip camera view when changing between front and rear

#import "FilterViewController.h"
#import "FilterCell.h"
#import "SlickSlider.h"

@interface FilterViewController () <UICollectionViewDataSource, UICollectionViewDelegate, SlickSliderDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *filterImageView;

@property (weak, nonatomic) IBOutlet UICollectionView *filterCollectionView;

@property (weak, nonatomic) IBOutlet SlickSlider *slider1;

@property (nonatomic) NSArray *filters;

@end

@implementation FilterViewController

- (void)setOriginalImage:(UIImage *)originalImage {
    
    // test code to see if filter image view is null
    NSLog(@"filter image view %@", self.filterImageView);
    
    self.filterImageView.image = originalImage;
    
    _originalImage = originalImage;
    
}

- (void)sliderDidFinishUpdatingWithValue:(float)value {
    
    NSLog(@"slider is %f", value);
    
}

- (UIImage *)resizeImage:(UIImage *)originalImage withSize:(CGSize)size {
    
    float scale = (originalImage.size.height > originalImage.size.width) ? size.width / originalImage.size.width : size.height / originalImage.size.height;
    
    
    CGSize ratioSize = CGSizeMake(originalImage.size.width * scale, originalImage.size.height * scale);

    UIGraphicsBeginImageContextWithOptions(ratioSize, NO, 0.0);
    
    [originalImage drawInRect:CGRectMake(0, 0, ratioSize.width, ratioSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

- (UIImage *)filterImage:(UIImage *)originalImage withFilterName:(NSString *)filterName {
    
    // this creates our "workbench"
    // context is just used later on in this method to convert CIImage to CGImage
    CIContext * context = [CIContext contextWithOptions:nil];
    
    // this turns UI Image into CI Image
//    CIImage * inputImage = originalImage.CIImage;
    CIImage * inputImage = [[CIImage alloc] initWithCGImage:originalImage.CGImage];
    
    // testing NSLog for inputImage if null
//    NSLog(@"%@", inputImage);
    
    CIFilter * filter = [CIFilter filterWithName:filterName];
    
    // it uses the image and its key to be used by the filter
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    
    // this makes it super mega pixelated
//    [filter setValue:@80 forKey:kCIInputScaleKey];
    
    
    
    // the output of the filter
    // CI is core image
    CIImage * result = [filter valueForKey:kCIOutputImageKey];
    
    // get the rect of the size of the image from the result
    CGRect rect = [result extent];
    
    // CI -> CG is core grpahics
    CGImageRef cgImage = [context createCGImage:result fromRect:rect];
    
    return [UIImage imageWithCGImage:cgImage scale:originalImage.scale orientation:originalImage.imageOrientation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.filters = [CIFilter filterNamesInCategory:kCICategoryColorEffect];
    
    NSLog(@"%@", self.filters);
    
    
    self.filterCollectionView.delegate = self;
    self.filterCollectionView.dataSource = self;
    
    
//    self.filterImageView.image = self.originalImage;
    
    // testing our filter image
    self.filterImageView.image = [self filterImage:self.originalImage withFilterName:self.filters[0]];
    
    self.slider1.delegate = self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.filters.count;
    
}

// this is a delegate method to return a UICollectionViewCell
// we click the cell and it will change the filter on the image
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // when working with CollectionView, it's items
    // when working with TableView, it's rows
    
    // changed UICollectionViewCell *cell to FilterCell *cell
    FilterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"filterCell" forIndexPath:indexPath];

    
    NSString * filterName = self.filters[indexPath.item];
    
    // get side thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        // this will run VERY slowly because UIKit shouldn't run in side threads
        
        
        UIImage * resizedImage = [self resizeImage:self.originalImage withSize:cell.imageView.frame.size];
        
        // anything in this block will run in the side thread (because we used dispatch)
        UIImage * filterImage = [self filterImage:resizedImage withFilterName:filterName];
        
        // get main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.imageView.image = filterImage;
            
        });
        
        
    });
    
    // move this into the side thread
//    UIImage * filterImage = [self filterImage:self.originalImage withFilterName:filterName];
    
    // test log
    NSLog(@"%@", filterName);
    
    // move this into the side thread too
//    cell.imageView.image = filterImage;
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * filterName = self.filters[indexPath.item];
    
    UIImage * resizedImage = [self resizeImage:self.originalImage withSize:self.filterImageView.frame.size];
    
    UIImage * filterImage = [self filterImage:resizedImage withFilterName:filterName];
    
    self.filterImageView.image = filterImage;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
