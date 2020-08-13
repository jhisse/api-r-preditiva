FROM r-base:4.0.0

# Instalando dependências
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		libxml2-dev \
		libz-dev \
        git-core \
        libssl-dev \
        libcurl4-gnutls-dev \
	&& rm -rf /var/lib/apt/lists/*

# Instalando o Plumber com o install2.r
RUN install2.r -s -d TRUE --error plumber

# Instalando o caret com o install2.r
RUN install2.r -s -d TRUE --error caret

# Setando o usuário e grupo
USER 1000:1000

# Definindo diretório de trabalho
WORKDIR /app

# Copiando arquivos
COPY api.r .

COPY glm_model.rds .

EXPOSE 8080

# Definindo comando a ser executado, ativando o endpoint do swagger
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb('/app/api.r'); pr$run(host='0.0.0.0', port=8080, swagger = TRUE)"]