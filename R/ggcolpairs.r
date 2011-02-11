######################---------------#####################

ggcolpairs <- function (dataset, xlist, ylist, colour="default", ggdetails="default", margins="default")
{
	# xlist,ylist -> list of desired x/y columns in "string" format
	# colour -> column to colour all plots in "string" format
	# plots edge default margins
	# ALERT: margins needed everywhere?? need fix or set global -- perhaps a getMargins() function...
	
	ifelse(margins == "default", cmargins <- c(0.1,-0.99), cmargins <- margins)
		
	xnum <- length(xlist)
	ynum <- length(ylist)
	plotnum <- xnum * ynum
	axisnum <- (xnum + ynum) - 1
	
	# ALERT: might not need vector lists since im generating and
	# ploting at the same instance with no need of recalling info.
	# Try using just normal variable for cplot and cpaxis.
	# plots_list <- vector("list", plotnum)
	# paxis_list <- vector("list", axisnum)
	
	ypos <- ynum
	xpos <- 1
	
	rowpos <- 1
	colpos <- 1
	
	# viewport configs
	cmp_setviewports(xlist, ylist)
	
	# Maybe make a separate function for plot/axis generation and print
	for(i in 1:plotnum)
	{
		# plots_list[[i]] <- generate_ggplot(dataset,xlist[xpos],ylist[ypos],colour,ggdetails,cmargins)
		plot_cmp <- generate_ggplot(dataset,xlist[xpos],ylist[ypos],colour,ggdetails,cmargins)
		
		daxis <- desired_axis(xpos,ypos)
		
		# only generates border axes
		if(daxis != "none")
		{
			if(daxis == "xy")
			{
				# print(paxis_cmp, vp = vplayout(rowpos,colpos))
				pushViewport(vplayout(rowpos,colpos))
				paxis_cmp <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],"y",cmargins)
				grid.draw(paxis_cmp)
				paxis_cmp <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],"x",cmargins)
				grid.draw(paxis_cmp)
				popViewport()

			} else {
				# paxis_list[[i]] <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],daxis,cmargins)
				# print(paxis_list[[i]], vp = vplayout(rowpos,colpos))
				paxis_cmp <- generate_gpaxis(dataset,xlist[xpos],ylist[ypos],daxis,cmargins)
				# print(paxis_cmp, vp = vplayout(rowpos,colpos))
				pushViewport(vplayout(rowpos,colpos))
				grid.draw(paxis_cmp)
				popViewport()
			}
		}
		
		# print(plots_list[[i]], vp = vplayout(rowpos,colpos))
		print(plot_cmp, vp = vplayout(rowpos,colpos))
		
		if(xpos == xnum)
		{
			xpos <- 1
			ypos <- ypos - 1
			rowpos <- rowpos + 1
		} else
			xpos <- xpos + 1
				
		colpos <- xpos		
	}
	# all plots printed, pop back to base?
	popViewport(3)
	# end?
}
