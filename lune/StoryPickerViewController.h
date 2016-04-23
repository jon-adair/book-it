//
//  StoryPickerViewController.h
//  lune
//
//  Created by Jon Adair on 4/23/16.
//  Copyright © 2016 Thinkamingo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ViewController.h"


@interface StoryPickerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) ViewController *vcMain;

@end
