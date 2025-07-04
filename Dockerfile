FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# Proje dosyasını doğru klasörden kopyala
COPY DemoProject/*.csproj ./  
RUN dotnet restore

# Tüm proje dosyalarını kopyala
COPY DemoProject/. ./  
RUN dotnet publish -c Release -o /out

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build /out ./

ENTRYPOINT ["dotnet", "DemoProject.dll"]
