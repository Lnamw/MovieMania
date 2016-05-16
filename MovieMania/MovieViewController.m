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

@property (nonatomic, strong) Movie *movieSelected;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *plotLabel;
@property (weak, nonatomic) IBOutlet UILabel *buttonChangeLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonLabel;


- (IBAction)addToFavorites:(id)sender;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadMovieDetails];
    
    self.buttonChangeLabel.hidden = YES;
    
//    if (self.myFavoriteList == nil) {
//        self.myFavoriteList = [[NSMutableArray alloc] initWithCapacity:0];
//    }
    
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
        
        self.movieSelected = [[Movie alloc] init];
        self.movieSelected.title = movieDetails[@"Title"];
        self.movieSelected.year = movieDetails[@"Year"];
        self.movieSelected.genre = movieDetails[@"Genre"];
        self.movieSelected.plot = movieDetails[@"Plot"];
        self.movieSelected.poster = movieDetails[@"Poster"];


        if (self.movieSelected.title != nil) {
            self.titleLabel.text = self.movieSelected.title;
            self.yearLabel.text = self.movieSelected.year;
            self.genreLabel.text = self.movieSelected.genre;
            self.plotLabel.text = self.movieSelected.plot;
            
            
            NSURLSessionDownloadTask *getPosterTask = [session downloadTaskWithURL:[NSURL URLWithString:self.movieSelected.poster] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                UIImage *downloadedPoster = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.imageView.image = downloadedPoster;
                });
            }];
            
            [getPosterTask resume];
            
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

- (IBAction)addToFavorites:(id)sender {
    
    [self.delegate addMovieToFavoriteList:self.movieSelected];
    self.buttonLabel.hidden = YES;
    self.buttonChangeLabel.hidden = NO;
    self.buttonChangeLabel.text = @"Movie added to favorites.";

    
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
