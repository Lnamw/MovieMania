//
//  MovieViewController.h
//  MovieMania
//
//  Created by Elena Maso Willen on 15/05/2016.
//  Copyright © 2016 Training. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@protocol MovieViewControllerDelegate <NSObject>

- (void)addMovieToFavoriteList:(Movie *)movie;

@end

@interface MovieViewController : UIViewController

@property (weak, nonatomic) id<MovieViewControllerDelegate>delegate;

@property (nonatomic, copy) NSString *movieTitleSelected;

@property (nonatomic, strong) Movie *movieSelectedRow;


@end
