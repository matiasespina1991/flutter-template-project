#!/bin/bash

#  Para imprimir el directorio: tree -L 4 -I "android|ios|test|build"
# Nombres de los archivos Dart que querés concatenar
files=(
    "lib/config.dart"
    "lib/main.dart"
    "lib/screens/home_screen/home_screen.dart"
    "lib/screens/login_screen/login_screen.dart"
#    "lib/widgets/AppScaffold/app_scaffold.dart"
    "lib/theme/main_theme.dart"
#    "lib/providers/auth_provider.dart"
#    "lib/providers/locale_provider.dart"
    "lib/providers/providers_all.dart"
    "lib/providers/theme_provider.dart"
#    "lib/models/current_user_data.dart"
    "pubspec.yaml"
)

# Archivo de salida
output_file="_combined.txt"

# Limpiar el archivo de salida si ya existe
> $output_file

# Concatenar los archivos
for file in "${files[@]}"
do
    cat "$file" >> $output_file
    echo "" >> $output_file # Agregar una línea en blanco entre archivos
done

echo "Files concatenated into $output_file"
