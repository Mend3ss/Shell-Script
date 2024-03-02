#!/bin/bash

echo "Por favor insira o ID da instância que terá o tamanho alterado"
read instance_id
echo "Você digitou: $instance_id"

echo "Parando instância para fazer a troca"
aws ec2 stop-instances --instance-ids $instance_id

# Esperar até que o status seja "stopped"
while true; do
    status=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[*].Instances[*].[State.Name]' --output text)
    if [ "$status" = "stopped" ]; then
        echo "Instância parada com sucesso."
        break
    else
        echo "Aguardando instância parar. Aguarde um momento..."
        sleep 7  # ajuste conforme necessário
    fi
done

echo "Por favor insira o tamanho desejado para a instância"
read instance_size
echo "Você digitou: $instance_size"

aws ec2 modify-instance-attribute --instance-id $instance_id --instance-type "{\"Value\": \"$instance_size\"}"

echo "Tamanho da instância alterado com sucesso."

echo "Iniciando instância"

aws ec2 start-instances --instance-ids $instance_id

#Esperar o status "start"
while true; do
    status=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[*].Instances[*].[State.Name]' --output text)
    if [ "$status" = "running" ]; then
        echo "Instância iniciada com sucesso."
        break
    else
        echo "Aguardando instância iniciar. Aguarde um momento..."
        sleep 7  # ajuste conforme necessário
    fi
done

echo "script finalizado"