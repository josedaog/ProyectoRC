/*------------------------------------------------------------------------
 Sistema experto que diagnostica si el paciente padece de covid-19
 gripe común o un simple resfriado, ofreciendole así unas pautas a seguir.
------------------------------------------------------------------------ */

go:-
hypothesis(Enfermedad),
nl,
write('Hay una alta probabilidad de que el paciente tenga: '),
write(Enfermedad),
nl, nl,
write('Hasta la próxima, cuídate.'),
undo.

% Hipótesis a comprobar 

hypothesis(resfriado) :- resfriado, !.
hypothesis(gripe) :- gripe, !.
hypothesis(covid19) :- covid19, !.
hypothesis(pulmonia) :- pulmonia, !.
hypothesis(desconocido). % No se ha podido diagnosticar

% Identificación de las hipótesis 

resfriado :-
verify(estornudos),
verify(congestion_nasal),
verify(dolor_garganta),
verify(tos_suave),
verify(dolor_muscular),
write('Consejos:'),
nl,
write('1. Descansa.'),
nl,
write('2. Paracetamol para aliviar el dolor.'),
nl,
write('3. Descongentionante nasal.'),
nl,
write('4. Bebe mucha agua.'),
nl.

gripe :-
verify(fiebre),
verify(fatiga),
verify(tos_seca),
verify(dolor_muscular),
verify(dolor_cabeza),

write('Consejos:'),
nl,
write('1. Descansa y protegete del frio.'),
nl,
write('2. Beber mucha agua.'),
nl,
write('3. Evita contagiar a los demás, quédate en casa.'),
nl.

covid19 :-
verify(fiebre),
verify(tos_seca),
verify(cansancio),
verify(anosmia_o_disgeusia),
write('Consejos:'),
nl,
write('1. Dado los sintomas, usted esta obligado a quedarse en casa.'),
nl,
write('Evite el contacto con cualquier persona y aviseles de su situacion.'),
nl,
write('2. Limpie y desinfecte superficies, use mascarilla.'),
nl,
write('3. Beber mucha agua.'),
nl,
write('4. La atencion medica se pondra en contacto con usted.'),
nl.

% Dada la situación actual en caso de padecer tales síntomas es muy probable que padezca de covid, 
% aún así se le atribuye otro caso dado que se deben distinguir entre el diagnóstico de un caso grave y leve.
% Siempre teniendo en cuenta que esto es un diagnóstico básico y que su uso es puramente ilustrativo.

pulmonia :-
verify(dificultad_respirar),
verify(dolor_pecho),
verify(incapacidad_habla),
write('La atencion medica se pondra en contacto con usted.'),
nl,
write('1. Quedese en casa y evite el contacto con otras personas.'),
nl,
write('2. Si sufre de sintomas graves necesita hospitalizacion.'),
nl.

% Como hacer las preguntas 

ask(Pregunta) :-
write('¿Sufre el paciente de '),
write(Pregunta),
write('? '),
read(Respuesta),
nl,
((Respuesta == yes ; Respuesta == y) ->
assert(yes(Pregunta)) ;
assert(no(Pregunta)), fail).

:- dynamic yes/1,no/1.

% Verificar la enfermedad

verify(S) :-
(yes(S) -> true ;
(no(S) -> fail ;
ask(S))).

% Deshacer las respuestas introducidas

undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.