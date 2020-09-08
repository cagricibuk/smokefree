git add .

echo "Commit mesajını giriniz."
read message

git commit -m "$message"
echo "git commit -m '$message'"

git push origin master

