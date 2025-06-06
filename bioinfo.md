# Introducão à bioinformática - CEN0485 
Aulas práticas da disciplina ["CEN0485 - Introducão à Bioinformática"](https://uspdigital.usp.br/jupiterweb/obterDisciplina?nomdis=&sgldis=cen0485)

__Criador e Instrutor__
Diego M. Riaño-Pachón

# Bioinformática

Os exercícios serão realizados nos computadores da sala de computadores da central de aulas do CENA/USP. Por favor, entre no computador usando o sistema operacional Ubuntu e o usuário cen0485.

## Bioinfo 1 - Operacoes básicas em Bioinformática

### Ferramentas do Unix úteis na bioinformática.

Após adquirir alguma familiaridade com os fundamentos do [sistema operacional Linux](unix.md), vamos explorar como alguns de seus comandos mais básicos podem ser extremamente úteis na área de bioinformática. Você entenderá por que o Linux é o sistema operacional de escolha na bioinformática.
Usaremos os dados do PMID: 249266651, especificamente os conjuntos de dados mostrados na Tabela 1. Para gerar que o RNA total de dados foi extra´ ıdo das c´elulas humanas prim´arias do m´ usculo liso das vias a´ereas (ASM) de quatro doadores diferentes. As c´elulas de cada doador foram tratadas com 1 µM DEX ou com controle ve´ıculo por 18 h. Aproximadamente 1 µg de RNA de cada amostra foi usado para gerar RNA-Seq cDNA bibliotecas para sequenciamento usando o TruSeq RNA Sample Prep Kit v2. O sequenciamento foi realizado em um instrumento HiSeq2000 gerando leituras pareadas (2x75bp). O principal objetivo do estudo foi obter ideias de como os glicocorticoides suprimem a inflama¸ c˜ao no ASM.
Para realizar esses exercícios, você precisa usar o arquivo [file1.tar.gz](https://github.com/labbces/cen0485/raw/main/files/file1.tar.gz). Após baixá-lo, o arquivo deve estar na sua pasta "Downloads". Você deve descompactá-lo em seu diretório HOME.

```
cd
mv ~/Downloads/file1.tar.gz ~/
tar xvzf file1.tar.gz
```

#### Algumas operações básicas com arquivos.

Usando alguns comandos do UNIX, podemos obter informações sobre arquivos e o conteúdo deles de forma rápida e eficiente, muitas vezes sem a necessidade de abrir o arquivo, que pode ser muito grande, para obter essas informações.

No subdiretório "~/dia1/", encontre o arquivo "TAIR10_pep_20101214_updated.fasta.gz", que corresponde à base de dados de sequências de proteínas previstas no genoma da planta modelo _Arabidopsis thaliana_. Para saber quantas linhas este arquivo possui, descomprioma o arquivo e conte o número de linhas com os comandos:

```
cd 
cd ~/dia1
gunzip TAIR10_pep_20101214_updated.fasta.gz
wc -l TAIR10_pep_20101214_updated.fasta
```
Pode conhecer o tamnho do arquivo com o comando _ls_:

```
ls -l -h TAIR10_pep_20101214_updated.fasta
```

O que faz a opção -h no comando 'ls'? Consulte a página de manual do _ls_ para saber."

Na maioria das vezes, é importante visualizar o conteúdo do arquivo, seja no início ou no final.  No entanto, devido ao grande tamanho dos arquivos com os quais normalmente se trabalha, não é conveniente abrir o arquivo com nenhum editor de texto, pois isso pode reduzir o tempo de resposta do computador. Podemos visualizar as primeiras ou ultimas linahs de um arquivo de texto com os comandos  _head_ e _tail_ respetivamente

```
head TAIR10_pep_20101214_updated.fasta
tail TAIR10_pep_20101214_updated.fasta
```
Esses comandos mostram as primeirais ou ultimas 10 linhas do arquivo. O que você pode fazer para mostrar um número maior de linhas? Consulte a página de manual do  _head_ 

Repare na saída do comando `head`. Está mostrando um registro de sequência no formato 'fasta'. Este formato é o mais simples para armazenar sequências, tanto de ácidos nucleicos quanto de proteínas. Sua estrutura é muito simples. Cada registro começa com uma linha que tem no seu início o sinal _>_ seguido de uma cadeia de caracteres de comprimento arbitrário que funciona como o identificador da sequência. Em seguida, nas linhas subsequentes, aparece a sequência em si, em quantas linhas forem necessárias.

Pode usar o comando _grep_ para localizar todas as linhas que tem um padrão de texto específico, ou seja, uma cadeia de texto específica. Vamos identificar todas a linas que comecam com o sinal _>_

```
grep ">" TAIR10_pep_20101214_updated.fasta
```

São muitas linhas, vamos usar o _pipe_ para examinar só as primeiras 4 linas com o padrão de texto:

```
grep ">" TAIR10_pep_20101214_updated.fasta | head -n 4
```

##### Fasta

O formato mais simples é conhecido como Fasta. Nele, uma entrada, que é uma sequência, é dividida em duas partes: a linha de identificação, que deve começar com o símbolo ">" seguido imediatamente pelo identificador da sequência, que pode ser qualquer cadeia de caracteres sem espaços. As linhas imediatamente após o identificador correspondem à própria sequência.

O formato Fasta é o formato de sequências mais amplamente utilizado em aplicações de bioinformática.

```
>gi|110742030|dbj|BAE98952.1| putative NAC domain protein [Arabidopsis thaliana]
MEDQVGFGFRPNDEELVGHYLRNKIEGNTSRDVEVAISEVNICSYDPWNLRFQSKYKSRDAMWYFFSRRE
NNKGNRQSRTTVSGKWKLTGESVEVKDQWGFCSEGFRGKIGHKRVLAFLDGRYPDKTKSDWVIHEFHYDL
LPEHQRTYVICRLEYKGDDADILSAYAIDPTPAFVPNMTSSAGSVVNQSRQRNSGSYNTYSEYDSANHGQ
QFNENSNIMQQQPLQGSFNPLLEYDFANHGGQWLSDYIDLQQQVPYLAPYENESEMIWKHVIEENFEFLV
DERTSMQQHYSDHRPKKPVSGVLPDDSSDTETGSMIFEDTSSSTDSVGSSDEPGHTRIDDIPSLNIIEPL
HNYKAQEQPKQQSKEKVISSQKSECEWKMAEDSIKIPPSTNTVKQSWIVLENAQWNYLKNMIIGVLLFIS
VISWIILVG
```

##### GenBank

O formato GenBank é utilizado pelo 'National Center for Biotechnology Information' ([NCBI](https://www.ncbi.nlm.nih.gov/)), o maior repositório de sequências de ácidos nucleicos e proteínas do mundo. O NCBI, juntamente com o [EMBL-EBI](https://www.ebi.ac.uk/) e o [DDBJ](https://www.ddbj.nig.ac.jp/), mantém conjuntamente o 'The International Nucleotide Sequence Database' ([Mizrachi, 2008](https://pubmed.ncbi.nlm.nih.gov/27896718/)).

Uma entrada neste formato é composta por duas partes. A primeira parte abrange as posições de 1 a 10 e geralmente contém o nome do campo, como LOCUS, DEFINITION, ACCESSION ou SOURCE. A segunda parte de cada entrada contém informações correspondentes ao campo em questão. Cada entrada é finalizada com o símbolo '//'. Você pode encontrar mais informações sobre esse tipo de arquivo [aqui](http://www.ncbi.nlm.nih.gov/Sitemap/samplerecord.html).

```
LOCUS       BAE98952                 429 aa            linear   PLN 27-JUL-2006
DEFINITION  putative NAC domain protein [Arabidopsis thaliana].
ACCESSION   BAE98952
VERSION     BAE98952.1
DBSOURCE    accession AK226863.1
KEYWORDS    .
SOURCE      Arabidopsis thaliana (thale cress)
  ORGANISM  Arabidopsis thaliana
            Eukaryota; Viridiplantae; Streptophyta; Embryophyta; Tracheophyta;
            Spermatophyta; Magnoliopsida; eudicotyledons; Gunneridae;
            Pentapetalae; rosids; malvids; Brassicales; Brassicaceae;
            Camelineae; Arabidopsis.
REFERENCE   1
  AUTHORS   Totoki,Y., Seki,M., Ishida,J., Nakajima,M., Enju,A., Morosawa,T.,
            Kamiya,A., Narusaka,M., Shin-i,T., Nakagawa,M., Sakamoto,N.,
            Oishi,K., Kohara,Y., Kobayashi,M., Toyoda,A., Sakaki,Y.,
            Sakurai,T., Iida,K., Akiyama,K., Satou,M., Toyoda,T., Konagaya,A.,
            Carninci,P., Kawai,J., Hayashizaki,Y. and Shinozaki,K.
  TITLE     Large-scale analysis of RIKEN Arabidopsis full-length (RAFL) cDNAs
  JOURNAL   Unpublished
REFERENCE   2  (residues 1 to 429)
  AUTHORS   Totoki,Y., Seki,M., Ishida,J., Nakajima,M., Enju,A., Morosawa,T.,
            Kamiya,A., Narusaka,M., Shin-i,T., Nakagawa,M., Sakamoto,N.,
            Oishi,K., Kohara,Y., Kobayashi,M., Toyoda,A., Sakaki,Y.,
            Sakurai,T., Iida,K., Akiyama,K., Satou,M., Toyoda,T., Konagaya,A.,
            Carninci,P., Kawai,J., Hayashizaki,Y. and Shinozaki,K.
  TITLE     Direct Submission
  JOURNAL   Submitted (26-JUL-2006) Motoaki Seki, RIKEN Plant Science Center;
            1-7-22 Suehiro-cho, Tsurumi-ku, Yokohama, Kanagawa 230-0045, Japan
            (E-mail:mseki@psc.riken.jp, URL:http://rarge.gsc.riken.jp/,
            Tel:81-45-503-9625, Fax:81-45-503-9586)
COMMENT     An Arabidopsis full-length cDNA library was constructed essentially
            as reported previously (Seki et al. (1998) Plant J. 15:707-720;
            Seki et al. (2002) Science 296:141-145).
            This clone is in a modified pBluescript vector.
            Please visit our web site (http://rarge.gsc.riken.jp/) for further
            details.
FEATURES             Location/Qualifiers
     source          1..429
                     /organism="Arabidopsis thaliana"
                     /db_xref="taxon:3702"
                     /chromosome="1"
                     /clone="RAFL08-19-M04"
                     /ecotype="Columbia"
                     /note="common name: thale cress"
     Protein         1..429
                     /product="putative NAC domain protein"
     Region          5..137
                     /region_name="NAM"
                     /note="No apical meristem (NAM) protein; pfam02365"
                     /db_xref="CDD:426740"
     CDS             1..429
                     /gene="At1g01010"
                     /coded_by="AK226863.1:89..1378"
ORIGIN      
        1 medqvgfgfr pndeelvghy lrnkiegnts rdvevaisev nicsydpwnl rfqskyksrd
       61 amwyffsrre nnkgnrqsrt tvsgkwkltg esvevkdqwg fcsegfrgki ghkrvlafld
      121 grypdktksd wvihefhydl lpehqrtyvi crleykgdda dilsayaidp tpafvpnmts
      181 sagsvvnqsr qrnsgsynty seydsanhgq qfnensnimq qqplqgsfnp lleydfanhg
      241 gqwlsdyidl qqqvpylapy enesemiwkh vieenfeflv dertsmqqhy sdhrpkkpvs
      301 gvlpddssdt etgsmifedt ssstdsvgss depghtridd ipslniiepl hnykaqeqpk
      361 qqskekviss qksecewkma edsikippst ntvkqswivl enaqwnylkn miigvllfis
      421 viswiilvg
//
```

#### Algumas operações básicas com sequências no formato Fasta

Durante o restante desta seção e na próxima, usaremos apenas sequências no formato Fasta. Por favor, verifique se as sequências de _A. thaliana_ no arquivo 'TAIR10_pep_20101214_updated.fasta' estão neste formato. Você pode usar o comando `head nome_do_arquivo` ou o comando `less nome_do_arquivo` para fazer isso.

Você já teve que contar o número de sequências num arquivo ou alterar o identificador das sequências no formato Fasta? Se fossem apenas algumas sequências, isso poderia ser feito facilmente em qualquer editor de texto. No entanto, quando se trata de milhares de sequências, a opção de usar um editor de texto deixa de ser viável. Felizmente, alguns comandos do Unix nos permitem realizar essas tarefas simples de forma rápida.

Como observado anteriormente, o comando `grep` pode nos ajudar a contar o número de sequências em um arquivo Fasta. O modificador `-c` conta o número de linhas que contêm um padrão específico em um arquivo, e podemos aproveitar o fato de que em um arquivo Fasta o símbolo _>_ aparece uma única vez para cada sequência. Para contar o número de sequencias armazenadas no arquivo pode usar o comando:

```
grep -c ">" TAIR10_pep_20101214_updated.fasta
```

Em outras situações, é importante modificar o identificador de cada sequência para incluir, por exemplo, uma abreviatura que represente o nome da espécie à qual a sequência pertence. Novamente, o Unix nos permite fazer essa alteração rapidamente usando o comando `sed`. Vamos adicionar a partícula 'ATH' a cada um dos identificadores do arquivo, aproveitando o fato de que à esquerda de cada identificador temos o símbolo '>'. Observe que os resultados desta operação estão sendo armazenados em um novo arquivo:

```
sed 's/>/>ATH_/' TAIR10_pep_20101214_updated.fasta > TAIR10_pep_20101214_updated.mod.fasta
```
As linhas com os identificadores neste arquivo são muito extensas, para muitos programas isto não é desejável. Vamos eliminar tudo que aparecer depois do primeiro ' |'. Para isso vamos usar [regular expressions](https://www.gnu.org/software/sed/manual/html_node/Regular-Expressions.html).

```
sed -r 's/ | .*$//' TAIR10_pep_20101214_updated.mod.fasta > TAIR10_pep_20101214_updated.mod2.fasta
```

### Buscas em banco de dados biológicos

#### NCBI – Bancos de dados e busca de informações

O National Center for Biotechnology Information (NCBI), uma instituição pública dos Estados Unidos, é responsável por armazenar informações sobre os genomas de diversas espécies, além de manter o maior banco de dados público de sequências de DNA e proteínas. Sua página principal pode ser acessada pelo seguinte link: http://www.ncbi.nlm.nih.gov/. Este site interliga todos os dados disponíveis em seus servidores, incluindo PubMed, todos os bancos de dados (Entrez), Blast, OMIM, Books, TaxBrowser, Structure, como ilustrado na figura. Embora o Entrez esteja listado como um dos serviços, na realidade, quase todos eles dependem diretamente do Entrez. Por exemplo, PubMed e Taxonomy estão intimamente ligados ao Entrez.

Vamos começar uma visita aos seus bancos de dados. Como primeiro passo, vamos acessar o PubMed. Esta base de dados contém informações sobre publicações científicas, cujos registros foram compilados pela National Library of Medicine (NLM), com a colaboração dos editores. Lá, você encontrará a maioria das referências necessárias, incluindo o resumo (Abstract) e, em alguns casos, o acesso gratuito à publicação. Para obter ajuda sobre como realizar buscas, consulte o seguinte link: http://www.ncbi.nlm.nih.gov/bookshelf/br.fcgi?book=helppubmed. As páginas possuem um menu de banco de dados em uma barra superior, e as pesquisas devem ser inseridas na janela mostrada na figura Uma busca deve seguir um formato semelhante a este:

__palavrachave__[campo] operador lógico __palavrachave__[field] . . .

![Pagina inicial de buscas no NCBI](Figs/NCBIStart.png)

Onde "palavra-chave" é a palavra utilizada para identificar um registro de acordo com o campo utilizado. Por exemplo, uma palavra-chave pode ser "Silva" no campo "authors". Operador lógico é qualquer um destes operadores booleanos: AND, OR, NOT, etc. Ao substituir por suas próprias palavras-chave no formato acima, lembre-se de que os campos devem estar entre colchetes [ ], mas os operadores são independentes (sem os símbolos), além disso, as aspas na palavra-chave são opcionais, mas servem para forçar uma busca pela palavra exata em vez de uma busca flexível. Por exemplo, se eu quiser pesquisar todos os artigos de 1999 publicados por Silva et al. na revista Science, eu uso o seguinte comando: "Silva"[AU] AND 1999[DP] AND "Science"[TA]. Quanto mais informações forem inseridas na busca, mais restrita será a resposta (por exemplo, se eu incluir mais autores). Os campos mais comuns que podem ser solicitados no PubMed são os seguintes:

* __All Fields [ALL]__ inclui todos os campos pesquisáveis do PubMed. Contudo, somente os termos que não encontrarem correspondência em uma das tabelas ou índices de tradução pelo processo de Mapeamento Automático de Termos serão pesquisados em Todos os Campos. O PubMed ignora palavras irrelevantes em consultas de pesquisa.

* __Author Name [AU]__ existe um limite no número de nomes de autores incluídos na citação MEDLINE, que variou ao longo dos anos (veja a política da NLM sobre nomes de autores). O MEDLINE não lista o nome completo. O formato para pesquisar pelo nome do autor é: sobrenome seguido de espaço e até as duas primeiras iniciais, seguido de espaço e abreviação do sufixo, se aplicável, tudo sem pontos ou vírgulas após o sobrenome (por exemplo, Fauci AS ou O’Brien JC Jr). Iniciais e sufixos podem ser omitidos na busca. O PubMed automaticamente trunca o nome de um autor para considerar iniciais variadas, por exemplo, "O’Brien J [AU]" recuperará "O’Brien JA", "O’Brien JB", "O’Brien JC Jr", bem como "O’Brien J". Para desativar esse truncamento automático, coloque o nome do autor entre aspas duplas e qualifique com [au] entre colchetes, por exemplo, "O’Brien J"[AU] para recuperar apenas "O’Brien J".

* __EC/RN Number [RN]__ é o número atribuído pela Enzyme Commission para designar uma enzima específica ou pelo Chemical Abstracts Service (CAS) para números de registro.

* __Entrez Date [EDAT]__ é a data em que a citação foi adicionada ao banco de dados PubMed. As citações são exibidas por ordem de data de entrada, com as mais recentes primeiro. As datas ou intervalos de datas devem ser inseridos no formato AAAA/MM/DD [edat], ex. 1998/04/06 [edat]. O mês e o dia são opcionais (por exemplo, 1998 [edat] ou 1998/03 [edat]). Para intervalos de datas, use dois pontos (:) entre as datas (por exemplo, 1996:1997 [edat] ou 1998/01:1998/04 [edat]).

* __Issue [IP]__ é o número da edição da revista na qual o artigo foi publicado.

* __Journal Title [TA]__ é a abreviatura do título do periódico, o nome completo do periódico ou número ISSN.

* __Language [LA]__ especifica o idioma da publicação.

* __Publication Date [DP]__ é a data em que o artigo foi publicado. As datas ou intervalos de datas devem ser pesquisados usando o formato AAAA/MM/DD [dp], ex. 1998/03/06 [dp]. O mês e o dia são opcionais (por exemplo, 1998 [dp] ou 1998/03 [dp]). Para intervalos de datas, insira dois pontos (:) entre as datas (por exemplo, 1996:1998 [dp] ou 1998/01:1998/04 [dp]).

* __Text Words [TW]__ inclui todas as palavras e números no título e resumo, além de termos MeSH, subtítulos, nomes de substâncias químicas, nome pessoal como assunto e o campo de Fonte Secundária (Secondary Source ID, SI) do MEDLINE. O campo "Nome pessoal como assunto" também pode ser pesquisado diretamente usando a tag de campo de pesquisa [ps], por exemplo, "rouxinol f [ps]".

* __Title Words [TI]__ abrange palavras e números incluídos no título de uma citação.

* __Title/Abstract Words [TIAB]__ engloba palavras e números presentes tanto no título quanto no resumo de uma citação.

* __Unique Identifiers [UID]__ são identificadores únicos atribuídos a cada registro no PubMed.

* __Volume [VI]__ refere-se ao número do volume da revista em que um artigo foi publicado.

Agora, vamos acessar o site onde o ENTREZ está localizado. Para fazer isso, selecione "TODOS OS BANCOS DE DADOS" na janela do banco de dados na página principal. O Entrez é um sistema de busca para sequências armazenadas em bancos de dados. Consultas sofisticadas podem ser feitas para obter um conjunto de sequências de seu interesse. Por exemplo, é possível solicitar a exibição de todas as sequências genômicas de Arabidopsis que foram incluídas no banco de dados entre os anos de 1997 e 1999, e que também contêm anotações (na tabela "features") nas regiões promotoras. A seguinte figura mostra a página de login do servidor Entrez.

![Entrez](linux/Figs/screenshotEntrez.png)

Assim, em um único site, podemos realizar buscas simultaneamente em todas as bases de dados ou selecionar uma única base de dados para realizar uma busca específica. Na caixa de busca, as sequências podem ser consultadas usando seus números identificadores (como o GI number ou o número de acesso). Questões mais complexas também podem ser formuladas usando a sintaxe do Entrez, de maneira semelhante ao que vimos no PubMed:
  
__palavrachave__[campo] operador lógico __palavrachave__[field] . . .

Para obter mais informações sobre o Entrez, você pode acessar o link: http://www.ncbi.nlm.nih.gov/bookshelf/br.fcgi?book=helpentrez&part=EntrezHelp.

##### Exercícios

1. ![exercicio](linux/Figs/f03c15.png)Qual é a classificação taxonômica da alga Chlamydomonas reinhardtii e quais outras plantas estão próximas, que possam ser usadas como fonte de marcadores? Quantas sequências de proteínas estão presentes no GenBank para a espécie Chlamydomonas reinhardtii?

2. ![exercicio](linux/Figs/f03c15.png)Acesse a página do PubMed e obtenha referências que tratam da biologia molecular e/ou genética da mandioca (Manihot esculenta). Quantos artigos foram publicados nos últimos dois anos e de quais laboratórios (ou regiões geográficas) são os autores? Explique como você realizou a pesquisa.

3. ![exercicio](linux/Figs/f03c15.png)Utilize o Entrez para encontrar todas as sequências EST (Expressed Sequence Tag) de arroz que foram depositadas no banco de dados.

#### Quais bancos de dados encontramos no NCBI?

O NCBI possui um grande número de bancos de dados, sendo o mais conhecido o GenBank, que contém todas as sequências de nucleotídeos. O GenPept contém as sequências de proteínas. Outras bases de dados incluem Genome, Structure e PubMed. 

##### GenBank

No GenBank, as sequências estão organizadas em 17 divisões, sendo 11 tradicionais e 6 Bulk. Nas divisões tradicionais, as sequências foram enviadas diretamente pelos pesquisadores e são caracterizadas, e as divisões são:

- PRI primatas
- PLN plantas
- BCT bactérias
- INV invertebrados
- ROD Roedores
- VRL Viral
- VRT outros vertebrados
- MAM Mamíferos (Ej. ROD + PRI)
- PHG Fagos
- SYN Sintético (vetores de clonagem, etc)
- UNA sem anotacãao

O Bulk consiste em sequências enviadas em grupos, por email ou FTP, que podem ser imprecisas e mal caracterizadas. Entre elas estão:

- __dbEST (Banco de Dados de EST, Tags de Sequências Expressas)__: Contém sequências expressas, fornecendo uma visão rápida da expressão gênica em diferentes condições ou tecidos.

- __dbSTS (Sequence-Tagged Sites)__: São marcadores genômicos curtos para os quais existem informações de sequência e de mapa, utilizados em mapeamento genético e localização de genes.

- __dbGSS (Genomic Survey Sequences)__: Inclui dados de sequência de genoma de etapa única, sequências terminais de BAC, YAC e cosmídeos, e sequências de exon, contribuindo para o mapeamento genômico.

- __dbHTGS (High-Throughput Genomic Sequences)__: Foi criado para armazenar informações de sequenciamento de genoma que ainda não foram finalizadas ou curadas, com o objetivo de torná-las disponíveis para a comunidade científica assim que possível.

Também existem bancos de dados específicos para:

- __HTC (High Throughput cDNA)__: Sequências de cDNA geradas em alta escala, úteis para estudos de expressão gênica e identificação de novos genes.

- __PAT (Patent)__: Sequências relacionadas a patentes, incluindo informações genéticas e biotecnológicas importantes para a propriedade intelectual e o desenvolvimento de novas tecnologias.

##### RefSeq

Queremos dar ênfase especial a um banco de dados do NCBI chamado RefSeq. Esse banco de dados foi criado para fornecer uma coleção biologicamente não redundante de sequências de DNA, RNA e proteínas. Cada RefSeq (sequência de referência) representa uma molécula única que ocorre naturalmente em um organismo. Essa base de dados é curada por pesquisadores, onde cada molécula não é um resultado de pesquisa direto, mas sim uma síntese de informações.

Vamos retornar à página principal do NCBI e, na janela de busca, deixando "all databases" selecionado, digite NC_001139. Verificamos que em Nucleotide temos 1 resultado, assim como em Genome, e em Gene temos 631 resultados.

Ao abrir Nucleotide, obtemos um flatfile de sequência que corresponde à sequência completa do cromossomo VII da levedura. Ao examinar o arquivo flatfile, podemos ver que ele contém várias informações. ![exercicio](linux/Figs/f03c15.png)Quais são elas?

É importante notar que os identificadores nesta base de dados mudam e são do tipo 2+6, com duas letras seguidas de 6 números. A tabela a seguir nos mostrará o que essas letras significam:

![Identificadores no RefSeq](linux/Figs/RefSeqIdentifiers.png)

#### Recuperação de Sequências no NCBI com Buscas Mais Específicas

Se conhecemos o organismo, as buscas no NCBI podem ser mais direcionadas. Acessando a página inicial do NCBI, vamos para o TaxBrowser e inserimos o nome do organismo que estamos procurando. Ao selecioná-lo, uma tabela com o número de sequências por tipo de molécula ou projeto aparece à direita. Clicar em uma das opções, como proteínas, nos direciona diretamente às proteínas daquele organismo.

Se sabemos os números de acesso, podemos inseri-los diretamente na janela de pesquisa da página principal do NCBI. Para várias sequências, os números são colocados com a palavra "OR" entre eles, por exemplo, AJ487842 OR AJ487843. Finalmente, para uma sequência de números de acesso, digite: AJ487842::AJ487851[ACCN].

Direcionamos a Pesquisa com Limites. Por exemplo, se eu quiser pesquisar as sequências de mRNA curadas relacionadas a um tipo de câncer em humanos, posso realizar a seguinte pesquisa: na janela de busca, digito "COLON CANCER AND NONPOLYPOSIS" e pesquiso no banco de dados de nucleotídeos. Então, em "Limits", seleciono a molécula de mRNA e em "only from" escolho RefSeq. Depois, vou para a janela "Preview/Index" acima e, em "Organismos", digito "humanos" e seleciono "AND".


## Bioinfo 2 - EMBOSS

[EMBOSS](https://emboss.sourceforge.net/), "The European Molecular Biology Open Software Suite", é um pacote de código aberto gratuito composto por centenas de aplicativos desenvolvidos especificamente para as necessidades da comunidade de biologia molecular. As áreas abrangidas pelas aplicações EMBOSS incluem alinhamento de sequências, pesquisa em bancos de dados usando padrões, identificação de motivos proteicos e análise de uso de códons. 

Você encontra descrições dos pacotes de EMBOSS neste [link](https://emboss.sourceforge.net/apps/release/6.6/emboss/apps/).￼

###  Recuperando sequências de bancos de dados

A recuperação de sequências de um banco de dados depende dos bancos disponíveis.

Vamos recuperar a sequência do gene ANAC092 do banco de dados de proteínas UniProt. Para isso  é necessário acessar o site do [UniProt](https://www.uniprot.org/) e localizar o identificador correto. 

![Busca no Uniprot](linux/Figs/uniprot.png)

![Registro em Uniprot](linux/Figs/get_seq_link.png)

Com o identificador apropriado, também podemos baixar a sequência em formato .txt, utilizando o comando wget.

```bash
wget https://www.uniprot.org/uniprot/D7MJK1.txt
```

Na sua tela deve aparecer algo semelhante ao seguinte quadro:

```
--2022-04-06 14:23:06-- https://www.uniprot.org/uniprot/D7MJK1.txt
3 Resolving www.uniprot.org (www.uniprot.org)... 193.62.193.81
4 Connecting to www.uniprot.org (www.uniprot.org)|193.62.193.81|:443... connected.
5 HTTP request sent, awaiting response... 200
6 Length: 4570 (4,5K) [text/plain]
7 Saving to: ‘D7MJK1.txt’
8 D7MJK1.txt 100%[===================>] 4,46K --.-KB/s in 0s
9 2022-04-06 14:23:08 (275 MB/s) - ‘D7MJK1.txt’ saved [4570/4570]
```

Em seguida, usaremos um programa da suíte EMBOSS para alterar o formato do registro baixado do UniProt. O programa utilizado será o "seqret". Você pode usar o comando "wossname" para procurar programas do EMBOSS que contenham em sua descrição uma palavra-chave específica. Antes de usar os programas do EMBOSS, é necessário ativar o ambiente que contém o software instalado em seu computador.

```bash
conda activate emboss
```

Note que seu prompt mudiou, agora exibindo o nome do ambiente ativado, neste caso, emboss. Lembre-se de desativar o ambiente quando terminar de usá-lo, para retornar ao estado original do seu sistema, usando o comando:

```bash
conda deactivate
```

Agora, você pode usar o mesmo programa, "seqret", para converter o arquivo .txt recuperado do UniProt para o formato FASTA. Consulte a pagina de manual do seqret para aprender sua sintaxe. ![exercicio](linux/Figs/f03c15.png) Descreva como pode converte a formato Fasta. 

Após ter sua sequência em formato fasta, para fazer cálculos sobre essas sequências, utilize o programa "compseq" do EMBOSS, que permite calcular a composição de palavras em uma sequência. ![exercicio](linux/Figs/f03c15.png) Calcule a frequência de monômeros e dímeros na sequência do ANAC092.

![exercicio](linux/Figs/f03c15.png) Existe alguma diferença entre o valor observado e o esperado das frequências de dímeros. O valor esperado para cada dímero vem de qual fonte?

### Seleção de quadros de leitura aberta

Um quadro de leitura aberta (ou [ORF de "Open Reading Frame"](https://en.wikipedia.org/wiki/Open_reading_frame)) refere-se a uma parte de uma sequência de ácidos nucléicos que pode ser traduzida em proteínas. Este segmento começa com um códon de início (usualmente AUG, que codifica a metionina) e termina com um códon de parada, sem quaisquer outros códons de parada entre eles. O ORF determina como os nucleotídeos são agrupados em códons, que por sua vez são traduzidos em aminoácidos para formar proteínas.

Os programas __getorf__ e __plotorf__ identificam ORFs em sequências de nucleotídeos. Um QLA é uma sequência (ou subsequência) de um comprimento mínimo especificado, delimitada por códons de parada ou por um códon de início e um de parada. iA pesar da universalidade do código genético, existem variações entre alguns grupos de organismos, por isso é crucial especificar o código genético utilizado para a tradução da sequência ou os códons de início e parada permitidos.

![exercicio](linux/Figs/f03c15.png) Use os programas getorf e plotorf para identificar o quadro de leitura aberto correto da sequência "[ANAC092_cDNA.fa](https://raw.githubusercontent.com/labbces/cen0485/main/files/ANAC092_cDNA.fa)". Verifique se existe alguma diferença nos resultados fornecidos por ambos os programas. Descreva o processo que realizou.

### Embaralhar/misturar Sequências

Ao realizar certos tipos de análise, por exemplo, a busca por sítios de ligação a fatores de transcrição em sequências de promotores (TFBS), é essencial ter um grupo de sequências como controle negativo, i.e., onde não é esperado encontrar o sitio de ligação. Uma prática comum é gerar sequências aleatórias que mantenham a composição monomérica das sequências originais. O programa "shuffleseq" realiza essa tarefa, embaralhando os monômeros de uma sequência "real" para produzir uma sequência aleatória. Geralmente, são geradas 1000 sequências aleatórias para cada sequência original.

![exercicio](linux/Figs/f03c15.png) Use o "shuffleseq" para gerar duas sequências aleatórias a partir do rRNA encontrado no arquivo [FN566965.fasta](https://raw.githubusercontent.com/labbces/cen0485/main/files/FN566965.fasta). ![exercicio](linux/Figs/f03c15.png) Calcule as frequências de dímeros da sequência original e das duas sequências aleatórias. Verifique se há diferenças. As diferenças, se encontradas, podem ser explicadas pela variabilidade aleatória. Explique! [exercicio](linux/Figs/f03c15.png) Descreva o processo.

![exercicio](linux/Figs/f03c15.png) Realize uma busca na literatura e encontre um artigo onde sejam utilizadas sequências aleatórias para testar alguma hipótese. Descreva brevemente o trabalho e como as sequências aleatórias foram utilizadas, deixando uma referência clara do artigo para facilitar sua localização.

## Bioinfo 3 - Comparação de Sequências I - Matrizes de pontos

As matrizes de pontos (“Dot Plot”) são ferramentas exploratórias para comparar strings de texto, ou seja, sequências. Entre outros, eles nos permitem encontrar facilmente regiões repetidas em uma sequência comparando-a com ela mesma. Também podemos ter uma boa ideia da estrutura de um gene comparando a sequência de sua região de codificação com a sequência do locus onde se encontra. 

Nesta seção, usaremos a implementação de matrizes de pontos do Instituto Suı́ço de Bioinformática, conhecida como [DotLet](https://dotlet.vital-it.ch/), que vemos na seguinte figura:

![dotlet](Figs/DotLet-1.png)

Vamos a comparar a sequencia [FN566965](https://raw.githubusercontent.com/labbces/cen0485/main/files/FN566965.fasta) contra ela mesma. A figura abaixo mostra como dar um nome à sequência e colá-la na caixa correspondente:

![dotlet-seqs](Figs/DotLet-2.png)

De volta à janela DotLet vemos que encontramos dois botões habilitados, eles agora aparecem com o nome da sequência que você acabou de adicionar. Uma delas representa a sequência que aparece na direção horizontal, a outra a sequência que aparece na direção vertical.

À direita dos botões/listas que identificam as sequências, encontramos dois parametros importantes, o tamanho de janela e matriz de substituição/pontoação. O que significam esses parametros? ![exercicio](linux/Figs/f03c15.png) Descreva o que você entendeu sobre eles.

Uma vez calculada a matriz de pontos, observamos duas seções de resultados. A região à esquerda mostra a própria matriz, em que pixels escuros representam pontuações baixas, ou seja, indesejáveis. À esquerda, visualizamos um histograma da frequência de cada pontuação. Manipulando este histograma, por meio das barras de rolagem horizontais, é possível ajustar a exibição da matriz de pontos.

![dotlet-results](Figs/DotLet-3.png)

- ![exercicio](linux/Figs/f03c15.png) Explique como o tamanho da janela afeta a exibição na matriz de pontos.
- ![exercicio](linux/Figs/f03c15.png) Qual é o significado da linha rosa no histograma de pontuação?
- ![exercicio](linux/Figs/f03c15.png) Compare a sequência de [cDNA](https://raw.githubusercontent.com/labbces/cen0485/main/files/ANAC092_cDNA.fa) e sua contraparte [genômica de ANAC092](https://raw.githubusercontent.com/labbces/cen0485/main/files/ANAC092_genomic.fasta). Descreva os resultados.

O DotLet é um programa básico para a criação de matrizes de pontos que, infelizmente, não consegue lidar com alguns casos mais complexos, como por exemplo, a visualização de regiões repetidas invertidas nas sequências comparadas. Por essa razão, optaremos por utilizar outro programa para matrizes de pontos, desta vez acessível a partir da linha de comando.

Vamos usar o programa [Re-Dot-Table](https://www.bioinformatics.babraham.ac.uk/projects/redotable/) para comparar a sequência do arquivo [secondarystructure.fasta](https://raw.githubusercontent.com/labbces/cen0485/main/files/secondarystructure.fasta) com ela mesma.

Esta sequência adquire a estrutura secundária que aparece abaixo. Nesta estrutura, as regiões que formam stems correspondem a repetições invertidas, que podem ser visualizadas como diagonais com inclinação oposta à diagonal principal no dotplot.

![secondary structure](Figs/secondarystructure.png)

Para gerar o dotplot com o software Re-Dot-Table, é necessário ativar um ambiente Conda no qual o software foi previamente instalado e, em seguida, executar o aplicativo:
  
```bash 
conda activate redotable
redotable
```

A seguinte figura mostra o resultado dessa comparação. Explore o efeito do tamanho da janela para gerar o dotplot.

![redotable](Figs/redotable_1.png)

Ao terminar lembre-se de desativar seu ambiente:

```bash
conda deactivate
```

- ![exercicio](linux/Figs/f03c15.png) Explique como o tamanho da janela afeta a exibição na matriz de pontos.
- ![exercicio](linux/Figs/f03c15.png) Qual é o significado das linhas azuis e vermelhas na matriz de pontos?

Encontre quais programas do EMBOSS conseguem criar dotplots. Pode usar o pacote wossname para fazer buscas com palavras-chave na descrição dos programas de EMBOSS. Lembre-se de ativar o ambiente de EMBOSS.

```bash
conda activate emboss
```

Recupere do [NCBI](https://www.ncbi.nlm.nih.gov/) as sequencias NM_214647 e NW_732498. Crie um dotplot com as sequências de cDNA (NM_214647) e genômica (NW_732498) e ![exercicio](linux/Figs/f03c15.png): descreva as sequências, por exemplo, em qual banco de dados estavam disponiveis, o organismo de origem, seus comprimentos; em seguida, descreva o procedimento para realizar o dotplot, como a seleção de parâmetros e, finalmente, descreva seus resultados.

Não esqueça de desativar o ambiente de EMBOSS.

```bash
conda deactivate
```

## Bioinfo 4 - Comparação de Sequências II - Alinhamentos de pares de sequências

Algumas partes deste capı́tulo vêm do tutorial disponivel neste [link](http://emboss.sourceforge.net/docs/emboss_tutorial/emboss_tutorial.pdf).

Para realizar os exercícios deste capítulo, lembre-se de ativar o ambiente conda do EMBOSS, conforme demonstrado na linha a seguir.

```bash
conda activate emboss
```

Quando terminar os exercícios, ou antes de ativar outro ambiente, lembre-se de desativar o ambiente atualmente ativo:

```bash
conda deactivate
```
### Matrizes de substituição

Vamos procurar, dentro da suíte do EMBOSS, o arquivo com a matriz de substituição PAM250. Para isso, você pode executar o seguinte comando:

```bash
embossdata EPAM250
```

Você obterá uma saída na sua tela semelhante à seguinte:

```
Find and retrieve EMBOSS data files
# The following directories can contain EMBOSS data files.
# They are searched in the following order until the file is found.
# If the directory does not exist, then this is noted below.
# '.' is the UNIX name for your current working directory.

File ./EPAM250                                                    Does not exist
File .embossdata/EPAM250                                          Does not exist
File /home/diriano/EPAM250                                        Does not exist
File /home/diriano/.embossdata/EPAM250                            Does not exist
File /usr/share/EMBOSS/data/EPAM250                               Exists
```

O que esperamos encontrar é o caminho onde o arquivo EPAM250 está armazenado. Observe que, em uma das linhas, a última palavra é 'Exists', indicando que o arquivo se encontra naquele local. Selecione o caminho do arquivo e visualize-o com o comando 'less':

```
less /usr/share/EMBOSS/data/EPAM250 
```

Responda:

- ![exercicio](linux/Figs/f03c15.png) Quem, e como, criou a famı́lia PAM de matrizes de substituição?
- ![exercicio](linux/Figs/f03c15.png) Onde estão as maiores pontuações? Explicar.
- ![exercicio](linux/Figs/f03c15.png) Qual é a substituição com a maior pontuação?
- ![exercicio](linux/Figs/f03c15.png) Por que as identidades não têm sempre a mesma pontuação?

### Alinhamento Global

No alinhamento global, o objetivo é comparar duas sequências ao longo de toda a sua extensão. Portanto, é apropriado quando esperamos que a semelhança entre as duas sequências se estenda por toda a sequência. No pacote EMBOSS, você encontrará o aplicativo 'needle', que implementa rigorosamente o algoritmo de [Needleman e Wunsch (1970)](https://doi.org/10.1016/0022-2836(70)90057-4) para obter o alinhamento global ideal por meio de programação dinâmica. Esta implementação pode demorar algum tempo para obter o alinhamento quando as sequências são longas.

- ![exercicio](linux/Figs/f03c15.png) Quais outros aplicativos no EMBOSS permitem que você faça alinhamentos globais? 
- ![exercicio](linux/Figs/f03c15.png) O que os torna diferentes de 'needle'?
- ![exercicio](linux/Figs/f03c15.png) Faça um alinhamento global entre o [cDNA](https://raw.githubusercontent.com/labbces/cen0485/main/files/ANAC092_cDNA.fa) e a sequência [genômica](https://raw.githubusercontent.com/labbces/cen0485/main/files/ANAC092_genomic.fasta) do gene ANAC092.
- ![exercicio](linux/Figs/f03c15.png) Qual matriz de substituições e penalidades para abrir e estender GAPs que você usou? Ex-
plicar.
- ![exercicio](linux/Figs/f03c15.png) Qual é a pontuação do alinhamento, seu comprimento e as porcentagens de identidade e
semelhança?
- ![exercicio](linux/Figs/f03c15.png) Explique a diferença entre semelhança e identidade.
- ![exercicio](linux/Figs/f03c15.png) O que significam os sı́mbolos? :, . y |?

Compare as sequências de aminoácidos das proteinas [ANAC092_pep.fasta](https://raw.githubusercontent.com/labbces/cen0485/main/files/ANAC092_pep.fasta) e [Pp3c6_27690](https://phytozome-next.jgi.doe.gov/report/gene/Ppatens_v3_3/Pp3c6_27690), codificadas por dois genes da família NAC de fatores de transcrição, em _Arabidopsis lyrata_ e no musgo _Physcomitrella patens_, respectivamente.

- ![exercicio](linux/Figs/f03c15.png)  Realize um alinhamento global entre as sequências de aminoácidos das proteínas NAC de _Arabidopsis lyrata_ e do musgo _Physcomitrella patens_.
- ![exercicio](linux/Figs/f03c15.png) Qual matriz de substituições e de penalidades utilizadas para abrir e estender gaps usou? Por favor, explique sua escolha.
- ![exercicio](linux/Figs/f03c15.png) Qual é a pontuação do alinhamento, seu comprimento, e quais são os percentuais de identidade e semelhança obtidos?
- ![exercicio](linux/Figs/f03c15.png) É possível melhorar o alinhamento ajustando outros parâmetros? Discuta suas opções.

### Alinhamento local

Conforme mencionado na seção anterior, o alinhamento global compara sequências ao longo de todo o seu comprimento. É necessário decidir se essa estratégia é a mais adequada para cada caso específico. O que aconteceria se você comparasse duas proteínas multidomínio que compartilham apenas um domínio entre si?

O objetivo do alinhamento local é identificar regiões de similaridade localizada, sem a necessidade de incluir as sequências completas. Esse tipo de alinhamento é particularmente útil para pesquisar em bancos de dados ou quando a semelhança entre a sequência de interesse e as sequências disponíveis no banco de dados não é conhecida.

Dentro do pacote EMBOSS, você encontrará a aplicação 'water', que implementa o algoritmo de [Smith e Waterman (1981)](https://doi.org/10.1016/0022-2836(81)90087-5) para obter o alinhamento local exacto através de programação dinâmica. Esta implementação pode demorar algum tempo para alcançar o alinhamento, especialmente quando as sequências são longas.

- ![exercicio](linux/Figs/f03c15.png) Que outros aplicativos no EMBOSS permitem que você faça alinhamentos locais? O que os
torna diferentes de water?
- ![exercicio](linux/Figs/f03c15.png) Faça um alinhamento local entre as sequências de aminoácidos das proteı́nas NAC de _Arabidopsis lyrata_ e do musgo _Physcomitrella patens_, que você usou na seção anterior.
- ![exercicio](linux/Figs/f03c15.png) Qual a matriz de subtituição e penalidades para abrir e estender gaps que você usou? Explicar.
- ![exercicio](linux/Figs/f03c15.png) Quais são as diferenças entre o alinhamento global e local dessas duas sequências?

### Significado dos alinhamentos

Independentemente das sequências fornecidas aos programas de alinhamento, eles sempre produzirão um alinhamento. Utilize as sequências de aminoácidos [ANAC092](https://raw.githubusercontent.com/labbces/cen0485/main/files/ANAC092_pep.fasta) e empregue o programa 'shuffleseq' para gerar duas sequências aleatórias com a mesma composição monomérica que ANAC092. Realize um alinhamento global e local com essas duas sequências aleatórias.

- ![exercicio](linux/Figs/f03c15.png) Qual é a pontuação do alinhamento, seu comprimento, e quais são os percentuais de identidade e semelhança?

Prossiga realizando um alinhamento local e global entre a sequência de aminoácidos de ANAC092 e uma das versões aleatórias.

- ![exercicio](linux/Figs/f03c15.png) Qual é a pontuação do alinhamento, seu comprimento, e quais são os percentuais de identidade e semelhança?
- ![exercicio](linux/Figs/f03c15.png) Discurse sobre seus resultados.

### Basic Local Alignment Search Tool - BLAST

A seguinte figura mostra os sabores de BLAST disponiveis no NCBI. Na primeira parte deste tutorial, realizaremos alguns exercícios utilizando esta interface gráfica do BLAST.

![BLAST home](Figs/BLAST_flavours.png)

O arquivo [desconocido.nuc.fa](https://raw.githubusercontent.com/labbces/cen0485/main/files/desconocido.nuc.fa), contém a sequência nucleotídica de um transcrito descoberta por você ao realizar uma análise de expressão diferencial em _A. thaliana_ sob tratamento com luz ultravioleta (UV-A), condição que induziu este transcrito. Copie a sequência da transcrição e acesse o site http://blast.ncbi.nlm.nih.gov/ através do se navegador navegador web. Vamos conduzir uma pesquisa BLAST básica; procure na página a busca com o programa 'blastx'. ![exercicio](linux/Figs/f03c15.png) Por que escolher 'blastx'?

No 'blastx', cole sua sequência desconhecida no campo “Enter query sequence” e digite Viridiplantae no campo “Organism” para restringir a busca a sequências de plantas verdes. Certifique-se de que o banco de dados selecionado seja o banco de dados não redundante de sequências proteicas.

![BLASTx input](linux/Figs/blastx_input.png)

Em buscas que envolvem a tradução online de uma sequência de DNA, você pode escolher o código genético a ser utilizado na tradução. Assegure-se de que o código genético selecionado seja o “Standard”. Mais abaixo, clique no link “Algorithm parameters”, o que revelará uma série de opções. Na seção “General parameters”, encontre o limiar esperado ou valor E. O valor E é o número esperado de alinhamentos com uma pontuação igual ou maior que a obtida que apareceriam por acaso. Ao selecionar alinhamentos significativos, este é o parâmetro mais importante; geralmente, alinhamentos com um valor E menor que 1 × 10^−5 representam sequências homólogas. No entanto, se estiver alinhando sequências muito curtas, por exemplo, de 20 resíduos, você deve permitir alinhamentos com um valor E muito alto, cerca de 100. Na seção “Scoring parameters”, você pode selecionar a matriz de substituição (escolha BLOSUM80) e a penalidade por inserir gaps no alinhamento. Observe que existe uma diferença entre o custo de introduzir um gap e o de estendê-lo. Por que essa diferença ocorre? As opções para abrir e estender gaps dependem da matriz de substituição escolhida.

![BLASTx input](linux/Figs/blastx_parameters.png)

Certifique-se de que a opção Filter na seção Filters and Masking esteja selecionada, a fim de reduzir o número de alinhamentos com sequências evolutivamente não relacionadas. 

Agora clique no botão BLAST e aguarde os resultados.

Os resultados fornecidos pelo BLAST vêm em diferentes apresentações. Primeiro encopntrará uma tabela com os melhores resultados (hits), mostrando o identificador (Número de Acesso) da sequência encontrada, uma parte de sua descrição, a pontoacão do alinhamento entre sua sequência desconhecida (_query_) e a sequência do banco de dados (_subject_), o percentual da sequência _query_ que está representado no alinhamento, a identidade e o valor E. É possível reordenar os dados nesta tabela clicando nos nomes das colunas. 

![BLASTx results 1](Figs/BLASTx_results1.png)

Também tem acesso a um resumo grafico dos _hits_. Este gráfico é uma representação dos melhores alinhamentos com um código de cores que indica o comprimento do alinhamento. 

![BLASTx results 2](Figs/BLASTx_results2.png)

Finalmente, você chega aos próprios alinhamentos. Aqui, encontrará novamente o escore e o valor E do alinhamento. Além disso, são apresentados o número de posições em que as duas sequências eram idênticas e similares (conforme a matriz de substituição) e o número de lacunas (gaps).

![BLASTx results 3](Figs/BLASTx_results3.png)

- ![exercicio](linux/Figs/f03c15.png) O que indicam as regiões dos alinhamentos que aparecem em cinza e em minúsculas? 
- ![exercicio](linux/Figs/f03c15.png) O que você pode dizer sobre a função do seu transcrito? Qual informação foi relevante para realizar essa inferência?

A interface web do NCBI BLAST é bastante intuitiva e amigável, entretanto, enfrenta algumas limitações ao se trabalhar com genômica e proteômica: (i) não é possível efetuar buscas em bancos de dados personalizados ou privados e (ii) existe uma limitação no número de sequências que podem ser utilizadas como consulta em cada busca. A solução mais eficiente para superar esses obstáculos é instalar o NCBI BLAST em um computador pessoal e configurar os bancos de dados específicos nos quais se deseja pesquisar. Este processo, no entanto, será abordado em outra ocasião.

## Bioinfo 5 - Comparação de Sequências III - Alinhamento Múltiplo de Sequências

Na teoria, os algoritmos de programação dinâmica descritos acima para alinhamentos de pares de sequências podem ser estendidos para o caso de um número arbitrário de sequências. Na prática, isso é computacionalmente muito caro, o que levou ao desenvolvimento de outros algoritmos que implementam atalhos na busca por alinhamentos ideais (heurísticos). O desenvolvimento de algoritmos para alinhamento de múltiplas sequências é uma área muito dinâmica na bioinformática. Atualmente, existem dezenas de programas que implementam diferentes algoritmos (ver [Notredame, 2007](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.0030123), e [Lemey et al., 2009](
https://doi.org/10.1017/CBO9780511819049), para uma revisão recente do tópico). Avanços recentes têm um foco especial dedicado à análise de milhões de sequências ([Santus et al., 2023](https://doi.org/10.1016/j.sbi.2023.102577)).

Nesta sessão, vamos desenvolver parte da prática apresentada no [capítulo 3 (página 100)](https://www.cambridge.org/core/books/phylogenetic-handbook/multiple-sequence-alignment/8625BB5832B90E7D5548928E8820E9B8) de [Lemey et al., 2009](
https://doi.org/10.1017/CBO9780511819049). Vamos alinhar as sequências dos genes TRIM5&alpha; de diferentes espécies de primatas. O TRIM5&alpha; é um fator de restrição viral que protege a maioria dos macacos do Velho Mundo (Cercopithecidae) da infecção pelo HIV. Esses dados foram originalmente analisados por [Sawyer et al., 2005](https://doi.org/10.1073/pnas.0409853102). Usaremos métodos de refinamento iterativo (Muscle) para criar alinhamentos proteicos e, em seguida, visualizar os resultados usando JalView. A partir do alinhamento das sequências proteicas vamos gerar o alinhamento correspondente no nível de nucleotídeo, terminando com a inspeção manual e o refinamento do alinhamento.

### Alinhando as sequências de aminoácidos de TRIM5&alpha; de primatas com Muscle

Para obter o alinhamento das sequências no arquivo [primatesAA.fasta](https://raw.githubusercontent.com/labbces/cen0485/main/files/primatesAA.fasta) pelo método de refinamento iterativo, usaremos o programa Muscle ([Edgar, 2004](https://doi.org/10.1186/1471-2105-5-113)). Este programa está instalado localmente em seu computador dentro do ambiente de conda compseqiii.

```
conda activate compseqiii 
cd
mkdir trim5alpha
cd trim5alpha
wget https://raw.githubusercontent.com/labbces/cen0485/main/files/primatesAA.fasta
muscle -align primatesAA.fasta -output primatesAA_muscle.afa
```

O programa completa o procedimento de alinhamento em alguns segundos e grava o arquivo de saída em formato fasta ("primatesAA_muscle.afa"). Você pode visualizar o alinhamento com o programa JalView, que possui uma interface gráfica muito intuitiva.

```
jalview primatesAA_muscle.afa
```

![JalView screenshot](Figs/jalview_primates.png)

- ![exercicio](linux/Figs/f03c15.png) Consegue identificar regiões de baixa qualidade no alinhamento? O que permite identificar essas regiões? Mostre um screenshot de algumas delas.

Muitas vezes, as regiões variáveisno alinhamento podem apresentar uma grande incerteza associada, e pode ser desejável descartá-las antes de prosseguir com as análises. O Trimal é uma ferramenta que facilita, entre outras funções, a tarefa de 'trimagem' do alinhamento de acordo com vários critérios selecionados pelo usuário. Em seguida, vamos usar o Trimal com a opção de remoção automática de regiões com muitos gaps, _-gappyout_. No entanto, repare que o software é muito flexível, e você pode especificar outros critérios que se adaptem melhor ao seu caso específico.

```
trimal  -in primatesAA_muscle.afa -out primatesAA_muscle.trim.afa -gappyout
```

- ![exercicio](linux/Figs/f03c15.png) Usando o jalview compare os dois alinhamentos *primatesAA_muscle.afa* e *primatesAA_muscle.trim.afa*. Descreva suas observações.

### TRIM5&alpha; do alinhemento de proteinas ao alinhamento de nucletídeos.

A degeneração do código genético leva a que um alinhamento de ácidos nucleicos forneça mais informações do que um alinhamento de proteínas. ![exercicio](linux/Figs/f03c15.png) Pode explicar por que isso acontece? No entanto, alinhar ácidos nucleicos de forma precisa é consideravelmente mais desafiador do que alinhar sequências de aminoácidos, principalmente devido às diferenças nos tamanhos dos alfabetos usados por essas macromoléculas: 4 nucleotídeos versus 20 aminoácidos.

Idealmente, alinhamentos em nível de nucleotídeos de sequências codificantes (CDS) deveriam respeitar as posições dos códons para manter a integridade funcional das proteínas codificadas. No entanto, programas como Muscle, MAFFT e ClustalX não consideram essa estrutura de códons, o que pode resultar em alinhamentos incorretos.

Para obter um alinhamento acurado em nível de nucleotídeos, é crucial utilizar ferramentas que integrem a análise de códons ou ajustar manualmente os alinhamentos para garantir que as trincas de nucleotídeos correspondam corretamente aos códons. Isso pode ser feito através de softwares especializados ou de abordagens complementares que focam em preservar a estrutura de códons durante o processo de alinhamento.

Nesta sessão prática, vamos empregar dois programas diferentes para obter o alinhamento em nível de nucleotídeos, informado pelo alinhamento das sequências de proteínas. Um desses programas é o [TranslatorX](http://translatorx.co.uk/), que possui uma interface web. Nele, você vai precisar do alinhamento das proteínas sem trimagem, e das [sequências de nucleotídeos correspondentes](https://raw.githubusercontent.com/labbces/cen0485/main/files/primatesNuc.fasta). ![exercicio](linux/Figs/f03c15.png) Descreva os passos para gerar esse alinhamento.

O outro programa que vamos usar é o Trimal, que já usamos para trimar as sequências. O Trimal consegue realizar dois passos simultaneamente: remover regiões duvidosas do alinhamento seguindo a especificação do usuário e obter o alinhamento de nucleotídeos compatível/informado com o alinhamento das proteínas. Vale a pena conferir a [documentação](http://trimal.cgenomics.org/) do Trimal para entender melhor as opções que ele oferece.

```
cd
cd trim5alpha
wget https://raw.githubusercontent.com/labbces/cen0485/main/files/primatesNuc.fasta
trimal  -in primatesAA_muscle.afa -out primatesAA_muscle.trim.nuc.afa -gappyout -backtrans primatesNuc.fasta
```

Realize um alihnamento das sequências de nucleotidos ignorando completamente a estrutura de códons usando mucle:

```
cd
cd trim5alpha
muscle -align primatesNuc.fasta -output primatesNuc_muscle.afa
```

- ![exercicio](linux/Figs/f03c15.png) Compare os alinhamentos *primatesNuc_muscle.afa* e *primatesAA_muscle.trim.nuc.afa* e descreva os resultados.

### Position-specific scoring matrices

As matrizes de pontuação específicas da posição (Position-specific scoring matrices, PSSMs) oferecem uma maneira sensível de representar a variabilidade em um alinhamento. Os PSSMs são construídos com base em alinhamentos múltiplos, por exemplo, dos sítios de ligação de fatores de transcrição. Abaixo está uma matriz que foi obtida a partir da base de dados de promotores de Saccharomyces cerevisiae e construída usando um alinhamento de 12 sítios de ligação do fator de transcrição [Pho4p](http://www.yeastract.com/view.php?existing=protein&proteinname=Pho4p) de levedura

![PSSM Pho4p](Figs/PSSM_Pho4p.png)

Cada linha representa um resíduo (A, C, G ou T) e cada coluna uma posição no conjunto de sequências alinhadas. Algumas posições são perfeitamente preservadas em todas as sequências, enquanto outras apresentam algumas alternativas. Ao utilizar esses tipos de matrizes para pesquisas, as posições mais conservadas impõem restrições mais fortes do que aquelas em que qualquer resíduo pode ser encontrado.

Siga o [link](https://jaspar.elixir.no/matrix/MA0265.3/) da PSSM que representa o sitio de ligação do fator de transcricão ABF1 de _Saccharomyces cerevisiae_ no banco de dados Jaspar.

- ![exercicio](linux/Figs/f03c15.png) Que tipo de informações estao armazenadas no banco de dados Jaspar?
- ![exercicio](linux/Figs/f03c15.png) Qual é o tamanho do alfabeto usado na matriz?
• ![exercicio](linux/Figs/f03c15.png) Qual é a largura da matriz?
• ![exercicio](linux/Figs/f03c15.png) Quantos sitios de ligação Abf1 estão armazenados no Jaspar? Qual cromossomo tem o maior número de sitios de ligação? Dica: examine o arquivo BED.

As PSSM podem ser representadas graficamente como Logos de Sequências (Sequence Logos). Esse tipo de representação foi concebido por [Schneider e Stephens](https://doi.org/10.1093/nar/18.20.6097) em 1990. A seguir, encontra-se o sequence logo que representa a matriz MA0265.3 do fator de transcrição ABF1:

![SeqLogo ABF1](Figs/SeqLogoABF1.png)

- ![exercicio](linux/Figs/f03c15.png) Explique brevemente o que está representado no sequence logo. O que está representado pelo eixo _y_? Como o conteúdo de informação de cada posição é calculado?

### Modelos ocultos de Markov: HMMs

Mesmo que você não encontre proteínas homólogas ao realizar uma busca com BLAST, ainda existem outras opções. A principal razão pela qual ele não encontra homólogos triviais é que pesquisas com sequências usando ferramentas como BLAST têm baixa sensibilidade. O BLAST normalmente não encontra proteínas homólogas que tenham menos de 30% de identidade. No entanto, algumas proteínas podem ter a mesma estrutura tridimensional e apresentar apenas 10% de identidade. Uma estratégia muito útil para encontrar ortólogos distantes é baseada no uso de Modelos de Hidden Markov (HMMs). Um HMM é essencialmente uma maneira probabilistica de definir motivos ou domínios.

Para criar um HMM, tudo o que você precisa é de um alinhamento múltiplo, que será usado para criar uma representação probabilística. Esta, por sua vez, pode ser utilizada para procurar sequências relacionadas. Os bancos de dados como o Pfam ([Mistry et al., 2021](https://doi.org/10.1093/nar/gkaa913)) são coleções de alinhamentos múltiplos para os quais os HMMs foram desenvolvidos. Estes modelos são utilizados para anotar sequências proteicas. A maior parte do trabalho dos curadores desses bancos de dados consiste em criar esses alinhamentos múltiplos. Recentemente o banco de dados PFAM foi integrado dentro do [InterPro](https://www.ebi.ac.uk/interpro/).

Vamos usar a seguinte proteı́na para fazer uma pesquisa no Pfam usando o Interpro:

```
>seq
MEYWHYVETTSSGQPLLREGEKDIFIDQSVGLYHGKSKILQRQRGRIFLTSQRIIYIDDAKPTQ
NSLGLELDDLAYVNYSSGFLTRSPRLILFFKDPSSKDELGKSAETASADVVSTWVCPICMVSNE
TQGEFTKDTLPTPICINCGVPADYELTKSSINCSNAIDPNANPRNQFGVNSENICPACTFANHP
QIGNCEICGHRLPNASKVRSKLNRLNFHDSRVHIELEKNSLARNKSSHSALSSSSSTGSSTEFV
QLSFRKSDGVLFSQATERALENILTEKNKHIFN
```

Vá para o site do [InterPro](https://www.ebi.ac.uk/interpro/), certifique-se de selecionar apenas a aplicação PFAM na seção de Advanced Options -> Applications, conforme mostra a figura:

![Interpro PFAM](Figs/InterProPFAM.png)

Discuta os resultados obtidos:

![InterPro PFAM results](Figs/InterProPFAMres.png)

## Bioinfo 6 - Montagem de genomas

O processo de montagem de genomas consiste na reconstrução da sequência original de um genoma a partir dos fragmentos de DNA produzidos pelo sequenciador. Lembre-se de que os instrumentos de sequenciamento atuais não conseguem ler cromossomos inteiros na maioria dos casos, especialmente para genomas grandes, ou seja, de dezenas de Mbp ou maiores.

Hoje, vamos montar o genoma de _Komagataeibacter rhaeticus_ a partir de leituras produzidas por duas tecnologias, ou seja, Illumina e PacBio. 

Descarregue o arquivo **MontagemGenomas.tar.gz** do e-Disciplinas e descompacte/descomprima o arquivo em sua máquina, com isso criará a pasta "PRÁTICA DE ENSAMBLAGEM DE GENOMAS".

```bash
cd ~/Downloads
mv MontagemGenomas.tar.gz ~/
cd
tar xvzf MontagemGenomas.tar.gz
rm MontagemGenomas.tar.gz
cd PRATICA_ENSAMBLAGEM_DE_GENOMAS
```

### Limpar sequências de Illumina

As tecnologias de segunda geração, como Illumina, produzem leituras que devem ser filtradas por critérios de qualidade de leitura, comprimento, presença de adaptadores, barcodes, contaminantes e artefatos. Em contraste, os sequenciadores e/ou montadores de tecnologias de terceira geração, como PacBio, geralmente já fazem automaticamente esse processo.

Na pasta *PRATICA_ENSAMBLAGEM_DE_GENOMAS/* encontra dois arquivos fastq com leituras pareadas de Illumina, i.e., *illumina_R1.fq* e *illumina_R2.fq*. Vamos usar o programa [FastQC](FASTQC) para visualizar a qualidades das leituras brutas.

- ![exercicio](linux/Figs/f03c15.png) O que são leituras pareadas?
- ![exercicio](linux/Figs/f03c15.png) Explique a organização do formato FASTQ.

```bash
conda activate fastqc
fastqc --nogroup --threads 2 illumina_R1.fq.gz illumina_R2.fq.gz
conda deactivate
```

O programa FastQC gerou dois arquivos *.html* que voce pode visualizar no seu navegador favorito. Discuta os resultados com o professor.

Agora, utilizaremos o [BBduk](https://jgi.doe.gov/data-and-tools/software-tools/bbtools/bb-tools-user-guide/bbduk-guide/) para a limpeza dos dados. O BBduk é capaz de realizar aprimoramentos na qualidade através de quality trimming, filtragem, remoção de adaptadores e filtragem de contaminantes utilizando correspondência por k-mer.

```bash
conda activate bbmap
bbduk.sh in1=illumina_R1.fq.gz in2=illumina_R2.fq.gz out1=./bbduk/bbduk.R1.fq.gz \
out2=./bbduk/bbduk.R2.fq.gz minlength=75 qtrim=w trimq=20 ref=adapters stats=stats.txt
conda deactivate
```

- ![exercicio](linux/Figs/f03c15.png) Qual é o significado das opções **qtrim=w** e **trimq=20**?

O BBduk vai gerar dois arquivos filtrados, *bbduk.R1.fq* e *bbduk.R2.fq*, na pasta *bbduk*. Esses arquivos serão usados na montagem de novo do genoma. Antes de montar o genoma, vamos usar o programa FASTQC para visualizar o efeito da filtragem do BBduk nas nossas leituras de Illumina.

- ![exercicio](linux/Figs/f03c15.png) Explique as diferenças no item "Per base quality" do relatório do FASTQC das leituras de Illumina antes e depois da filtragem com o bbduk.

### Limpar sequências de PacBio HiFi

Apesar das leituras de PacBio HiFi normalmente não conterem adaptadores, pois estes são removidos durante o processamento dos dados de sequenciamento, sempre vale a pena conferir com um programa adicional. Neste caso, usaremos o [HiFiAdapterFilt](https://github.com/sheinasim/HiFiAdapterFilt).

```bash
cd 
cd PRATICA_ENSAMBLAGEM_DE_GENOMAS
conda activate hifiadapterfilt
git clone https://github.com/sheinasim/HiFiAdapterFilt.git
export PATH=$PATH:~/PRATICA_ENSAMBLAGEM_DE_GENOMAS/HiFiAdapterFilt
export PATH=$PATH:~/PRATICA_ENSAMBLAGEM_DE_GENOMAS/HiFiAdapterFilt/DB
bash hifiadapterfilt.sh -l 44 -m 97 -t 4 -o HiFiAdapterFilt_res -p PacBio
```

O processo anterior vai gerar o arquivo *HiFiAdapterFilt_res/PacBio.filt.fastq.gz*, que será usado na montagem do genoma.

### Análise do espectro de k-mers

Os [k-mer](https://en.wikipedia.org/wiki/K-mer) são sequências de DNA de tamanho _k_ encontradas em uma sequência maior. É importante observar que para obter todos os k-mer de uma sequência, você começa no primeiro nucleotídeo da sequência e pega os próximos k nucleotídeos. Em seguida, você desloca-se um nucleotídeo à frente e pega os k nucleotídeos, repete o processo até chegar no fim da sequencia, i.e., até não conseguir pegar k nucleotídeos. Vamos a listar todos os k-mer, com k=3, isto é vamos gerar o catálogo de k-mers da sequência abaixo:

```
Sequência:   ACGTAGCGTAGGT
3-mer 1:     ACG
3-mer 2:      CGT
3-mer 3:       GTA
3-mer 4:        TAG
3-mer 5:         TGC
3-mer 6:          GCG
3-mer 7:           CGT
3-mer 8:            GTA
3-mer 9:             TAG
3-mer 10:             AGG
3-mer 11:              GGT

```

Observe que a quantidade de k-mers distintos corresponde a 4 elevado à k potência (__4^k__). Ao analisar estatísticas relacionadas aos k-mers em dados brutos de sequenciamento, é viável adquirir _insights_ sobre as características do genoma em estudo, mesmo antes de iniciar o processo de montagem. Além disso, muitas dessas estimativas, obtidas por meio das estatísticas dos k-mers, podem informar e influenciar os procedimentos de montagem e anotação do genoma. Através do catálogo de k-mers, é possível calcular as frequências empíricas dos k-mers em um conjunto de dados, ou até mesmo em um genoma montado, resultando no espectro de k-mers desses dados. A frequência empírica dos k-mers na sequência acima é a seguinte:

```
k-mer	Freq
ACG	1
AGG	1
CGT	2
GCG	1
GTA	2
GGT	1
TAG	2
TGC	1
TTG	1
```

A partir da frequência empírica de k-mers, podemos calcular o espectro de k-mers, que nada mais é do que um histograma da coluna _Freq_ da tabela acima. Ou seja, o espectro de k-mers informa quantos k-mers distintos aparecem com uma frequência _x_ (multiplicidade ou profundidade), da seguinte maneira:

```
Número kmers	Multiplicidade
6		1
3		2
```

A partir das frequências empíricas dos k-mers e do espectro de k-mers, é possível estimar várias características do genoma, incluindo tamanho, heterozigosidade, fração do genoma composta por sequências repetitivas e ploidia. Para realizar essas estimativas, podemos utilizar ferramentas como o [GenomeScope2 e o SmudgePlots](https://www.nature.com/articles/s41467-020-14998-3/). Nesta pratica usaremos só o GenomeScope.

Vamos proceder com a instalação de uma ferramenta muito rápida para catalogar e contar k-mers, o FastK, para os dados de Illumina e de PacBio HiFi:

```bash
conda activate genomescope2
cd ~/PRATICA_ENSAMBLAGEM_DE_GENOMAS
git clone https://github.com/thegenemyers/FastK
cd FastK && make
install -c FastK Fastrm Fastmv Fastcp Fastmerge Histex Tabex Profex Logex Vennex Symmex Haplex Homex Fastcat /home/cen0485/miniconda3/envs/genomescope2/bin/
cd ~/PRATICA_ENSAMBLAGEM_DE_GENOMAS
```

O espectro de k-mers para Illumina será calculado com k=17, e para PacBio com k=51

```bash
FastK -v -t4 -k17 -M16 -T4 bbduk/bbduk.R[12].fq.gz -NKRHAE_illumina_k17
Histex -G KRHAE_illumina_k17 > KRHAE_illumina_k17.histo
FastK -v -t4 -k51 -M16 -T4 HiFiAdapterFilt_res/PacBio.filt.fastq.gz -NKRHAE_pacbio_k51
Histex -G KRHAE_pacbio_k51 > KRHAE_pacbio_51.histo
conda deactivate
```
Assim, teremos dois arquivos com a extensão .histo. Agora, você pode ir ao site do [GenomeScope2 ](http://genomescope.org/genomescope2.0/) e carregar esses arquivos, um de cada vez (caso tenha problema gerando os arquivo, pode usar esses: [illumina](files/KRHAE_k17.histo.gz), [pacbio](files/KRHAE_PB_k51.histo.gz)). Verifique, após carregar o arquivo, se informou o valor de k usado e a ploidia do organismo, neste caso, 1.

- ![exercicio](linux/Figs/f03c15.png) Descreva o espectro de k-mers para os dois conjuntos de dados e o tipo de informações que podem ser extraídas desse espectro.


### Montagem de genoma usando dados Illumina

Vamos montar o genoma com o software [SPAdes](https://currentprotocols.onlinelibrary.wiley.com/doi/abs/10.1002/cpbi.102), um montador de genomas baseados nos grafos de [_de Bruijin_](https://www.nature.com/articles/nbt.2023).

```bash
conda activate spades
spades.py --isolate -o  KRHAE_spades -1 bbduk/bbduk.R1.fq.gz  -2 bbduk/bbduk.R2.fq.gz --threads 8
conda deactivate
```

### Montagem de genoma usando dados PacBio

Existem montadores especializados em explorar dados de leituras longas de alta qualidade, como as leituras  PacBio HiFi. Entre esses montadores está o Flye. [Flye](https://www.nature.com/articles/s41587-019-0072-8), o [HiFiAsm](https://www.nature.com/articles/s41592-020-01056-5), o [HiCanu](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7545148/) e o [IPA](https://github.com/PacificBiosciences/pbipa). Hoje vamos usar o Flye.

```bash
conda activate flye
flye --pacbio-hifi HiFiAdapterFilt_res/PacBio.filt.fastq.gz  -o KRHAE_flye --threads 8 --min-overlap 1000
conda deactivate
```

### Visualizando o grafo de montagem.

Os dois montadores que usamos geraram um grafo com a montagem. Para Illumina, o [grafo](https://en.wikipedia.org/wiki/Graph_(discrete_mathematics)) está no arquivo *assembly_graph_with_scaffolds.gfa* e para o Flye, o grafo está no arquivo *assembly_graph.gfa*. Podemos visualizar esses grafos com o software [Bandage](https://academic.oup.com/bioinformatics/article/31/20/3350/196114).

```bash
conda activate bandage
Bandage
```
Primeiro carregue o grafo da sua montagem:

![Bandage 1](Figs/Bandage_001.png)

![Bandage 2](Figs/Bandage_002.png)

Em seguida, aperte no botão "Draw Graph". As figuras a seguir têm os grafos das montagens resultantes do Flye e do SPAdes, respectivamente.

![Bandage Flye](Figs/Bandage_003_flye.png)

![Bandage SPAdes](Figs/Bandage_004_spades.png)


- ![exercicio](linux/Figs/f03c15.png) Explique as diferenças dos grafos das montagens gerados pelo Flye e pelo SPAdes.
- 
### Métricas das montagens

#### Contiguidade

Iremos calcular métricas de contiguidade com o software [Quast](https://academic.oup.com/bioinformatics/article/29/8/1072/228832), como número de contigs produzidos, N50, L50, tamanho do maior contig, etc., para as duas montagens com o intuito de compará-las.

```bash
conda activate quast
quast --labels "KRHAE_flye, KRHAE_spades" --threads 3 KRHAE_flye/assembly.fasta KRHAE_spades/scaffolds.fasta
conda deactivate
```

O Quast gera um arquivo em formato HTML que pode ser facilmente visualizado no seu navegador preferido. 

- ![exercicio](linux/Figs/f03c15.png) As métricas de contiguidade permitem diferenciar as duas montagens? Quais métricas oferecem maior informação relevante para avaliar a qualidade das montagens?

#### Completude do espaco gênico

Além da avaliação da contiguidade, é comum questionar-se se a montagem consegue capturar todos os genes que deveriam estar presentes na espécie. Isso normalmente é chamado de análise de completude do espaço gênico e pode ser conferido com softwares como [BUSCO](https://academic.oup.com/mbe/article/38/10/4647/6329644) ou [Compleasm(https://academic.oup.com/bioinformatics/article/39/10/btad595/7284108)]. O BUSCO (Benchmarking Universal Single-Copy Orthologs) e o compleasem, avaliam a qualidade das montagens de genomas e anotações de genes comparando-os a conjuntos de genes ortólogos esperados universalmente em um determinado clado. O software fornece medidas de completude com base na presença de genes essenciais conservados, ajudando a identificar possíveis deficiências na montagem ou na anotação.

```bash
conda activate compleasm
compleasm  run  -a KRHAE_flye/assembly.fasta -o compleasem_KRHAE_flye -l rhodospirillales_odb10 
compleasm  run  -a KRHAE_spades/scaffolds.fasta -o compleasem_KRHAE_spades -l rhodospirillales_odb10 
conda deactivate
```

- ![exercicio](linux/Figs/f03c15.png) Comparar os resultados de completude e contiguidade para as duas montagens.

### Comparacao das duas montagens com matriz de pontos

[DotPlotly](https://github.com/tpoorten/dotPlotly) é uma ferramenta interativa de visualização que facilita a comparação de estruturas de genoma através de dotplots. Aqui está uma sessão prática dividida em etapas. 

Na primeima etapa precisamos alinhar as duas montagens, para isso usaremos o programa [minimap2](https://academic.oup.com/bioinformatics/article/34/18/3094/4994778). O Minimap2 é uma ferramenta de alinhamento rápida e versátil, frequentemente usada para o alinhamento de sequências longas de DNA ou RNA, como as produzidas por tecnologias de sequenciamento de terceira geração (PacBio ou Oxford Nanopore). Ele é projetado para ser eficiente tanto em termos de velocidade quanto de uso de memória, o que o torna ideal para lidar com grandes genomas ou conjuntos de dados de sequenciamento em grande escala. Minimap2 realiza alinhamentos aproximados e é capaz de lidar com sequências completas de cromossomos ou mesmo genomas inteiros. Ele utiliza uma estratégia baseada em "sketching" (esboço), que simplifica as sequências em conjuntos de substrings (k-mers), para rapidamente identificar regiões candidatas a alinhamento antes de realizar alinhamentos mais detalhados. Isso permite ao Minimap2 identificar rapidamente correspondências locais entre sequências, o que é fundamental para montagens de genomas, mapeamento de reads e comparações genômicas em larga escala.

```bash
conda activate dotplotly
minimap2 KRHAE_flye/assembly.fasta KRHAE_spades/scaffolds.fasta -x asm5  > flye_vs_illumina.paf
```

Na segunda etapa usaremos o arquivo de alinhamento gerado pelo Minimap2 para a criação da matriz de pontos com DotPlotly. O DotPlotly lerá o arquivo de alinhamento PAF e gerará um plot interativo baseado nas informações de alinhamento, mostrando as similaridades e diferenças entre as montagens no navegador.

```bash
git clone https://github.com/tpoorten/dotPlotly.git
./dotPlotly/pafCoordsDotPlotly.R -i flye_vs_illumina.paf -o flye_vs_illumina -s -t -m 500 -q 500 -k 7 -l
google-chrome flye_vs_illumina.html
conda deactivate
```

- ![exercicio](linux/Figs/f03c15.png) Descreva cada um dos argumentos usados na execução do minimap2 e do pafCoordsDotPlotly.R. Discuta como esses parâmetros podem afetar a análise.

## Bioinfo 7 - Anotação de genomas

Depois de ter montado o genoma da _Komagataeibacter rhaeticus_ na seção anterior, normalmente a seguinte pergunta em um projeto de genômica é: E onde estão os genes? O processo de identificá-los no genoma é o que é chamado de anotação do genoma, ou predição de genes, ou anotação estrutural do genoma. Nesta seção, vamos usar o genoma montado com os dados de PacBio na seção anterior.

A previsão de genes em organismos procariotos é bem mais simples que em eucariotos, principalmente porque a estrutura dos genes é mais simples; por exemplo, normalmente os genes não têm introns.

Nesta seção, vamos usar o software [Prokka](https://pubmed.ncbi.nlm.nih.gov/24642063/) para realizar a previsão de genes no genoma de _K. rhaeticus_.

Agora vamos a preparar o ambiente para a anotação do genoma. Primeiro vamos a criar uma pasta no seu HOME com a sequencia do genome e onde serao armazenados os resultados da anotação.

```bash
cd 
mkdir ANOTACAO_DE_GENOMAS
cd  ANOTACAO_DE_GENOMAS
cp ~/PRATICA_ENSAMBLAGEM_DE_GENOMAS/KRHAE_flye/assembly.fasta .
```

Desta vez, vamos usar o software de uma forma um pouco diferente. Até agora, a maioria dos pacotes que utilizamos na linha de comandos foram instalados em seus computadores, junto com todas as suas dependências. Para ter uma ideia do que foi instalado e como, podem conferir o arquivo [setting_env.sh](setting_env.sh). No entanto, o Prokka é um software que possui muitas dependências e, para facilitar a instalação e o uso, vamos utilizar um container do [Singularity](https://docs.sylabs.io/guides/3.5/user-guide/introduction.html). O container funciona de maneira semelhante a uma máquina virtual, onde todo o software e suas dependências já vêm instaladas e prontas para uso.

Para descarregar o container, primeiro temos que ativar o ambiente que possui o Singularity e, em seguida, podemos descarregar a imagem. Isso é feito com o comando 'build' do Singularity, que irá descarregar várias partes da imagem da internet e criará um arquivo .sif na sua pasta de trabalho. Esse arquivo é o contêiner que usaremos depois para anotar o genoma.

```bash
conda activate singularitycew
singularity build prokka.sif docker://staphb/prokka:latest
```

Agora podemos executar o trabalho do Prokka que irá anotar os genes do genoma de _K. rhaeticus_. Isso vai levar aproximadamente 5 minutos.

```bash
 singularity exec prokka.sif prokka --outdir KRHAE_Prokka --addgenes --addmrna --genus  Komagataeibacter --species rhaeticus --locustag KRHAE --cpus 8 --rnammer --rfam assembly.fasta
 ```

- ![exercicio](linux/Figs/f03c15.png)  Quando terminar, confira a ajuda do Prokka para entender o que cada um dos argumentos usados está fazendo. Em seguida, desative o ambiente do Singularity.

```bash
 singularity exec prokka.sif prokka -h
 conda deactivate 
 ls -l KRHAE_Prokka
 BASEPROKKA=`basename KRHAE_Prokka/*.gff`
 BASEPROKKA=${BASEPROKKA/.gff}
 ```

Vamos ver um resumo dos resultados gerados pelo Prokka. Abra o arquivo `KRHAE_Prokka/${BASEPROKKA}.txt` com seu visualizador de texto preferido. Repare que o número que aparece no nome do arquivo pode ser diferente para você. O conteúdo é semelhante ao que aparece abaixo:

```bash
cat KRHAE_Prokka/${BASEPROKKA}.txt
```

```
organism: Komagataeibacter rhaeticus strain
contigs: 1
bases: 3597563
CDS: 3252
gene: 3322
mRNA: 3322
misc_RNA: 18
rRNA: 3
tRNA: 48
tmRNA: 1
```

- ![exercicio](linux/Figs/f03c15.png) O que significa cada um desses nomes que aparecem nesse resumo? Por que o número de CDS não corresponde ao número de mRNAs?

Mas onde estão os genes preditos? Vamos olhar o arquivo `KRHAE_Prokka/${BASEPROKKA}.gff` com o visualizador de texto. Este é um arquivo de texto tabular que contém informações sobre regiões genômicas (cada linha) em 9 colunas. Este formato recebe o nome de [Generic Feature Format (GFF)](https://www.ensembl.org/info/website/upload/gff3.html) e é muito usado na anotação de genomas, mas não é o único. Na pasta de resultados, há outros arquivos onde a mesma informação de predição de genes aparece em outros formatos. O arquivo `.ffn` tem a sequência em formato FASTA de todos os transcritos preditos. O arquivo `.faa` contém as sequências de proteínas preditas.

- ![exercicio](linux/Figs/f03c15.png) O que está armazenado em cada uma das colunas do arquivo GFF? Na coluna de fase (oitava coluna), por que existem pontos ou os números 0, 1 e 2? O que significa cada um deles?

Agora vamos comparar as sequências das proteínas preditas com as sequências das proteínas do gênero _Komagataeibacter_ disponíveis no NCBI. Para isso, vamos usar o [BLAST](https://www.ncbi.nlm.nih.gov/books/NBK279690/) a partir da linha de comandos.

Primeiro, temos que descarregar todas as proteínas do gênero disponíveis no NCBI. Para isso, vá ao banco de dados de [taxonomia](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi) e procure pelo nome do gênero. Na página de resultados, clique no nome do gênero, isso deve levá-lo a uma página semelhante à que aparece abaixo. Repare que aparecem 259.511 proteínas disponíveis no banco de dados de proteínas do NCBI. 

![KRHAE proteins NCBI](Figs/KRHAE_proteins_NCBI.png)

Vamos descarregá-las. Clique no número 259.511 e, na página de resultados, clique em "Send to" e, em seguida, em "File". Selecione o formato "FASTA" e clique em "Create File". Isso vai descarregar um arquivo chamado `sequence.fasta` que contém todas as proteínas do gênero _Komagataeibacter_ disponíveis no NCBI. Troque o nome do arquivo para `Komagataeibacter_prots_NCBI.fasta`

```bash
cd ~/ANOTACAO_DE_GENOMAS
mv ~/Downloads/sequence.fasta Komagataeibacter_prots_NCBI.fasta
```

Alternativamente, você pode descarregar uma cópia desse arquivo (em formato .gz) do e-Disciplinas. Lembre-se de descompactá-lo primeiro antes de continuar.

Agora podemos usar essa colecao de proteínas para comparar com as proteínas preditas pelo Prokka. Vamos usar o BLAST para isso. Mas primeiro temos que formatar o banco de dados de proteínas do gênero _Komagataeibacter_ para que o BLAST possa usá-lo.

```bash
conda activate hifiadapterfilt
makeblastdb -in Komagataeibacter_prots_NCBI.fasta -dbtype prot -out Komagataeibacter_prots_NCBI
```

Com o banco de dados formatado, podemos realizar a busca com `blastp`. Vamos conservar apenas o melhor hit e pedir para o software produzir os resultados em formato tabular 7 (com comentários), acrescentando a informação do tamanho da sequência `query` e `subject` na tabela. Em seguida, vamos remover os comentários do arquivo, produzindo um arquivo novo, que posteriormente será importado no LivreOffice Calc para realizar algumas operações.

```bash
blastp -query KRHAE_Prokka/${BASEPROKKA}.faa -db Komagataeibacter_prots_NCBI \
 -num_threads 8 -outfmt '7 std qlen slen'  -max_target_seqs 1 \
 -qcov_hsp_perc 0.9 -evalue 1e-5 -out blastp_results.tab
grep -v "#" blastp_results.tab > blastp_results_noHash.tab
conda deactivate
```

- ![exercicio](linux/Figs/f03c15.png) O que significa cada uma das colunas do arquivo `blastp_results_noHash.tab`? O que significa o valor de `e-value`? O que significa o valor de `qcov_hsp_perc`?

Agora vamos visualizar a anotacao de genoma, junto com as leituras de PacBio  mapeadas no genoma. Para isso, vamos usar o [Integrated Genomics Viewer - IGV](https://software.broadinstitute.org/software/igv/). Teremos que gerar os arquivos de alinhamento das leituras com o genoma primeiro.

```bash
conda activate jupiterplot
minimap2 -t 8 -ax map-hifi assembly.fasta ~/PRATICA_ENSAMBLAGEM_DE_GENOMAS/HiFiAdapterFilt_res/PacBio.filt.fastq.gz | samtools view -b | samtools sort --threads 4 -o PacBio_KRHAE_sorted.bam && samtools index PacBio_KRHAE_sorted.bam
samtools faidx assembly.fasta
conda deactivate
```

Agora, temos que ativa o ambiente do IGV e carregar os arquivos `assembly.fasta`, `PacBio_KRHAE_sorted.bam` e `KRHAE_Prokka/${BASEPROKKA}.gff` 

```bash
conda activate igv
igv
```

![IGV](Figs/IGV.png)

### Gene Ortólogos
Os genes ortólogos são genes que evoluíram de um ancestral comum e estão presentes em diferentes espécies. Eles desempenham um papel fundamental na compreensão da evolução, pois ajudam a identificar funções conservadas entre organismos distintos. A identificação de genes ortólogos é crucial para estudos comparativos, permitindo inferir funções genéticas e processos biológicos comuns entre espécies.

Vamos agora explorar com mais profundidade o uso de genes ortólogos. Para isso, utilizaremos o [OMA (Orthologous Matrix)](https://oma-stage.vital-it.ch/oma/home/) no seu navegador. O projeto OMA é uma ferramenta e banco de dados para a inferência de ortólogos entre genomas completos.

O algoritmo de inferência do OMA envolve três etapas principais. Primeiro, ele calcula alinhamentos Smith-Waterman entre todas as sequências para identificar correspondências significativas, inferindo sequências homólogas. Em seguida, ele determina pares ortólogos, que são homólogos relacionados por eventos de especiação, levando em conta distâncias evolutivas e a incerteza na inferência de distâncias. Por fim, os ortólogos são agrupados de duas maneiras: em "grupos OMA" que servem como genes marcadores para reconstrução filogenética e em "HOGs" que representam grupos de genes comuns em niveis taxonômicos específicos.

Nesta sessão, vamos resolver os exercícios do [Módulo 1 do treinamento do OMA](https://omabrowser.org/oma/academy/module/BGA_session). 

Para resolver esses exercícios, é muito recomendado consultar regularmente as páginas de ajuda do OMA: "[Orthology Basics](https://omabrowser.org/oma/type/)," "[Types of homologs](https://omabrowser.org/oma/homologs/)," "[Access the OMA Data](https://omabrowser.org/oma/uses/)," "[Catalog of Tools](https://omabrowser.org/oma/tools/)," e "[Glossary](https://omabrowser.org/oma/glossary/)." Elas fornecerão informações valiosas para concluir com êxito os exercícios do Módulo 1.

## Bioinfo 8 - Transcriptômica

RNA-Seq é uma técnica de sequenciamento que utiliza tecnologias modernas de sequenciamento para revelar a presença e a quantidade de RNA em uma amostra biológica em um dado momento. Usaremos os dados do artigo [PMID: 24926665](https://pubmed.ncbi.nlm.nih.gov/24926665/), especificamente os conjuntos de dados mostrados na tabela abaixo. O RNA total foi extraído de cultivos primários de células humanas do músculo liso das vias aéreas (ASM) de quatro doadores diferentes, as células de cada doador foram tratadas com 1 µM DEX ou com controle por 18 horas. Aproximadamente 1 µg de RNA de cada amostra foi usado para gerar bibliotecas de cDNA de RNA-Seq para sequenciamento utilizando o [TruSeq RNA Sample Prep Kit v2](https://www.illumina.com/products/by-type/sequencing-kits/library-prep-kits/truseq-rna-v2.html). O sequenciamento foi realizado em um instrumento HiSeq2000, gerando leituras pareadas (2x75bp). O principal objetivo do estudo foi obter insights sobre como os glicocorticoides suprimem a inflamação no ASM.

| Accession   | Sample        | Cell    |
|-------------|---------------|---------|
| SRR1039508  | Untreated     | N61311  |
| SRR1039509  | Dexamethasone | N61311  |
| SRR1039512  | Untreated     | N052611 |
| SRR1039513  | Dexamethasone | N052611 |
| SRR1039516  | Untreated     | N080611 |
| SRR1039517  | Dexamethasone | N080611 |
| SRR1039520  | Untreated     | N061011 |
| SRR1039521  | Dexamethasone | N061011 |


### Recuperando os Dados de Repositórios Públicos

Os dados de sequenciamento deste estudo estão disponíveis no Short Read Archive (SRA), um banco de dados do NCBI dedicado a armazenar dados de sequenciamento massivo obtidos com tecnologias modernas. Precisamos baixar os dados de lá. Este passo pode demorar consideravelmente, pois o volume de dados é considerável. Por isso, os dados também estão disponíveis em um servidor próprio.

```bash
cd ~/Downloads
wget https://labbces.cena.usp.br/shared/PRATICA_RNASEQ/PRATICA_RNASEQ.tar.gz
mv PRATICA_RNASEQ.tar.gz ~/
cd
tar xvzf PRATICA_RNASEQ.tar.gz
```

### Pre-Processamento de Dados

Primeiro, você deve verificar a qualidade das suas leituras com o FastQC para decidir se precisa realizar algum filtro de qualidade. O comando a seguir executa o FastQC para cada um dos seus arquivos, um por um, mas de forma automática. Esse processo pode levar algum tempo.

```bash
cd ~/PRATICA_RNASEQ
mkdir -p QC
conda activate fastqc
for file_R1 in $(ls -1 RAW/*_1.fastq.gz); do file_R2=${file_R1/_1/_2}; fastqc --noextract \
--threads 2 --nogroup -o QC $file_R1 $file_R2; done
conda deactivate
```	

Verifique a qualidade abrindo o arquivo .html gerado pelo FastQC para cada um dos arquivos de leitura no seu navegador web favorito. ![exercicio](linux/Figs/f03c15.png) Como está a qualidade desse sequenciamento?

Agora utilizamos o BBDuk para limpar nossas sequências.

```bash
cd ~/PRATICA_RNASEQ
conda activate bbmap
mkdir -p CLEAN
cd CLEAN
for sample in $(cut -f1 -d"," ../metadata.csv | grep SRR); \
 do file_R1=${sample}_1.fastq.gz ;file_R2=${sample}_2.fastq.gz; \
 echo $file_R1 $file_R2 ; \
 bbduk.sh in1=../RAW/$file_R1\
 in2=../RAW/$file_R2\
 out1=./$file_R1\ out2=./$file_R2\
 minlength=50\
 qtrim=w threads=6\
 trimq=20;
 done
conda deactivate
```

![exercicio](linux/Figs/f03c15.png)  Qual porcentagem de leituras foi removida no total?

Agora, você pode rodar o FASTQC novamente e verificar as estatísticas de qualidade dos arquivos gerados pelo BBDuk. Faça isso por conta própria. ![exercicio](linux/Figs/f03c15.png)  A qualidade das leituras melhorou?

### Quantificação de Expressão Gênica

Vamos quantificar a expressão gênica utilizando a versão [GRCh38.p14(https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_46/gencode.v46.transcripts.fa.gz)] do genoma humano. Para isso, usaremos o [Salmon](https://salmon.readthedocs.io/en/latest/salmon.html) para a quantificação da expressão gênica.

Primeiro, precisamos criar um índice com o nosso genoma de referência. O seguinte comando deve criar uma pasta chamada "salmon_index" em `~/PRATICA_RNASEQ/salmon_index`.

```bash	
conda activate transcriptomics
conda install -y -c bioconda salmon
cd ~/PRATICA_RNASEQ/
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_46/gencode.v46.transcripts.fa.gz
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_46/gencode.v46.annotation.gtf.gz
salmon index --gencode -t gencode.v46.transcripts.fa.gz -i salmon_index --threads 6
```

Agora podemos quantificar nossas leituras usando o índice gerado com o genoma de referência. O comando a seguir executa o Salmon para todos os arquivos de cada amostra (R1 e R2) sequencialmente.

```bash
mkdir -p Quantification
cd Quantification
for sample in $(cut -f1 -d"," ../metadata.csv | grep SRR); do
echo Processing sample $sample
  salmon quant --validateMappings --seqBias --posBias \
  --softclip --index ../salmon_index --libType A \
  -1 ../CLEAN/${sample}_1.fastq.gz -2 ../CLEAN/${sample}_2.fastq.gz \
  -p 6 -o $sample > ${sample}.log  2>&1
echo Done sample $sample
done
```

O processo de quantificação com o Salmon pode levar algum tempo. Os arquivos resultantes da quantificação podem ser encontrados na pasta `~/PRATICA_RNASEQ/Quantification`.

Lá, há uma pasta para cada amostra, e dentro de cada pasta, vários arquivos. O arquivo com a informação de quantificação é o quant.sf. ![exercicio](linux/Figs/f03c15.png) O que significa cada uma das colunas do arquivo quant.sf?

Neste ponto, podemos apagar as leituras de sequenciamento para liberar espaço no computador. Certifique-se de que todos os dados necessários foram processados e salvos adequadamente antes de apagar as leituras de sequenciamento, para evitar a perda de informações importantes.

```bash 
rm -rf ~/PRATICA_RNASEQ/RAW
rm -rf ~/PRATICA_RNASEQ/CLEAN
```

Agora que concluímos a quantificação, podemos começar a formular perguntas sobre os dados. Vamos usar o R para analisar como os níveis de expressão dos genes mudam em cada condição experimental. R é um software livre para computação estatística e criação de gráficos.

Para tornar nossa interação com o R mais amigável, utilizaremos o RStudio, que é um ambiente de desenvolvimento integrado (IDE) para R. Se o comando `rstudio` não estiver instalado, terá que instala-lo manualmente. 

Caso tenha que instalar Rstudio, vai na pagina: https://posit.co/download/rstudio-desktop/, e descarregue o arquivo `RSTUDIO-2024.04.1-748-AMD64-DEBIAN.TAR.GZ`.

```bash
cd ~/PRATICA_RNASEQ
wget https://download1.rstudio.org/electron/focal/amd64/rstudio-2024.04.1-748-amd64-debian.tar.gz
tar xvf rstudio-2024.04.1-748-amd64-debian.tar.gz
echo "PATH=$PATH:~/PRATICA_RNASEQ/rstudio-2024.04.1-748/bin" >> ~/.bashrc
echo "export PATH" >> ~/.bashrc
. ~/.bashrc
rstudio
```

![RStudio](Figs/rstudio.png)

A grosso modo, podemos dividir a área de trabalho do RStudio em quatro regiões:

- Na área superior esquerda, você encontrará abas que hospedam seus scripts e projetos. Isso permite que você organize e acesse facilmente seu código-fonte e trabalhe em diferentes projetos de análise de dados.
- Na área inferior esquerda, estão localizadas as abas Console, Terminal e Background Jobs, que permitem interagir com o ambiente do R. O Console é onde você pode executar comandos e ver a saída imediata. O Terminal permite interações mais avançadas com o sistema operacional, enquanto as Tarefas em Segundo Plano rastreiam e gerenciam tarefas em execução.
- A área superior direita exibe as abas Environment, History, Connections e Tutorial. São abas que fornecem informações e recursos adicionais. O Ambiente mostra os objetos em sua sessão R atual. O Histórico registra comandos anteriores. Conexões permitem a integração com outros serviços e tutoriais fornecem orientações úteis.
- A área inferior direita inclui as abas Files, Plots, Packages, Help, Viewer e Presentation. Arquivos gerencia seus arquivos e diretórios. Gráficos exibe gráficos gerados durante sua análise. Pacotes ajuda a gerenciar pacotes R. Ajuda fornece informações detalhadas sobre funções e pacotes. O Visualizador permite visualizar conjuntos de dados e gráficos interativamente. Apresentação ajuda a criar apresentações R Markdown.

Essas abas tornam o RStudio uma ferramenta versátil e eficaz para o desenvolvimento e análise de projetos em R.

### Análise de Expressão Diferencial 

Realizaremos a identificação de genes diferencialmente expressos inteiramente no R usando o IDE RStudio. Todo o código desta seção deve ser executado no RStudio.

Primeiro, precisamos instalar um pacote que está faltando no momento. Este pacote entende o output do Salmon e pode importar automaticamente a quantificação de transcritos para o R. Além disso, ele conhece o genoma humano. O pacote é o tximeta.

Para instalar e carregar o tximeta, siga os passos abaixo no RStudio:

```R
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("tximeta",update = FALSE, ask = FALSE)
```	

Agora vamos carregar os pacotes que vamos usar para a detecção de genes diferencialmente expressos e para a visualização dos resultados.

```R
library(DESeq2)
library(ggplot2)
library(tximeta)
library(pheatmap)
library(viridis)
setwd("~/PRATICA_RNASEQ/")
```

Carregue as informações sobre o experimento, nomes de amostras e condição

```R	
targets<-read.table("metadata.csv",
header=F,
sep = ",",
stringsAsFactors=FALSE,
col.names = c("names", "condition", "cell"))
targets$names<-as.factor(targets$names)
targets$cell<-as.factor(targets$cell)
targets
```
Vamos fazer uma lista dos arquivos de quantificação criados pelo Salmon. Observe que os arquivos do Salmon estão em pastas que têm os mesmos nomes das amostras, ou seja, a primeira coluna do objeto targets acima. Por favor, note que estes são apenas 'strings'. Depois de criar essa lista, vamos verificar se de fato eles existem no disco.

```R
files<-file.path(paste0("Quantification/",targets$names,"/quant.sf",se =""))
file.exists(files)
```

A resposta ao comando anterior deve ter sido uma colecao de TRUE, um para cada um dos arquivos, se algúm deles for FALSE, você terá que verificar o que aconteceu com o arquivo.

Agora vamos adicionar o nome do arquivo no objeto de metadados `targets`

```R
targets$files<-files
row.names(targets)<-targets$names
targets
```	

Importaremos a quantificação da transcrição gerada pelo Salmon e a descrição do experimento usando o tximeta. Para mais detalhes, consulte o manual do [tximeta](https://bioconductor.org/packages/3.14/bioc/vign
ettes/tximeta/inst/doc/tximeta.html).

É importante notar que o Salmon realiza a quantificação no nível de transcrito. Lembre-se de que um locus gênico, ou seja, um gene, pode produzir mais de um transcrito através do processo de splicing alternativo. No entanto, a análise que vamos realizar será no nível de gene. O tximeta agregará a quantificação no nível de transcrito para o nível de gene.

Antes de carregar nossos dados, crie o objeto transcriptome. Isso facilitará várias operações, como resumir os níveis de expressão da transcrição no nível genético, obter informações funcionais sobre os genes, entre outras.

```R	
makeLinkedTxome(indexDir="salmon_index",
  source="LocalEnsembl",
  organism="Homo sapiens",
  release="46",
  genome="GRCh38.p14",
  fasta="./gencode.v46.transcripts.fa.gz",
  gtf="./gencode.v46.annotation.gtf.gz",
  write=FALSE)
```

Agora, crie o objeto tximeta, que incluirá os dados do Salmon, a descrição do experimento e acesso às informações do transcriptoma. Este objeto é chamado [SummarizedExperiment](https://bioconductor.org/packages/release/bioc/vignettes/SummarizedExperiment/inst/doc/SummarizedExperiment.html).

```R
se <- tximeta(targets)
dim(se)
```

O último comando informa que quantificamos 253.181 transcritos do genoma humano. Vamos ver os nomes desses transcritos, mostrando os primeiros seis. Note como o identificador do transcrito começa com o prefixo `ENST`. 

```R
head(rownames(se))
```

Agora vamos resumir essa quantificação no nível de transcrito para o nível de gene e, em seguida, vamos imprimir os nomes dos primeiros genes. Note que agora os identificadores têm o prefixo `ENSG`.

```R
gse <- summarizeToGene(se)
dim(gse)
head(rownames(gse))
```

Repare também que o número de genes quantificados é menor que o número de transcritos. Isso ocorre porque um gene pode ter mais de um transcrito, mas um transcrito pertence a um único gene. Quantificamos 62.646 genes.

Com o objeto `gse`, podemos agora iniciar a análise diferencial de expressão genética. Para isso, existem muitos pacotes diferentes no R que poderiam ser usados; hoje, vamos utilizar o pacote DESeq2. Primeiramente, precisamos transformar nosso objeto SummarizedExperiment (gse) em um objeto nativo do DESeq2, o DESeqDataSet. Além dos dados, o DESeqDataSet requer uma descrição do design experimental, onde especificamos os fatores de interesse no estudo e/ou os fatores que devem ser fontes de variação e como lidar com eles. Isso é feito usando uma fórmula, com a mesma sintaxe dos modelos lineares simples (lm) no R.

Neste exemplo particular, temos pelo menos duas fontes de variação conhecidas. Primeiro, a condição: amostras tratadas ou não com Dexametasona. Segundo, a linha celular: as células ASM primárias foram obtidas de quatro doadores, que foram divididos em grupos tratados e não tratados. Portanto, podemos ter um efeito do doador. Verifique os alvos para confirmar isso. Usaremos esses dois fatores em nossas análises. Queremos testar o efeito da Dexametasona, enquanto controlamos o efeito das diferentes linhas celulares. Note que este é um design experimental emparelhado, pois cada amostra (cellLine) foi tratada e não tratada. Nesse caso, especificaremos a fórmula como ~ cellLine + condição.

```R
dds <- DESeqDataSet(gse, design = ~cell+condition)
```

É comum que alguns genes no conjunto de dados não sejam expressos ou sejam expressos em níveis muito baixos. É uma boa prática remover esses genes de análises adicionais.

```R
nrow(dds) # Numero de genes antes da filtragem
keep <- rowSums(counts(dds)) > 1 #Manter genes que tenham pelo menos uma contagem na soma do gene
dds <- dds[keep,]
nrow(dds) # Numero de genes depois da filtragem
```	

Em seguida temos que realizar a [normalização](https://hbctraining.github.io/DGE_workshop/lessons/02_DGE_count_normalization.html) das contagems de leituras. O DESeq2 usa um método de normalização chamado "size factors" para ajustar as contagens de leituras para a profundidade de sequenciamento. Isso é feito para que as contagens de leituras possam ser comparadas entre amostras. O DESeq2 também aplica uma transformação de dados para estabilizar a variância em relação à média. Isso é feito para que os dados possam ser comparados de forma mais confiável.

E vamos também remover os genes que não estejam expressos em pelo menos quatro das amostras.

```R
dds <- estimateSizeFactors(dds)
keep <- rowSums(counts(dds) > 0) >= 4
dds <- dds[keep,]
nrow(dds) # Number of genes, that have counts in at least 4 samples
```

Agora que os dados estão no formato adequado e filtrados, podemos realizar algumas análises exploratórias para verificar se os dados parecem consistentes.

Muitas das análises exploratórias requerem dados homocedásticos. Nossas contagens, no entanto, não são homocedásticas. No DESeq2, as funções vst (variance-stabilizing transformation) e rlog (regularized log transformation) podem normalizar os dados para torná-los mais homocedásticos. Como regra, a função vst é recomendada quando você tem mais de 30 amostras.

Vamos examinar a similaridade entre as amostras calculando a distância euclidiana entre elas usando a função `dist`. Esta função pressupõe que as amostras são as linhas, então devemos primeiro transpor a matriz. Em seguida, vamos visualizar as distâncias euclidianas entre as amostras em um mapa de calor.

```R
rld <- rlog(dds, blind = TRUE)
sampleDists <- dist(t(assay(rld)))
sampleDistMatrix <- as.matrix( sampleDists )
rownames(sampleDistMatrix) <- paste( rld$condition, rld$cell, sep = " - " )
colnames(sampleDistMatrix) <- NULL
colors <- inferno(250)
pheatmap(sampleDistMatrix,
  clustering_distance_rows = sampleDists,
  clustering_distance_cols = sampleDists,
  col = colors)
```

![sample_dist_heatmap.png](Figs/sample_dist_heatmap.png)

E agora com o coeficiente de correlação de Pearson.

```R
samplecor <- as.dist((1-(cor(assay(rld), method='pearson')))*100)
sampleCorMatrix <- as.matrix( samplecor )
rownames(sampleCorMatrix) <- paste( rld$condition, rld$cell, sep = " - " )
colnames(sampleCorMatrix) <- NULL
pheatmap(sampleCorMatrix,
  clustering_distance_rows = samplecor,
  clustering_distance_cols = samplecor,
  col=colors)
```

![sample_dist_heatmap_pearson.png](Figs/sample_dist_heatmap_pearson.png)

Uma boa alternativa é também realizar uma análise de componentes principais (PCA) com os genes que mais variam no conjunto de dados e observar se as amostras se agrupam conforme o esperado.

```R
pcaData <- plotPCA(rld, intgroup = c( "condition","cell"), returnData = TRUE)
percentVar <- round(100 * attr(pcaData, "percentVar"))
ggplot(pcaData, aes(x = PC1, y = PC2, color = condition, shape = cell)) +
  geom_point(size =3) +
  xlab(paste0("PC1: ", percentVar[1], "% variance")) +
  ylab(paste0("PC2: ", percentVar[2], "% variance")) +
  coord_fixed() +
  ggtitle("PCA with RLOG data")
```
É claro como a principal fonte de variação é a condição experimental, enquanto a linha celular parece ter um efeito menor, mais não despecivel.

![PCA.png](Figs/PCA.png)

Ao que parece, os dados estão em ordem, então podemos prosseguir com a análise de expressão diferencial. Vamos identificar todos aqueles genes que mudam pelo menos 2 vezes, para cima (up-regulated) ou para baixo (down-regulated) em sua expressão entre as amostras tratadas e não tratadas. Como estaremos realizando milhares de testes, precisamos lidar com o problema de [múltiplos testes](https://en.wikipedia.org/wiki/Multiple_comparisons_problem). O DESeq2 usa o método de correção de Benjamini-Hochberg para controlar a taxa de falsas descobertas.

```R
dds <- DESeq(dds)
res <- results(dds, lfcThreshold = 1, altHypothesis = "greaterAbs", parallel = T)
summary(res)
```

Desta forma podemos ver que identificamos 72 genes up-regulated, ou seja induzidos pela dexametazona, e outros 135 genes down-regulated, ou seja reprimidos pela dexometasona. Um dos principais genes identificados no artigo original foi o **CRISPLD2**, que tem o identificador `ENSG00000103196.12`. Vamos procurá-lo na nossa lista de resultados e plotar seus níveis de expressão nas condições do experimento.

```R
res["ENSG00000103196.12",]
plotCounts(dds, gene = "ENSG00000103196.12", normalized = TRUE)
```
![CRISPLD2_expression.png](Figs/CRISPLD2_expression.png)