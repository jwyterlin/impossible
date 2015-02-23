//
//  ImpossibleView.m
//  impossible
//
//  Created by Jhonathan Wyterlin on 17/08/14.
//  Copyright (c) 2014 Jhonathan Wyterlin. All rights reserved.
//

#import "ImpossibleView.h"

@implementation ImpossibleView

-(id)init {
    
    // Comentario só para teste
    
    self = [super init];
    
    if ( self ) {
        
        // Timer que executa o Game Loop ( "run" ) 60 vezes por segundo
        self.gameRunTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(run) userInfo:nil repeats:YES];
        
        // Posição inicial do jogador
        self.playerX = 160;
        self.playerY = 275;
        self.playerRadius = 25;
        
        // Posição inicial do inimigo
        self.enemyX = 0;
        self.enemyY = 0;
        self.enemyRadius = 0;
        
        // Variável para controlar a execução do jogo
        self.running = YES;
        
        // Criação do Label que exibirá a mensagem de "Game Over!"
        self.gameOverLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 40.0f, 300.0f, 50.0f)];
        self.gameOverLabel.font = [UIFont systemFontOfSize:40.0f];
        self.gameOverLabel.textColor = [UIColor lightGrayColor];
        self.gameOverLabel.backgroundColor = [UIColor clearColor];
        self.gameOverLabel.text = @"";
        [self addSubview:self.gameOverLabel];
        
        // Criação do label que exibirá o score do jogador
        self.gameScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 85, 300, 30)];
        self.gameScoreLabel.font = [UIFont systemFontOfSize:25.0f];
        self.gameScoreLabel.textColor = [UIColor whiteColor];
        self.gameScoreLabel.backgroundColor = [UIColor clearColor];
        self.gameScoreLabel.text = @"0";
        [self addSubview:self.gameScoreLabel];
        
    }
    
    return self;
    
}

// Game Loop
-(void)run {
    
    if ( self.running == YES ) {
        
        // Aumenta o raio do inimigo
        self.enemyRadius++;
        
        // Checa colisões
        [self checkCollision];
        
        // Informa ao iOS que a tela deve ser redesenhada
        [self setNeedsDisplay];
        
    }
    
}

-(void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawBackgroundInContext:context];
    [self drawPlayerInContext:context];
    [self drawEnemyInContext:context];
    
}

// Desenha o jogador
-(void)drawPlayerInContext:(CGContextRef)context {
    
//    BOOL circleOf360Degrees = YES;
//    
//    UIGraphicsPushContext(context);
//    CGContextBeginPath(context);
//    CGContextAddArc( context, self.playerX, self.playerY, self.playerRadius, 0, (2*M_PI), circleOf360Degrees );
//    CGContextSetRGBFillColor( context, 0.0f, 0.9f, 0.0f, 1.0f );
//    CGContextFillPath(context);
//    UIGraphicsPopContext();

    // Utiliza uma imagem do projeto e a desenha em um determinado ponto da tela
    UIImage *image = [UIImage imageNamed:@"nave.png"];
    
    float axisX = ( self.playerX - ( image.size.width / 2 ) );
    float axisY = ( self.playerY - ( image.size.height / 2 ) );
    
    [image drawAtPoint:CGPointMake( axisX, axisY )];
    
}

-(void)moveDown:(int)pixels {
    
    if ( self.running == YES ) {
        
        self.playerY += pixels;
        
    }
    
}

// Desenha o plano de fundo
-(void)drawBackgroundInContext:(CGContextRef)context {
    
//    UIGraphicsPushContext(context);
//    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
//    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
//    UIGraphicsPopContext();
    
    // Utiliza uma imagem do projeto e a desenha em um determinado ponto da tela
    UIImage *image = [UIImage imageNamed:@"sky.png"];
    [image drawAtPoint:CGPointMake(0, 0)];
    
}

// Desenha o inimigo
-(void)drawEnemyInContext:(CGContextRef)context {
    
    BOOL circleOf360Degrees = YES;
    
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, self.enemyX, self.enemyY, self.enemyRadius, 0, (2*M_PI), circleOf360Degrees);
    //CGContextSetRGBFillColor(context, 0.4f, 0.4f, 0.4f, 1.0f);
    CGContextSetRGBFillColor(context, 1.0f, 0.0f, 0.0f, 1.0f);
    CGContextFillPath(context);
    UIGraphicsPopContext();
    
}

// Verifica colisões
-(void)checkCollision {
    
    double distance = 0.0f;
    
    // Teorema de Pitágoras
    distance = pow(self.playerY - self.enemyY, 2) + pow(self.playerX - self.enemyX, 2);
    distance = sqrt(distance);
    
    if ( distance <= ( self.playerRadius + self.enemyRadius ) ) {
        self.gameOverLabel.text = @"GAME OVER!";
        self.running = NO;
    }
    
}

// Soma pontos
-(void)increaseScore:(int)points {
    
    if ( self.running == YES ) {
        
        self.score += points;
        
        self.gameScoreLabel.text = [NSString stringWithFormat:@"%d", self.score];
        
    }
    
}

// Para o jogo
-(void)stopGame {
    
    self.running = NO;
    
}

// Reinicia o jogo, redefinindo as variáveis
-(void)restart {
    
    self.enemyX = 0;
    self.enemyY = 0;
    self.enemyRadius = 0;
    
    self.playerX = 160;
    self.playerY = 275;
    self.playerRadius = 25;
    
    self.score = 0;
    self.gameScoreLabel.text = @"0";
    self.gameOverLabel.text = @"";
    
    self.running = YES;
    
}

@end
