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
        return 3;
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
                label = @"1968 NASA/USA";
                break;
            case 1:
                label = @"1969 NASA/USA"; 
                break;
            case 2:
                label = @"1972 NASA/USA";
                break;
                
            default:
                label = @"Video";
                break;
                
        }
        cell.imageView.image = [UIImage imageNamed:@"icon-video"];
    } else if ( [_contentMode isEqualToString:@"image"] ) {
        switch ( indexPath.row ) {
            case 0:
                label = @"1959 OKB-1/USSR";
                break;
            case 1:
                label = @"1964-65 NASA/USA";
                break;
            case 2:
                label = @"1966 Molyniya-M/USSR";
                break;
            case 3:
                label = @"1968 NASA/USA";
                break;
            case 4:
                label = @"1969 NASA/USA";
                break;
            case 5:
                label = @"1972 NASA/USA";
                break;
            case 6:
                label = @"2003 ESA/Europe";
                break;
            case 7:
                label = @"2007 CNSA/China";
                break;
            case 8:
                label = @"2008 ISRO/India";
                break;
            case 9:
                label = @"2014 LuxSpace/Luxembourg";
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
