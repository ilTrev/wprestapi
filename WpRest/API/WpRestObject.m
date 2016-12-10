//
//  WpRestObject.m
//  WpRest
//
//  Created by Marco Donati on 08/12/2016.
//  Copyright © 2016 Marco Donati. All rights reserved.
//

typedef enum {
    kOperationTypeGetAllTags,
    kOperationTypeGetSingleTag,
    kOperationTypeGetAllCategories,
    kOperationTypeGetSingleCategory,
    kOperationTypeGetMorePosts,
    kOperationTypeGetSinglePost
}kOperationType;

#import "WpRestObject.h"
#import <AFNetworking.h>
#import <JSONModel/JSONModel.h>

@implementation WpRestObject

-(void)getAllTags
{
    [self performOperationWithPath:@"tags" andIdentifier:kOperationTypeGetAllTags];
}

-(void)getAllCategories
{
    [self performOperationWithPath:@"categories" andIdentifier:kOperationTypeGetAllCategories];
}

-(void) getCategoryWithId:(NSString *)categoryId
{
    [self performOperationWithPath:[NSString stringWithFormat:@"categories/%@", categoryId] andIdentifier:kOperationTypeGetSingleCategory];
}

-(void) getAllPosts
{
    [self performOperationWithPath:@"posts" andIdentifier:kOperationTypeGetMorePosts];
}

-(void) getPostWithId:(NSString *)postId
{
    [self performOperationWithPath:[NSString stringWithFormat:@"posts/%@", postId] andIdentifier:kOperationTypeGetSinglePost];
}

-(void) getLastPost
{
    [self performOperationWithPath:@"posts?per_page=1" andIdentifier:kOperationTypeGetMorePosts];
}

#pragma mark - Network stuff

-(void)performOperationWithPath:(NSString *)path andIdentifier:(kOperationType)operationId
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/wp-json/wp/v2/%@", self.baseURL, path]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.userInfo = @{@"operationId": [NSNumber numberWithInt:operationId]};
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self didendNetworkOperation:operation result:responseObject error:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [operation start];
}

-(void)didendNetworkOperation:(AFHTTPRequestOperation *)operation result:(NSDictionary *)result error:(NSError *)error
{
    switch ([[operation.userInfo valueForKey:@"operationId"] intValue]) {

        case kOperationTypeGetAllCategories:
            if ([self.delegate respondsToSelector:@selector(didReceiveCategoriesArray:)]) {
                [self.delegate didReceiveCategoriesArray:[WPCategory arrayOfModelsFromDictionaries:(NSArray *)result error:&error]];
            }
            break;
            
        case kOperationTypeGetSingleCategory:
            if ([self.delegate respondsToSelector:@selector(didReceiveCategory:)]) {
                [self.delegate didReceiveCategory:[[WPCategory alloc] initWithDictionary:result error:nil]];
            }
            break;
            
        case kOperationTypeGetAllTags:
            if ([self.delegate respondsToSelector:@selector(didReceiveTagsArray:)]) {
                [self.delegate didReceiveTagsArray:[WPTag arrayOfModelsFromDictionaries:(NSArray *)result error:&error]];
            }
            break;
            
        case kOperationTypeGetMorePosts:
            if ([self.delegate respondsToSelector:@selector(didReceivePostsArray:)]) {
                [self.delegate didReceivePostsArray:[WPPost arrayOfModelsFromDictionaries:(NSArray *)result error:&error]];
            }
            break;
            
        case kOperationTypeGetSinglePost:
            if ([self.delegate respondsToSelector:@selector(didReceivePost:)]) {
                [self.delegate didReceivePost:[[WPPost alloc] initWithDictionary:result error:nil]];
            }
            break;
            
        default:
            break;
    }
}

@end
