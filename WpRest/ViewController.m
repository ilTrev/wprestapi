//
//  ViewController.m
//  WpRest
//
//  Created by Marco Donati on 08/12/2016.
//  Copyright © 2016 Marco Donati. All rights reserved.
//

#import "ViewController.h"
#import "WpRestObject.h"
#import "WordpressObjects.h"

@interface ViewController() <WpRestObjectDelegate, UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView.delegate = self;
    
    WpRestObject *wpRestObject = [WpRestObject new];
    wpRestObject.delegate = self;
    wpRestObject.baseURL = @"http://www.iltrev.it";
    
//    [wpRestObject getPostWithId:@"752"];
//    [wpRestObject getAllPosts];
//    [wpRestObject getAllCategories];
//    [wpRestObject getCategoryWithId:@"2"];
//    [wpRestObject getLastPost];
    [wpRestObject getAllTags];
}

#pragma mark - UIWebView Delegate Methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // All links are opened in an external Safari session
    if (navigationType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:request.URL options:@{} completionHandler:^(BOOL success) {}];
        return NO;
    }
    return YES;
}

#pragma mark - WpRestObject Delegate Methods

-(void)didReceivePostsArray:(NSArray *)posts
{
    NSLog(@"%@", posts);
}

-(void)didReceivePost:(WPPost *)post
{
    self.titleLabel.text = post.title.rendered;
    [self.webView loadHTMLString:post.content.rendered baseURL:nil];
}

-(void)didReceiveCategoriesArray:(NSArray *)categories
{
    NSLog(@"%@", categories);
}

-(void)didReceiveCategory:(WPCategory *)category
{
    NSLog(@"%@", category);
}

-(void)didReceiveTagsArray:(NSArray *)tags
{
    NSLog(@"%@", tags);
}

@end
