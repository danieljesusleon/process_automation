#!/bin/bash
#optener lista de archivos en limpio y volcarlos en una lista simple
ls -l |awk '{print$9}' | sed '/^ *$/d' | sed '/copia_archivos_kubernetes.sh/d' > lista
#leer lista de archivos a incorporar y agregarlos/subirlos al pod
while IFS= read -r line; do 
 if [ "$line" != "lista" ]; then
  echo "subiendo $line"
  sleep 5
  kubectl -n avob cp $line $pod_name:"/opt/$line""
  sleep 5
  echo "archivo $line cargado"
 fi ; done < lista 
 rm lista
