# findstring

A Bash script that will search through  directory of files for a specific string and output which files contain it.

This uses simple \*nix commands to get a listing of files in the directory structure, and then read each file and search for the needle.

### **Usage**
./findstring \<File Type\> \<Input Directory\> "\<Search Term\>" \["hex"\]

The **\<File Type\>** is a filter. The script only searches these files.
The **\<Input Directory\>** is the structure to search (recursive).
The **\<Search Term\>** is what we are looking for.
If the word **hex** is specified, the search term and file content are all converted to hex (useful for non-text files).

-@BaddaBoom