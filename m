Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751601AbeEVCgK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 May 2018 22:36:10 -0400
Date: Tue, 22 May 2018 10:36:07 +0800
From: Xiong Murphy Zhou <xzhou@redhat.com>
Subject: Re: [PATCH] generic/484: Need another process to check record locks
Message-ID: <20180522023607.erii7fuiblwczmzz@XZHOUW.usersys.redhat.com>
References: <1526881320-10983-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526881320-10983-1-git-send-email-yangx.jy@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, guaneryu@gmail.com, xzhou@redhat.com, jlayton@poochiereds.net
List-ID: <fstests@vger.kernel.org>

On Mon, May 21, 2018 at 01:42:00PM +0800, Xiao Yang wrote:
> 1) According to fcntl(2) manpage, A single process always gets F_UNLCK in
>    the l_type field when using fcntl(F_GETLK) to acquire the existing lock
>    set by itself because it could convert the existing lock to a new lock
>    unconditionally.  So we need another process to check if the lock exists.

I used to do that, eventaully I deleted it because we don't need
to check in another process in this case.

Thanks,
Xiong

> 
> 2) Remove redundant exit(0).
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  src/t_locks_execve.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/src/t_locks_execve.c b/src/t_locks_execve.c
> index 9ad2dc3..d99d7de 100644
> --- a/src/t_locks_execve.c
> +++ b/src/t_locks_execve.c
> @@ -8,6 +8,7 @@
>  #include <errno.h>
>  #include <pthread.h>
>  #include <unistd.h>
> +#include <sys/types.h>
>  #include <sys/wait.h>
>  
>  static void err_exit(char *op, int errn)
> @@ -32,12 +33,24 @@ struct flock fl = {
>  
>  static void checklock(int fd)
>  {
> -	if (fcntl(fd, F_GETLK, &fl) < 0)
> -		err_exit("getlk", errno);
> -	if (fl.l_type == F_UNLCK) {
> -		printf("record lock is not preserved across execve(2)\n");
> -		exit(1);
> +	pid_t pid;
> +
> +	pid = fork();
> +	if (pid < 0)
> +		err_exit("fork", errno);
> +
> +	if (!pid) {
> +		if (fcntl(fd, F_GETLK, &fl) < 0)
> +			err_exit("getlk", errno);
> +		if (fl.l_type == F_UNLCK) {
> +			printf("record lock is not preserved across execve(2)\n");
> +			exit(1);
> +		}
> +		exit(0);
>  	}
> +
> +	waitpid(pid, NULL, 0);
> +
>  	exit(0);
>  }
>  
> @@ -52,7 +65,6 @@ int main(int argc, char **argv)
>  	if (argc == 3) {
>  		fd = atoi(argv[2]);
>  		checklock(fd);
> -		exit(0);
>  	}
>  
>  	fd = open(argv[1], O_WRONLY|O_CREAT, 0755);
> -- 
> 1.8.3.1
> 
> 
> 
