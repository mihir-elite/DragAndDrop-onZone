//
//  DragableVC.m
//  DragAndDrop
//
//  Created by martin on 05/06/2013.
//  Copyright (c) 2013 doduck.com. All rights reserved.
//

#import "DragableView.h"
#import "ZoneView.h"

@implementation DragableView

@synthesize delegate,staticView;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    touchStart = [[touches anyObject] locationInView:self];
    [delegate isDragingStart:self];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [delegate isDragingEnd:self];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint point = [[touches anyObject] locationInView:self];
    self.center = CGPointMake(self.center.x + point.x - touchStart.x, self.center.y + point.y - touchStart.y);
    [delegate isDragingMoved:self];
}

-(void)movedOutZone:(ZoneView *)matchingZone{
    self.backgroundColor = [UIColor greenColor];
}

-(void)movedInZone:(ZoneView *) matchingZone{
    self.backgroundColor = [UIColor clearColor];
}

- (void)dropInZone:(ZoneView *)zone{
    CGRect zonePos = [zone positionInMother];
    CGPoint contentPadding = [self getContentPadding];
    CGRect newPosition = CGRectMake(zonePos.origin.x - contentPadding.x,
                                     zonePos.origin.y - contentPadding.y,
                                     self.frame.size.width,
                                     self.frame.size.height);
    
    [UIView animateWithDuration:0.5 animations:^{
                         self.frame = newPosition;
                     } completion:nil];
}

@end