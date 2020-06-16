# Sistema Experto. 

## Covid-19.

El Sistema Experto propuesto diagnostica si el paciente padece de covid-19
gripe común o un simple resfriado, ofreciendole así unas pautas a seguir.
Sigue una lógica de predicados muy simple, para ejecutarlo debe guardar el archivo y si se encuentra en la interfaz gráfica de swipl seleccionarlo al hacer consult, en caso de que se encuentre en el terminal bastaría con situarse en la carpeta donde se encuentre el archivo en cuestión, ejecutar **swipl** (o la version de Prolog correspondiente) y hacer un consult al archivo creado, ejemplo:

>nordin@wsl $ swipl
>
>?- consult('expert.pl'). o ['expert.pl']. (ambos sirven)
>
>?- go.

Entonces podrás contestar las preguntas, el programa acepta respuestas como "y" o "yes" en caso afirmativo, si se introduce cualquier otro valor el sistema no tendrá en cuenta tal síntoma para el diagnóstico.

Al ser un programa tan básico es posible editarlo para que diagnostique cualquier otras enfermedades o situaciones que el lector crea conveniente. También sería posible, a través de lógica difusa, incluir un diagnóstico que nos muestre con que probabilidad el paciente puede tener una enfermedad u otra, ya que tal y como está implementado, el paciente debe tener todos los síntomas descritos para diagnosticar la enfermedad, en caso contrario, la daría por enfermedad desconocida. Por ello se han atribuido los casos más frecuentes de cada enfermedad, para hacer el análisis más sencillo.  