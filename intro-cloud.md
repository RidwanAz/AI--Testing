**Create and Initialize a Repository**
```
mkdir MarketPeak_Ecommerce
cd MarketPeak_Ecommerce
git init
```

**Stage and Commit the Template to Git**
```
git add .
git config --global user.name "YourUsername"
git config --global user.email "youremail@example.com"
git commit -m "Initial commit with basic e-commerce site structure"
```
**Push Template to Github Repository**
```
git remote add origin https://github.com/your-git-username/MarketPeak_Ecommerce.git
git push -u origin main
```

**Cloning Github Repository to EC2 Instance**
```
git clone git@github.com:yourusername/MarketPeak_Ecommerce.git
```
or
```
git clone https://github.com/yourusername/MarketPeak_Ecommerce.git
```

Install and Configure Webserver on EC2
```
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo rm -rf /var/www/html/*
sudo cp -r ~/MarketPeak_Ecommerce/* /var/www/html/
sudo systemctl reload httpd
```

**Integration and Deployment Workflow**
```
git branch development
git checkout development
git add .
git commit -m "Add new features or fix bugs"
git push origin development
git checkout main
git merge development
git push origin main
git pull origin main
sudo systemctl reload httpd

