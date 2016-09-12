module PaperUtils

using Plots
export plot, plot!, png, pdf, pyplot
using Reexport
@reexport using LaTeXStrings

using JLD

export autofig
export savefigdata, loadfigdata

# Common plot options
figdir = "autofigs"
plotfont = font("Fira Sans", 10)
titlefont = font("Fira Sans", 14)
plotopts = Dict(
    :linewidth=>2,
    :legend=>true,
    :tickfont=>plotfont,
    :legendfont=>plotfont,
    :guidefont=>plotfont,
    :titlefont=>titlefont
)
pyplot(;plotopts...)
PyPlot.rc("font", family="serif")

"Make a figure and save it to files"
function autofig(plotfunc, name)
    p = plotfunc()
    figloc = joinpath(figdir, name)
    Plots.png(figloc)
    Plots.pdf(figloc)

    p
end

# Common data file options
datadir = "figdata"

"Save a dictionary of values into a JLD file"
function savefigdata(id, datadict)
    filename = joinpath(datadir, id) * ".jld"
    save(filename, datadict)
end

"Load a dictionary of values from a JLD file"
function loadfigdata(id)
    filename = joinpath(datadir, id) * ".jld"
    load(filename)
end

end # module PaperUtils
