#!/bin/bash

echo "Por favor insira o ID da instância que terá o tamanho alterado"

read instance_id

echo "Você digitou: $instance_id"

echo "Por favor insira o tamanho desejado para a instância"

read instance_size

export instance_id

export instance_size

aws ec2 modify-instance-attribute \
    --instance-id $instance_id \
    --instance-type "{\"Value\": \"$instance_size\"}"