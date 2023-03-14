#!/bin/bash
# Programa para Instalar Kaban he instalarle el respaldo inicial
# por Elias Hung
kaban-instalar () {
cd ~/tron/programas/GesProgramas
source ./i-d-wekan-gantt-gpl.sh
source ./wekan-gantt.sh
instalarkaban
restaurarkaban
    
}
kaban-instalar
