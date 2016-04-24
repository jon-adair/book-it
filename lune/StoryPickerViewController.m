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
        return 6;
    } else if ( [_contentMode isEqualToString:@"video"] ) {
        return 8;
    } else if ( [_contentMode isEqualToString:@"image"] ) {
        return 10;
    } else if ( [_contentMode isEqualToString:@"favorite"] ) {
        return _vcMain.favorites.count;
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
                label = @"Fun Facts About the Moon";
                break;
            case 2:
                label = @"How the Moon Was Created (Indian Folk Tale)";
                break;
            case 3:
                label = @"The Moon - Robert Lewis Stevenson (Poem)";
                break;
            case 4:
                label = @"The Freedom of The Moon - Robert Frost (Poem)";
                break;
            case 5:
                label = @"Child Moon - Carl Sandburg (Poem)";
                break;
                
            default:
                label = @"Story";
                break;
        }
        cell.imageView.image = [UIImage imageNamed:@"icon-book"];
    } else if ( [_contentMode isEqualToString:@"video"] ) {
        switch ( indexPath.row ) {
            case 0:
                label = @"Apollo 8 - 1968 NASA/USA";
                break;
            case 1:
                label = @"Apollo 11 - 1969 NASA/USA";
                break;
            case 2:
                label = @"Apollo 17 - 1972 NASA/USA";
                break;
            case 3:
                label = @"Formation of the Moon";
                break;
            case 4:
                label = @"How the Moon Affects Earth";
                break;
            case 5:
                label = @"Returning to the Moon";
                break;
            case 6:
                label = @"Moon, Mars, and Beyond";
                break;
            case 7:
                label = @"LRO - Tour of the Moon";
                break;
                
            default:
                label = @"Video";
                break;
                
        }
        cell.imageView.image = [UIImage imageNamed:@"icon-video"];
    } else if ( [_contentMode isEqualToString:@"image"] ) {
        switch ( indexPath.row ) {
            case 0:
                label = @"Luna 1-3 - 1959 OKB-1/USSR";
                break;
            case 1:
                label = @"Ranger 7-9 - 1964-65 NASA/USA";
                break;
            case 2:
                label = @"Luna 9-10 - 1966 Molyniya-M/USSR";
                break;
            case 3:
                label = @"Apollo 8 - 1968 NASA/USA";
                break;
            case 4:
                label = @"Apollo 11 - 1969 NASA/USA";
                break;
            case 5:
                label = @"Apollo 17 - 1972 NASA/USA";
                break;
            case 6:
                label = @"SMART-1 - 2003 ESA/Europe";
                break;
            case 7:
                label = @"Chang'e 1 - 2007 CNSA/China";
                break;
            case 8:
                label = @"Moon Impact Probe - 2008 ISRO/India";
                break;
            case 9:
                label = @"4M - 2014 LuxSpace/Luxembourg";
                break;
                
            default:
                label = @"Video";
                break;
                
        }
//        NSString *name = [NSString stringWithFormat:@"image-%02d.jpg", indexPath.row+1];
//        cell.imageView.image = [UIImage imageNamed:name];
        cell.imageView.image = [UIImage imageNamed:@"icon-images"];

    }

    cell.textLabel.text = label;
    cell.detailTextLabel.text = @"detail here";
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
    } else if ( [_contentMode isEqualToString:@"image"] ) {
        [_vcMain didSelectContent:indexPath.row withContentType:_contentMode];
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
