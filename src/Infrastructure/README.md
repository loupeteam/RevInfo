# RevInfo
RevInfo automatically creates Git commit data and Automation Studio build information in a variable declaration file which you can use within an Automation Studio project. It makes clear what committed version of code is running and who transferred it (+when!) to ensure you’ll never walk away from a machine with uncommited code, ever again.

**Configuration Pre-Build Step:**
```
"$(AS_PROJECT_PATH)\Logical\Infrastructure\RevInfo\getRevInfo.sh" "$(AS_PROJECT_PATH)\Logical\Infrastructure\RevInfo" "${AS_CONFIGURATION}" "${AS_USER_NAME}"
```