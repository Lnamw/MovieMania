//
//  FavoritesTableViewController.h
//  MovieMania
//
//  Created by Elena Maso Willen on 16/05/2016.
//  Copyright © 2016 Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieViewController.h"

@interface FavoritesTableViewController : UITableViewController <MovieViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *myFavoriteList;




@end
