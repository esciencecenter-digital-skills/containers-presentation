---
title: Introduction to Containers
subtitle: and specifically Docker
---

# Why?
## Question
Why do you think containers are useful to you?

## You want to use software
- Run software that's not available on your OS
- Run software that's hard to install on any OS
- Dealing with many dependencies
- Check results against different versions of same software
- Reproduce a colleague's results

## You want others to run yours
- Deployment: have it work on someone elses computer
- Your users complain about not being able to install
- Have a colleague check your results

## Question
How did your struggles impact the quality of your work?

# Inception: levels of the virtual
## What is a computer, physically?
- CPU
- Memory
- Disk

## And what else?
- Software:
   - Kernel
   - Libraries
   - Executables

## Can we change the Kernel?
- Swap out the hard drive
- Dual boot
- Virtual machine

## Change libraries
- Chroot
- Static linking
- Containers

# Containers and Images
## Image
- An image is like a harddrive
- If we're baking cookies: the cookie template

## Container
- A container is like a running computer
- If we're baking cookies: the cookie! yum


