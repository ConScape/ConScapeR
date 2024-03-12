GridRSP <- function(g, theta) {
  h <- JuliaConnectoR::juliaLet("ConScape.GridRSP(g, θ=theta)", g=g, theta=theta)
  return(h)
}

betweenness_qweighted <- function(h) {
  betw <- JuliaConnectoR::juliaLet("ConScape.betweenness_qweighted(h)", h=h)
  return(betw)
}

betweenness_kweighted <- function(h, alpha) {
  betw <- JuliaConnectoR::juliaLet("ConScape.betweenness_kweighted(h, distance_transformation=x -> exp(-x*alpha))", h=h, alpha=alpha)
  return(betw)
}

connected_habitat <- function(h, alpha) {
  func <- JuliaConnectoR::juliaLet("ConScape.connected_habitat(h, distance_transformation=x -> exp(-x*alpha))", h=h, alpha=alpha)
  return(func)
}
