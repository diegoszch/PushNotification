

#SDK donet core 2.1 por se tratar de um LTS

FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /app

# Copiar todos os csproj da pasta src
COPY src/projects/*.csproj ./
RUN dotnet restore

# Build da aplicacao
COPY . ./
RUN dotnet publish -c Release -o out

# Build da imagem
FROM microsoft/dotnet:2.1-aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "Project.dll"]