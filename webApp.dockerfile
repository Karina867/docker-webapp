FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as build-env
WORKDIR /WebApp
COPY WebApp/*.csproj .
RUN dotnet restore
COPY WebApp .
RUN dotnet publish -c Release -o /publish

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1 as runtime
WORKDIR /publish
COPY --from=build-env /publish .
EXPOSE 80
ENTRYPOINT ["dotnet", "WebApp.dll"]