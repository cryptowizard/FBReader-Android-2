#!/bin/bash -vxeu

for app in BibliaOrtodoxa VietileSfintilor BibliotecaOrtodoxa Pidalion; do
  echo "Building $app"
  git reset --hard HEAD
  ./molitfelnic_to_any_app.sh $app && ./dockerbuild.sh $app
done
