Received: from mx1.redhat.com ([209.132.183.28]:35431 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715AbcETOk2 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 May 2016 10:40:28 -0400
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] generic/208: do not leave pending async ios behind during process exit
References: <1463696380-20169-1-git-send-email-tahsin@google.com>
Date: Fri, 20 May 2016 10:40:26 -0400
In-Reply-To: <1463696380-20169-1-git-send-email-tahsin@google.com> (Tahsin
	Erdogan's message of "Thu, 19 May 2016 15:19:40 -0700")
Message-ID: <x49r3cwztb9.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: Tahsin Erdogan <tahsin@google.com>
Cc: fstests@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Tahsin Erdogan <tahsin@google.com> writes:

> An inflight async io could keep the filesystem busy and cause umount
> -EBUSY errors after process exit. When the async io process is killed
> forcibly with SIGKILL, it doesn't get a chance to wait for ios to
> complete.

exit_aio will wait for all outstanding I/O before it returns, so you
shouldn't run into this.

-Jeff

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
> @@ -62,6 +62,26 @@ static unsigned char buf[GINORMOUS] __attribute((aligned (4096)));
>  	exit(1);		\
>  } while (0)
>  
> +
> +volatile int timeout_reached = 0;
> +
> +static void alarm_handler(int signum)
> +{
> +	timeout_reached = 1;
> +}
> +
> +void set_timeout(unsigned int seconds)
> +{
> +	struct sigaction sa;
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_handler = alarm_handler;
> +	sigemptyset(&sa.sa_mask);
> +	if (sigaction(SIGALRM, &sa, NULL) == -1)
> +		fail("sigaction: %d\n", errno);
> +
> +	alarm(seconds);
> +}
> +
>  void spin_dio(int fd)
>  {
>  	io_context_t ctx;
> @@ -70,18 +90,28 @@ void spin_dio(int fd)
>  	struct io_event event;
>  	int ret;
>  
> +	set_timeout(SECONDS);
> +
>          io_prep_pwrite(&iocb, fd, buf, GINORMOUS, 0);
>  
>  	ret = io_queue_init(1, &ctx);
>  	if (ret)
>  		fail("io_queue_init returned %d", ret);
>  
> -	while (1) {
> +	while (!timeout_reached) {
>  		ret = io_submit(ctx, 1, iocbs);
>  		if (ret != 1)
>  			fail("io_submit returned %d instead of 1", ret);
>  
> -		ret = io_getevents(ctx, 1, 1, &event, NULL);
> +		/*
> +		 * Retry io_getevents() if it gets interrupted by alarm signal.
> +		 * We don't want to leave behind uncompleted async io requests
> +		 * that could cause umount -EBUSY errors.
> +		 */
> +		do {
> +			ret = io_getevents(ctx, 1, 1, &event, NULL);
> +		} while (ret == -EINTR && timeout_reached);
> +
>  		if (ret != 1)
>  			fail("io_getevents returned %d instead of 1", ret);
>  
> @@ -99,17 +129,15 @@ void spin_buffered(int fd)
>  {
>  	int ret;
>  
> -	while (1) {
> +	set_timeout(SECONDS);
> +
> +	while (!timeout_reached) {
>  		ret = pwrite(fd, buf, GINORMOUS, 0);
>  		if (ret != GINORMOUS)
>  			fail("buffered write returned %d", ret);
>  	}
>  }
>  
> -static void alarm_handler(int signum)
> -{
> -}
> -
>  int main(int argc, char **argv)
>  {
>  	pid_t buffered_pid;
> @@ -118,7 +146,8 @@ int main(int argc, char **argv)
>  	int fd;
>  	int fd2;
>  	int status;
> -	struct sigaction sa;
> +	int dio_exit;
> +	int buffered_exit;
>  
>  	if (argc != 2)
>  		fail("only arg should be file name");
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
>  
> -		printf("ran for %d seconds without error, passing\n", SECONDS);
> -		exit(0);
> -	}
> +	buffered_exit = (pid == buffered_pid && WIFEXITED(status)) ?
> +			WEXITSTATUS(status) : 1;
>  
> -	if (pid == dio_pid) {
> -		kill(buffered_pid, SIGKILL);
> -		waitpid(buffered_pid, NULL, 0);
> -	} else {
> -		kill(dio_pid, SIGKILL);
> -		waitpid(dio_pid, NULL, 0);
> +	if (dio_exit || buffered_exit) {
> +		/*
> +		 * pass on the child's pass/fail return code or fail if the
> +		 * child didn't exit cleanly.
> +		 */
> +		exit(dio_exit || buffered_exit);
>  	}
>  
> -	/* 
> -	 * pass on the child's pass/fail return code or fail if the child 
> -	 * didn't exit cleanly.
> -	 */
> -	exit(WIFEXITED(status) ? WEXITSTATUS(status) : 1);
> +	printf("ran for %d seconds without error, passing\n", SECONDS);
> +	exit(0);
>  }
