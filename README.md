# wassermandli

The purpos of wassermandli is to compare different genes and identify possible gene duplications, pseudogenes of member of same gene families. No *a priori* knowledge is needed or used.

wassermandli computes all pairwise alignments of a list of genes. The alignments are performed with the [Smith Waterman](https://en.wikipedia.org/wiki/Smith%E2%80%93Waterman_algorithm) algorithm implemented in [water](http://emboss.sourceforge.net/apps/release/6.6/emboss/apps/water.html) from the EMBOSS package.

wassermandli requires a list of genes of interest and a multifasta file containing the gene sequences (both DNA or AA are possible). By default the results appear as **STDOUT**, but they can be redirected with *"> results.txt"*. Furthermore all alignments are also saved to an *ad hoc* created folder **WATER_align**.



### Usage

```
bash wassermandli.sh -h
```
