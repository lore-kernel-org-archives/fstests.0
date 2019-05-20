Received: from userp2130.oracle.com ([156.151.31.86]:51752 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732280AbfETQ2y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 May 2019 12:28:54 -0400
Date: Mon, 20 May 2019 09:28:47 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] generic/530: fix shutdown failure of generic/530 in
 overlay
Message-ID: <20190520162847.GA5334@magnolia>
References: <1557727865-3745-1-git-send-email-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557727865-3745-1-git-send-email-jefflexu@linux.alibaba.com>
Sender: fstests-owner@vger.kernel.org
To: Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 13, 2019 at 02:11:05PM +0800, Jeffle Xu wrote:
> Testcases are recommended to use  _require_scratch_shutdown()
> and _scratch_shutdown() pair helper function to test and execute
> shutdown.
> 
> generic/530 formmerly used _require_scratch_shutdown() to test
> whether the filesystem supports shutdown or not, while executed
> the shutdown action in a raw binary (src/t_open_tmpfiles) rather
> than the recommended _scratch_shutdown() helper. This will cause
> a "shutdown: Inappropriate ioctl for device" error message when
> testing overlay filesystem.
> 
> This patch simply move the shutdown action from the raw binary
> into the packaged _scratch_shutdown() helper. That is, we remove
> the "shutdown" interface of t_open_tmpfiles.c and call
> _scratch_shutdown() in genric/530 and xfs/501.
> 
> thx
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  src/t_open_tmpfiles.c | 19 -------------------
>  tests/generic/530     |  4 +++-
>  tests/xfs/501         |  4 +++-
>  3 files changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/src/t_open_tmpfiles.c b/src/t_open_tmpfiles.c
> index da9390f..0393c6b 100644
> --- a/src/t_open_tmpfiles.c
> +++ b/src/t_open_tmpfiles.c
> @@ -24,7 +24,6 @@ static int min_fd = -1;
>  static int max_fd = -1;
>  static unsigned int nr_opened = 0;
>  static float start_time;
> -static int shutdown_fs = 0;
>  
>  void clock_time(float *time)
>  {
> @@ -69,22 +68,6 @@ void die(void)
>  				end_time - start_time);
>  		fflush(stdout);
>  
> -		if (shutdown_fs) {
> -			/*
> -			 * Flush the log so that we have to process the
> -			 * unlinked inodes the next time we mount.
> -			 */
> -			int flag = XFS_FSOP_GOING_FLAGS_LOGFLUSH;
> -			int ret;
> -
> -			ret = ioctl(min_fd, XFS_IOC_GOINGDOWN, &flag);
> -			if (ret) {
> -				perror("shutdown");
> -				exit(2);
> -			}
> -			exit(0);
> -		}
> -
>  		clock_time(&start_time);
>  		for (fd = min_fd; fd <= max_fd; fd++)
>  			close(fd);
> @@ -160,8 +143,6 @@ int main(int argc, char *argv[])
>  		if (ret)
>  			perror(argv[1]);
>  	}
> -	if (argc > 2 && !strcmp(argv[2], "shutdown"))
> -		shutdown_fs = 1;
>  
>  	clock_time(&start_time);
>  	while (1)
> diff --git a/tests/generic/530 b/tests/generic/530
> index b0d188b..56c6d32 100755
> --- a/tests/generic/530
> +++ b/tests/generic/530
> @@ -49,7 +49,9 @@ ulimit -n $max_files
>  
>  # Open a lot of unlinked files
>  echo create >> $seqres.full
> -$here/src/t_open_tmpfiles $SCRATCH_MNT shutdown >> $seqres.full
> +$here/src/t_open_tmpfiles $SCRATCH_MNT >> $seqres.full
> +_scratch_shutdown -f
> +
>  
>  # Unmount to prove that we can clean it all
>  echo umount >> $seqres.full
> diff --git a/tests/xfs/501 b/tests/xfs/501
> index 974f341..4be9997 100755
> --- a/tests/xfs/501
> +++ b/tests/xfs/501
> @@ -54,7 +54,9 @@ ulimit -n $max_files
>  
>  # Open a lot of unlinked files
>  echo create >> $seqres.full
> -$here/src/t_open_tmpfiles $SCRATCH_MNT shutdown >> $seqres.full
> +$here/src/t_open_tmpfiles $SCRATCH_MNT >> $seqres.full
> +_scratch_shutdown -f

NAK.

The whole point of both of these tests is to check the operation of
unlinked inode recovery after filesystem failure.  Moving the shutdown
call so that it happens after t_open_tmpfiles exits and releases all the
fds renders both tests completely broken and pointless.

The _require_scratch_shutdown behavior overlayfs (as I was hinting
before I left for vacation) is not particularly intuitive, and the next
step ought to have been "Ok, the helpers' behavior is intentional and
any program that wants to test shutdown has to use a file on the lower
fs; how do we pass the necessary control handle to t_open_tmpfiles", not
ripping out the offending code without figuring out what the test
actually does.

IOWS,

_scratch_shutdown_handle() {
	if [ $FSTYP = "overlayfs" ]; then
		echo "$OVL_BASE_SCRATCH_MNT"
	else
		echo "$SCRATCH_MNT"
	fi
}

$here/src/t_open_tmpfiles $SCRATCH_MNT shutdown $(_scratch_shutdown_handle)

Oh, it's already upstream, I'll send a revert later <grumble>...

--D

> +
>  
>  # Unmount to prove that we can clean it all
>  echo umount >> $seqres.full
> -- 
> 1.8.3.1
> 
