module compiler;

import std.stdio;
import std.conv;
import std.file;

class Compiler {
    public byte[] tape;
    public int pointer;
    public char[] input;

    public this(string input) {
        this.input = input.dup;
        tape = new byte[30_000];
    }

    public void run() {
        int unmatchedBracketCounter = 0;

        for (int i = 0; i < input.length; i++) {
            switch (input[i]) {
                case '>':
                    pointer++;
                    break;
                
                case '<':
                    pointer--;
                    break;

                case '+':
                    tape[pointer]++;
                    break;

                case '-':
                    tape[pointer]--;
                    break;

                case '.':
                    write(cast(char)tape[pointer], "\n");
                    break;

                case ',':
                    char k = readln()[0];
                    tape[pointer] = cast(byte)k;
                    break;

                case '[':
                    if (tape[pointer] == 0) {
                        unmatchedBracketCounter++;
                        while (input[i] != ']' || unmatchedBracketCounter != 0) {
                            i++;

                            if (input[i] == '[') {
                                unmatchedBracketCounter++;
                            } else if (input[i] == ']') {
                                unmatchedBracketCounter--;
                            }
                        }
                    }
                    break;

                case ']':
                    if (tape[pointer] != 0) {
                        unmatchedBracketCounter++;
                        while (input[i] != '[' || unmatchedBracketCounter != 0) {
                            i--;

                            if (input[i] == ']') {
                                unmatchedBracketCounter++;
                            } else if (input[i] == '[') {
                                unmatchedBracketCounter--;
                            }
                        }
                    }
                    break;

                default:
                    break;
            }
        }
    }
}

/*
void main() {
    // read file
    string program;
    File file = File("brainf.b", "r");
    foreach (line; file.byLine()) {
        program ~= line;
    }
    file.close();

    auto comp = new Compiler(program);
    comp.run();
}
*/