//
//  FavoritesTableViewController.m
//  MovieMania
//
//  Created by Elena Maso Willen on 16/05/2016.
//  Copyright © 2016 Training. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "FavoriteCell.h"
#import "MovieViewController.h"
#import "Movie.h"

@interface FavoritesTableViewController ()


@end

@implementation FavoritesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadMovies];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)myFavoriteList {
    if (_myFavoriteList == nil) {
        _myFavoriteList = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _myFavoriteList;
}


#pragma mark - MovieViewController Delegate

- (void)addMovieToFavoriteList:(Movie *)movie {
    
    BOOL found = NO;
    
    for (Movie *findMovie in self.myFavoriteList) {
        if ([findMovie.title isEqualToString: movie.title] ) {
            found = YES;
        }
    }
    
    if (!found) {
        [self.myFavoriteList addObject:movie];
        
        [self saveMovies];
        
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Movie already added to your list" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];

    }

    
    [self.tableView reloadData];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myFavoriteList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FavoriteCell *cell = (FavoriteCell *)[tableView dequeueReusableCellWithIdentifier:@"favoriteCell" forIndexPath:indexPath];
    
    Movie *movie = self.myFavoriteList[indexPath.row];
    
    cell.titleLabelCell.text = movie.title;
    cell.yearLabelCell.text = movie.year;
    cell.genreLabelCell.text = movie.genre;

    
    return cell;
}

#pragma mark - Table View Delegare

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"showMovieSegueFromRow" sender:nil];
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"showMovieSegueFromRow"]) {
        MovieViewController *mvc = (MovieViewController *)[segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Movie *movie = self.myFavoriteList[indexPath.row];

        NSString *movieTitle = movie.title;
        
        mvc.movieTitleSelected = movieTitle;
    }
    
}

#pragma mark - loading and saving
-(NSURL *)applicationDocumentDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void)saveMovies {

    NSString *path = [[self applicationDocumentDirectory].path stringByAppendingPathComponent:@"MovieList"];
    NSData *movieData = [NSKeyedArchiver archivedDataWithRootObject:self.myFavoriteList];
    
    [movieData writeToFile:path atomically:YES];
    
}

-(void)loadMovies {
   
    NSString *path = [[self applicationDocumentDirectory].path stringByAppendingPathComponent:@"MovieList"];
    NSData *movieData = [NSData dataWithContentsOfFile:path];
    
    self.myFavoriteList = [NSKeyedUnarchiver unarchiveObjectWithData:movieData];
    [self.tableView reloadData];
    
}






@end
