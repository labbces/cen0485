
# rerun if any changes are made to the # ## ### #### in the README.md
cat header.md > toc.md
START=2
tail +$START ../bioinfo.md | ./gh-md-toc - | perl -p -e 's/\(#/\(bioinfo.md\/#/' >> toc.md

## copy the contents of toc.md to README.md to create a TOC with more depth
