//
//  OGUtility.h
//  Hacker News
//
//  Created by Thomas Denney on 30/08/2013.
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <gumbo.h>

NS_ASSUME_NONNULL_BEGIN

@interface OGUtility : NSObject

+ (instancetype)sharedInstance;

+ (NSString *)tagForGumboTag:(GumboTag)tag;
+ (GumboTag)gumboTagForTag:(NSString *)tag;

- (NSString *)tagForGumboTag:(GumboTag)gumboTag;
- (GumboTag)gumboTagForTag:(NSString *)tag;

@end

NS_ASSUME_NONNULL_END
