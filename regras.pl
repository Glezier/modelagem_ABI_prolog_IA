% Identifica disciplinas do tronco comum

obrigatoria_tronco(Disciplina) :-
    tronco_comum(Disciplina, _, _, _).


% Identifica disciplinas obrigatorias de um curso

obrigatoria(Curso, Disciplina) :-
    curso(Curso),
    obrigatoria_tronco(Disciplina).

obrigatoria(Curso, Disciplina) :-
    curriculo(Curso, Disciplina, obrigatoria, _).


% Identifica disciplinas optativas de um curso

optativa(Curso, Disciplina) :-
    curriculo_optativa(Curso, Disciplina, _, _).


% Verifica se uma disciplina pertence ao catalogo

pertence_catalogo(Curso, Disciplina) :-
    obrigatoria(Curso, Disciplina).

pertence_catalogo(Curso, Disciplina) :-
    optativa(Curso, Disciplina).


% Disciplinas compartilhadas entre CC e IA

compartilhada(Disciplina) :-
    pertence_catalogo(cc, Disciplina),
    pertence_catalogo(ia, Disciplina).


% Disciplinas exclusivas de CC

exclusiva_cc(Disciplina) :-
    pertence_catalogo(cc, Disciplina),
    \+ pertence_catalogo(ia, Disciplina).


% Disciplinas exclusivas de IA

exclusiva_ia(Disciplina) :-
    pertence_catalogo(ia, Disciplina),
    \+ pertence_catalogo(cc, Disciplina).


% Disciplinas obrigatorias nos dois cursos

obrigatoria_ambos(Disciplina) :-
    obrigatoria(cc, Disciplina),
    obrigatoria(ia, Disciplina).


% Obrigatoria em CC e optativa em IA

obrigatoria_cc_optativa_ia(Disciplina) :-
    obrigatoria(cc, Disciplina),
    optativa(ia, Disciplina).


% Obrigatoria em IA e optativa em CC

obrigatoria_ia_optativa_cc(Disciplina) :-
    obrigatoria(ia, Disciplina),
    optativa(cc, Disciplina).

% Identifica disciplinas utilizadas nos curriculos
% que ainda nao possuem nome cadastrado

disciplina_sem_nome(D) :-
    pertence_catalogo(_, D),
    \+ disciplina(D, _).


% Conta as disciplinas obrigatorias especificas de determinado curso

total_obrigatorias(Curso, Total) :-
    findall(D,
        curriculo(Curso, D, obrigatoria, _),
        Lista),
    sort(Lista, Unicas),
    length(Unicas, Total).


% Calcula a carga horaria obrigatoria especifica

carga_obrigatoria(Curso, Total) :-
    findall(CH,
        curriculo(Curso, _, obrigatoria, CH),
        Lista),
    sum_list(Lista, Total).


% Conta as disciplinas compartilhadas

total_compartilhadas(Total) :-
    findall(D, compartilhada(D), Lista),
    sort(Lista, Unicas),
    length(Unicas, Total).


% Conta as disciplinas exclusivas de cada curso

total_exclusivas(cc, Total) :-
    findall(D, exclusiva_cc(D), Lista),
    sort(Lista, Unicas),
    length(Unicas, Total).

total_exclusivas(ia, Total) :-
    findall(D, exclusiva_ia(D), Lista),
    sort(Lista, Unicas),
    length(Unicas, Total).


% Identifica disciplinas cadastradas mais de uma vez no mesmo catalogo de obrigatorias

obrigatoria_duplicada(Curso, D) :-
    findall(D,
        curriculo(Curso, D, obrigatoria, _),
        Lista),
    length(Lista, Quantidade),
    Quantidade > 1.