//
//  Movie.m
//  MovieMania
//
//  Created by Elena Maso Willen on 15/05/2016.
//  Copyright © 2016 Training. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _title = [aDecoder decodeObjectForKey:@"title"];
        _year = [aDecoder decodeObjectForKey:@"year"];
        _genre = [aDecoder decodeObjectForKey:@"genre"];
        _plot = [aDecoder decodeObjectForKey:@"plot"];
        _poster = [aDecoder decodeObjectForKey:@"poster"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:_year forKey:@"year"];
    [aCoder encodeObject:_genre forKey:@"genre"];
    [aCoder encodeObject:_plot forKey:@"plot"];
    [aCoder encodeObject:_poster forKey:@"poster"];
}


@end


