//
//  MovieViewController.h
//  tomatoes
//
//  Created by fxie on 1/21/14.
//  Copyright (c) 2014 fxie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView * posterImage;
@property (nonatomic, weak) IBOutlet UILabel * synopsisLabel;
@property (nonatomic, weak) IBOutlet UILabel * castLabel;
@property (nonatomic, strong) Movie *movie;

@end
