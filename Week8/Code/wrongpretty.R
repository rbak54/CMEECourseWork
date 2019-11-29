# Question 29
fern <- function(start_position, direction, length)  {
  start_position<-turtle(start_position,direction,length) 
  if (length>0.01){
    fern(start_position=start_position,direction=direction-pi/4,length=length*0.38)
    fern(start_position=start_position,direction=direction,length=length*0.87)
  }
}
draw_fern <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(c(0,2),c(-1,8),xlab=" ", ylab=" ","n")
  fern(start_position = c(0,0), direction=pi/2, length=1)
}

fern2 <- function(start_position, direction, length,dir)  {
  start_position<-turtle(start_position,direction,length) 
  if (length>0.01){
    #dir=-1*dir
    fern2(start_position=start_position,direction=direction+(dir*(pi/4)),length=length*0.38,dir=-1)
    fern2(start_position=start_position,direction=direction+(dir*(pi/4)),length=length*0.87,dir==1)
    #  if (dir==1){
    #   fern2(start_position=start_position,direction=direction+pi/4,length=length*0.38,dir=1)
    #   fern2(start_position=start_position,direction=direction,length=length*0.87,dir=1)
    # }
  }
}
draw_fern2 <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(c(-2,2),c(-1,10),xlab=" ", ylab=" ","n")
  fern2(start_position = c(0,0), direction=pi/2, length=1,dir=1)
}


fern2 <- function(start_position, direction, length,dir)  {
  start_position<-turtle(start_position,direction,length) 
  if (length>0.01){
    #dir=-1*dir
    fern2(start_position=start_position,direction=direction+(dir*(pi/4)),length=length*0.38,dir==-1)
    fern2(start_position=start_position,direction=direction+(dir*(pi/4)),length=length*0.87,dir==1)
    #  if (dir==1){
    #   fern2(start_position=start_position,direction=direction+pi/4,length=length*0.38,dir=1)
    #   fern2(start_position=start_position,direction=direction,length=length*0.87,dir=1)
    # }
  }
}
draw_fern2 <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(c(-2,2),c(-1,10),xlab=" ", ylab=" ","n")
  fern2(start_position = c(0,0), direction=0, length=1,dir=1)
}

fern2 <- function(start_position, direction, length,dir)  {
  start_position<-turtle(start_position,direction,length) 
  if (length>0.01){
    #dir=-1*dir
    fern2(start_position=start_position,direction=direction+(dir*(pi/4)),length=length*0.38,dir=1)
    fern2(start_position=start_position,direction=direction+(dir*(pi/4)),length=length*0.87,dir=-1)
    #  if (dir==1){
    #   fern2(start_position=start_position,direction=direction+pi/4,length=length*0.38,dir=1)
    #   fern2(start_position=start_position,direction=direction,length=length*0.87,dir=1)
    # }
  }
}
draw_fern2 <- function()  {
  # clear any existing graphs and plot your graph within the R window
  graphics.off()
  plot(c(-2,2),c(-1,10),xlab=" ", ylab=" ","n")
  fern2(start_position = c(0,0), direction=pi/2, length=1,dir=1)
}
