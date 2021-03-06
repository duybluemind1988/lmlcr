# Copyright (C) 2020, Marek Gagolewski, https://www.gagolewski.com

library("knitr")

opts_chunk$set(
    fig.height=3.5,
    fig.width=6,
    dev=c("CairoPDF", "CairoSVG"),
    out.width=NULL,
    dpi=300,
    error=FALSE,
    fig.show="hold",
    fig.lp='fig:',
    dev.args=list(pointsize=11)
)
