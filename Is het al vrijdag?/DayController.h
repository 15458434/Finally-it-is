//
//  DayController.h
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 28/06/16.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

@import Foundation;

@interface DayController : NSObject

@property (nonatomic, readonly) BOOL isHetAlZeventienUur;
@property (nonatomic, readonly) BOOL isHetAlVrijdag;
@property (nonatomic, readonly) BOOL isHetAlWeekend;

@end
