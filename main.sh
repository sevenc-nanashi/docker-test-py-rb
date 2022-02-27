cd /root

echo "# Installation test"
echo "## python3.9 main.py"
python3.9 main.py

echo
echo "## ruby main.rb"
ruby main.rb


echo
echo "# Web server test"
echo "## service nginx start"
service nginx start

echo
echo "# ruby sinatra.rb"
ruby sinatra.rb
