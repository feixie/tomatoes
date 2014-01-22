//
//  MovieViewController.m
//  tomatoes
//
//  Created by fxie on 1/21/14.
//  Copyright (c) 2014 fxie. All rights reserved.
//

#import "MovieViewController.h"

@interface MovieViewController ()

@end

@implementation MovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.synopsisLabel.text = self.movie.synopsis;
    self.castLabel.text = self.movie.cast;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
