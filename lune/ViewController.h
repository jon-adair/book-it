//
//  ViewController.h
//  lune
//
//  Created by Jon Adair on 4/23/16.
//  Copyright © 2016 Thinkamingo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnMoon;
@property (weak, nonatomic) IBOutlet UIButton *btnBook;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *btnData;
@property (weak, nonatomic) IBOutlet UIButton *btnPictures;
@property (weak, nonatomic) IBOutlet UIButton *btnVideos;
@property (weak, nonatomic) IBOutlet UIButton *btnPortrait;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorites;
@property (weak, nonatomic) IBOutlet UIButton *btnSettings;

- (void) didSelectStory:(int) storyId;
- (void) didSelectVideo:(int) videoId;
- (void) didSelectContent:(int) contentId withContentType:(NSString *)contentType;
- (void) didFavoriteContent:(int) contentId withContentType:(NSString *) contentType;
- (BOOL) isFavoriteContent:(int) contentId withContentType:(NSString *) contentType;
- (void) didUnFavoriteContent:(int) contentId withContentType:(NSString *) contentType;

@property NSMutableArray *favorites;

@end

