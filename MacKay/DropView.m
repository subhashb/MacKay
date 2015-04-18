//
//  DropView.m
//  MacKay
//
//  Created by Subhash Bhushan on 17/04/15.
//  Copyright (c) 2015 Subhash Bhushan. All rights reserved.
//

#import "DropView.h"
#import "Uploader.h"

@implementation DropView
@synthesize image;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self registerForDraggedTypes:[NSArray arrayWithObjects:
                                       NSColorPboardType, NSFilenamesPboardType, nil]];
        NSLog(@"initialization");
    }
    return self;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self registerForDraggedTypes:[NSArray arrayWithObject:NSURLPboardType]];
        NSLog(@"Registered");
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    if (!image) {
        [[NSColor grayColor] set];
        NSRectFill(dirtyRect);
    } else {
        [image drawInRect:dirtyRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
    }
    NSLog(@"Drawing");
    // Drawing code here.
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    if ([NSImage canInitWithPasteboard:[sender draggingPasteboard]] &&
        [sender draggingSourceOperationMask] & NSDragOperationCopy) {
        return NSDragOperationCopy;
    }
    return NSDragOperationNone;
}

- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender {
    NSLog(@"DRAGGING");
    return NSDragOperationCopy;
}

- (void) draggingEnded:(id<NSDraggingInfo>)sender {
    NSLog(@"ENDED");
}

- (void) draggingExited:(id<NSDraggingInfo>)sender {
    NSLog(@"EXITED");
}

- (BOOL) prepareForDragOperation:(id<NSDraggingInfo>)sender {
    return YES;
}

- (BOOL) performDragOperation:(id<NSDraggingInfo>)sender {
    NSURL *fileURL;
    fileURL = [NSURL URLFromPasteboard:[sender draggingPasteboard]];
    NSString *fileName = [fileURL lastPathComponent];
    [[Uploader alloc] initWithURL:[NSURL URLWithString:@"https://kaybus.dev/api/assets"]
                           filePath:fileURL
                           fileName:fileName
                           delegate:self
                       doneSelector:@selector(onUploadDone:)
                      errorSelector:@selector(onUploadError:)];
    return YES;
}

- (void) concludeDragOperation:(id<NSDraggingInfo>)sender {
    [self setNeedsDisplay:YES];
}

@end
