# Setting up cloud computing for data analysis

There are a number of companies that offer IaaS (Infrastructure as a Service) solutions an individual researcher can take advantage of, including AWS (Amazon) and the Google Cloud Platform. There will be a lot of jargon in this post, and a bit of time on the command line, so let's tackle some of the big questions first.

## What does IaaS really mean though?
So, whenever you run an analysis on your computer, you utilize your CPU, which is defined by the specs you bought the computer with - the amount of RAM, the number of cores, the clock rate, etc. and potentially, depending on what you are doing, the GPU if you have one and it isn't integrated onto the CPU (most modern ultrabooks have graphics cards that provision RAM from the CPU - It may not matter but maybe don't daisy chain those two 4k monitors). What you can do and how fast you can do it are a function of your system specs and how well optimized your machine is for the process you are trying to run. So, buy a spec'd out machine, right? Well...maybe not. Enter IaaS.

What you can do instead is use your mediocre physical machine to connect to a virtual machine and here is the kicker - you can adjust how many cores, how much RAM, and how much GPU processing power is provisioned every time you turn it on (and it's cheap). For example, I run a baseline configuration with 8 cores and 54 Gb of RAM but I cna quadruple that with a single line of code if I need to.

The birds eye view is pretty simple. Google maintains LOTS of commercially available raw processing power. You can rent it from them. They give you a virtual machine with whatever specs you need, and provision some disk space for you. The first time around, you pick an operating system (probably a linux distro) and install whatever programs you want. Next time around, there it all is, just like you left it. Tunnel back in and you are all set to pick up where you left off.

There are other advantages. If you use more than one computer or OS, keeping local copies of packages up to date and uniform is probably annoying. A central vm server solves that problem.

How do you use it?
That's kind of the point of the rest of the post. Read on.

## Start-up
