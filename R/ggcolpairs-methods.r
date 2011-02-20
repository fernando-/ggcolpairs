# Internal package functions 
# --------------------------

# Generates grob of a ggplot object which only contains a x axis
# @param p plot object to be striped
# @param offset_v vertical offset to move the axis in order to account for grid space
# @param cmargins custom margin space surrounding the plots
# @keywords hplot
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

# Generates grob of a ggplot object which only contains a y axis
# @param p plot object to be striped
# @param offset_h horizontal offset to move the axis in order to account for grid space
# @param cmargins custom margin space surrounding the plots
# @keywords hplot
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

# Returns which axis is desired to be generated based on matrix position
# @param xpos x axis position in the matrix
# @param ypos y axis position in the matrix
# @keywords methods
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

# Calculates the offset margin space needed for the y axis of a plot based on axis text character length
# @param p plot object for which to base the calculation
# @keywords methods
yaxis_offset <- function(p)
{		
	pGrob <- ggplotGrob(p)
	pylab <- getGrob(pGrob,"axis.text.y.text",grep=TRUE)
	maxchar <- max(nchar(pylab[["label"]]))
	ya_offset <- -1 - 0.4 * maxchar
			
	return(ya_offset)
}

# Generates ggplot based on parameter data
# @param dataset original data set
# @param xvar string column name of desired x axis
# @param yvar string column name of desired y axis
# @param cpcolour string column name to color the data, default is none
# @param ggdetails additional layer to build ggplot, default is geom_point, can combine multiple layers with a list
# @param cmargins custom margin space surrounding the plots
# @keywords hplot
generate_ggplot <- function(dataset,xvar,yvar,cpcolour,ggdetails,cmargins)
{
	margin1 = cmargins[1]
	margin2 = cmargins[2]
		
	cplot <- ggplot(data = dataset, aes_string(x = xvar, y = yvar))
	
	if(cpcolour != "default")
		cplot <- cplot + aes_string(colour = cpcolour)
	
	# defaults to geom_point unless ggdetails are specified
	ifelse(ggdetails != "default", cplot <- cplot + ggdetails, cplot <- cplot + geom_point())
		
	# removes legend and axis in order to create same size plots overall
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

# Generates transparent ggplot to be customized into axis only
# @param dataset original data set
# @param xvar string column name of desired x axis
# @param yvar string column name of desired y axis
# @param daxis string value of the desired axis
# @param cmargins custom margin space surrounding the plots
# @keywords hplot
generate_gpaxis <- function(dataset,xvar,yvar,daxis,cmargins)
{
	cpaxis <- ggplot(data = dataset, aes_string(x = xvar, y = yvar)) + geom_point(colour = "transparent")
	
	offset_h <- yaxis_offset(cpaxis)
	offset_v = -1.6
	
	if(daxis == "x")
		cpaxis <- just_x_axis(cpaxis,offset_v,cmargins)
	else if(daxis == "y")
		cpaxis <- just_y_axis(cpaxis,offset_h,cmargins)
	
	return(cpaxis)
}

# Structures viewport layout positions based on x and y parameters
# @param x viewport row position
# @param y viewport column position
# @keywords internal
# @author Hadley Wickham \email{h.wickham@@gmail.com}
vplayout <- function(x,y)
{	
	viewport(layout.pos.row=x,layout.pos.col=y)
}

# Configures the matrix plot and sets viewports and prepares them for printing axes and plots
# @param xlist list of string column names of the dataset representing x axes
# @param ylist list of string column names of the dataset representing y axes
# @param title string of desired title for resulting matrix
# @param legend string representing legend visibility
# @param legendplot ggplot object for which to base the legend
# @keywords methods
cmp_setviewports <- function(xlist, ylist, title, legend, legendplot)
{	
	if(legend != "off")
		legendplot <- legendplot + opts(keep="legend_box", legend.position = c(0.5,0.5), legend.justification = "centre")
	
	grid.newpage()
	
	xnum <- length(xlist)
	ynum <- length(ylist)
	ypos <- ynum
	
	if(title != "")
	{
		titlelayout=grid.layout(nrow=2, ncol=1, heights=c(1,27))
		pushViewport(viewport(layout=titlelayout))
		pushViewport(viewport(layout.pos.row=1, layout.pos.col=1))
		grid.text(title)
		popViewport()
		pushViewport(viewport(layout.pos.row=2, layout.pos.col=1))
	}
	
	if(legend != "off")
	{
		legendlayout=grid.layout(nrow=1, ncol=2, widths=c(29,3))
		pushViewport(viewport(layout=legendlayout))		
		pushViewport(viewport(layout.pos.row=1, layout.pos.col=2))
		grid.draw(ggplotGrob(legendplot))
		popViewport()
		pushViewport(viewport(layout.pos.row=1, layout.pos.col=1))
	}
	
	# cwidths, cheights -> sizes of labels, axis and plots space
	cwidths = c(1, 3, 25)
	cheights = c(25, 1, 1)	
	
	# rows -> 3 -> plotspace, xaxes, xlabels
	# cols -> 3 -> ylabels, yaxes, plotspace
	baselayout=grid.layout(nrow=3, ncol=3, widths=cwidths, heights=cheights)
	pushViewport(viewport(layout=baselayout))
	
	# TRY: might remove x/y label layouts and include them in custom axes ggplot objects
	# ---start y axis labels---
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
	# ---finit y axis labels---
		
	# ---start x axis labels---
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
	# ---finit x axis labels---
	
	# ---Plots viewport configuration---	
	# set viewport on allocated plotspace
	pushViewport(viewport(layout.pos.row=1, layout.pos.col=3))
	# generate new viewport grid of plots according to data
	pushViewport(viewport(layout=grid.layout(nrow=ynum, ncol=xnum)))
}
