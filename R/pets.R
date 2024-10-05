pets<-function(taxa, time, obs_type=NULL, fauna=NULL, plot=T, colours=c("red","green","blue","orange","purple"),persistence="palegreen", absence="pink", end=NULL){
	res<-NULL
	if(is.null(obs_type)){
  		data<-as.data.frame(cbind(taxa,time,rep("observation",length(taxa))))
	}else{
  		data<-as.data.frame(cbind(taxa,time,obs_type))
	}
	species<-unique(data[,1])
	if(!(is.null(fauna))){
		checksp<-species[-which(species %in% fauna)]
		if (length(checksp)>0){
  			stop(paste("There are species absent in the checklist:",checksp))
		}
	}
	res$observations<-length(which(!(is.na(time))))
	res$NA_observation<-length(which(is.na(time)))
	anni<-NULL
	for(sp in 1:length(species)){
		anni[[sp]]<-as.numeric(unique(data[which(data[,1]==species[sp]),2]))
	}
	start<-min(unlist(anni),na.rm=T)
	if(is.null(end)){
		end<-max(unlist(anni),na.rm=T)
	}
	nasp<-rep(0,length(species))
	for(sp in 1:length(species)){
    		if(is.na(min(anni[[sp]]))){
   	 		nasp[sp]<-1
  		}
	}
	tipidati<-unique(data[,3])
	tipidati<-tipidati[order(tipidati)]
	last_sp<-rep(NA,length(species))
	first_sp<-last_sp
	for (c in 1:length(species)){
  		annisp<-anni[[c]][which(!is.na(anni[[c]]))]
  		if(length(annisp)>0){
  			last_sp[c]<-max(anni[[c]],na.rm=T)
  			first_sp[c]<-min(anni[[c]],na.rm=T)
		}
	}
	last_sp2<-last_sp
	last_sp2[which(is.na(last_sp))]<-min(last_sp,na.rm=T)-1
	ordine<-order(last_sp2)
	species2<-species[ordine]
	last_sporder<-last_sp[ordine]
	first_sporder<-first_sp[ordine]
	if(plot){
		plot(rbind(c(start-2,0),c(end,length(species))),type="n",ylab="Species",xlab="years")
		mtext(paste(paste(c(tipidati,"Plural"),"=",col=c(colours[1:length(tipidati)],colours[length(colours)]),sep=""),collapse=", "),cex=0.5)
		for (sp in 1:length(species2)){
  			datisp<-data[which(data[,1]==species2[sp]),]
  			annir<-datisp[!duplicated(cbind(datisp[,2],datisp[,3])),]
			annisp<-as.numeric(unique(annir[,2]))
			if(length(which(!(is.na(annisp))))>0){
				mi<-min(annisp, na.rm=T)
				ma<-max(annisp, na.rm=T)
				rect((mi-1.5),(sp-0.5),(ma)-0.5,(sp+0.5),col=persistence,border=T)
				rect((ma-1.5),(sp-0.5),(end)-0.5,(sp+0.5),col=absence,border=T)
			}
			for (quad in 1:length(annisp)){
  				tipi1<-annir[which(annir[,2]==annisp[quad]),]
  				tipol<-tipi1[,3]
  				match<-which(tipidati %in% tipol)
  				if(length(match)>0){
  					if(length(match)==1){
  						colore<-colours[match]
  					}
 					if(length(match)>1){
    						colore<-colours[length(colours)]
  					}
					rect(((annisp[quad])-1.5),(sp-0.5),((annisp[quad])-0.5),(sp+0.5),col=colore,border=T)
				}
				arrows((start-2.5),(sp-0.5),(annisp[quad]-0.5),(sp-0.5), length =0)
			}
 			if(length(match)==0){
    				colore<-"grey"
    				rect((start-2.5),(sp-0.5),(start-1.5),(sp+0.5),col=colore,border=T)
 			}
		}
	}
	petsind<-round((end-last_sporder)/((end-first_sporder)+1),5)
	res$extinctionP<-sum(end-last_sp, na.rm=T)/sum((end-first_sp), na.rm=T)
	res$table<-as.data.frame(cbind(species2,first_sporder,last_sporder,petsind))
	colnames(res$table)<-c("Species","first rec","last rec", "Abscence fraction")
	return(res)
}
