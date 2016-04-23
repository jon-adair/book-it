//
//  ViewController.m
//  lune
//
//  Created by Jon Adair on 4/23/16.
//  Copyright © 2016 Thinkamingo. All rights reserved.
//

#import "ViewController.h"
#import "MoonViewController.h"
#import "StoryPickerViewController.h"
#import "StoryViewController.h"

@interface ViewController () {
}

@end

@implementation ViewController {
    UITableView *storyPicker;
    MoonViewController *vcMoon;
    StoryPickerViewController *vcStoryPicker;
    StoryViewController *vcStory;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    vcMoon = [[MoonViewController alloc] initWithNibName:nil bundle:nil];
    vcMoon.vcMain = self;
    vcStoryPicker = [[StoryPickerViewController alloc] initWithNibName:nil bundle:nil];
    vcStoryPicker.vcMain = self;
    vcStory = [[StoryViewController alloc] initWithNibName:nil bundle:nil];
    vcStory.vcMain = self;
    
    UIViewController *vc = vcMoon;
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    

    
}

- (void)viewWillAppear:(BOOL)animated {
}

- (IBAction)clickMoon:(id)sender {

    UIViewController *vc = vcMoon;
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    
}

- (IBAction)clickBook:(id)sender {
    UIViewController *vc = vcStoryPicker;
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView addSubview:vc.view];
    [vc didMoveToParentViewController:self];

}

- (IBAction)clickChart:(id)sender {
}

- (IBAction)clickPictures:(id)sender {
}

- (IBAction)clickVideos:(id)sender {
}

- (IBAction)clickPortrait:(id)sender {
}

- (IBAction)clickFavorites:(id)sender {
}

- (IBAction)clickSettings:(id)sender {
}


- (void) didSelectStory:(int) storyId {
    NSString *filePath;
    
    switch ( storyId ) {
        case 0:
            filePath = [[NSBundle mainBundle] pathForResource:@"story-armstrong" ofType:@"html"];
            break;
        default:
            filePath = [[NSBundle mainBundle] pathForResource:@"blank" ofType:@"html"];
            break;
    }
    
    [vcStory setContent:filePath];
    
    
    UIViewController *vc = vcStory;
    
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
