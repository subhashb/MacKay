//
//  DropView.h
//  MacKay
//
//  Created by Subhash Bhushan on 17/04/15.
//  Copyright (c) 2015 Subhash Bhushan. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DropView : NSView <NSDraggingDestination> {
    NSImage *image;
}

@property (retain) NSImage *image;

@end
