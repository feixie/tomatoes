//
//  Movie.m
//  tomatoes
//
//  Created by fxie on 1/21/14.
//  Copyright (c) 2014 fxie. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary: (NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        self.synopsis = dictionary[@"synopsis"];
        self.cast = [self cast:dictionary[@"abridged_cast"]];
        
        NSDictionary *posterDictionary = dictionary[@"posters" ];
        self.posterUrl = [posterDictionary objectForKey:@"original"];
    }
    
    return self;
}

- (NSString *) cast: (NSArray *)abridgedCast {

    NSMutableString *completeCast =[NSMutableString string];
    for (NSDictionary *wholeCast in abridgedCast) {
        
        [completeCast appendString:[wholeCast objectForKey:@"name"]];
        [completeCast appendString:@" "];
        
    }
    //NSLog(@"cast is %@", completeCast);
    return completeCast;
}

@end
