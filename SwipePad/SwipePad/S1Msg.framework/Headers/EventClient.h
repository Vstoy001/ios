#import <Foundation/Foundation.h>

#import "ZMQContext.h"
#import "ZMQSocket.h"
#import "ZMQException.h"

typedef struct {
    int x;
    int y;
} MyPoint;


// gesture type
typedef enum {
    TYPE_NONE = -1,
    TYPE_PAN = 0,
    TYPE_SWIPE = 1,
    TYPE_PRESS = 2,
    TYPE_RELEASE = 3,
    TYPE_LONG_PRESS = 4,
    TYPE_ROTATE = 5,
    TYPE_TAP = 6,
    TYPE_DOUBLE_TAP = 7
} GestureType;

// gesture direction
typedef enum {
    DIR_NONE = 0,
    DIR_LEFT = 1,
    DIR_RIGHT = 2,
    DIR_UP = 3,
    DIR_DOWN
} GestureDirection;

// gesture state
typedef enum {
    STATE_SINGLE = 0,
    STATE_START = 1,
    STATE_UPDATE = 2,
    STATE_END = 3,
    STATE_CANCEL = 4
} GestureState;

typedef struct  {
    GestureType type;
    GestureDirection direction;
    GestureState state;
    int numFingers;
    int posX;
    int posY;
    int velX;
    int velY;
} UserInputEvent;

@interface EventClient : NSObject {
    ZMQContext *context;
    ZMQSocket *sock;
    
    NSTimeInterval lastSentTime;
}

- (id) initWithEndpoint:(NSString *)endpoint;

- (void) sendEventWithId: (int) eventId data: (NSData *) messageData ;

- (void) sendAbsPosWithDown: (int) down coord: (MyPoint *) point;

- (void) sendAbsPos2: (int) down coord1: (MyPoint *) point1 coord2: (MyPoint *) point2 ;

- (void) sendUserInputEvent: (UserInputEvent *) userInput;

- (void) sendDDSWithTicks: (int) ticks direction: (int) dir;

- (void) sendResetCarsor;

- (void) setContext: (NSString *) context;


@end