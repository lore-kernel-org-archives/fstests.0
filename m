Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:48531 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755233AbbAHSo7 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 8 Jan 2015 13:44:59 -0500
Message-ID: <54AED028.10101@sandeen.net>
Date: Thu, 08 Jan 2015 12:44:56 -0600
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] src/godown: support f2fs triggering specific ioctl
References: <1420741879-73691-1-git-send-email-jaegeuk@kernel.org>
In-Reply-To: <1420741879-73691-1-git-send-email-jaegeuk@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

On 1/8/15 12:31 PM, Jaegeuk Kim wrote:
> This patch triggers the F2FS-related ioctl for godown.

hohum, wouldn't it be a whole lot easier to just re-use the XFS ioctl
number in f2fs?  Then you wouldn't have to duplicate all this code.

If you really want your own unique ioctl number, what about
just doing statfs on the target, and if f_type returns F2FS_SUPER_MAGIC,
swictch the ioctl nr to F2FS_IOC_GOINGDOWN.

Then if not F2FS_SUPER_MAGIC, leave the ioctl nr at XFS_IOC_GOINGDOWN, and
if it fails, it fails (other filesystems might support the original nr.)

And then you can probably just add "f2fs" to the existing testcase,
and move it to tests/shared?

-Eric

> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  src/godown.c | 88 ++++++++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 65 insertions(+), 23 deletions(-)
> 
> diff --git a/src/godown.c b/src/godown.c
> index b140a41..b44790b 100644
> --- a/src/godown.c
> +++ b/src/godown.c
> @@ -19,33 +19,82 @@
>  #include <syslog.h>
>  #include "global.h"
>  
> +#define F2FS_IOCTL_MAGIC	0xf5
> +#define F2FS_IOC_GOINGDOWN	_IO(F2FS_IOCTL_MAGIC, 6)
> +
> +enum ftypes {
> +	XFS_FS,
> +	F2FS_FS,
> +};
> +
>  static char *xprogname;
> +static char *mnt_dir;
> +static int verbose_opt = 0;
> +static int flushlog_opt = 0;
>  
> +static enum ftypes fs = XFS_FS;
>  
>  static void
>  usage(void)
>  {
> -	fprintf(stderr, "usage: %s [-f] [-v] mnt-dir\n", xprogname);
> +	fprintf(stderr, "usage: %s [-f] [-v] [-s 0/1] mnt-dir\n", xprogname);
> +}
> +
> +static int
> +xfs_goingdown(int fd)
> +{
> +	int flag;
> +
> +	flag = (flushlog_opt ? XFS_FSOP_GOING_FLAGS_LOGFLUSH
> +			    : XFS_FSOP_GOING_FLAGS_NOLOGFLUSH);
> +	if (verbose_opt) {
> +		printf("Calling XFS_IOC_GOINGDOWN\n");
> +	}
> +
> +	syslog(LOG_WARNING, "xfstests-induced forced shutdown of %s:\n",
> +			mnt_dir);
> +	if ((xfsctl(mnt_dir, fd, XFS_IOC_GOINGDOWN, &flag)) == -1) {
> +		fprintf(stderr, "%s: error on xfsctl(GOINGDOWN) of \"%s\": %s\n",
> +				xprogname, mnt_dir, strerror(errno));
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +static int
> +f2fs_goingdown(int fd)
> +{
> +	if (verbose_opt) {
> +		printf("Calling F2FS_IOC_GOINGDOWN\n");
> +	}
> +	syslog(LOG_WARNING, "xfstests-induced forced shutdown of %s:\n",
> +			mnt_dir);
> +	if ((ioctl(fd, F2FS_IOC_GOINGDOWN)) == -1) {
> +		fprintf(stderr, "%s: error on ioctl(GOINGDOWN) of \"%s\": %s\n",
> +				xprogname, mnt_dir, strerror(errno));
> +		return 1;
> +	}
> +	return 0;
> +
>  }
>  
>  int
>  main(int argc, char *argv[])
>  {
> -	int c;
> -	int flag;
> -	int flushlog_opt = 0;
> -	int verbose_opt = 0;
> +	int c, fd;
>  	struct stat st;
> -	char *mnt_dir;
> -	int fd;
> +	int ret = 0;
>  
>        	xprogname = argv[0];
>  
> -	while ((c = getopt(argc, argv, "fv")) != -1) {
> +	while ((c = getopt(argc, argv, "fs:v")) != -1) {
>  		switch (c) {
>  		case 'f':
>  			flushlog_opt = 1;
>  			break;
> +		case 's':
> +			fs = atoi(optarg);
> +			break;
>  		case 'v':
>  			verbose_opt = 1;
>  			break;
> @@ -94,10 +143,6 @@ main(int argc, char *argv[])
>  	}
>  #endif
>  
> -
> -	flag = (flushlog_opt ? XFS_FSOP_GOING_FLAGS_LOGFLUSH 
> -			    : XFS_FSOP_GOING_FLAGS_NOLOGFLUSH);
> -
>  	if (verbose_opt) {
>  		printf("Opening \"%s\"\n", mnt_dir);
>  	}
> @@ -107,18 +152,15 @@ main(int argc, char *argv[])
>  		return 1;
>  	}
>  
> -	if (verbose_opt) {
> -		printf("Calling XFS_IOC_GOINGDOWN\n");
> +	switch (fs) {
> +	case XFS_FS:
> +		ret = xfs_goingdown(fd);
> +		break;
> +	case F2FS_FS:
> +		ret = f2fs_goingdown(fd);
> +		break;
>  	}
> -	syslog(LOG_WARNING, "xfstests-induced forced shutdown of %s:\n",
> -		mnt_dir);
> -	if ((xfsctl(mnt_dir, fd, XFS_IOC_GOINGDOWN, &flag)) == -1) {
> -		fprintf(stderr, "%s: error on xfsctl(GOINGDOWN) of \"%s\": %s\n",
> -			xprogname, mnt_dir, strerror(errno));
> -		return 1;
> -	}
> -
>  	close(fd);
>  
> -	return 0;
> +	return ret;
>  }
> 

