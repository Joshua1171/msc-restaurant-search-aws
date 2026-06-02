#!/bin/bash
# Inicializa recursos en LocalStack para search-svc
set -e

AWS_ENDPOINT="http://localhost:4566"
AWS_REGION="us-east-1"
AWS_CMD="aws --endpoint-url=$AWS_ENDPOINT --region $AWS_REGION"
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test

echo "▶ Creando tabla DynamoDB restaurant-restaurants..."
$AWS_CMD dynamodb create-table \
    --table-name restaurant-restaurants \
    --attribute-definitions \
        AttributeName=restaurant_id,AttributeType=S \
        AttributeName=city,AttributeType=S \
    --key-schema \
        AttributeName=restaurant_id,KeyType=HASH \
    --global-secondary-indexes \
        "IndexName=city-index,KeySchema=[{AttributeName=city,KeyType=HASH}],Projection={ProjectionType=ALL}" \
    --billing-mode PAY_PER_REQUEST \
    || echo "(ya existe)"

echo "✔ LocalStack listo para search-svc"