setlocal includeexpr=MatlabIncludify(v:fname)

function! MatlabIncludify(fname) abort
    let parts = split(a:fname, '\.')[0:-1]

    let packages = parts[0:-2]
    let packages2path = join(map(packages, '"+" . v:val'), '/')
    let class = parts[-1]
    let class2path = "@" . class . "/" . class . ".m"

    let outPath = packages2path . "/" . class2path

    if !filereadable(outPath)
        let outPath = packages2path . "/" . class . ".m"
        if !filereadable(outPath)
            " Maybe we need to strip off the last part of the path name
            " because it's a function
            let parts = parts[0:-2]

            let packages = parts[0:-2]
            let packages2path = join(map(packages, '"+" . v:val'), '/')
            let class = parts[-1]
            let class2path = "@" . class . "/" . class . ".m"
            let outPath = packages2path . "/" . class2path

            if !filereadable(outPath)
                let outPath = packages2path . "/" . class . ".m"
            endif

        endif
    endif

    return outPath
endfunction
