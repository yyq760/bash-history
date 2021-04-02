# bash-history
bash shell历史命令自动记录到文件

## 原理
采用 **SHELL** 内置变量 **PROMPT_COMMAND** 记录到重定向到 **syslog** 的方法记录到文件

## 文件用途

| 文件名                 | 作用                                                       |
| :--------------------- | :--------------------------------------------------------- |
| files/HIST.sh          | 环境变量配置加载文件                                       |
| files/hist             | cron的脚本文件，用于定期检查文件权限                       |
| files/history.conf     | rsyslog的配置文件，配置自定义的日志级别                    |
| setup.sh               | 安装脚本                                                   |
| /var/log/history/*.log | 每个用户的history日志文件                                  |
| /root/.bash_history    | root用户的history文件                                      |
| /var/log/history.log   | 系统全局的记录文件，记录**用户、IP、命令、返回值、进程ID等** |

## 如何安装

```bash
git clone https://github.com/yyq760/bash-history.git
cd bash-history
bash setup.sh
```

## 日志文件格式预览

- history命令输出：

    ```text
     6859  <2021-04-02 11:07:03>: history
     6860  <2021-04-02 11:07:09>: cd /var/log/history
     6861  <2021-04-02 11:07:09>: ls
     6862  <2021-04-02 11:07:12>: more alter-1000.log
     6863  <2021-04-02 11:07:16>: exit
     6864  <2021-04-02 11:07:24>: history
    ```


- /var/log/history.log:

    ```text
    Mar 18 21:08:37 localhost alter: alter@192.168.1.104 : PID[22275] PPID[22272] : @/images :  ls -lrt RETURN[0]
    Mar 18 21:08:37 localhost alter: alter@192.168.1.104 : PID[22275] PPID[22272] : @/images :  ls -lrt RETURN[0]
    Mar 18 21:08:38 localhost alter: alter@192.168.1.104 : PID[22275] PPID[22272] : @/images :  ls -lrt RETURN[0]
    Mar 19 21:49:25 localhost alter: alter@192.168.1.101 : PID[19333] PPID[19331] : @/home/alter :  exit RETURN[0]
    Mar 19 21:49:42 localhost alter: alter@192.168.1.101 : PID[19333] PPID[19331] : @/home/alter :  it 30 RETURN[130]
    Mar 19 21:57:11 localhost alter: alter@192.168.1.101 : PID[19516] PPID[19515] : @/home/alter :  it 30 RETURN[0]
    Mar 19 21:57:25 localhost alter: alter@192.168.1.101 : PID[19516] PPID[19515] : @/home/alter :  iptv down RETURN[0]
    Mar 19 21:57:32 localhost alter: alter@192.168.1.101 : PID[19516] PPID[19515] : @/home/alter :  dt 10 RETURN[0]
    Mar 19 22:12:40 localhost alter: alter@192.168.1.101 : PID[19851] PPID[19850] : @/home/alter :  e RETURN[0]
    Mar 19 22:12:44 localhost alter: alter@192.168.1.101 : PID[19851] PPID[19850] : @/home/alter :  dt 7 RETURN[0]
    Mar 19 22:52:09 localhost alter: alter@192.168.1.104 : PID[20595] PPID[20589] : @/home/alter :  e RETURN[0]
    ```

