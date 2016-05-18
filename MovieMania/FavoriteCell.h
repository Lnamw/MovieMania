//
//  FavoriteCell.h
//  MovieMania
//
//  Created by Elena Maso Willen on 17/05/2016.
//  Copyright © 2016 Training. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titleLabelCell;
@property (weak, nonatomic) IBOutlet UILabel *yearLabelCell;
@property (weak, nonatomic) IBOutlet UILabel *genreLabelCell;

@end
