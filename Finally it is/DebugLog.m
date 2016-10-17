//
//  DebugLog.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 07/10/2016.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

@import Foundation;

void DebugLog(NSString *format, ...)
{
#ifdef DEBUG
    va_list args;
    va_start(args, format);
    NSLog(@"%@", [[NSString alloc] initWithFormat:format arguments:args]);
    va_end(args);
#endif
}
