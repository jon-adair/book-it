//
//  MoonViewController.h
//  lune
//
//  Created by Jon Adair on 4/23/16.
//  Copyright © 2016 Thinkamingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import<CoreLocation/CoreLocation.h>

@interface MoonViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) ViewController *vcMain;
@property (weak, nonatomic) IBOutlet UIButton *btnPhase;
@property (weak, nonatomic) IBOutlet UIImageView *imgDish;
@property (weak, nonatomic) IBOutlet UILabel *lblMoonData;
@property (weak, nonatomic) IBOutlet UIImageView *imgUp;
@property (weak, nonatomic) IBOutlet UIImageView *imgLeft;
@property (weak, nonatomic) IBOutlet UIImageView *imgDown;
@property (weak, nonatomic) IBOutlet UIImageView *imgRight;
@property (weak, nonatomic) IBOutlet UILabel *lblLocating;
@property (weak, nonatomic) IBOutlet UILabel *lblMoon;



@end
