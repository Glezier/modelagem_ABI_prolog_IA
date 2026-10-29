# Análise comparativa dos currículos de Ciência da Computação e Inteligência Artificial utilizando Prolog

## Integrantes
- Edmar Miqueias Carvalho Vieira
- Glezier Montalvane de Farias Ferreira
- Luis Eduardo do Rosario Fonseca
- Willy Kauã Diniz Teixeira

## 1. Introdução

Este trabalho apresenta uma análise comparativa dos Projetos Pedagógicos dos Cursos de Ciência da Computação e Inteligência Artificial da Universidade Federal do Maranhão (UFMA), utilizando a linguagem de programação lógica Prolog.

O objetivo é construir uma base de conhecimento com informações sobre disciplinas, obrigatoriedade, carga horária e organização semestral dos dois cursos, permitindo realizar consultas e identificar semelhanças e diferenças entre suas estruturas curriculares.

## 2. Organização da base de conhecimento

A implementação foi dividida em seis arquivos:

- disciplinas.pl: identificação das disciplinas e definição do Tronco Formativo Comum
- curriculos.pl: disciplinas obrigatórias específicas e catálogos de optativas
- regras.pl: regras auxiliares para identificar disciplinas compartilhadas, exclusivas e realizar contagens
- semestres.pl: distribuição semestral das disciplinas obrigatórias e dos espaços de optativas
- consultas.pl: implementação das seis consultas propostas
- main.pl: é responsável por carregar os demais arquivos

A base utiliza fatos e regras para representar as informações extraídas dos PPCs. Os identificadores das disciplinas são utilizados para relacionar os dados e evitar repetições desnecessárias.

A modelagem considera os cursos (`cc` e `ia`), as disciplinas e seus atributos, como nome, carga horária, eixo formativo, natureza curricular e semestre aconselhado. As relações indicam a participação de cada disciplina no tronco comum, nas obrigatórias específicas ou nos catálogos de optativas.

Os principais predicados utilizados são:

|            Predicado            |                                  Finalidade                                  |
|         `disciplina/2`          |              Associa o identificador ao nome da disciplina                   |
|         `tronco_comum/4`        |    Registra disciplina, eixo, carga horária e semestre do tronco comum       |
|          `curriculo/4`          |       Registra disciplinas obrigatórias específicas de cada curso            |
|      `curriculo_optativa/4`     |         Registra as optativas, seus grupos e cargas horárias                 |
| `obrigatoria/2` e `optativa/2`  |   Identificam a natureza curricular de uma disciplina em determinado curso   |
|      `pertence_catalogo/2`      |       Verifica a presença de uma disciplina no catálogo de um curso          |
|     `semestre_especifica/3`     |       Associa uma obrigatória específica ao semestre aconselhado             |
|       `espaco_optativas/3`      |       Registra as horas destinadas às optativas por semestre                 |

Para a comparação, uma disciplina é considerada compartilhada quando o mesmo identificador normalizado aparece nos dois catálogos, seja como obrigatória ou optativa. A comparação considera os componentes curriculares representados na base, sem afirmar equivalência administrativa ou aproveitamento automático de créditos. Como simplificação, pequenas diferenças de grafia dos nomes são tratadas por um identificador único quando se referem ao mesmo componente. Os semestres representam a sequência aconselhada dos PPCs, e não uma exigência de matrícula naquela ordem.

## 3. Consultas desenvolvidas

**Nível:** Básico

### 3.1. Quais disciplinas compõem o Tronco Formativo Comum?

**Consulta:**

```prolog
disciplinas_tronco_comum(Nome, Eixo, CH, Semestre).
```

**Resultado obtido:** O tronco comum possui 17 disciplinas, distribuídas nos três primeiros semestres, totalizando 1.080 horas. As disciplinas pertencem aos eixos de Computação, Matemática e Formação Humanística e Empreendedora.

**Explicação:** A consulta utiliza `tronco_comum/4` para recuperar as informações de cada disciplina e `disciplina/2` para identificar seu nome.

### 3.2. Quais disciplinas são obrigatórias em cada curso após o tronco comum?

**Consultas:**

```prolog
obrigatorias_especificas(cc, Nome, CH).
obrigatorias_especificas(ia, Nome, CH).
```

**Resultado obtido:** Ciência da Computação possui 14 disciplinas obrigatórias específicas, totalizando 810 horas. Inteligência Artificial também possui 14 disciplinas obrigatórias específicas, totalizando 840 horas.

**Explicação:** A consulta seleciona os fatos `curriculo/4` classificados como obrigatórios e recupera os nomes correspondentes.

**Nível:** Intermediário

### 3.3. Quais disciplinas são obrigatórias nos dois cursos?

**Consulta:**

```prolog
obrigatorias_compartilhadas(Nome).
```

**Resultado obtido:** Foram identificadas 19 disciplinas obrigatórias em ambos os cursos: as 17 disciplinas do Tronco Formativo Comum, além de Banco de Dados I e Estrutura de Dados II. Estas duas não fazem parte do tronco comum mas são obrigatórias em ambos os cursos, conforme PPCs, por isso são consideradas.

**Explicação:** A regra verifica se uma disciplina é obrigatória simultaneamente em Ciência da Computação e Inteligência Artificial.

### 3.4. Quais disciplinas aparecem apenas no catálogo de um dos cursos?

**Consultas:**

```prolog
disciplinas_exclusivas(cc, Nome).
disciplinas_exclusivas(ia, Nome).
```

**Resultado obtido:** 52 disciplinas exclusivas de Ciência da Computação e 25 de Inteligência Artificial. As consultas retornam os nomes de cada uma, considerando obrigatórias e optativas.

**Explicação:** Para cada disciplina de um curso, verifica-se sua ausência no catálogo do outro por meio da negação lógica `\+`.

**Nível:** Avançado

### 3.5. Quantas disciplinas são compartilhadas e quantas são específicas de cada catálogo?

**Consulta:**

```prolog
comparacao_catalogos(Compartilhadas, ExclusivasCC, ExclusivasIA).
```

**Resultado obtido:** Considerando os identificadores cadastrados na base de conhecimento, foram identificadas 33 disciplinas compartilhadas entre os catálogos, 52 exclusivas de Ciência da Computação e 25 exclusivas de Inteligência Artificial. A comparação inclui disciplinas obrigatórias e optativas, sem contar duas vezes uma mesma disciplina dentro de cada catálogo.

Diferentemente da terceira consulta, essa comparação considera também as optativas. Portanto, uma disciplina obrigatória em um curso e optativa no outro é considerada compartilhada.

**Explicação:** São utilizadas as regras de identificação de disciplinas compartilhadas e exclusivas, combinadas com `findall/3`, `sort/2` e `length/2`.

### 3.6. Como varia, por semestre aconselhado, a distribuição de carga horária entre obrigatórias e espaços destinados a optativas nos dois cursos?

**Consultas:**

```prolog
distribuicao_semestral(cc, Semestre, Obrigatorias, Optativas).
distribuicao_semestral(ia, Semestre, Obrigatorias, Optativas).
```

**Resultado obtido:**

| Semestre | CC obrigatórias | CC optativas | IA obrigatórias | IA optativas |
|    1º    |      360 h      |      0 h     |      360 h      |     0 h      |
|    2º    |      330 h      |      0 h     |      330 h      |     0 h      |
|    3º    |      390 h      |      0 h     |      390 h      |     0 h      |
|    4º    |      360 h      |      0 h     |      300 h      |     60 h     |
|    5º    |      270 h      |     60 h     |      240 h      |    120 h     |
|    6º    |      180 h      |    180 h     |      240 h      |     60 h     |
|    7º    |      0 h        |    300 h     |       60 h      |    240 h     |
| **Total**|   **1.890 h**   |   **540 h**  |   **1.920 h**   |   **480 h**  |

**Explicação:** A consulta combina as cargas horárias do tronco comum com as disciplinas obrigatórias específicas e os espaços destinados às optativas em cada semestre. 

O oitavo semestre não apresenta carga horária de disciplinas obrigatórias ou espaços de optativas na representação adotada, motivo pelo qual foi omitido da tabela.

### 3.7. Verificação das respostas

As seis consultas foram executadas no SWI-Prolog, e os resultados obtidos corresponderam aos dados cadastrados na base de conhecimento e às informações utilizadas dos PPCs.

Também foi realizado um teste sem resultado, consultando uma disciplina que não integra o tronco comum:

```prolog
disciplinas_tronco_comum('Disciplina Inexistente', _, _, _).
```

O resultado obtido é `false`, pois não existe fato que satisfaça essa condição.

## 4. Análise dos resultados

Os dois cursos compartilham uma formação inicial de 1.080 horas, correspondente aos três primeiros semestres. Após esse período, apresentam diferenças na distribuição das disciplinas e na composição dos catálogos.

Ciência da Computação possui 810 horas de disciplinas obrigatórias específicas e 540 horas de optativas, enquanto Inteligência Artificial possui 840 horas obrigatórias específicas e 480 horas optativas.

As consultas também demonstram que a presença de uma disciplina nos dois catálogos não significa necessariamente que ela tenha a mesma classificação curricular. Uma disciplina pode ser obrigatória em um curso e optativa no outro.

A utilização do Prolog permite representar essas relações por meio de regras e obter diferentes comparações sem repetir manualmente a análise dos PPCs.

## 5. Conclusão

O trabalho demonstrou a aplicação da programação lógica na representação e análise de informações curriculares. A base de conhecimento desenvolvida permitiu identificar disciplinas comuns, obrigatórias, exclusivas e diferenças na distribuição de carga horária entre os cursos. As consultas realizadas estão em consonância com os dados registrados nos PPCs.


## Referências

UNIVERSIDADE FEDERAL DO MARANHÃO. *Projeto Pedagógico do Curso de Bacharelado em Ciência da Computação*. São Luís: UFMA, 2025. Seções 5.4 e 6.5, especialmente as Tabelas 7, 8, 9, 10 e 11.

UNIVERSIDADE FEDERAL DO MARANHÃO. *Projeto Pedagógico do Curso de Bacharelado em Inteligência Artificial*. São Luís: UFMA, 2025. Seções 5.4 e 6.5, especialmente as Tabelas 7, 8, 9, 10 e 11.