# Nice Plots for exit time
# SRC 2020-06-09, updated 2020-08-01

rm(list = ls())
graphics.off()

# Load results of Step 4

# Save results for further plotting
#save(Tstep,Xvar,avec,D1,D2,sigma,xeq,xvec,drift,diff,negPF,
#     xvec.ep,EPF,x,wts,ETL,ETR,xL,wtsL,xR,wtsR,
#     file='Results_tau_plots_Peter1315.Rdata')

#load(file='Results_tauweights_Plots_Peter0811.Rdata')
load(file='Demo_tauweights_Plots_Peter1315.Rdata')

# Save data for Matlab
#stdlevel = as.data.frame(cbind(Tstep,Xvar))
#write.csv(stdlevel,file='Enrichment_Peter.csv')

# Calculate mean exit time for left basin ---------------------------------------------
nL = length(ETL[,1])
nR = length(ETR[,1])
nboth =nR + nL

#
meanETl = sum(ETL[1:nL,2]*wts[1:nL])/sum(wts[1:nL])/12
print('',quote=F)
print('Mean ET (hours) for left basin',quote=F)
print(meanETl)
print('-----------------------------------------------',quote=F)

# save axes
xL = x[1:nL]
wtsL = wts[1:nL]

# Calculate weighted average ET for right basin ===========================================================

#
meanETr = sum(ETR[1:nR,2]*wts[(nL):(nboth-1)])/sum(wts[(nL):(nboth-1)])/12
print('',quote=F)
print('Mean ET (hours) for right basin',quote=F)
print(meanETr)
print('-----------------------------------------------',quote=F)

xR = x[nL:(nboth-1)]
wtsR = wts[nL:(nboth-1)]
# decdoy is used for converting time to different units, if needed
decdoy = Tstep

# 5 panel version ----------------------------------------------------
windows(height=15,width=5)
par(mfrow=c(5,1),mar=c(3.9, 4.5, 0.5, 1) + 0.1,cex.axis=1.1,font.axis=2,
    cex.lab=1.4,font.lab=2)
#
plot(decdoy,Xvar,type='l',col='black',lwd=1,xlab='Year',
     ylab='Phycocyanin')
#
par(mar=c(2, 4.5, 0, 1) + 0.1)
#
yrange=range(c(D1,sigma))
xrange=range(avec)
plot(avec,D1,ylim=yrange,type='l',col='black',lwd=2,xlab=' ', #xlab='Phycocyanin',
     ylab='Drift or Diffusion')
points(avec,sigma,type='l',col='black',lty=2,lwd=2)
abline(h=0,lwd=1,lty=2,col='gray')
legend(x=-1,y=0.28,legend=c('diff. (as s.d.)','drift'),lty=c(2,1),lwd=c(2,2),seg.len=4,
       col=c('black','black'),cex=1,text.font=2,bty='n')
#
plot(xvec.ep[2:200],EPF,type='l',lwd=2,col='black',xlim=xrange,xlab=' ', #xlab='Phycocyanin',
     ylab='Effective Potential')
#
xrange=range(c(ETL[,1],ETR[,1],avec))
yrange=range(c(ETL[,2],ETR[,2]))/12
plot(ETL[,1],ETL[,2]/12,xlim=xrange,ylim=yrange,type='l',col='black',lwd=2,xlab=' ', #xlab='Phycocyanin',
     ylab='Exit Time, hours')
points(ETR[,1],ETR[,2]/12,type='l',col='black',lwd=2)
abline(v=xeq[2],lty=3,lwd=2)
#
par(mar=c(3.9, 4.5, 0, 1) + 0.1)
#
plot(x,wts,type='l',lwd=2,xlim=xrange,col='black',xlab='Phycocyanin',ylab='Density')

# Try Layout
m.plot = rbind(c(1,1),c(2,3),c(4,5))
print(m.plot)

windows(height=8,width=6)
layout(m.plot)
par(mar=c(3.9, 4.5, 0.5, 1) + 0.1,cex.axis=1.1,font.axis=2,
    cex.lab=1.4,font.lab=2)
#
plot(decdoy,Xvar,type='l',col='black',lwd=1,xlab='Year',
     ylab='Phycocyanin Level')
text(x=2013.1,y=5.5,'A',cex=1.4,font=2)
#
par(mar=c(2, 4.5, 0, 1) + 0.1)
#
yrange=range(c(D1,sigma))
xrange=range(avec)
plot(avec,D1,ylim=yrange,type='l',col='black',lwd=2,xlab=' ', #xlab='Phycocyanin',
     ylab='Drift or Diffusion')
points(avec,sigma,type='l',col='black',lty=2,lwd=2)
abline(h=0,lwd=1,lty=2,col='gray')
legend(x=-7,y=0.3,legend=c('diffusion (as s.d.)','drift'),lty=c(2,1),lwd=c(2,2),seg.len=4,
       col=c('black','black'),cex=1,text.font=2,bty='n')
text(x=6,y=0.55,'B',cex=1.4,font=2)
#legend(x=-1,y=0.28,legend=c('diff. (as s.d.)','drift'),lty=c(2,1),lwd=c(2,2),seg.len=4,
#      col=c('black','black'),cex=1,text.font=2,bty='n')
#
plot(xvec.ep[2:200],EPF,type='l',lwd=2,col='black',xlim=xrange,xlab=' ', #xlab='Phycocyanin',
     ylab='Effective Potential')
text(x=6.6,y=-5.2,'C',cex=1.4,font=2)
#
par(mar=c(3.9, 4.5, 0, 1) + 0.1)
xrange=range(c(ETL[,1],ETR[,1],avec))
yrange=range(c(ETL[,2],ETR[,2]))/12
plot(ETL[,1],ETL[,2]/12,xlim=xrange,ylim=yrange,type='l',col='black',lwd=2,xlab='Phycocyanin',
     ylab='Exit Time, hours')
points(ETR[,1],ETR[,2]/12,type='l',col='black',lwd=2)
abline(v=xeq[2],lty=3,lwd=2)
text(x=-4,y=5,paste('mean = ',round(meanETl,0)),cex=1.4,font=2)
text(x=4,y=5,paste('mean = ',round(meanETr,0)),cex=1.4,font=2)
text(x=5.9,y=22,'D',cex=1.4,font=2)
#
plot(x,wts,type='l',lwd=2,xlim=xrange,col='black',xlab='Phycocyanin',ylab='Density')
text(x=5.9,y=0.003,'E',cex=1.4,font=2)

# Try Layout + Color =================================================================

m.plot = rbind(c(1,1),c(2,3),c(4,5))
print(m.plot)

windows(height=8,width=6)
layout(m.plot)
par(mar=c(3.9, 4.5, 0.5, 1) + 0.1,cex.axis=1.1,font.axis=2,
    cex.lab=1.4,font.lab=2)
#
plot(decdoy,Xvar,type='l',col='forestgreen',xaxt='n',lwd=1,xlab='Year',
     ylab='Phycocyanin')
axis(side = 1, pretty(Tstep, n = 4))
abline(h=xeq[2],col='darkred',lwd=2)
abline(v=c(2013:2016),lty=2,lwd=2,col='darkgray')
text(x=2013.1,y=6.5,'A',cex=1.4,font=2)

#
par(mar=c(2, 4.5, 0, 1) + 0.1)
#
yrange=range(c(D1,sigma))
xrange=range(avec)
plot(avec,D1,ylim=yrange,type='l',col='black',lwd=2,xlab=' ', #xlab='Phycocyanin',
     ylab='Drift or Diffusion')
points(avec,sigma,type='l',col='red',lty=2,lwd=2)
abline(h=0,lwd=1,lty=2,col='gray')
text(x=6.5,y=0.15,'B',cex=1.5,font=2)
legend('top',legend=c('diffusion (as s.d.)','drift'),lty=c(2,1),lwd=c(2,2),seg.len=4,
       col=c('red','black'),cex=1,text.font=2,bty='n')

#legend(x=-1,y=0.28,legend=c('diff. (as s.d.)','drift'),lty=c(2,1),lwd=c(2,2),seg.len=4,
#      col=c('black','black'),cex=1,text.font=2,bty='n')
#
plot(xvec.ep[2:200],EPF,type='l',lwd=2,col='black',xlim=xrange,xlab=' ', #xlab='Phycocyanin',
     ylab='Effective Potential')
text(x=5,y=-7.5,'C',cex=1.5,font=2)
#
par(mar=c(3.9, 4.5, 0, 1) + 0.1)
xrange=range(c(ETL[,1],ETR[,1],avec))
yrange=range(c(ETL[,2],ETR[,2]))/12
plot(ETL[,1],ETL[,2]/12,xlim=xrange,ylim=yrange,type='l',col='blue',lwd=2,xlab='Phycocyanin',
     ylab='Exit Time, hours')
points(ETR[,1],ETR[,2]/12,type='l',col='forestgreen',lwd=2)
abline(v=xeq[2],lty=3,lwd=2)
text(x=-4,y=5,paste('mean = ',round(meanETl,0)),cex=1.4,font=2)
text(x=4,y=5,paste('mean = ',round(meanETr,0)),cex=1.4,font=2)
text(x=6,y=240,'D',cex=1.5,font=2)
#
plot(x,wts,type='l',lwd=1,xlim=xrange,col='black',xlab='Phycocyanin',ylab='Density')
polygon(c(-4.01,xL,xL[length(xL)],xL[1]),c(0,wtsL,wtsL[1],wtsL[1]),col='skyblue',border=NA)
polygon(c(xR,xR[1],xR[1]),c(wtsR,wtsR[length(wtsR)],wtsR[1]),col='lightgreen',border=NA)
#polygon(c(xL,xL[length(xL)],xL[1]),c(wtsL,wtsL[1],wtsL[1]),col='skyblue',border=NA)
#polygon(c(xR,xR[1],xR[1]),c(wtsR,wtsR[length(wtsR)],wtsR[1]),col='lightgreen',border=NA)
points(x,wts,type='l',lwd=3,xlim=xrange,col='black')
text(x=5.5,y=0.009,'E',cex=1.5,font=2)
