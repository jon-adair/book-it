//
//  StoryViewController.m
//  lune
//
//  Created by Jon Adair on 4/23/16.
//  Copyright © 2016 Thinkamingo. All rights reserved.
//

#import "StoryViewController.h"
#import "ViewController.h"

@interface StoryViewController ()

@end

@implementation StoryViewController {
    NSString *_url;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_webView setOpaque:NO];
    _webView.backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    
}

- (IBAction)clickFavorite:(id)sender {
    
}

- (IBAction)clickShare:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] init];
    sheet.title = @"Share";
    [sheet addButtonWithTitle:@"Facebook"];
    [sheet addButtonWithTitle:@"Email"];
    
    [sheet showFromRect:_btnShare.frame inView:self.view animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setContent:(NSString *)url {
    _url = url;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
//    [_webView reload];
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
