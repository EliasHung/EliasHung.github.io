# Ejemplo de Documentación Python

``` python

"""Impresora de columna de hoja de cálculo

Este script permite al usuario imprimir en la consola todas las columnas del
hoja de cálculo. Se supone que la primera fila de la hoja de cálculo es la
Ubicación de las columnas.

Esta herramienta acepta archivos de valores separados por comas (.csv), así como Excel
(.xls, .xlsx) archivos.

Este script requiere que `pandas` esté instalado dentro de Python
entorno en el que está ejecutando este script.

Este archivo también se puede importar como un módulo y contiene lo siguiente
funciones:

    * get_spreadsheet_cols - devuelve los encabezados de columna del archivo
    * main - la función principal del script
"""

import argparse

import pandas as pd


def get_spreadsheet_cols(file_loc, print_cols=False):

"""Obtiene e imprime las columnas de encabezado de la hoja de cálculo

    Parameters
    ----------
    file_loc : str
       
        La ubicación del archivo de la hoja de cálculo.
    print_cols : bool, optional
Un indicador utilizado para imprimir las columnas en la consola (el valor predeterminado es False)

    Returns
    -------
    list
        una lista de cadenas utilizadas que son las columnas de encabezado
    """

    file_data = pd.read_excel(file_loc)
    col_headers = list(file_data.columns.values)

    if print_cols:
        print("\n".join(col_headers))

    return col_headers


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        'input_file',
        type=str,
        help="El archivo de hoja de cálculo para imprimir las columnas de"
    )
    args = parser.parse_args()
    get_spreadsheet_cols(args.input_file, print_cols=True)


if __name__ == "__main__":
    main()


```
