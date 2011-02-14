# ggcolpairs...

ggcolpairs <- function (dataset, xlist, ylist, colour="default", ggdetails="default", margins="default", title="", legend="off")
{
	# xlist,ylist -> list of desired x/y columns in "string" format
	# colour -> column to colour all plots in "string" format
	# plots edge default margins
	# ALERT: margins needed everywhere?? need fix or set global -- perhaps a getMargins() function...
	
	ifelse(margins == "default", cmargins <- c(0.1,-0.99), cmargins <- margins)
		
	xnum <- length(xlist)
	ynum <- length(ylist)
	plotnum <- xnum * ynum
	axisnum <- (xnum + ynum)
	
	# ALERT: might not need vector lists since im generating and
	# ploting at the same instance with no need of recalling info.
	# Try using just normal variable for cplot and cpaxis.
	plots_list <- vector("list", plotnum)
	paxis_list <- vector("list", axisnum)
	
	ypos <- ynum
	xpos <- 1
	
	axiscounter <- 1
	
	# rowpos <- 1
	# colpos <- 1
	
	# viewport configs
	# cmp_setviewports(xlist, ylist)
	
	# Maybe make a separate function for plot/axis generation and print
	for(i in 1:plotnum)
	{
		plots_list[[i]] <- generate_ggplot(dataset,xlist[xpos],ylist[ypos],colour,ggdetails,cmargins)
		# plot_cmp <- generate_ggplot(dataset,xlist[xpos],ylist[ypos],colour,ggdetails,cmargins)
		
		daxis <- desired_axis(xpos,ypos)
		
		# only generates border axes
		if(daxis != "none")
		{
			if(daxis == "xy")
			{
				# print(paxis_cmp, vp = vplayout(rowpos,colpos))
				# pushViewport(vplayout(rowpos,colpos))
				paxis_list[[axiscounter]] <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],"y",cmargins)
				# paxis_cmp <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],"y",cmargins)
				# grid.draw(paxis_cmp)
				paxis_list[[axiscounter + 1]] <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],"x",cmargins)
				# paxis_cmp <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],"x",cmargins)
				# grid.draw(paxis_cmp)
				# popViewport()
				axiscounter <- axiscounter + 2

			} else {
				paxis_list[[axiscounter]] <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],daxis,cmargins)
				# print(paxis_list[[i]], vp = vplayout(rowpos,colpos))
				# paxis_cmp <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],daxis,cmargins)
				# print(paxis_cmp, vp = vplayout(rowpos,colpos))
				# pushViewport(vplayout(rowpos,colpos))
				# grid.draw(paxis_cmp)
				# popViewport()
				axiscounter <- axiscounter + 1
			}
		}
		
		# print(plots_list[[i]], vp = vplayout(rowpos,colpos))
		# print(plot_cmp, vp = vplayout(rowpos,colpos))
		
		if(xpos == xnum)
		{
			xpos <- 1
			ypos <- ypos - 1
			# rowpos <- rowpos + 1
		} else
			xpos <- xpos + 1
				
		# colpos <- xpos		
	}
	# all plots printed, pop back to base?
	# popViewport(3)
	# end?
	dev.off()
	#return colpairs object
	colpairs <- list(
		xlist = xlist,
		ylist = ylist,
		title = title,
		legend = legend,
		plots_list = plots_list,
		paxis_list = paxis_list
	)
	
	attributes(colpairs)$class <- "ggcolpairs"
	
	colpairs
	
}

print.ggcolpairs <- function(colpairs, ...)
{
	xlist <- colpairs$xlist
	ylist <- colpairs$ylist
	plots_list <- colpairs$plots_list
	paxis_list <- colpairs$paxis_list
	title <- colpairs$title
	legend <- colpairs$legend 
	
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

summary.ggcolpairs <- function(colpairs, ...)
{
	cat("[Matrix plot]\n\n")
	cat("Title: \n")
	print(colpairs$title)
	cat("\nColumns: \n")
	print(colpairs$xlist)
	cat("\nRows: \n")
	print(colpairs$ylist)
	cat("\n")
}

