# Use uma imagem base oficial do Python com Alpine Linux para um tamanho menor.
FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
COPY requirements.txt .

# Instala as dependências de compilação, os pacotes Python e depois remove
# as dependências de compilação em uma única camada para otimizar o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta em que a aplicação será executada.
EXPOSE 8000

# Comando para iniciar a aplicação usando Uvicorn.
# --host 0.0.0.0 faz com que o servidor seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]