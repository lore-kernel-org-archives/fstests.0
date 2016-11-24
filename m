Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:11445 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750830AbcKXXUD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Nov 2016 18:20:03 -0500
Date: Fri, 25 Nov 2016 10:15:58 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/390: Add tests for inode timestamp policy
Message-ID: <20161124231558.GV31101@dastard>
References: <1479948722-2936-1-git-send-email-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1479948722-2936-1-git-send-email-deepa.kernel@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: fstests@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
List-ID: <fstests@vger.kernel.org>

On Wed, Nov 23, 2016 at 04:52:02PM -0800, Deepa Dinamani wrote:
> The test helps to validate clamping and mount behaviors
> according to supported file system timestamp ranges.
> 
> Note that the test can fail on 32-bit systems for a
> few file systems. This will be corrected when vfs is
> transitioned to use 64-bit timestamps.

Thanks for doing this, Deepa. A few comments below - Eryu has
already given lots of feedback, so I won't repeat all that...

> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
>  common/attr           |  27 ++++++
>  src/Makefile          |   2 +-
>  src/y2038_futimens.c  |  61 +++++++++++++
>  tests/generic/390     | 238 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/390.out |   2 +
>  tests/generic/group   |   1 +
>  6 files changed, 330 insertions(+), 1 deletion(-)
>  create mode 100644 src/y2038_futimens.c
>  create mode 100755 tests/generic/390
>  create mode 100644 tests/generic/390.out
> 
> diff --git a/common/attr b/common/attr
> index ce2d76a..579dc9b 100644
> --- a/common/attr
> +++ b/common/attr
> @@ -56,6 +56,33 @@ _acl_get_max()
>  	esac
>  }
>  
> +_filesystem_timestamp_range()
> +{
> +	device=${1:-$TEST_DEV}
> +	case $FSTYP in
> +	ext4)	#dumpe2fs
> +		if [ $(dumpe2fs -h $device 2>/dev/null | grep "Inode size:" | cut -d: -f2) -gt 128 ]; then
> +			echo "-2147483648 15032385535"
> +		else
> +			echo "-2147483648 2147483647"
> +		fi
> +		;;
> +
> +	xfs)
> +		echo "-2147483648 2147483647"
> +		;;
> +	jfs)
> +		echo "0 4294967295"
> +		;;
> +	f2fs)
> +		echo "-2147483648 2147483647"
> +		;;
> +	*)
> +		echo "-1 -1"
> +		;;
> +	esac
> +}

This is better off in common/rc right now - common/attr is for
extended attribute test code, not generic filesystem stuff.

> diff --git a/src/y2038_futimens.c b/src/y2038_futimens.c
> new file mode 100644
> index 0000000..291e4fa
> --- /dev/null
> +++ b/src/y2038_futimens.c
> @@ -0,0 +1,61 @@
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <sys/stat.h>
> +#include <errno.h>
> +#include <stdlib.h>
> +
> +int
> +do_utime(int fd, long long time)
> +{
> +	struct timespec t[2];
> +
> +	/*
> +	 * Convert long long to timespec format.
> +	 * Seconds precision is assumed here.
> +	 */
> +	t[0].tv_sec = time;
> +	t[0].tv_nsec = 0;
> +	t[1].tv_sec = time;
> +	t[1].tv_nsec = 0;
> +
> +	/* Call utimens to update time. */
> +	if (futimens(fd, t)) {
> +		perror("futimens");
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +int
> +main(int argc, char **argv)
> +{
> +	int fd;
> +	long long time;
> +
> +	if(argc < 3) {
> +			fprintf(stderr, "Usage: %s filename timestamp\n"
> +					"Filename: file to be created or opened in current directory\n"
> +					"Timestamp: is seconds since 1970-01-01 00:00:00 UTC\n", argv[0]);
> +			exit(1);
> +	}
> +
> +	/* Create the file */
> +	fd = creat(argv[1], 0666);
> +	if(fd < 0) {
> +		perror("creat");
> +		exit(1);
> +	}
> +
> +	/* Get the timestamp */
> +	time = strtoull(argv[2], NULL, 0);
> +	if (errno) {
> +		perror("strtoull");
> +		exit(1);
> +	}
> +
> +	if (do_utime(fd, time))
> +		return 1;
> +
> +	return 0;
> +}

This might be useful to add to xfs_io rather than a one-off helper
for xfstest - that avoids the need to create files, and it can be
used to change times on existing files....

....

> +_run_test_individual() #_run_individual_test(file, timestamp, update_time)
> +{
> +    file=$1
> +    timestamp=$2
> +    update_time=$3

No need for comments after the function declaration - the prototype
is obvious from the local variable assignments....

...

> +#Remove log from last run
> +rm -f $seqres.full
> +
> +#install cleaner
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_scratch_mkfs &>> $seqres.full 2>&1 || _fail "mkfs failed"
> +read tsmin tsmax <<<$(_filesystem_timestamp_range $SCRATCH_DEV)

This is all test setup preamble, so should be at the top.

> +if [ $tsmin -eq -1 -a $tsmax -eq -1 ]; then
> +    _notrun "filesystem $FSTYP timestamp bounds are unknown"
> +fi

This should be in a _requires_timestamp_range() function, I think.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
