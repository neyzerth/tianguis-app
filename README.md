# Tianguis App

## How Start the proyect

### In CLI
1. Go to ```...react-native/```
2. To install dependences, run: ```npm install```
3. When you have the dependeces, run it with ```npx expo start```
4. If you want to re-install the dependences:
   1.  Delete ```node-modules/```
   2.  Delete ```package-lock.json```  
   3.  Clean npm cache with ```npm cache clean --force```
   4.  Run ```npm install```

### With scripts

#### Windows
Run the script in cmd:
```cmd
start.bat
```

If you want to install the dependences, run:
```cmd
start.sh --i
```

If you want to re-install all the dependences, run:
```cmd
start.sh --r
```

#### Linux/Mac
Ensure the script have permission to execute
```bash
chmod +x start.sh
```

And execute the script:
```bash
./start.sh
```

If you want to install the dependences, run:
```bash
./start.sh --i
```

If you want to re-install all the dependences, run:
```bash
./start.sh --r
```