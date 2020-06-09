# Representación del conocimiento en Inteligencia Articial

Si en algo podemos caracterizarnos los seres humanos es en entender, razonar e interpretar el entorno, la cuestión es: ¿Como hacer que una máquina actúe como nosotros?

En respuesta a esta pregunta surge la *Representación del conocimiento*, situándola pues como uno de los pilares fundamentales de  la Inteligencia Artificial.

* [Introducción](##introducción)
* [Objetivo](##objetivo)
* [Representación del conocimiento en IA](##representación-del-conocimiento-en-ia)

## Introducción

La representación del conocimiento es un área muy amplia que abarca tantos aspectos teóricos como los más puramente epistemológicos incluyendo problemas de enfoque práctico como el tratamiento de datos. A continuación trataeremos como la representación del conocimiento permite codificar el conocimiento humano de manera que este pueda ser usado computacionalmente, no se trata solo de guardar y tratar datos, sino de hacer posible que una máquina pueda aprender de estos y comportarse de manera inteligente, tal y como haría una ser humano.
Por lo general, podemos clasificar el conocimiento en tres tipos:

* Conocimiento declarativo

    Son hechos sobre objetos o situaciones. Estos poseen mayor capacidad expresiva, lo que a su vez produce una menor capacidad computacional. Es conocimiento pasivo expresado mediante sentencias acerca de los hechos del mundo que nos rodea.
    Este conocimiento puede ser representado con modelos relacionales y esquemas basados en lógica. Los modelos relacionales pueden ser representados en forma de árboles, grafos o redes semántica. Los esquemas de representación lógica incluyen el uso de lógica proposicional y lógica de predicados.

* Conocimiento procedimental

    Es aquel conocimiento compilado que se refiere a la forma de realizar cierta tarea, es decir, el saber como hacer algo. Por ejemplo, los pasos a seguir para resolver un problema de matemáticas.
    Están caracterizados por gramáticas formales, usualmente implantadas por sistemas o lenguajes procedimentales y sistemas basados en reglas.

* Conocimiento heurístico

    Es un tipo especial de conocimiento usado por los humanos para resolver problemas complejos. Está relacionado con la palabra griega *heuriskein* que significa descubrir. Entendemos por heurístico a un criterio, método, estrategia seguida para simplificar la solución de un problema.

![Imagen1](./imagenes/img1.png)

## Objetivo

La representación del conocimiento deberia comprender y describir la riqueza del mundo. Sin embargo, en la práctica, el esfuerzo llevado a cabo en la investigación de éste se ha concentrado en desarrollar un conjunto de normas que la máquina debe realizar para llegar a un fin específico. Este fin proviene de la abstracción del conocimiento haciendo un examen minucioso del mundo real.
Con esto queremos decir que las técnicas y herramientas son básicas para el desarrollo sí, pero el verdadero reto se encuentra en entender y poder describir la riqueza que nos rodea.

![Imagen2](./imagenes/img2.jpg)

## Representación del conocimiento en IA

Para representar algo necesitamos saber:

* Su forma o estructura.
* El uso que le dan los seres inteligentes.
* El uso que le derá la inteligencia artificial.
* Como adquirir el conocimiento.
* Como almacenarlo y manipularlo.

En la actualidad no tenemos una respuesta completa a estas preguntas, no obstante, construiremos modelos que simulen la adquisición, estructuración y manipulación del conocimiento que nos permitan crear sistemas artificiales inteligentes.

Un esquema que muestre que elementos componen un sistema inteligente:

![Imagen3](./imagenes/img3.png)

* Percepción: Encargada de recibir datos o información del entorno.
* Aprendizaje: El sistema debe ser capaz de aprender del entorno, de manera que el computador pueda aprender por el mismo sin necesidad de ser programado.
* Representación del conocimiento y razonamiento: El componente principal, encargado de enseñar a la máquina la inteligencia humana, el objetivo es que el agente en cuestión se comporte inteligentemente y como el razonamiento automatizado puede ir extrayendo la información del entorno conforme la vaya necesitando.
* Planificación y ejecución: El agente necesitará un plan, que consistirá en darle unas condiciones iniciales, efectos y una secuencia de acciones que lo lleven a su fin. Una vez este ha sido completado, el último paso será la ejecución del proceso final.

Los agentes que encontramos en estos sistemas pueden pues, conocer *solo* aquello que ha experimentado, por ejemplo, en *Prolog*:

Si preguntamos a Prolog si 1+1=2:

    ?- 2 is 1+1.
    Yes
Este nos responde sí ya se le ha dado tal conocimiento, si le preguntaramos si Lucas es un pato:

    ?- esPato(Lucas).
    No
Este nos dice que no ya que no se le ha dotado de ese conocimiento, no sabe ni qué es un pato ni conoce a un tal Lucas. Para darle ese conocimiento bastaría con expresarlo mediante un hecho (verdad incondicional) en un archivo con extensión *.pl* e introducirle esPato(Lucas). De esta forma si le volvieramos a preguntar:

    ?- esPato(Lucas).
    Yes
    ?- esPato(X).
    X = Lucas   
Incluso si le preguntamos por el nombre de un pato este nos responderá porque ya ha sido incluido en su *base de conocimiento*.
