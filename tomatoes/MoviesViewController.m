//
//  MoviesViewController.m
//  tomatoes
//
//  Created by fxie on 1/21/14.
//  Copyright (c) 2014 fxie. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieViewController.h"
#import "MovieCell.h"
#import "Movie.h"

@interface MoviesViewController ()

@property (nonatomic, strong) NSMutableArray *movies;


- (void)reload;

@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self reload];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self reload];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%lu", (unsigned long)self.movies.count);
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    Movie *movie = [self.movies objectAtIndex:indexPath.row];
    NSLog(@"in table view");

    NSLog(@"%@", movie.title);
    cell.movieTitleLabel.text = movie.title;
    cell.synopsisLabel.text = movie.synopsis;
    cell.castLabel.text = movie.cast;
    

    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *selectedCell = (UITableViewCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
    Movie *movie = self.movies[indexPath.row];
    
    MovieViewController *movieViewController = (MovieViewController *)segue.destinationViewController;
    movieViewController.movie = movie;
}

#pragma mark - Private methods

- (void)reload {
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        //create a movie class, instantiate with dictionary, nsmutable array of movies
        NSArray *movies = [object objectForKey:@"movies"];
        
        self.movies = [[NSMutableArray alloc] init];
        
        for (id movieDictionary in movies) {
            Movie *movie = [[Movie alloc] initWithDictionary:movieDictionary];
            [self.movies addObject:movie];
        }
        
        NSLog(@"%@", object);

        //NSLog(@"movies: %@", self.movies);
        [self.tableView reloadData];
        
    }];
}

@end