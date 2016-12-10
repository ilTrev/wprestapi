//
//  WpRestObject.h
//  WpRest
//
//  Created by Marco Donati on 08/12/2016.
//  Copyright © 2016 Marco Donati. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WordpressObjects.h"

@protocol WpRestObjectDelegate <NSObject>

@optional

/**
 Called when getAllPosts method ends with success

 @param posts The array containing all the site's posts
 */
-(void) didReceivePostsArray:(NSArray *)posts;

/**
 Called when getPostWithId method ends with success
 
 @param post The post item
 */
-(void) didReceivePost:(WPPost *)post;

/**
 Called when getAllCategories method ends with success

 @param categories The array containing all the site's categories
 */
-(void) didReceiveCategoriesArray:(NSArray *)categories;

/**
 Called when getCategoryWithId method ends with success
 
 @param category The category item
 */
-(void) didReceiveCategory:(WPCategory *)category;

/**
 Called when getAllTags method ends with success
 
 @param categories The array containing all the site's tags
 */
-(void) didReceiveTagsArray:(NSArray *)tags;

@end


@interface WpRestObject : NSObject

/**
 Must be set as the object that will execute the delegate methods
 */
@property (weak, nonatomic) id          delegate;

/**
 The base URL of the WordPress site. Must be set before any operation
 */
@property (strong, nonatomic) NSString *baseURL;

/**
 Retrieves all posts from the blog at the base URL
 */
-(void) getAllPosts;

/**
 Retrieves a specific post
 
 @param categoryId The unique identifier of the category to be retrieved
 */
-(void) getCategoryWithId:(NSString *)categoryId;

/**
 Retrieves a specific post

 @param postId The unique identifier of the post to be retrieved
 */
-(void) getPostWithId:(NSString *)postId;

/**
 Retrieves the most recent post
 */
-(void) getLastPost;

/**
 Retrieves the list of the site's categories
 */
-(void) getAllCategories;

/**
 Retrieves all tags from the blog at the base URL
 */
-(void) getAllTags;

@end
