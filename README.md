# Jenkins cli for git subcommand

Jenkins的git命令

适合开发者日常构建

## 参数设置

支持从环境变量和git config读取配置

> JENKINS_URL 或 jenkins.url 参数是必须的

### 环境变量

- export JENKINS_URL=http://url
- export JENKINS_TOKEN=TOKEN
- export JENKINS_LOGIN=ygmpkk@gmail.com


### Git config

- git config jenkins.url http://jenkins
- git config jenkins.token TOKEN
- git config jenkins.login ygmpkk@gmail.com

## 命令

- git jenkins list              获取项目列表
- git jenkins build project     启动构建任务
- git jenkins log project       查看构建日志
