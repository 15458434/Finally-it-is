//
//  DebugLog.h
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 07/10/2016.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#ifndef DebugLog_h
#define DebugLog_h

/**
 Logs only when the app is compiled to a debug binary.

 @param format Format is s string to be formatted with the arguments.
 @param ...    The arguments for in the string.
 */
extern void DebugLog(NSString *format, ...);

#endif /* DebugLog_h */
