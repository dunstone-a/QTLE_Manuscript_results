#' Plot the distribution of variance explained across genes
#' calculated using getVarianceExplained from scater.
#' 
#' @param sim SCE object of simulated data
#' @param variables array of factors to include in variance explained plots
#' 
#' @return ggplot object
#' 
plotVarExp <- function(sce, variables=c("Sample")) {
  
  sim <- plotCheckSCE(sce, variables)
  
  colsX <- c("40+%"="#0f162e", "30-40%"="#205e9e", 
             "20-30%"="#489fd4", "10-20%"="#b6def2")
  
  mat.sim <- as.data.frame(getVarianceExplained(sim, variables=variables))
  mat.sim$type <- "simulated"
  n_genes <- nrow(mat.sim)
  
  ve.summary <- mat.sim %>% 
    pivot_longer(-type, names_to = "factor", values_to = "ve.percent") %>%
    mutate(ve = cut(ve.percent, breaks = c(0, 10, 20, 30, 40, 100),
                    labels = c("x", "10-20%", "20-30%", "30-40%", "40+%"))) %>%
    group_by(factor) %>% dplyr::count(ve) %>%
    mutate(p = n / n_genes) %>% dplyr::filter(ve != "x")
  
  
  if (nrow(ve.summary) == 0){
    ve.summary[1, ] <- list(factor="Sample", ve="10-20%", n=0, p=0)
  }
  
  ggbarplot(ve.summary, x="factor", y="p", fill="ve", color=NA, 
            position = position_dodge(0.8), palette=colsX, 
            ylab="genes", legend.title="", legend=c(0.9,0.75), 
            font.legend = c(8, "plain", "black")) + 
    theme(legend.background = element_rect(fill=NA, colour=NA)) +
    scale_y_continuous(labels = function(x) paste0(x*100, "%")) +
    theme(axis.title.x = element_blank()) 
}



plotSilhouette <- function(sce, group_by="Sample", ntop=500,
                           colour_by=NULL, shape_by=NULL, samp.col="Dark2",
                           type.col = c(simulated = "#ccbb44", 
                                        empirical = "#AA3377")){
  
  if(nrow(sce) > ntop){
    var.cuttoff <- sort(rowVars(logcounts(sce)), decreasing = TRUE)[ntop]
    sce <- sce[rowVars(logcounts(sce)) >= var.cuttoff, ]
  }
  sce.dist <- dist(t(logcounts(sce)), method="euclidean")
  sce$cluster <- as.numeric(colData(sce)[, group_by])
  recode <- data.frame(unique(colData(sce)[,c('cluster', group_by)]))
  
  sil.results <- silhouette(colData(sce)[,"cluster"], sce.dist)
  sil.results <- merge(sil.results[], recode, by="cluster")

  ymin <- quantile(sil.results$sil_width, 0.001)
  ymax <- quantile(sil.results$sil_width, 0.999)
  
  
  ggviolin(sil.results, x=group_by, y="sil_width", fill=group_by, 
           add = "median_q1q3", ylim = c(ymin, ymax), xlab=FALSE) + 
    geom_hline(aes(yintercept=0), linetype="dashed")

}


plotCheckSCE <- function(sce, variables, ntop=500){
  
  if(!"logcounts" %in% names(assays(sce))){
    sce <- logNormCounts(sce)
    sce <- runPCA(sce, ntop=ntop)
  }
  
  if(!"PCA" %in% reducedDimNames(sce)){
    sce <- runPCA(sce, ntop=ntop)
  }
  
  for(v in variables){
    if (class(sce[[v]]) != "numeric"){
      sce[[v]] <- as.numeric(factor(sce[[v]],
                                    levels = unique(sce[[v]])))
    }
  }
  
  if(!"matrix" %in% class(counts(sce))){
    counts(sce) <- as.matrix(counts(sce))
  }
  if(!"matrix" %in% class(logcounts(sce))){
    logcounts(sce) <- as.matrix(logcounts(sce))
  }
  
  return(sce)
  
}
