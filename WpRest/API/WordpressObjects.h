//
//  WordpressObjects.h
//  WpRest
//
//  Created by Marco Donati on 08/12/2016.
//  Copyright © 2016 Marco Donati. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface NestedObject : JSONModel
@property (strong, nonatomic) NSString      *rendered;
@end

@interface WPPost : JSONModel
@property (strong, nonatomic) NSNumber      *id;
@property (strong, nonatomic) NestedObject  *content;
@property (strong, nonatomic) NestedObject  *title;
@property (strong, nonatomic) NestedObject  *excerpt;
@property (strong, nonatomic) NSString      *author;
@property (strong, nonatomic) NSArray       *categories;
@property (strong, nonatomic) NSArray       *tags;
@property (strong, nonatomic) NSString      *date;
@property (strong, nonatomic) NSString      *date_gmt;
@end

@interface WPCategory : JSONModel
@property (strong, nonatomic) NSNumber      *id;
@property (strong, nonatomic) NSNumber      *parent;
@property (strong, nonatomic) NSString      *name;
@property (strong, nonatomic) NSString      *slug;
@property (strong, nonatomic) NSString      *link;
@end

@interface WPTag : JSONModel
@property (strong, nonatomic) NSNumber      *id;
@property (strong, nonatomic) NSString      *name;
@property (strong, nonatomic) NSString      *slug;
@property (strong, nonatomic) NSString      *description;
@end
