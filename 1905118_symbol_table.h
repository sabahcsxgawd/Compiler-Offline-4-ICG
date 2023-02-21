#pragma once

class SymbolInfo
{
private:
    string name, type, dataType;
    // next pointer to resolve chaining in ScopeTable
    SymbolInfo *next;
    int ruleStartLine, ruleEndLine, arraySize;
    bool leafNodeStatus, isAFunction, isAnArray, isFunctionDeclared, isFunctionDefined;
    vector<SymbolInfo *> parseTreeChildList, functionParameterList;

public:
    int baseOffset;

    SymbolInfo()
    {
    }

    SymbolInfo(SymbolInfo *symbolInfo)
    {
        this->name = symbolInfo->name;
        this->type = symbolInfo->type;
        this->dataType = symbolInfo->dataType;
        this->next = symbolInfo->next;
        this->ruleStartLine = symbolInfo->ruleStartLine;
        this->ruleEndLine = symbolInfo->ruleEndLine;
        this->arraySize= symbolInfo->arraySize;
        this->leafNodeStatus = symbolInfo->leafNodeStatus;
        this->isAFunction = symbolInfo->isAFunction;
        this->isAnArray = symbolInfo->isAnArray;
        this->isFunctionDeclared = symbolInfo->isFunctionDeclared;
        this->isFunctionDefined = symbolInfo->isFunctionDefined;
        this->parseTreeChildList = symbolInfo->parseTreeChildList;
        this->functionParameterList= symbolInfo->functionParameterList;
        this->baseOffset = symbolInfo->baseOffset;
    }

    SymbolInfo(string name, string type)
    {
        this->name = name;
        this->type = type;
        this->dataType = "";
        this->next = NULL;
        this->ruleStartLine = this->ruleEndLine = this->arraySize = 0;
        this->leafNodeStatus = this->isAFunction = this->isAnArray = this->isFunctionDeclared = this->isFunctionDefined = false;
        this->parseTreeChildList.clear();
        this->functionParameterList.clear();
        this->baseOffset = 0;
    }

    void setIsAFunction(bool status)
    {
        this->isAFunction = status;
    }

    void setIsAnArray(bool status)
    {
        this->isAnArray = status;
    }

    void setArraySize(int arraySize) {
        this->arraySize = arraySize;
    }

    void setIsFunctionDeclared(bool status)
    {
        this->isFunctionDeclared = status;
    }

    void setIsFunctionDefined(bool status)
    {
        this->isFunctionDefined = status;
    }

    void setLeafNodeStatus(bool status)
    {
        this->leafNodeStatus = status;
    }

    void setDataType(string dataType)
    {
        this->dataType = dataType;
    }

    void setRuleStartLine(int ruleStartLine)
    {
        this->ruleStartLine = ruleStartLine;
    }

    void setRuleEndLine(int ruleEndLine)
    {
        this->ruleEndLine = ruleEndLine;
    }

    void setName(string name)
    {
        this->name = name;
    }

    void setType(string type)
    {
        this->type = type;
    }

    void setNextSymbolInfo(SymbolInfo *next)
    {
        this->next = next;
    }

    bool getIsAFunction()
    {
        return this->isAFunction;
    }

    bool getIsFunctionDeclared()
    {
        return this->isFunctionDeclared;
    }

    bool getIsFunctionDefined()
    {
        return this->isFunctionDefined;
    }

    bool getIsAnArray()
    {
        return this->isAnArray;
    }

    int getArraySize() {
        return this->arraySize;
    }

    bool getLeafNodeStatus()
    {
        return this->leafNodeStatus;
    }

    string getName()
    {
        return this->name;
    }

    string getType()
    {

        return this->type;
    }

    string getDataType()
    {

        return this->dataType;
    }

    int getRuleStartLine()
    {
        return this->ruleStartLine;
    }

    int getRuleEndLine()
    {
        return this->ruleEndLine;
    }

    void addSymbolToList(SymbolInfo *symbolInfo)
    {
        this->parseTreeChildList.push_back(symbolInfo);
    }

    void addFunctionParameterToList(SymbolInfo *symbolInfo)
    {
        this->functionParameterList.push_back(symbolInfo);
    }

    vector<SymbolInfo *> getParseTreeChildList()
    {
        return this->parseTreeChildList;
    }

    vector<SymbolInfo *> getFunctionParameterList()
    {
        return this->functionParameterList;
    }

    SymbolInfo *getNextSymbolInfo()
    {
        return this->next;
    }

    ~SymbolInfo()
    {
        delete this->next;
    }
};

class ScopeTable
{
private:
    int id;
    uint64_t num_of_buckets;
    SymbolInfo **symbolInfos;
    ScopeTable *parent_scope;

    uint64_t sdbm_hash(string name)
    {
        uint64_t hashValue = 0;
        for (char c : name)
        {
            hashValue = (uint64_t)c + (hashValue << 6) + (hashValue << 16) - hashValue;
        }
        hashValue = hashValue % num_of_buckets;
        return hashValue;
    }

public:
    ScopeTable()
    {
    }

    ScopeTable(int id, uint64_t num_of_buckets, ScopeTable *parent_scope)
    {
        this->id = id;
        this->num_of_buckets = num_of_buckets;
        this->parent_scope = parent_scope;

        this->symbolInfos = new SymbolInfo *[this->num_of_buckets];
        for (uint64_t i = 0; i < this->num_of_buckets; ++i)
        {
            this->symbolInfos[i] = NULL; // initialize to NULL
        }
    }

    int getID()
    {
        return this->id;
    }

    int geNumOfBuckets()
    {
        return this->num_of_buckets;
    }

    ScopeTable *getParentScope()
    {
        return this->parent_scope;
    }

    SymbolInfo *lookUpSymbol(string name)
    {
        uint64_t hashedIndex = this->sdbm_hash(name);
        int currPos = 1;

        SymbolInfo *finder = this->symbolInfos[hashedIndex];

        while (finder != NULL)
        {
            if (finder->getName() == name)
            {
                // found the symbol in this ScopeTable
                // cout << "	'" << name << "' found in ScopeTable# " << this->id << " at position " << hashedIndex + 1 << ", " << currPos << '\n';
                return finder;
            }
            // move along the chain to search
            currPos++;
            finder = finder->getNextSymbolInfo();
        }
        // not found
        return NULL;
    }

    bool insertSymbol(SymbolInfo *symbol, ofstream &logOut)
    {
        string name = symbol->getName();
        uint64_t hashedIndex = this->sdbm_hash(name);
        int currPos = 1;

        SymbolInfo *finder = this->symbolInfos[hashedIndex];
        SymbolInfo *previousSymbol = NULL;

        while (finder != NULL)
        {
            if (finder->getName() == name)
            {
                // already exists
                logOut << "\t" << name << " already exisits in the current ScopeTable\n";
                return false;
            }
            // move along the chain to either to find it or find the correct position for insertion
            currPos++;
            previousSymbol = finder;
            finder = finder->getNextSymbolInfo();
        }
        // the first entry in hash table is empty so insert it
        if (previousSymbol == NULL)
        {
            this->symbolInfos[hashedIndex] = symbol;
            // logOut << "	" << "Inserted in ScopeTable# " << this->id << " at position " << hashedIndex + 1 << ", " << currPos << '\n';
            return true;
        }
        // insert at the first NULL position
        previousSymbol->setNextSymbolInfo(symbol);
        // logOut << "	" << "Inserted in ScopeTable# " << this->id << " at position " << hashedIndex + 1 << ", " << currPos << '\n';
        return true;
    }

    bool deleteSymbol(string name)
    {
        uint64_t hashedIndex = this->sdbm_hash(name);
        int currPos = 1;

        SymbolInfo *finder = this->symbolInfos[hashedIndex];
        SymbolInfo *previousSymbol = NULL;

        while (finder != NULL)
        {
            if (finder->getName() == name)
            {
                // deletion is possible
                // need to modify the chain
                if (previousSymbol == NULL)
                {
                    // found at first position
                    this->symbolInfos[hashedIndex] = finder->getNextSymbolInfo();
                }
                else
                {
                    previousSymbol->setNextSymbolInfo(finder->getNextSymbolInfo());
                }

                // making the next pointer of to be deleted element to NULL so that
                // when calling the destructor of this SymbolInfo object it does not
                // destroy the chain starting from it
                finder->setNextSymbolInfo(NULL);

                delete finder;

                // cout << "	Deleted '" << name << "' from ScopeTable# " << this->id << " at position " << hashedIndex + 1 << ", " << currPos << '\n';

                return true;
            }
            currPos++;
            previousSymbol = finder;
            finder = finder->getNextSymbolInfo();
        }
        // not found so cannot delete
        // cout << "	Not found in the current ScopeTable\n";
        return false;
    }

    void printScopeTable(ofstream &logOut)
    {
        string temp = "";
        logOut << "\t"
               << "ScopeTable# " << this->id << "\n";
        for (uint64_t i = 0; i < this->num_of_buckets; ++i)
        {
            if (this->symbolInfos[i] == NULL)
            {
                continue;
            }

            logOut << "\t" << i + 1 << "--> ";
            // looping over the symbols in the index position
            SymbolInfo *mover = this->symbolInfos[i];
            while (mover != NULL)
            {
                if(mover->getIsAnArray()) {
                    temp = "ARRAY, " + mover->getDataType();
                    logOut << "<" << mover->getName() << ", " << temp << "> ";
                }
                else if(mover->getIsAFunction()) {
                    temp = "FUNCTION, " + mover->getDataType();
                    logOut << "<" << mover->getName() << ", " << temp << "> ";
                }
                else {
                    logOut << "<" << mover->getName() << ", " << mover->getDataType() << "> ";
                }
                mover = mover->getNextSymbolInfo();
            }
            logOut << '\n';
        }
    }

    void printGlobalVarsInASM(ofstream &logOut)
    {
        for (uint64_t i = 0; i < this->num_of_buckets; ++i)
        {
            if (this->symbolInfos[i] == NULL)
            {
                continue;
            }
            // looping over the symbols in the index position
            SymbolInfo *mover = this->symbolInfos[i];
            while (mover != NULL)
            {
                if(!mover->getIsAFunction()) {
                    int arrSize = mover->getArraySize() > 1 ? mover->getArraySize() : 1;
                    // string name = mover->getName();
                    // if(name == "number") {
                    //     name = '_' + mover->getName();
                    // }
                    logOut << "\t" << mover->getName() << " DW " << arrSize << " DUP (0000H)\n";
                }
                mover = mover->getNextSymbolInfo();
            }        
        }
    }

    ~ScopeTable()
    {
        for (uint64_t i = 0; i < this->num_of_buckets; ++i)
        {
            // destroying each chain of the symbols in the scope table
            delete this->symbolInfos[i];
        }
        // deallocating the memory
        delete[] this->symbolInfos;
        // cout << "	ScopeTable# " << this->id << " removed\n";
    }
};

class SymbolTable
{
private:
    ScopeTable *currentScopeTable;

public:
    SymbolTable()
    {
        // default constructor
        this->currentScopeTable = NULL;
    }

    void enterScope(int id, uint64_t num_of_buckets)
    {
        // creating new Scope Table and making the current one its parent as well as
        // making it the current Scope Table
        ScopeTable *newScopeTable = new ScopeTable(id, num_of_buckets, this->currentScopeTable);
        this->currentScopeTable = newScopeTable;
    }

    void exitScope()
    {
        if (this->currentScopeTable == NULL)
        {
            // do nothing
        }
        else if (this->currentScopeTable->getParentScope() == NULL)
        {
            // root Scope Table can not be exited without 'Q' command
            // which is resolved by calling destructor of Symbol Table
            int id = this->currentScopeTable->getID();
            // cout << "	ScopeTable# " << id << " cannot be removed\n";
        }
        else
        {
            // removing the current Scope Table and making its parent the current one
            ScopeTable *tempScopeTable = this->currentScopeTable;
            this->currentScopeTable = this->currentScopeTable->getParentScope();
            delete tempScopeTable;
        }
    }

    bool insertSymbolInSymbolTable(SymbolInfo *symbol, ofstream &logOut)
    {
        // insertion in symbol table which inserts symbol info obj to current scope table
        return this->currentScopeTable->insertSymbol(symbol, logOut);
    }

    bool removeSymbolInSymbolTable(string name)
    {
        // removal from symbol table which removes symbol info obj from current scope table
        return this->currentScopeTable->deleteSymbol(name);
    }

    SymbolInfo *lookUpSymbolInSymbolTable(string name)
    {
        ScopeTable *finder = this->currentScopeTable;
        SymbolInfo *lookedUp = NULL;
        while (finder != NULL)
        {
            lookedUp = finder->lookUpSymbol(name);
            if (lookedUp != NULL)
            {
                // found the symbol in current scope table
                return lookedUp;
            }
            else
            {
                // looking it up in parent scopes
                finder = finder->getParentScope();
            }
        }
        // not found in any scope tables
        // cout << "	'" << name << "' not found in any of the ScopeTables\n";
        return NULL;
    }

    void printCurrentScopeTable(ofstream &logOut)
    {
        // printing current scope table
        this->currentScopeTable->printScopeTable(logOut);
    }

    void printAllScopeTables(ofstream &logOut)
    {
        // printing all scope tables
        ScopeTable *mover = this->currentScopeTable;
        while (mover != NULL)
        {
            mover->printScopeTable(logOut);
            mover = mover->getParentScope();
        }
    }

    void printAllGlobalVarsInASM(ofstream &logOut)
    {
        ScopeTable *mover = this->currentScopeTable;
        while (mover != NULL)
        {
            mover->printGlobalVarsInASM(logOut);
            mover = mover->getParentScope();
        }
    }

    ~SymbolTable()
    {
        ScopeTable *toBeDeletedScopeTable = this->currentScopeTable;
        while (toBeDeletedScopeTable != NULL)
        {
            // deleting all the scope tables in the symbol table
            this->currentScopeTable = this->currentScopeTable->getParentScope();
            delete toBeDeletedScopeTable;
            toBeDeletedScopeTable = this->currentScopeTable;
        }
    }
};