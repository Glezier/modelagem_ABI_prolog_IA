% Lista as disciplinas do Tronco Formativo Comum

disciplinas_tronco_comum(Nome, Eixo, CargaHoraria, Semestre) :-
    tronco_comum(Id, Eixo, CargaHoraria, Semestre),
    disciplina(Id, Nome).


% Lista as disciplinas obrigatorias especificas de cada curso

obrigatorias_especificas(Curso, Nome, CargaHoraria) :-
    curriculo(Curso, Id, obrigatoria, CargaHoraria),
    disciplina(Id, Nome).


% Lista as disciplinas obrigatorias presentes nos dois cursos

obrigatorias_compartilhadas(Nome) :-
    obrigatoria_ambos(Id),
    disciplina(Id, Nome).

% Lista as disciplinas exclusivas do catalogo de cada curso

disciplinas_exclusivas(cc, Nome) :-
    exclusiva_cc(Id),
    disciplina(Id, Nome).

disciplinas_exclusivas(ia, Nome) :-
    exclusiva_ia(Id),
    disciplina(Id, Nome).


% Conta as disciplinas compartilhadas e exclusivas dos catalogos

comparacao_catalogos(Compartilhadas, ExclusivasCC, ExclusivasIA) :-
    total_compartilhadas(Compartilhadas),
    total_exclusivas(cc, ExclusivasCC),
    total_exclusivas(ia, ExclusivasIA).

% Compara a carga horaria obrigatoria e optativa por semestre

distribuicao_semestral(Curso, Semestre, Obrigatorias, Optativas) :-
    curso(Curso),
    between(1, 8, Semestre),
    carga_tronco_semestre(Semestre, CargaTronco),
    carga_especifica_semestre(Curso, Semestre, CargaEspecifica),
    Obrigatorias is CargaTronco + CargaEspecifica,
    (espaco_optativas(Curso, Semestre, Optativas) -> true ; Optativas = 0).