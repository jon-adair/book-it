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
    
    // TODO: needs to persist
    _favorites = [[NSMutableArray alloc] init];

    
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
    [vcStoryPicker setContentMode:@"story"];
    UIViewController *vc = vcStoryPicker;
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView addSubview:vc.view];
    [vc didMoveToParentViewController:self];

}

- (IBAction)clickChart:(id)sender {
}

- (IBAction)clickPictures:(id)sender {
    [vcStoryPicker setContentMode:@"image"];
    UIViewController *vc = vcStoryPicker;
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView addSubview:vc.view];
    [vc didMoveToParentViewController:self];
}

- (IBAction)clickVideos:(id)sender {
    [vcStoryPicker setContentMode:@"video"];
    UIViewController *vc = vcStoryPicker;
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView addSubview:vc.view];
    [vc didMoveToParentViewController:self];
}

- (IBAction)clickPortrait:(id)sender {
}

- (IBAction)clickFavorites:(id)sender {
}

- (IBAction)clickSettings:(id)sender {
    
    NSString *filePath;
    
    filePath = [[NSBundle mainBundle] pathForResource:@"credits" ofType:@"html"];
    
    [vcStory setContent:filePath];
    
    UIViewController *vc = vcStory;
    
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView addSubview:vc.view];
    [vc didMoveToParentViewController:self];

}


- (BOOL) isFavoriteContent:(int) contentId withContentType:(NSString *) contentType {
    for ( id item in _favorites ) {
        if ( [[(NSDictionary *)item objectForKey:@"type"] isEqualToString:contentType] &&
            [[(NSDictionary *)item objectForKey:@"id"] intValue] == contentId ) {
            return YES;
        }
    }
    return NO;
}

- (void) didUnFavoriteContent:(int) contentId withContentType:(NSString *) contentType {
    for ( id item in _favorites ) {
        if ( [[(NSDictionary *)item objectForKey:@"type"] isEqualToString:contentType] &&
             [[(NSDictionary *)item objectForKey:@"id"] intValue] == contentId ) {
            [_favorites removeObject:item];
            break;
        }
    }
}

- (void) didFavoriteContent:(int) contentId withContentType:(NSString *) contentType
{
    if ( ! [self isFavoriteContent:contentId withContentType:contentType] ) {
        [_favorites addObject:[[NSDictionary alloc] initWithObjectsAndKeys:@"type", contentType, @"id", contentId, nil]];
    }
}

- (void) didSelectStory:(int) storyId {
    NSString *filePath;
    
    switch ( storyId ) {
        case 0:
            filePath = [[NSBundle mainBundle] pathForResource:@"story-armstrong" ofType:@"html"];
            break;
        case 1:
            filePath = [[NSBundle mainBundle] pathForResource:@"story-fun-facts" ofType:@"html"];
            break;
        case 2:
            filePath = [[NSBundle mainBundle] pathForResource:@"story-folk-tale" ofType:@"html"];
            break;
        case 3:
            filePath = [[NSBundle mainBundle] pathForResource:@"story-poem-01" ofType:@"html"];
            break;
        case 4:
            filePath = [[NSBundle mainBundle] pathForResource:@"story-poem-02" ofType:@"html"];
            break;
        case 5:
            filePath = [[NSBundle mainBundle] pathForResource:@"story-poem-03" ofType:@"html"];
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

- (void) didSelectVideo:(int) videoId {
    NSString *filePath;
    
    NSString *name = [NSString stringWithFormat:@"video-%02d", videoId+1];
    filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"html"];

    [vcStory setContent:filePath];
    
    
    UIViewController *vc = vcStory;
    
    [self addChildViewController:vc];
    vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    
}

- (void) didSelectContent:(int) contentId withContentType:(NSString *)contentType {
    NSString *filePath;
    
    if ( [contentType isEqualToString:@"image"] ) {
        NSString *name = [NSString stringWithFormat:@"image-%02d", contentId+1];
        filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"html"];
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
