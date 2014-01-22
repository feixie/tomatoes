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
#import "UIImageView+AFNetworking.h"

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
	
    // Hide network error label
    [self.networkErrorLabel setHidden:TRUE];
    
    // Set up pull to refresh
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refresh;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    Movie *movie = [self.movies objectAtIndex:indexPath.row];

    cell.movieTitleLabel.text = movie.title;
    cell.synopsisLabel.text = movie.synopsis;
    cell.castLabel.text = movie.cast;
    
    NSString *imageUrl = movie.posterUrl;
    
    [cell.posterImage setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder-avatar"]];
    
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

-(void)refreshView: (UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing movie list..."];
    
    [self reload];
    [refresh endRefreshing];
}

- (void)reload {
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSInteger responseCode = [(NSHTTPURLResponse *)response statusCode];
        if (!connectionError && responseCode == 200){
            // all is good, hide network error
            [self.networkErrorLabel setHidden:TRUE];
            
            // load the data
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            //create a movie class, instantiate with dictionary, nsmutable array of movies
            NSArray *movies = [object objectForKey:@"movies"];
            
            self.movies = [[NSMutableArray alloc] init];
            
            for (id movieDictionary in movies) {
                Movie *movie = [[Movie alloc] initWithDictionary:movieDictionary];
                [self.movies addObject:movie];
            }
            
            NSLog(@"%@", object);
            [self.tableView reloadData];
        }
        else{
            // unhide network error label
            [self.networkErrorLabel setHidden:FALSE];
            
            //show error message
            NSLog(@"connectionError=%@", connectionError);
            NSLog(@"responseCode=%d", responseCode);
        }
        
    }];
}

@end
