# proyecto_pasantia

Este proyecto busca crear una aplicación donde el usuario podrá leer un cuento y en base a diferentes opciones elegir la ruta mediante la cual en cuento progresará.
El proyecto está dividido en 5 capas.
1.- La primera capa es la capa **config** dentro de la cual se almacenará el enrutamiento de la aplicación, las preferencias y el tema (decoración, colores principales, secundarios, etc.)
2.- La segunda capa es la capa **aplication** esta capa contendrá los providers de riverpod y el delegate. El delegate será el encargado de la búsqueda de cuentos y los providers se permitirán que la lógica de la aplicación se comunique con la capa de presentación.
3.- La tercera capa corresponde a la capa **domain** o la capa de dominio. Dentro de esta capa se almacenarán los modelos que se utilizarán a lo largo del proyecto. Los modelos principales son los del usuario y los de cuento. En el caso del cuento se utilizará un árbol para recorrer todas las opciones y rutas posibles del cuento.
4.- La cuarta capa pertenece a **infraestrucure** que corresponde a toda la lógica de la aplicación. Incluyendo las consultas de la base de datos, búsqueda, encriptación, etc.
5.- La última capa es la capa de presentación o **presentation** esta capa se divide en tres secciones screens, views y widgets. La sección de screens contiene el formato de la pantalla que se utilizará dependiendo los requisitos de cada página. Los views contendrán el contenido de la página. Por último, la sección de widgets contendrá widgets personalizados, componentes de los views y componentes compartidos entre páginas.

#Almacenamiento de datos sensibles
Para almacenar datos que podrían vulnerar la seguridad de la aplicación se almacenarán en un archivo .env, el cual no será visible una vez sea desplegada la aplicación. Además, este archivo debe mantenerse de manera local y no debe subirse al repositorio de github. Los datos se almacenan de la siguiente manera *clave=valor*, sin espacios y si es una cadana de caracteres es de usar comillas simples.