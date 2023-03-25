#!/usr/bin/env bash
## https://github.com/mattduck/gh2md#install
pip install gh2md

## https://gist.github.com/justincbagley/ec0a6334cc86e854715e459349ab1446?permalink_comment_id=3706145#gistcomment-3706145
pip3 install gh-md-to-html[pdf_export]

## export the access token as ENV variables, need to add this token first before running this script
export GITHUB_ACCESS_TOKEN=<token>

## copy all the issue in '.md' format
$HOME/.local/bin/gh2md PRIVATE_REPO_PATH issues --multiple-files --no-closed-prs

## directory for issue converted to pdf
mkdir pdf_issues
cd issues/

## convert each 'issue.md' to 'issue.pdf'
count=0;
for entry in `ls $search_dir`; do 
  count=$((count + 1));
  $HOME/.local/bin/gh-md-to-html $entry -p ../pdf_issues/$entry.pdf
  if [[ $count == 2 ]];
  then
      sleep 100;
      count=0;
  fi
done

## create a zip and remove the unwanted files
cd ..
zip -r issues.zip pdf_issues
rm -r issues
