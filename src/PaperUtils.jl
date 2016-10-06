module PaperUtils

using Plots
export plot, plot!, png, pdf, pyplot
using Reexport
@reexport using LaTeXStrings

using JLD

export autofig
export savefigdata, loadfigdata

# plot styling
basefontsize = 10
aspectratio = 1.5
onecolwidth = 3.3  # inches
twocolwidth = 6.9  # inches
dpi = 150
figsize = [1, 1/aspectratio] * dpi * onecolwidth
bigfigsize = [1, 1/aspectratio] * dpi * twocolwidth
plotfont = font("serif", basefontsize)

# Common plot options
figdir = "autofigs"
plotopts = Dict(
    :linewidth=>2,
    :legend=>true,
    :tickfont=>plotfont,
    :legendfont=>plotfont,
    :guidefont=>plotfont,
    :titlefont=>plotfont,
    :size=>figsize,
    :grid=>false
)
pyplot(;plotopts...)

"Make a figure and save it to files"
function autofig(plotfunc, name; big=false)
    p = plotfunc()
    if big
        suffix = "_big_fig"
    else
        suffix = "_fig"
    end
    figloc = joinpath(figdir, name)
    figname = figloc * suffix
    Plots.svg(figname)
    run(`rsvg-convert -f pdf -o $figname.pdf $figname.svg`)

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
