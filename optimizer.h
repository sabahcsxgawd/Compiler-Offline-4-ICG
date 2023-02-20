#pragma once

string JMPS[] = {
  "JC",
  "JNC",
  "JE",
  "JZ",
  "JNE",
  "JNZ",
  "JO",
  "JNO",
  "JP",
  "JPE",
  "JNP",
  "JPO",
  "JS",
  "JNS",
  "JA",
  "JNBE",
  "JAE",
  "JNB",
  "JBE",
  "JNA",
  "JG",
  "JNLE",
  "JGE",
  "JNL",
  "JL",
  "JNGE",
  "JLE",
  "JNG",
  "JCXZ",
  "JMP"
};

class lineClass
{
private:
    string line;
    bool keep, hasTab;
public:
    lineClass(string line) {
        this->line = line;
        this->keep = true;
        this->hasTab = false;
        if(line[0] == '\t') {
            this->line.erase(0, 1);
            this->hasTab = true;
        }
    }
    bool getKeep() {
        return this->keep;
    }
    bool getHasTab() {
        return this->hasTab;
    }
    string getLine() {
        return this->line;
    }
    void setKeep(bool keep) {
        this->keep = keep;
    }
    bool isAJMP() {
        string temp = "";
        if(this->line.size() > 1 && this->line.find(" ") != string::npos) {
            temp = this->line.substr(0, this->line.find(" "));
            for(string j : JMPS) {
                if(temp == j) {
                    return true;
                }
            }
        }
        return false;
    }
    string getLHS() {
        int commaIndex = this->line.find(",");
        return this->line.substr(4, commaIndex - 4);
    }
    string getRHS() {
        int commaIndex = this->line.find(",");
        return this->line.substr(commaIndex + 2, this->line.size() - commaIndex - 2);
    }
};

void removeLines(vector<lineClass>& lines) {
    vector<lineClass> temp;
    for(lineClass l : lines) {
        if(l.getKeep()) {
            temp.push_back(l);
        }
    }
    lines.clear();
    lines = temp;
    temp.clear();
}

void optimize(ifstream &codeasm, ofstream &optcodeasm) {
    vector<lineClass> lines;
    map<string, int> labels;
    string _line;
    while (getline(codeasm, _line)) {
        lines.push_back(lineClass(_line));
    }
    int count = lines.size();
    
    //pass 1 to detect addition or subtraction with zero and necessary labels

    for(int i = 0; i < count; i++) {
        if((lines[i].getLine().substr(0, 3)) == "ADD" || (lines[i].getLine().substr(0, 3)) == "SUB") {
            if(lines[i].getLine().find(", 0") != string::npos) {
                lines[i].setKeep(false);
            }
        }
        else if(lines[i].isAJMP()) {
            labels[lines[i].getLine().substr(lines[i].getLine().find(" ") + 1, lines[i].getLine().size() - (lines[i].getLine().find(" ") + 1))]++;
        }
    }
     
    // pass 2 to remove unncessary labels
    for(int i = 0; i < count; i++) {
        if(lines[i].getLine()[0] == 'L' && lines[i].getLine().find(":") != string :: npos) {
            if(!labels[lines[i].getLine().substr(0, lines[i].getLine().size() - 1)]) {
                lines[i].setKeep(false);
            }
        }
    }

    removeLines(lines);
    count = lines.size();

    // pass 3 to remove redundant PUSH POP instructions

    for(int i = 0; i < count; ) {
        if(i + 1 < count) {
           if(lines[i].getLine() == "PUSH AX" && lines[i + 1].getLine() == "POP AX") {
            lines[i].setKeep(false);
            lines[i + 1].setKeep(false);
            i += 2;
           }
           else {
            i++;
           }
        }
        else {
            break;
        }
    }

    removeLines(lines);
    count = lines.size();

    // pass 4 to remove redundant MOV instructions
    for(int i = 0; i < count; ) {
        if(i + 1 < count) {
            if(lines[i].getLine().find("MOV") != string::npos && lines[i + 1].getLine().find("MOV") != string::npos) {
                if((lines[i].getLHS() == lines[i + 1].getRHS()) && (lines[i].getRHS() == lines[i + 1].getLHS())) {
                    lines[i+1].setKeep(false);
                    i += 2;
                }
                else {
                    i++;
                }
            }
            else {
                i++;
            }
        }
        else {
            break;
        }
    }

    removeLines(lines);
    count = lines.size();

    for(lineClass l : lines) {
        optcodeasm << (l.getHasTab() ? "\t" : "") << l.getLine() << '\n';
    }

    lines.clear();

}