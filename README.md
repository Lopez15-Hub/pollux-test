# Documentación Técnica Finance App
## Prueba para puesto de Fullstack developer

## Inicio rápido

    1. Clona el proyecto: https://github.com/Lopez15-Hub/pollux-test.git
    2. Dentro del proyecto, abre una terminal y ejecuta el comando "flutter pub get" para obtener las dependencias.
    3. Abre un emulador y luego de eso ejecuta el comando "flutter run"

## Temas del documento

1. Convenciones
2. Arquitectura
3. Conociendo el núcleo de nuestra aplicación
4. Respecto a tests
5. Enlaces externos

## Convenciones

Cada archivo dentro de este proyecto está metículosamente discriminado por su función, por ejemplo: Si es un servicio el archivo va a terminar en \_service.dart, si fuese repositorio: \_repository.dart y así sucesivamente a excepción de los BLoC's que en este caso se respeta la estructura creada por la extensión BLoC de visual studio code.

## Arquitectura

Para la arquitectura de este proyecto se implementó una variable recomendada por la documentación oficial de patrón BLoC. Aplicando programación por capas y separando las vistas de la lógica lo más que se pueda.

### Servicios

Cada servicio representa una implementación de terceros, tales cómo API's o implementaciones de librerías. Es el encargado de transportar la información hacia el repositorio.

### Repositorios

Un repositorio es la capa de intercambio entre los servicios externos y la capa de negocios. En esta variable de la documentación oficial de BLoC, observarán que para una implementación mas cómoda, se le añadió la funcionalidad de contener los metodos necesarios para crear modelos en la base de datos (SQFLITE). Esto, con el objetivo de facilitar la obtención y manejo de la información

### Directorios Globales

- Core: El núcleo de la aplicación. Contiene toda la lógica necesaria y requerida para el funcionamiento de la aplicación.

- Presentation: Es la capa de presentación. En ella se alojan los diseños que verá el usuario y podrá interactuar con el.

## Conociendo el núcleo de nuestra aplicación

- blocs: Directorio que contiene las lógicas de negocio, estados y eventos que consumen las vistas del proyecto. Dentro del mismo se incluyen los cubits
- config: Carpeta de configuración, especificamente aloja la constante "databaseName" para configurar el nombre de la base de datos.

- data: En este directorio se alojan las estructuras de datos, y las implementaciones necesarias para el manejo de los mismos.

- helpers: Son funciones de fácil acceso. Diseñadas para simplificar código y facilitar la implementación de procedimientos especificos.

## Respecto a tests

Las pruebas unitarias de este proyecto están disponibles en la carpeta test que se encuentra en la raíz de este proyecto.


## Enlaces externos


Guía utilizada en la arquitectura del proyecto: https://bloclibrary.dev/#/architecture
