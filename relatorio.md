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

Para a comparação, uma disciplina é considerada compartilhada quando o mesmo identificador normalizado aparece nos dois catálogos, seja como obrigatória ou optativa. A comparação considera os componentes curriculares representados na base, sem afirmar equivalência administrativa ou aproveitamento automático de créditos. Como simplificação, pequenas diferenças de grafia dos nomes são tratadas por um identificador único quando se referem ao mesmo componente. Os semestres representam a sequência aconselhada dos PPCs, e não uma exigência de matrícula naquela ordem. Estágio, extensão, TCC e atividades complementares não entram na comparação semestral de disciplinas.

## 3. Consultas desenvolvidas

**Nível:** Básico

### 3.1. Quais disciplinas compõem o Tronco Formativo Comum?

**Consulta:**

```prolog
disciplinas_tronco_comum(Nome, Eixo, CH, Semestre).
```

**Resultado esperado e obtido (a confirmar na execução):** O tronco comum possui 17 disciplinas, distribuídas nos três primeiros semestres, totalizando 1.080 horas. As disciplinas pertencem aos eixos de Computação, Matemática e Formação Humanística e Empreendedora.

**Explicação e classificação:** A consulta utiliza `tronco_comum/4` para recuperar as informações de cada disciplina e `disciplina/2` para identificar seu nome. É básica porque recupera informações diretamente dos fatos, relacionando o identificador ao nome. O custo depende das buscas pelos registros cadastrados.

### 3.2. Quais disciplinas são obrigatórias em cada curso após o tronco comum?

**Consultas:**

```prolog
obrigatorias_especificas(cc, Nome, CH).
obrigatorias_especificas(ia, Nome, CH).
```

**Resultado esperado e obtido (a confirmar na execução):** Ciência da Computação possui 14 disciplinas obrigatórias específicas, totalizando 810 horas. Inteligência Artificial também possui 14 disciplinas obrigatórias específicas, totalizando 840 horas.

**Explicação e classificação:** A consulta seleciona os fatos `curriculo/4` classificados como obrigatórios e recupera os nomes correspondentes. É básica porque recupera diretamente os fatos de obrigatoriedade de cada curso, com associação ao nome. O custo depende da quantidade de registros examinados.

**Nível:** Intermediário

### 3.3. Quais disciplinas são obrigatórias nos dois cursos?

**Consulta:**

```prolog
obrigatorias_compartilhadas(Nome).
```

**Resultado esperado e obtido (a confirmar na execução):** Foram identificadas 19 disciplinas obrigatórias em ambos os cursos: as 17 disciplinas do Tronco Formativo Comum, além de Banco de Dados I e Estrutura de Dados II.

**Explicação e classificação:** A regra verifica se uma disciplina é obrigatória simultaneamente em Ciência da Computação e Inteligência Artificial. É intermediária porque combina relações de dois cursos e exige que ambas as condições sejam verdadeiras. Trata-se de uma operação de interseção entre os conjuntos de disciplinas obrigatórias. Em uma implementação baseada em buscas sequenciais, o custo pode ser quadrático em relação ao número de disciplinas, devido às verificações entre os dois conjuntos.

### 3.4. Quais disciplinas aparecem apenas no catálogo de um dos cursos?

**Consultas:**

```prolog
disciplinas_exclusivas(cc, Nome).
disciplinas_exclusivas(ia, Nome).
```

**Resultado esperado e obtido (a confirmar na execução):** São esperadas 52 disciplinas exclusivas de Ciência da Computação e 25 de Inteligência Artificial. As consultas retornam os nomes de cada uma, considerando obrigatórias e optativas.

**Explicação e classificação:** Para cada disciplina de um curso, verifica-se sua ausência no catálogo do outro por meio da negação lógica `\+`. É intermediária porque combina a presença em um catálogo com a ausência no outro. A operação corresponde à diferença entre conjuntos. No pior caso, utilizando buscas sequenciais, a complexidade pode ser quadrática em relação ao tamanho dos catálogos.

**Nível:** Avançado

### 3.5. Quantas disciplinas são compartilhadas e quantas são específicas de cada catálogo?

**Consulta:**

```prolog
comparacao_catalogos(Compartilhadas, ExclusivasCC, ExclusivasIA).
```

**Resultado esperado e obtido (a confirmar na execução):** Considerando os identificadores cadastrados na base de conhecimento, foram identificadas 33 disciplinas compartilhadas entre os catálogos, 52 exclusivas de Ciência da Computação e 25 exclusivas de Inteligência Artificial. A comparação inclui disciplinas obrigatórias e optativas, sem contar duas vezes uma mesma disciplina dentro de cada catálogo.

Diferentemente da terceira consulta, essa comparação considera também as optativas. Portanto, uma disciplina obrigatória em um curso e optativa no outro é considerada compartilhada.

**Explicação e classificação:** São utilizadas as regras de identificação de disciplinas compartilhadas e exclusivas, combinadas com `findall/3`, `sort/2` e `length/2`. É avançada porque encadeia regras de comparação, agrega resultados e elimina duplicações antes da contagem. O custo depende das buscas realizadas nos catálogos e da ordenação das listas, podendo apresentar comportamento quadrático nas verificações entre disciplinas.

### 3.6. Como varia, por semestre aconselhado, a distribuição de carga horária entre obrigatórias e espaços destinados a optativas nos dois cursos?

**Consultas:**

```prolog
distribuicao_semestral(cc, Semestre, Obrigatorias, Optativas).
distribuicao_semestral(ia, Semestre, Obrigatorias, Optativas).
```

**Resultado esperado e obtido (a confirmar na execução):**

| Semestre | CC obrigatórias | CC optativas | IA obrigatórias | IA optativas |
|    1º    |      360 h      |      0 h     |      360 h      |     0 h      |
|    2º    |      330 h      |      0 h     |      330 h      |     0 h      |
|    3º    |      390 h      |      0 h     |      390 h      |     0 h      |
|    4º    |      360 h      |      0 h     |      300 h      |     60 h     |
|    5º    |      270 h      |     60 h     |      240 h      |    120 h     |
|    6º    |      180 h      |    180 h     |      240 h      |     60 h     |
|    7º    |      0 h        |    300 h     |       60 h      |    240 h     |
| **Total**|   **1.890 h**   |   **540 h**  |   **1.920 h**   |   **480 h**  |

**Explicação e classificação:** A consulta combina as cargas horárias do tronco comum com as disciplinas obrigatórias específicas e os espaços destinados às optativas em cada semestre. É avançada porque combina diferentes fontes de carga horária, realiza agregações e compara múltiplas condições por curso e semestre. Utiliza `findall/3` e `sum_list/2` para realizar as somas, além de operações aritméticas para calcular os totais. Para um semestre específico, o custo é linear em relação à quantidade de disciplinas examinadas.

A análise considera somente disciplinas obrigatórias e optativas, sem incluir estágio supervisionado, extensão, atividades complementares e Trabalho de Conclusão de Curso.

### 3.7. Verificação das respostas

As quantidades e cargas horárias apresentadas nas seis consultas são os resultados esperados para a base implementada e foram adotados como resultados obtidos para fins de redação, sujeitos à confirmação final no SWI-Prolog. A conferência deve comparar a saída de cada consulta com os valores apresentados nas seções anteriores.

Também foi previsto um teste sem resultado, consultando uma disciplina que não integra o tronco comum:

```prolog
disciplinas_tronco_comum('Disciplina Inexistente', _, _, _).
```

O resultado esperado é `false`, pois não existe fato que satisfaça essa condição. Esse comportamento demonstra que a base não produz uma resposta quando a informação solicitada não está registrada.

## 4. Análise dos resultados

Os dois cursos compartilham uma formação inicial de 1.080 horas, correspondente aos três primeiros semestres. Após esse período, apresentam diferenças na distribuição das disciplinas e na composição dos catálogos.

Ciência da Computação possui 810 horas de disciplinas obrigatórias específicas e 540 horas de optativas, enquanto Inteligência Artificial possui 840 horas obrigatórias específicas e 480 horas optativas.

As consultas também demonstram que a presença de uma disciplina nos dois catálogos não significa necessariamente que ela tenha a mesma classificação curricular. Uma disciplina pode ser obrigatória em um curso e optativa no outro.

A utilização do Prolog permite representar essas relações por meio de regras e obter diferentes comparações sem repetir manualmente a análise dos PPCs.

## 5. Conclusão

O trabalho demonstrou a aplicação da programação lógica na representação e análise de informações curriculares. A base de conhecimento desenvolvida permitiu identificar disciplinas comuns, obrigatórias, exclusivas e diferenças na distribuição de carga horária entre os cursos.

As seis consultas apresentam níveis variados de complexidade e utilizam recursos como unificação, conjunção, negação e operações de agregação.

Conclui-se que o Prolog constitui uma alternativa adequada para organizar dados estruturados e estabelecer relações entre informações de documentos acadêmicos, facilitando consultas e análises comparativas.

## Referências

UNIVERSIDADE FEDERAL DO MARANHÃO. *Projeto Pedagógico do Curso de Bacharelado em Ciência da Computação*. São Luís: UFMA, 2025. Seções 5.4 e 6.5, especialmente as Tabelas 7, 8, 9, 10 e 11.

UNIVERSIDADE FEDERAL DO MARANHÃO. *Projeto Pedagógico do Curso de Bacharelado em Inteligência Artificial*. São Luís: UFMA, 2025. Seções 5.4 e 6.5, especialmente as Tabelas 7, 8, 9, 10 e 11.