//
//  Movie.h
//  tomatoes
//
//  Created by fxie on 1/21/14.
//  Copyright (c) 2014 fxie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSString *cast;

- (id)initWithDictionary: (NSDictionary *)dictionary;


@end
