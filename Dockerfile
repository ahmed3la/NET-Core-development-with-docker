#this file for test
FROM microsoft/dotnet:sdk AS build
WORKDIR /app

COPY core-api/*.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out
#RUN dotnet publish --configuration Release --runtime win-x64
FROM microsoft/dotnet:aspnetcore-runtime AS runtime

WORKDIR /app

COPY --from=build /app/out .
ENTRYPOINT [ "dotnet","core-api.dll" ]
