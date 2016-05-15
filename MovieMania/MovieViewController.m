//
//  MovieViewController.m
//  MovieMania
//
//  Created by Elena Maso Willen on 15/05/2016.
//  Copyright © 2016 Training. All rights reserved.
//

#import "MovieViewController.h"
#import "Movie.h"

@interface MovieViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *plotLabel;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self loadMovieDetails];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadMovieDetails {
    
    NSString *movieTitle = [[NSString alloc] initWithString:self.movieTitleSelected];
    NSString *movieTitleForUrl = [movieTitle stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSLog(@"tile fir url is: %@", movieTitleForUrl);
    
    NSString *apiUrl = [NSString stringWithFormat:@"http://www.omdbapi.com/?t=%@&y=&plot=short&r=json", movieTitleForUrl];

    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *jsonData = [session dataTaskWithURL:[NSURL URLWithString:apiUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *jsonError;
        NSDictionary *movieDetails = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        
        Movie *movie = [[Movie alloc] init];
        movie.title = movieDetails[@"Title"];
        movie.year = movieDetails[@"Year"];
        movie.genre = movieDetails[@"Genre"];
        movie.plot = movieDetails[@"Plot"];
        movie.poster = movieDetails[@"Poster"];


        if (movie.title != nil) {
            self.titleLabel.text = movie.title;
            self.yearLabel.text = movie.year;
            self.genreLabel.text = movie.genre;
            self.plotLabel.text = movie.plot;
        } else {
            
            self.titleLabel.hidden = YES;
            self.yearLabel.hidden = YES;
            self.genreLabel.hidden = YES;
            self.plotLabel.hidden = YES;

            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Title not found, please type again." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view reloadInputViews];
        });
        
    }];

    [jsonData resume];

}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
