Received: from mx1.redhat.com ([209.132.183.28]:40273 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180AbcFKP2j (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 11 Jun 2016 11:28:39 -0400
Date: Sat, 11 Jun 2016 23:28:36 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/208: do not leave pending async ios behind
 during process exit
Message-ID: <20160611152836.GW5140@eguan.usersys.redhat.com>
References: <1463696380-20169-1-git-send-email-tahsin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463696380-20169-1-git-send-email-tahsin@google.com>
Sender: fstests-owner@vger.kernel.org
To: Tahsin Erdogan <tahsin@google.com>
Cc: fstests@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

On Thu, May 19, 2016 at 03:19:40PM -0700, Tahsin Erdogan wrote:
> An inflight async io could keep the filesystem busy and cause umount
> -EBUSY errors after process exit. When the async io process is killed
> forcibly with SIGKILL, it doesn't get a chance to wait for ios to
> complete.
> 
> With this patch, instead of killing the children processes, we let them
> exit on their own after the timeout expires.
> 
> Signed-off-by: Tahsin Erdogan <tahsin@google.com>
> ---
>  src/aio-dio-regress/aio-dio-invalidate-failure.c | 89 ++++++++++++++----------
>  1 file changed, 54 insertions(+), 35 deletions(-)
> 
> diff --git a/src/aio-dio-regress/aio-dio-invalidate-failure.c b/src/aio-dio-regress/aio-dio-invalidate-failure.c
> index 24f3e3c..474a83c 100644
> --- a/src/aio-dio-regress/aio-dio-invalidate-failure.c
> +++ b/src/aio-dio-regress/aio-dio-invalidate-failure.c

[snip]

> @@ -152,38 +181,28 @@ int main(int argc, char **argv)
>  		exit(0);
>  	}
>  
> -	memset(&sa, 0, sizeof(sa));
> -	sa.sa_handler = alarm_handler;
> -	sigemptyset(&sa.sa_mask);
> -	if (sigaction(SIGALRM, &sa, NULL) == -1)
> -		fail("sigaction: %d\n", errno);
>  
> -	alarm(SECONDS);
> +	/* Child processes will exit on their own when timeout expires. */
> +	pid = waitpid(dio_pid, &status, 0);
> +	printf("dio_pid %d, pid %d, status %#x\n", dio_pid, pid, status);
>  
> -	pid = wait(&status);
> -	if (pid < 0 && errno == EINTR) {
> -		/* if we timed out then we're done */
> -		kill(buffered_pid, SIGKILL);
> -		kill(dio_pid, SIGKILL);
> +	dio_exit = (pid == dio_pid && WIFEXITED(status)) ?
> +			WEXITSTATUS(status) : 1;
>  
> -		waitpid(buffered_pid, NULL, 0);
> -		waitpid(dio_pid, NULL, 0);
> +	pid = waitpid(buffered_pid, &status, 0);
> +	printf("buffered_pid %d, pid %d, status %#x\n", buffered_pid, pid, status);

These two "printf" breaks generic/208

--- tests/generic/208.out       2016-06-02 12:38:40.111000000 +0800
+++ /root/workspace/xfstests/results//ext3_2k/generic/208.out.bad 2016-06-11 23:10:01.578000000 +0800
@@ -1,2 +1,4 @@
 QA output created by 208
 +dio_pid 17541, pid 17541, status 0
 +buffered_pid 17540, pid 17540, status 0
  ran for 200 seconds without error, passing

Thanks,
Eryu
