flutter format lib --set-exit-if-changed
if [ $? -eq 1 ]; then
  flutter format lib
  git add .
  git commit -m "chore: run flutter format lib"
  echo "push changes? [y/n]"
  read pushResponse
  if [ $pushResponse = "y" ]; then
    git push origin
  fi
fi
flutter format test --set-exit-if-changed
if [ $? -eq 1 ]; then
  flutter format test
  git add .
  git commit -m "chore: run flutter format test"
  echo "push changes? [y/n]"
  read pushResponse
  if [ $pushResponse = "y" ]; then
    git push origin
  fi
fi
echo "Run dart fix --dry-run? [y/n]"
read dryRunResponse
if [ "$dryRunResponse" = "y" ]; then
  dart fix --dry-run
fi
echo "Run dart fix --apply? [y/n]"
read applyResponse
if [ "$applyResponse" = "y" ]; then
  dart fix --apply
  if [ -z "$(git status --porcelain)" ]; then
    echo "No changes to commit"
  else
    git add .
    git commit -m "chore: run dart fix --apply"
    echo "push changes? [y/n]"
    read pushResponse
    if [ $pushResponse = "y" ]; then
      git push origin
    fi
  fi
fi
echo "Run tests? [y/n]"
read testResponse
if [ "$applyResponse" = "y" ]; then
  flutter test
else
  exit 0
fi