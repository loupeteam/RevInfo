# Info
Package is provided by Loupe  
https://loupe.team  
info@loupe.team  
1-800-240-7042  

# Description
This repo provides a program package that provide basic rev info functions. 

### Program Package
This is a program package.  RevInfo automatically creates Git commit data and Automation Studio build information in a variable declaration file which you can use within an Automation Studio project. It makes clear what committed version of code is running and who transferred it (+when!) to ensure you’ll never walk away from a machine with uncommited code, ever again.

**Configuration Pre-Build Step:**
```
"$(AS_PROJECT_PATH)\Logical\Infrastructure\RevInfo\getRevInfo.sh"
```

# Installation
To install using the Loupe Package Manager (LPM), in an initialized Automation Studio project directory run `lpm install revinfoprog`. For more information about LPM, see https://loupeteam.github.io/LoupeDocs/tools/lpm.html

# Documentation
For more documentation and examples, see https://loupeteam.github.io/LoupeDocs/tools/revinfo.html

# Licensing

This project is licensed under the [MIT License](LICENSE).
