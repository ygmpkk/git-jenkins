# Jenkins cli for git subcommand

Jenkins的git命令

适合开发者日常构建

## 安装升级

安装

```
brew install https://raw.githubusercontent.com/ygmpkk/git-jenkins/master/git-jenkins.rb
```

升级

```
brew uninstall git-jenkins
brew install https://raw.githubusercontent.com/ygmpkk/git-jenkins/master/git-jenkins.rb
```

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

- git jenkins list                  获取项目列表
- git jenkins generate              生成创建项目的配置文件
- git jenkins credentials <domain>  获取Jenkins的Git远程认证信息
- git jenkins create <project>      创建一个项目
- git jenkins build <project>       启动构建任务
- git jenkins log <project>         查看构建日志


## 配置文件

一般配置文件名为 `config.xml`

在Git项目下，运行 `git jenkins generate`，
会获取到 `git remote.origin.url` 作为 `hudson.plugins.git.UserRemoteConfig` 的 `url` 地址。
并且获取当前的branch为 `hudson.plugins.git.BranchSpec` 的 `branch` 。

用户需要填写的变量

- *YOUR GIT REMOTE CREDENTIALS* 可以通过 `git jenkins credentials` 获得
- *YOUR SHELL COMMAND* 需要构建的运行脚本

这个模板是仅提供最基本的功能，可以完全重写以符合自己的需求。

示例

```
<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.plugins.git.GitSCM" plugin="git@2.4.4">
    <configVersion>2</configVersion>
    <userRemoteConfigs>
      <hudson.plugins.git.UserRemoteConfig>
        <url>git@github.com:ygmpkk/git-jenkins.git</url>
        <credentialsId>9b846252-8d17-45e3-9da2-10537b009c9e</credentialsId>
      </hudson.plugins.git.UserRemoteConfig>
    </userRemoteConfigs>
    <branches>
      <hudson.plugins.git.BranchSpec>
        <name>develop</name>
      </hudson.plugins.git.BranchSpec>
    </branches>
    <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
    <submoduleCfg class="list"/>
    <extensions/>
  </scm>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers/>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>set
VERSION=`date +%Y%m%d`
sh pkg.sh $GIT_BRANCH $VERSION.$BUILD_ID
      </command>
    </hudson.tasks.Shell>
  </builders>
  <publishers/>
  <buildWrappers/>
</project>
```

## 演示步骤

```
> git config jenkins.url http://jenkins:8080

> git jenkins credentials

TITLE:
Global credentials (unrestricted)

DESCRIPTION:
Credentials that should be available irrespective of domain specification to requirements matching.

NAME                          KEY
jenkins                       xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

> git jenkins generate > config.xml
> cat config.xml

<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.plugins.git.GitSCM" plugin="git@2.4.4">
    <configVersion>2</configVersion>
    <userRemoteConfigs>
      <hudson.plugins.git.UserRemoteConfig>
        <url>git@github.com:ygmpkk/git-jenkins.git</url>
        <credentialsId>YOUR GIT REMOTE CREDENTIALS</credentialsId>
      </hudson.plugins.git.UserRemoteConfig>
    </userRemoteConfigs>
    <branches>
      <hudson.plugins.git.BranchSpec>
        <name>master</name>
      </hudson.plugins.git.BranchSpec>
    </branches>
    <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
    <submoduleCfg class="list"/>
    <extensions/>
  </scm>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers/>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>
        YOUR SHELL COMMAND
      </command>
    </hudson.tasks.Shell>
  </builders>
  <publishers/>
  <buildWrappers/>
</project>

> Youu should replace YOUR GIT REMOTE CREDENTIALS and YOUR SHELL COMMAND

> git jenkins create test config.xml

Jenkins: Create job test
SUCCESS

> git jenkins list

JOBS:
NAME                       STATUS
test                       NOTBUILT

VIEWS:
NAME         URL
All          http://jenkins:8080/
```
