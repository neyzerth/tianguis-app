# Tianguis App

## Reset package problem

### Linux/Mac
```bash
cd react-native
rm -rf node_modules/
rm package-lock.json
npm cache clean --force
npm install
```

### Windows
```cmd
cd react-native
rmdir /s /q node_modules
del package-lock.json
npm cache clean --force
npm install
```

> **Note**: En Windows, si usas PowerShell en lugar de CMD, puedes usar:
> ```powershell
> Remove-Item -Recurse -Force node_modules
> Remove-Item package-lock.json
> ```