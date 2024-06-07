# Proyecto Pasantía

Este proyecto busca crear una aplicación donde el usuario podrá leer un cuento y, en base a diferentes opciones, elegir la ruta mediante la cual el cuento progresará.

## Estructura del Proyecto

El proyecto está dividido en 5 capas:

1. **Capa Config**
   - Almacena el enrutamiento de la aplicación, las preferencias y el tema (decoración, colores principales, secundarios, etc.).

2. **Capa Application**
   - Contiene los providers de Riverpod y el delegate.
   - El delegate será el encargado de la búsqueda de cuentos.
   - Los providers permiten que la lógica de la aplicación se comunique con la capa de presentación.

3. **Capa Domain**
   - Almacena los modelos utilizados a lo largo del proyecto.
   - Los modelos principales son los del usuario y los del cuento.
   - En el caso del cuento, se utilizará un árbol para recorrer todas las opciones y rutas posibles del cuento.

4. **Capa Infrastructure**
   - Contiene toda la lógica de la aplicación, incluyendo las consultas de la base de datos, búsqueda, encriptación, etc.

5. **Capa Presentation**
   - Se divide en tres secciones: screens, views y widgets.
   - La sección de screens contiene el formato de la pantalla que se utilizará dependiendo de los requisitos de cada página.
   - Los views contienen el contenido de la página.
   - Los widgets personalizados, componentes de los views y componentes compartidos entre páginas se encuentran en la sección de widgets.

## Almacenamiento de Datos Sensibles

Para almacenar datos que podrían vulnerar la seguridad de la aplicación, se utilizará un archivo `.env`, el cual no será visible una vez sea desplegada la aplicación. Este archivo debe mantenerse de manera local y no debe subirse al repositorio de GitHub. Los datos se almacenan de la siguiente manera `clave=valor`, sin espacios y si es una cadena de caracteres se recomienda usar comillas simples.

## Prod

### Cambiar el Nombre de la Aplicación
```bash
flutter pub run change_app_package_name:main com.dase.talestell
