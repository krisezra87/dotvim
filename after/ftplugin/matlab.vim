setlocal includeexpr=MatlabIncludify(v:fname)
" setlocal foldlevel=12 % Use this for spaces, but what a shitty way to do folds
setlocal foldlevel=3
let localPath=getcwd()
exec "set path+=" . localPath

" This is ugly but it will work.  TODO make this relative one directory above the localPath above
let b:dafPath = "/home/kezra/GIT/daf/"
exec "set path+=" . b:dafPath

function! MatlabIncludify(fname) abort
    let parts = split(a:fname, '\.')[0:-1]

    " The out path can occur in one of a variety of ways:
    " 1. As packages2path / classname .m
    " 2. As packages2path / @ classname / classname .m
    " 3. If a function, the classname could be wrong and we need to rewind and discard the function: packages2path-1/classname.m or packages2path-1/@classname/classname.m.
    " 4. It's a named static function and it's in packages2path-1/@classname/functionname.m
    " 5. Any of the above 4 but in a different folder

    let packages = parts[0:-2]
    let packages2path = join(map(packages, '"+" . v:val'), '/')
    let classname = parts[-1]

    "ok let's try case 1

    let outPath = packages2path . "/" . classname . ".m"

    if !filereadable(outPath)
        " Try a different folder
        let outPath = b:dafPath . outPath
    endif

    " Alrighty, case 2
    if !filereadable(outPath)
        let outPath = packages2path . "/@" . classname . "/" . classname . ".m"

        " I guess we'll nest this...
        if !filereadable(outPath)
            " Try a different folder
            let outPath = b:dafPath . outPath
        endif
    endif

    " Well... so far so good, case 3
    " This would be a good case for making another function
    " NOTE: this order is expressing a preference if there is a class and a package folder with the same name
    if !filereadable(outPath)
        "case 3 part 1
        let packages = parts[0:-3]
        let packages2path = join(map(packages, '"+" . v:val'), '/')
        let classname = parts[-2]

        let outPath = packages2path . "/" . classname . ".m"

        if !filereadable(outPath)
            " Try a different folder
            let outPath = b:dafPath . outPath
        endif

        " Alrighty, case 3 part 2
        if !filereadable(outPath)
            let outPath = packages2path . "/@" . classname . "/" . classname . ".m"

            " I guess we'll nest this...
            if !filereadable(outPath)
                " Try a different folder
                let outPath = b:dafPath . outPath
            endif
        endif
    endif

    " and case 4
    if !filereadable(outPath)
        let functionname = parts[-1]
        let outPath = packages2path . "/@" . classname . "/" . functionname . ".m"
        if !filereadable(outPath)
            " Try a different folder
            let outPath = b:dafPath . outPath
        endif
    endif

    return outPath
endfunction
