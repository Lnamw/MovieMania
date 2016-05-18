//
//  SearchViewController.m
//  MovieMania
//
//  Created by Elena Maso Willen on 15/05/2016.
//  Copyright © 2016 Training. All rights reserved.
//

#import "SearchViewController.h"
#import "MovieViewController.h"
#import "FavoritesTableViewController.h"

@interface SearchViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.searchTextField resignFirstResponder];
    return YES;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"showMovieSegue"]) {
        MovieViewController *mvc = (MovieViewController *)[segue destinationViewController];
        
        NSString *movieTitle = self.searchTextField.text;
        
        mvc.movieTitleSelected = movieTitle;
        
        for (UINavigationController *nc in self.tabBarController.viewControllers) {
            if ([nc isKindOfClass:[UINavigationController class]]) {
            
                for (UIViewController *vc in nc.viewControllers) {
                    if ([vc isKindOfClass:[FavoritesTableViewController class]]) {
                        mvc.delegate = (FavoritesTableViewController *)vc;
                        break;
                    }
                }
            }
        }
    }
}


@end
