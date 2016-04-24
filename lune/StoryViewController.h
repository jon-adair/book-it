//
//  StoryViewController.h
//  lune
//
//  Created by Jon Adair on 4/23/16.
//  Copyright © 2016 Thinkamingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface StoryViewController : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) ViewController *vcMain;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;

- (void) setContent:(NSString *)url;

@end
