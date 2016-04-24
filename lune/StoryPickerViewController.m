//
//  StoryPickerViewController.m
//  lune
//
//  Created by Jon Adair on 4/23/16.
//  Copyright © 2016 Thinkamingo. All rights reserved.
//

#import "StoryPickerViewController.h"

@interface StoryPickerViewController ()

@end

@implementation StoryPickerViewController {
    NSString *_contentMode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableView.backgroundColor = [UIColor blackColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setContentMode:(NSString *) contentMode {
    _contentMode = contentMode;
    [_tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ( [_contentMode isEqualToString:@"story"] ) {
        return 3;
    } else if ( [_contentMode isEqualToString:@"video"] ) {
        return 5;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"picker"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"picker"];
    }
    
    NSString *label;
    
    if ( [_contentMode isEqualToString:@"story"] ) {
        switch ( indexPath.row ) {
            case 0:
                label = @"Neil Armstrong";
                break;
            case 1:
                label = @"What the Moon Sees";
                break;
            case 2:
                label = @"The Moon Through the Years";
                break;
                
            default:
                label = @"Story";
                break;
        }
        cell.imageView.image = [UIImage imageNamed:@"icon-book"];
    } else if ( [_contentMode isEqualToString:@"video"] ) {
        switch ( indexPath.row ) {
            case 0:
                label = @"LRO Moon";
                break;
            case 1:
                label = @"A View From The Other Side"; // jdkMHkF7BaA
                break;
            case 2:
                label = @"The Moon Through the Years";
                break;
                
            default:
                label = @"Video";
                break;
                
        }
        cell.imageView.image = [UIImage imageNamed:@"icon-video"];
    }
    
    cell.textLabel.text = label;
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( [_contentMode isEqualToString:@"story"] ) {
        [_vcMain didSelectStory:indexPath.row];
    } else if ( [_contentMode isEqualToString:@"video"] ) {
        [_vcMain didSelectVideo:indexPath.row];
    }
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
