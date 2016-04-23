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



@end
