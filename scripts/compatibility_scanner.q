SCRIPT_DIR:{$["/"~last x;x;x,"/"]}first[system"pwd"],"/","/" sv -1 _ "/" vs string .z.f;
BASH_GREP_SCRIPT:SCRIPT_DIR,"compatibility_scanner/grep.sh";
BASH_FIND_SCRIPT:SCRIPT_DIR,"compatibility_scanner/find.sh";

overridedZsRegex:(
  "\\.z\\.ts";
  "\\.z\\.pg";
  "\\.z\\.ps";
  "\\.z\\.po";
  "\\.z\\.pc";
  "\\.z\\.ws";
  "\\.z\\.wo";
  "\\.z\\.wc";
  "\\.z\\.pi";
  "\\.z\\.exit"
 );


run:{[]
  args:parseArgs[];
  if[not ()~args`dir;args[`files]:distinct args[`files],getDirFileList args`dir];
  res:$[0<>count args`files;sum scanFile each args[`files];[-1"No files to scan";0]];

  -1"\nTotal lines with incompatibilities: ",string res;

  exit 0;
 };

scanFile:{[file]
  -1"--- '",file,"' ---";

  str:-1 _ raze{"(",x,")|"}each overridedZsRegex;

  res:system"bash ",BASH_GREP_SCRIPT," \"",str,"\" \"",file,"\"";
  if[enlist[""]~res;res:()];

  res:{{("J"$first x;":" sv 1 _ x)}":" vs x}each res;
  
  {-1"Line ",string[first x],":\t",last x}each res;
  -1"\nFound ",string[count res]," lines with compatibility issues in file";

  :count res;
 };

getDirFileList:{[dir]
  :system"bash ",BASH_FIND_SCRIPT," \"",dir,"\"";
 };

parseArgs:{[]
  args:(enlist[`]!enlist[::]),.Q.opt .z.x;

  if[0h~type args`dir;args[`dir]:first args`dir];
  if[10h<>type args`dir;args[`dir]:()];

  if[0h<>type args`files;args[`files]:enlist args`files];
  args[`files]:args[`files] where 10h=type each args`files;

  :args;
 };



run[];
