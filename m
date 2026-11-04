Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821716;
	b=AiHlRt59EPV+fxvxXWFgF7bbadPSxdURKxf7JBbMnEDxTiCiHc/mVWu34WO2GbOi4pMk
	 v2vm0iE0MeKsXeL6sOZOok/10gHoTHCE0qdLqbPWwEhLll3LaDGrIOeoxItxKNe7EaSGH
	 uJ2SwldMVdD//cNuEocgOcRLrcifp9Vty6rYn+GKDR/dMYYkrapwkA/uDS1VSgD67+eTC
	 rUMzmBLAGRGhazMRYK1x4A3wXVzagJmrbJopfuw+ai3LcwVltwUWV6xyZMHviLfa1kPrI
	 5W0WPikgYac0s44RzmSUUXd7ev3jARu+d3a6jfL3972pJtm8nRKLjT1n1vx5MpvSs2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821716;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=hEIB0cmVP2l6hm7F3bLDAUHAA1FOzXbZxdXaNn4cGy0=;
	b=dJ/ozTZ5VvJG3ykjohZ/ZUYGY1FW7MN7NYTvum52uWi8B09lwdtyVC96nXrBgzn+/2LG
	 EShbnsEpOSEhD2FTNFY1bKtVejRG+qYJfOyxcriEEzPfzxBOJMOrZDo6DV8ZzbuccEJFY
	 1X7mViE+0yR2uk2M1NnTyhlFRoVcV6+B+rZfG9eql+laazTNYafVOk4vJILjHrj4oOfan
	 azlTKkZnZLa7mKlBGRRb5vaLuW1QEuaK6w5LpMKmYMQ7VChwdXC8B7EjNEW8THwhzHFfR
	 Xs9k7uikQG3UwonvTOkOOzNBpRc9+GSNLd3+taLZR8YdNCmpbAse4UE2MMp1j5Fi/GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BT4hC+q9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CCB608F13F;
	Wed,  4 Nov 2026 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BT4hC+q9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A40A1F000C1;
	Wed,  4 Nov 2026 19:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821715;
	bh=hEIB0cmVP2l6hm7F3bLDAUHAA1FOzXbZxdXaNn4cGy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BT4hC+q9wBgWDKTP5v4y/mPVZqsiGn782o06mp28oBZBw4uTAvBeklYhj092R9yZB
	 cCB3EzL3KntS91tTs3Mhq+7oFvZCA+rFHIkceRfo1aBNkZc+cMS77/C57W2O0YaeIw
	 PjkmxFsa2u0IJIU9xti2wK0+gWMF9y8SKy8MCI4JRL+p5Tp32vYOHd5rhafF7Gk4SY
	 VCF3FEwkrC1bGurWx3zmz56PjBF10KdaApicB86EX9j3mxEZpvg4I7dnmMAx177e9J
	 UtcIYqG4UXR/5istaCVM46imA3lWgqVmG6soOe53zeD17Gsr/jW9lL7jhl3C3w/91p
	 dOd5qhh/5gWwg==
Date: Thu, 5 Nov 2026 03:48:30 +0800
From: Zorro Lang <zlang@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC fstests] generic: add a test for multigrain timestamps
Message-ID: <auuAoDQDrDhuBvE5@zlang-mailbox>
Mail-Followup-To: Jeff Layton <jlayton@kernel.org>, 
	fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20261027-mgtime-v1-1-ec68914a116e@kernel.org>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-mgtime-v1-1-ec68914a116e@kernel.org>

On Tue, Oct 27, 2026 at 09:58:50AM -0400, Jeff Layton wrote:
> Ensure that the mtime and ctime apparently change, even when there are
> multiple writes in quick succession. Since this is opt-in for in-kernel
> filesystems and there is no way to test for this feature in userland,
> limit it to just ext4, f2fs, btrfs, tmpfs and xfs for now.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> I'd like to start testing this to make sure it doesn't break, but it's
> not universally supported on all filesystems. Is an explicit allowlist
> like this the right approach?
> ---
>  src/Makefile          |   2 +-
>  src/mgtime.c          | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++

Add src/mgtime to .gitignore too.

>  tests/generic/999     |  35 ++++++++++++++++
>  tests/generic/999.out |   1 +
>  4 files changed, 145 insertions(+), 1 deletion(-)
> 
> diff --git a/src/Makefile b/src/Makefile
> index 0ff607ae1593..07bf749a1b8c 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -36,7 +36,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
>  	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
> -	rw_hint btrfs_ioctl
> +	rw_hint btrfs_ioctl mgtime
>  
>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> diff --git a/src/mgtime.c b/src/mgtime.c
> new file mode 100644
> index 000000000000..4ff7c206d31f
> --- /dev/null
> +++ b/src/mgtime.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Older Linux kernels always use coarse-grained timestamps, with a
> + * resolution of around 1 jiffy. Writes that are done in quick succession
> + * on those kernels apparent change to the ctime or mtime.
> + *
> + * Newer kernels attempt to ensure that fine-grained timestamps are used
> + * when the mtime or ctime are queried from userland.
> + *
> + * Open a file and do a 1 byte write to it and then statx the mtime and ctime.
> + * Do that in a loop 1000 times and ensure that the value is different from
> + * the last.
> + *
> + * Copyright (c) 2023: Jeff Layton <jlayton@kernel.org>
                    ^^^^
                    2026 ?

> + */
> +#define _GNU_SOURCE 1
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <stdint.h>
> +#include <getopt.h>
> +#include <stdbool.h>
> +
> +#define NUM_WRITES 1000
> +
> +static int64_t statx_ts_cmp(struct statx_timestamp *ts1, struct statx_timestamp *ts2)
> +{
> +	int64_t ret = ts2->tv_sec - ts1->tv_sec;
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = ts2->tv_nsec;
> +	ret -= ts1->tv_nsec;
> +
> +	return ret;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int ret, fd, i;
> +	struct statx stx = { };
> +	struct statx_timestamp ctime, mtime;
> +	bool verbose = false;
> +
> +	while ((i = getopt(argc, argv, "v")) != -1) {
> +		switch (i) {
> +		case 'v':
> +			verbose = true;
> +			break;
> +		}
> +	}
> +
> +	if (argc < 2) {
> +		errno = -EINVAL;
> +		perror("usage");
> +	}
> +
> +	fd = open(argv[1], O_WRONLY|O_CREAT|O_TRUNC, 0644);

If you use "-v" option, won't argv[1] be "-v"? Maybe you should check optind,
and use argv[optind].

> +	if (fd < 0) {
> +		perror("open");
> +		return 1;
> +	}
> +
> +	ret = statx(fd, "", AT_EMPTY_PATH, STATX_MTIME|STATX_CTIME, &stx);

statx() is a relatively new system call that might not be supported on older
systems. Perhaps you could refer to src/stat_test.c and use xfstests_statx() ?

> +	if (ret < 0) {
> +		perror("stat");
> +		return 1;
> +	}
> +
> +	ctime = stx.stx_ctime;
> +	mtime = stx.stx_mtime;
> +
> +	for (i = 0; i < NUM_WRITES; ++i) {
> +		ssize_t written;
> +
> +		written = write(fd, "a", 1);
> +		if (written < 0) {
> +			perror("write");
> +			return 1;
> +		}
> +
> +		ret = statx(fd, "", AT_EMPTY_PATH, STATX_MTIME|STATX_CTIME, &stx);
> +		if (ret < 0) {
> +			perror("stat");
> +			return 1;
> +		}
> +
> +		if (verbose)
> +			printf("%d: %llu.%u\n", i, stx.stx_ctime.tv_sec, stx.stx_ctime.tv_nsec);
> +
> +		if (!statx_ts_cmp(&ctime, &stx.stx_ctime)) {

It looks like this currently only checks whether the timestamp changed.
Changing the condition from checking non-zero to "<= 0" might can
also catch clock rollback bugs (even if that scenario seems unlikely:)

> +			printf("Duplicate ctime after write!\n");
> +			return 1;
> +		}
> +
> +		if (!statx_ts_cmp(&mtime, &stx.stx_mtime)) {
> +			printf("Duplicate mtime after write!\n");
> +			return 1;
> +		}
> +
> +		ctime = stx.stx_ctime;
> +		mtime = stx.stx_mtime;
> +	}
> +	return 0;
> +}
> diff --git a/tests/generic/999 b/tests/generic/999
> new file mode 100755
> index 000000000000..878247515e71
> --- /dev/null
> +++ b/tests/generic/999
> @@ -0,0 +1,35 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026, Jeff Layton <jlayton@kernel.org>
> +#
> +# FS QA Test No. 999
> +#
> +# Multigrain time test
> +#
> +# Open a file, and do 1 byte writes to it, and statx the file for
> +# the ctime and mtime after each write. Ensure that they have changed
> +# since the previous write.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick

I just checked doc/group-names.txt and noticed that it only lists the 'atime'
group. I think it would make sense to introduce a 'timestamp' group. There
are already quite a few tests covering atime, ctime, and mtime in xfstests,
but they all seem to be lumped under the 'atime' group for now.

Of course, if you'd rather not deal with introducing a new group in this patch,
sticking with the 'atime' group for now is totally fine.

> +
> +# Override the default cleanup function.

If you want to clean up "$TEST_DIR/test_mgtime_file.$$" in _cleanup, you
can define a local _cleanup function here. Otherwise, you can drop the
stale comment above.

> +_require_test_program mgtime

_require_test

> +
> +# Multigrain timestamps are opt-in per filesystem; only allowlist the ones
> +# known to support them.
> +case "$FSTYP" in
> +ext4|btrfs|tmpfs|xfs|f2fs)
> +	;;
> +*)
> +	_notrun "multigrain timestamps not supported on $FSTYP"
> +	;;
> +esac

We could wrap this logic into a _require_multigrain_timestamps() helper.
If there is a better way than probing FSTYP, we can always discuss
and update it later.

> +
> +testfile="$TEST_DIR/test_mgtime_file.$$"
> +

rm -f $testfile

> +$here/src/mgtime $testfile

echo "Silence is golden"

> +
> +# success, all done
> +status=0
> +exit

_exit 0

Thanks,
Zorro

> diff --git a/tests/generic/999.out b/tests/generic/999.out
> new file mode 100644
> index 000000000000..7fbc67688211
> --- /dev/null
> +++ b/tests/generic/999.out
> @@ -0,0 +1 @@
> +QA output created by 999
> 
> ---
> base-commit: 333c067ccf2f389f5558860336a7fa64157cd46e
> change-id: 20261027-mgtime-64194b4e22b4
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
