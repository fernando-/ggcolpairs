######################---------------#####################
library(ggplot2)

just_x_axis <- function(p, offset_v=0, cmargins)
{
	margin1 = cmargins[1]
	margin2 = cmargins[2]
	
	p <- p + opts(
		axis.line = theme_blank(),
		# axis.text.x = theme_blank(), 
		axis.title.x = theme_blank(),
		axis.text.y = theme_blank(),
		# axis.ticks = theme_blank(),  		
		axis.title.y = theme_blank(),
		legend.position="none",
		# legend.background = theme_blank(), legend.key = theme_blank(), legend.text = theme_blank(), legend.title = theme_blank(),
		panel.background = theme_blank(), panel.border = theme_blank(), panel.grid.major = theme_blank(), panel.grid.minor = theme_blank(),
		plot.background = theme_blank(), plot.title = theme_blank(), 
		strip.background = theme_blank(), strip.text.x = theme_blank(), strip.text.y = theme_blank()
		) +
		opts(plot.margin=unit.c(unit(margin1, "lines"), unit(margin1,"lines"), unit(offset_v,"lines"), unit(margin2,"lines")))
		
	
	p.Grob <- ggplotGrob(p)
	p.Grob.xaxis <- editGrob(p.Grob, "axis.ticks.segments", gp = gpar(col = "transparent"),grep=TRUE)

	return(p.Grob.xaxis)
}

just_y_axis <- function(p, offset_h=0, cmargins)
{
	margin1 = cmargins[1]
	margin2 = cmargins[2]
	
	p <- p + opts(
		axis.line = theme_blank(),
		axis.text.x = theme_blank(), axis.title.x = theme_blank(),
		# axis.text.y = theme_blank(),
		# axis.ticks = theme_blank(),  		
		axis.title.y = theme_blank(),
		legend.position="none",
		# legend.background = theme_blank(), legend.key = theme_blank(), legend.text = theme_blank(), legend.title = theme_blank(),
		panel.background = theme_blank(), panel.border = theme_blank(), panel.grid.major = theme_blank(), panel.grid.minor = theme_blank(),
		plot.background = theme_blank(), plot.title = theme_blank(), 
		strip.background = theme_blank(), strip.text.x = theme_blank(), strip.text.y = theme_blank()
		) +
		opts(plot.margin=unit.c(unit(margin1, "lines"), unit(margin1,"lines"), unit(margin2,"lines"), unit(offset_h,"lines")))
	
	
	p.Grob <- ggplotGrob(p)
	p.Grob.yaxis <- editGrob(p.Grob, "axis.ticks.segments", gp = gpar(col = "transparent"),grep=TRUE,global=TRUE)
	p.Grob.yaxis <- editGrob(p.Grob.yaxis, "axis.ticks.segments", gp = gpar(col = "grey50"),grep=TRUE)
	
	return(p.Grob.yaxis)
}

desired_axis <- function(xpos,ypos)
{
	if(xpos == 1 && ypos == 1)
		daxis <- "xy"
	else if(xpos != 1 && ypos == 1)
		daxis <- "x"
	else if(xpos == 1 && ypos != 1)
		daxis <- "y"
	else
		daxis <- "none"
		
	return(daxis)
}

yaxis_offset <- function(p)
{	
	# calculates the y offset needed for a plot
	pGrob <- ggplotGrob(p)
	pylab <- getGrob(pGrob,"axis.text.y.text",grep=TRUE)
	maxchar <- max(nchar(pylab[["label"]]))
	ya_offset <- -1 - 0.4 * maxchar
			
	return(ya_offset)
}

generate_ggplot <- function(dataset,xvar,yvar,cpcolour,ggdetails,cmargins)
{
	margin1 = cmargins[1]
	margin2 = cmargins[2]
		
	cplot <- ggplot(data = dataset, aes_string(x = xvar, y = yvar))
	
	if(cpcolour != "default")
		cplot <- cplot + aes_string(colour = cpcolour)
	
	#defaults to geom_point unless ggdetails are specified
	if(ggdetails != "default")
		cplot <- cplot + ggdetails
	else
		cplot <- cplot + geom_point()
		
	#removes legend and axis in order to create same size plots overall
	cplot <- cplot + opts(
		legend.position="none",
		axis.text.x = theme_blank(), 
		axis.ticks = theme_blank(), 
		axis.title.x = theme_blank(), 
		axis.text.y = theme_blank(), 
		axis.title.y = theme_blank(),
		plot.margin=unit.c(unit(margin1, "lines"), 
			unit(margin1,"lines"), 
			unit(margin2,"lines"), 
			unit(margin2,"lines")))
			
	return(cplot)
}

generate_gpaxis <- function(dataset,xvar,yvar,daxis,cmargins)
{
	#use the just_?_axis functions to customize multiplot axes
	#use daxis to know which axis to generate
	#...
	# done - NEED TO GENERALIZE OFFSETS -- calculate according to max xvar/yvar size? absolute value?
	# NEED TO GENERALIZE X offset?
	# xy offset woes....
	#...
		
	cpaxis <- ggplot(data = dataset, aes_string(x = xvar, y = yvar)) + geom_point(colour = "transparent")
	
	offset_h <- yaxis_offset(cpaxis)
	offset_v = -1.6
	
	# if(daxis == "xy")
		# cpaxis <- just_xy_axis(cpaxis,offset_h,offset_v,cmargins)
	# else 
	if(daxis == "x")
		cpaxis <- just_x_axis(cpaxis,offset_v,cmargins)
	else if(daxis == "y")
		cpaxis <- just_y_axis(cpaxis,offset_h,cmargins)
	
	return(cpaxis)
}

vplayout <- function(x,y)
{
	#Credit Hadley for this vplayout function!!
	viewport(layout.pos.row=x,layout.pos.col=y)
}
	
cmp_setviewports <- function(xlist, ylist)
{
	# base layout matrix config
	# cwidths, cheights -> sizes of labels, axis and plots space
	# rows -> 3 -> plotspace, xaxes, xlabels
	# cols -> 3 -> ylabels, yaxes, plotspace 
	# ALERT: need to generalize, 
	# might remove x/y label layouts and include them in custom axes
	
	grid.newpage()
	
	cwidths = c(1, 3, 25)
	cheights = c(25, 1, 1)
	
	xnum <- length(xlist)
	ynum <- length(ylist)
	ypos <- ynum
	
	baselayout=grid.layout(nrow=3, ncol=3, widths=cwidths, heights=cheights)
	pushViewport(viewport(layout=baselayout))

	#---start y axis labels---
	pushViewport(viewport(layout.pos.row=1, layout.pos.col=1))
	pushViewport(viewport(layout=grid.layout(nrow=ynum, ncol=1)))
	
	for(i in 1:ynum)
	{
		pushViewport(vplayout(i,1))
		grid.text(ylist[ypos], rot=90)
		if(ypos != 1)
		{
			popViewport()
			ypos <- ypos - 1
		} else
			popViewport(3)
	}
	#---finit y axis labels---
		
	#---start x axis labels---
	pushViewport(viewport(layout.pos.row=3, layout.pos.col=3))
	pushViewport(viewport(layout=grid.layout(nrow=1, ncol=xnum)))
	
	for(i in 1:xnum)
	{
		pushViewport(vplayout(1,i))
		grid.text(xlist[i])
		if(i != xnum)
			popViewport()
		else
			popViewport(3)
	}
	#---finit x axis labels---
	
	#---Plots viewport configuration---
	
	#set viewport on allocated plotspace
	pushViewport(viewport(layout.pos.row=1, layout.pos.col=3))
	#generate new viewport grid of plots according to data
	pushViewport(viewport(layout=grid.layout(nrow=ynum, ncol=xnum)))
}
