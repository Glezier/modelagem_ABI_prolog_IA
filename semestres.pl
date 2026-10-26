% Calcula a carga horaria obrigatoria especifica por semestre

carga_especifica_semestre(Curso, Semestre, Total) :-
    findall(CH,
        (semestre_especifica(Curso, Id, Semestre),
         curriculo(Curso, Id, obrigatoria, CH)),
        Lista),
    sum_list(Lista, Total).

% Calcula a carga horaria do tronco comum por semestre

carga_tronco_semestre(Semestre, Total) :-
    findall(CH,
        tronco_comum(_, _, CH, Semestre),
        Lista),
    sum_list(Lista, Total).

% Semestres aconselhados das obrigatorias especificas de CC

semestre_especifica(cc, banco_dados1, 4).
semestre_especifica(cc, estrutura_dados2, 4).
semestre_especifica(cc, arquitetura_computadores, 4).
semestre_especifica(cc, processo_desenvolvimento, 4).
semestre_especifica(cc, calculo3, 4).
semestre_especifica(cc, fisica3, 4).

semestre_especifica(cc, linguagens_formais, 5).
semestre_especifica(cc, redes_computadores1, 5).
semestre_especifica(cc, sistemas_operacionais1, 5).
semestre_especifica(cc, circuitos_digitais1, 5).
semestre_especifica(cc, laboratorio_circuitos1, 5).

semestre_especifica(cc, compiladores, 6).
semestre_especifica(cc, teoria_computacao, 6).
semestre_especifica(cc, calculo_numerico, 6).


% Semestres aconselhados das obrigatorias especificas de IA

semestre_especifica(ia, banco_dados1, 4).
semestre_especifica(ia, estrutura_dados2, 4).
semestre_especifica(ia, arquitetura_sistemas, 4).
semestre_especifica(ia, introducao_ciencia_dados, 4).
semestre_especifica(ia, aprendizado_maquina, 4).

semestre_especifica(ia, visao_computacional, 5).
semestre_especifica(ia, aprendizado_profundo, 5).
semestre_especifica(ia, laboratorio_ciencia_dados, 5).
semestre_especifica(ia, modelagem_otimizacao, 5).

semestre_especifica(ia, processamento_linguagem_natural, 6).
semestre_especifica(ia, robotica_inteligente, 6).
semestre_especifica(ia, laboratorio_visao, 6).
semestre_especifica(ia, implantacao_modelos_ml, 6).

semestre_especifica(ia, laboratorio_inovacao_ia, 7).

% Espacos de optativas por semestre em Ciencia da Computacao

espaco_optativas(cc, 4, 0).
espaco_optativas(cc, 5, 60).
espaco_optativas(cc, 6, 180).
espaco_optativas(cc, 7, 300).


% Espacos de optativas por semestre em Inteligencia Artificial

espaco_optativas(ia, 4, 60).
espaco_optativas(ia, 5, 120).
espaco_optativas(ia, 6, 60).
espaco_optativas(ia, 7, 240).