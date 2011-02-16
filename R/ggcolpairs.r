# Creates a matrix of ggplot2 plots based on a dataset's columns
# @param dataset original data object to plot
# @param xlist list of string column names of the dataset representing x axes
# @param ylist list of string column names of the dataset representing y axes
# @param colour string column name to color the data, default is none
# @param ggdetails additional layer include in the ggplot2 plots, default is geom_point, can be combined for multiple layers
# @param margins margin space surrounding the plots, default is lines based, 0.1 for top and right and -0.4 for bottom and left
# @param title string of desired title for resulting matrix, default is none
# @param legend string representing legend visibility, default is off
# @keywords hplot
ggcolpairs <- function (dataset, xlist, ylist, colour="default", ggdetails="default", margins="default", title="", legend="off")
{
	ifelse(margins == "default", cmargins <- c(0.1,-0.4), cmargins <- margins)
		
	xnum <- length(xlist)
	ynum <- length(ylist)
	plotnum <- xnum * ynum
	axisnum <- (xnum + ynum)
	
	plots_list <- vector("list", plotnum)
	paxis_list <- vector("list", axisnum)
	
	ypos <- ynum
	xpos <- 1
	
	axiscounter <- 1
	
	# TRY: make a separate function for plot/axis generation and print
	for(i in 1:plotnum)
	{
		plots_list[[i]] <- generate_ggplot(dataset,xlist[xpos],ylist[ypos],colour,ggdetails,cmargins)
		daxis <- desired_axis(xpos,ypos)
		
		# only generates border axes
		if(daxis != "none")
		{
			if(daxis == "xy")
			{
				paxis_list[[axiscounter]] <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],"y",cmargins)
				paxis_list[[axiscounter + 1]] <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],"x",cmargins)
				axiscounter <- axiscounter + 2

			} else {
				paxis_list[[axiscounter]] <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],daxis,cmargins)
				axiscounter <- axiscounter + 1
			}
		}		
			
		if(xpos == xnum)
		{
			xpos <- 1
			ypos <- ypos - 1
		} else
			xpos <- xpos + 1
	}
	# TRY: generate axis on print, ggplotGrob generated display window, this dev off removes it
	dev.off()	
	
	colpairs <- list(
		xlist = xlist,
		ylist = ylist,
		title = title,
		legend = legend,
		plots_list = plots_list,
		paxis_list = paxis_list
	)
	
	attributes(colpairs)$class <- "ggcolpairs"
	
	#return colpairs object
	colpairs	
}

# Print configuration to display the matrix of plots
# @param x object with a list of information generated by ggcolpairs to produce the matrix
# @param ... not used
# @keywords print
print.ggcolpairs <- function(x, ...)
{
	xlist <- x$xlist
	ylist <- x$ylist
	plots_list <- x$plots_list
	paxis_list <- x$paxis_list
	title <- x$title
	legend <- x$legend 
	
	xnum <- length(xlist)
	ynum <- length(ylist)
	plotnum <- xnum * ynum
	ypos <- ynum
	xpos <- 1
	rowpos <- 1
	colpos <- 1
	axiscounter <- 1
	
	cmp_setviewports(xlist, ylist, title, legend, plots_list[[1]])
		
	for(i in 1:plotnum)
	{
		daxis <- desired_axis(xpos,ypos)
		
		# only generates border axes
		if(daxis != "none")
		{
			if(daxis == "xy")
			{
				# print(paxis_cmp, vp = vplayout(rowpos,colpos))
				pushViewport(vplayout(rowpos,colpos))
				# paxis_list[[i]] <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],"y",cmargins)
				# paxis_cmp <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],"y",cmargins)
				grid.draw(paxis_list[[axiscounter]])
				# paxis_list[[axisnum]] <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],"x",cmargins)
				# paxis_cmp <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],"x",cmargins)
				grid.draw(paxis_list[[axiscounter + 1]])
				popViewport()
				
				axiscounter <- axiscounter + 2

			} else {
				# paxis_list[[i]] <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],daxis,cmargins)
				# print(paxis_list[[i]], vp = vplayout(rowpos,colpos))
				# paxis_cmp <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],daxis,cmargins)
				# print(paxis_cmp, vp = vplayout(rowpos,colpos))
				pushViewport(vplayout(rowpos,colpos))
				grid.draw(paxis_list[[axiscounter]])
				popViewport()
				
				axiscounter <- axiscounter + 1
			}
		}
		
		print(plots_list[[i]], vp = vplayout(rowpos,colpos))
		# print(plot_cmp, vp = vplayout(rowpos,colpos))
		
		if(xpos == xnum)
		{
			xpos <- 1
			ypos <- ypos - 1
			rowpos <- rowpos + 1
		} else
			xpos <- xpos + 1
				
		colpos <- xpos		
	}
	popViewport(3)
	
	if(title != "")
		popViewport()
	if(legend != "off")
		popViewport()
}

# Summary configuration to display the basic information of the matrix plot
# @param object list of information generated by ggcolpairs containing the properties of the matrix
# @param ... not used
# @keywords misc
summary.ggcolpairs <- function(object, ...)
{
	cat("[Matrix plot]\n\n")
	cat("Title: \n")
	print(object$title)
	cat("\nColumns: \n")
	print(object$xlist)
	cat("\nRows: \n")
	print(object$ylist)
	cat("\n")
}

