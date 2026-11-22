Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795364894;
	b=ZfTQvOo0BdcCH8U2Joz4oHjN9Hu7/N5538krCK/B0iDmKuptSYWyePF6f0LoNvohhvlu
	 AmWch+bopq28oDK192FAk/o44qeb/4j333M97CNRXXPg3h3cKb+NEgrIzxqrCO4FPhUFl
	 w2bruIrTxGEu455NVToqU0gD3ifHfmObJQI9x1YVhHjQfxvgeURelBmn79PhgIcUUDUMb
	 WhIdPd5JnYU8HjarMnYS7oU+V72gFOtUdRKUeCUAxJVgqdUyGeds0sFlB2WFW9XdZwGG6
	 2nGECZ8O0uwtkf3Dpy7XP8LHTumoW2CpV78hWOoTAn3Vw0MZtqcsSPco5vpzm+OhTPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795364894;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=iliHa2JYx8K6gmU8uBB+hP4z50snkbYVmYuatp7ZD3M=;
	b=G7MYWZ6xz9QG/+mVJaFoh37ZL8GkvoYY4rDNe5GlcuOs8wjc4Yz7E8jr6rJ+ejju4+6b
	 GJfwj7ifUTdUFWxZQtXbFgjhl4Vw5ae+eKNESdtZ/urw/s/4DUypQlNAUDdbzaf3m+iM3
	 AFYJkwameoDLuw3Ac884oXywhuscaD1GLNIN3SB8uCDqCpSHfam1uh+Q4H4X57MnS1Dcj
	 wczDeyv4KsAMO1zXTDSl7oj/014gvFruWcPbts+53a9C4m5XMz4e9dh0TcqJeyPcJcUOn
	 gImWdhEP+IAnpJ8mt0VKDJtmVMxbT5YUiHFP0a3gUEKF/t2YG1OBz7hcQfmn0mtA7PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f12MIUMt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD24606A320;
	Sun, 22 Nov 2026 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f12MIUMt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5181F000D2;
	Sun, 22 Nov 2026 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795364893;
	bh=iliHa2JYx8K6gmU8uBB+hP4z50snkbYVmYuatp7ZD3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f12MIUMtFt78eE6xd0aG0ZBpom6YJe7xS0KBePw5qkBsuA5yAgYi+MsPXS1jEZpbm
	 cetjsUR4VHgffloXkbwhgW4yp9Ctx988z+GBvvuJo+ELgvuy+gEcI5PkDUG9F8JrWy
	 /rWTO1gBFyYVzXpjFzDQMO2U/dUg0gAmODkQ/UvE8j+Jzyy5a7XBsdyYXVafuEcPAM
	 SkZvgRf0R6maHgmwDRQGp+wTaLRWMmEmkgtZp/nQKQo2hT+kT19teHAekWvYuuc0Tl
	 Z6X5hsJrZZVzTuAh0ZOLm3AELaQ0IuvmifVsPuLnuu9aqggW5pRVOU9lEMIe5tjfg5
	 gbBS/WQ4c9gBg==
Date: Mon, 23 Nov 2026 00:28:04 +0800
From: Zorro Lang <zlang@kernel.org>
To: Shaopei Zhu <shaopei_1012@163.com>
Cc: fstests@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>, 
	exfat@lists.linux.dev
Subject: Re: [PATCH] exfat: test EXFAT_IOC_COMBINE
Message-ID: <awMH-NYHb-k_3N9v@zlang-mailbox>
Mail-Followup-To: Shaopei Zhu <shaopei_1012@163.com>, 
	fstests@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>, exfat@lists.linux.dev
References: <20261122125634.624942-1-shaopei_1012@163.com>
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
In-Reply-To: <20261122125634.624942-1-shaopei_1012@163.com>

On Sun, Nov 22, 2026 at 08:56:34PM +0800, Shaopei Zhu wrote:
> Add a test for EXFAT_IOC_COMBINE, which appends the clusters of one
> file to another without copying data, zero-filling the destination up
> to the next cluster boundary first, and then unlinks the source.
> 
> The test covers an aligned and an unaligned destination, empty
> destination and source, a fragmented source appended to a contiguous
> destination, a destination extended by truncate and by fallocate, a
> source unlinked before the call, and invalid requests, and checks that
> the source is unlinked.  The contents are compared with the expected
> result before and after a remount.
> 
> It is skipped on kernels without the ioctl.
> 
> This was written with the help of an AI coding assistant (Claude Code,
> Opus 5.5) and reviewed and tested by me.
> 
> Signed-off-by: Shaopei Zhu <shaopei_1012@163.com>
> ---
> 
> Notes:
>     The ioctl is added by this kernel patch, under review:
>     https://lore.kernel.org/all/20261122124029.609636-1-shaopei_1012@163.com/

Hi,

Thanks for this new feature test case.

For a new feature, we usually wait until it has enough review and is confirmed
to be accepted by the subsystem before merging its test cases. Just in case
the patch gets nacked or its behavior changes during review. Please ping this
thread once it's ready :)

A few of initial review points below ...

>     
>     The test is skipped on kernels without it.  Based on for-next.
>
>  .gitignore          |   1 +
>  src/Makefile        |   2 +-
>  src/exfat_combine.c |  91 +++++++++++++++++++++++++
>  tests/exfat/002     | 158 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/exfat/002.out |  15 +++++
>  5 files changed, 266 insertions(+), 1 deletion(-)
>  create mode 100644 src/exfat_combine.c
>  create mode 100755 tests/exfat/002
>  create mode 100644 tests/exfat/002.out
> 
> diff --git a/.gitignore b/.gitignore
> index cdcfa06..0876aee 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -82,6 +82,7 @@ tags
>  /src/dirperf
>  /src/dirstress
>  /src/e4compact
> +/src/exfat_combine
>  /src/ext4_resize
>  /src/fake-dump-rootino
>  /src/fault
> diff --git a/src/Makefile b/src/Makefile
> index a1fc38d..b42d7d7 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -38,7 +38,7 @@ LINUX_TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
>  	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
>  	rw_hint btrfs_ioctl refluxfs xfs-exchange-to-eof \
> -	xfs-exchange-to-dirty-eof xfs-swapext-reflink
> +	xfs-exchange-to-dirty-eof xfs-swapext-reflink exfat_combine
>  
>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> diff --git a/src/exfat_combine.c b/src/exfat_combine.c
> new file mode 100644
> index 0000000..2b0b795
> --- /dev/null
> +++ b/src/exfat_combine.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2026 Shaopei Zhu.  All Rights Reserved.
> + *
> + * Call EXFAT_IOC_COMBINE to append the clusters of src to dst.
> + *
> + * Exits with 0 on success, 2 if the ioctl is not supported and 1 on any
> + * other error.
> + */
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/ioctl.h>
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#ifndef EXFAT_IOC_COMBINE
> +struct exfat_combine_args {
> +	__s32 src_fd;
> +	__u32 flags;
> +};
> +#define EXFAT_IOC_COMBINE	_IOW('r', 0x20, struct exfat_combine_args)
> +#endif
> +
> +static void usage(const char *prog)
> +{
> +	fprintf(stderr,
> +		"usage: %s [-f flags] [-r|-w] [-U] dst src\n"
> +		"  -f flags  value of exfat_combine_args.flags\n"
> +		"  -r        open src read-only\n"
> +		"  -w        open src write-only\n"
> +		"  -U        unlink src before combining (use the open fd)\n",
> +		prog);
> +	exit(1);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct exfat_combine_args args = { 0 };
> +	int src_mode = O_RDWR, unlink_first = 0;
> +	int c, dst, src;
> +
> +	while ((c = getopt(argc, argv, "f:rwU")) != -1) {
> +		switch (c) {
> +		case 'f':
> +			args.flags = strtoul(optarg, NULL, 0);
> +			break;
> +		case 'r':
> +			src_mode = O_RDONLY;
> +			break;
> +		case 'w':
> +			src_mode = O_WRONLY;
> +			break;
> +		case 'U':
> +			unlink_first = 1;
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
> +	}
> +	if (argc - optind != 2)
> +		usage(argv[0]);
> +
> +	dst = open(argv[optind], O_RDWR);
> +	if (dst < 0) {
> +		perror(argv[optind]);
> +		return 1;
> +	}
> +	src = open(argv[optind + 1], src_mode);
> +	if (src < 0) {
> +		perror(argv[optind + 1]);
> +		return 1;
> +	}
> +	if (unlink_first && unlink(argv[optind + 1])) {
> +		perror("unlink");
> +		return 1;
> +	}
> +
> +	args.src_fd = src;
> +	if (ioctl(dst, EXFAT_IOC_COMBINE, &args)) {
> +		fprintf(stderr, "EXFAT_IOC_COMBINE: %s\n", strerror(errno));
> +		return errno == ENOTTY ? 2 : 1;
> +	}

Your patch mentions that "Open file descriptors of the source refer to an empty
file afterwards." Given that, shouldn't we also verify here that fstat(src)
reports st_size == 0, and that pread(src) returns 0 to ensure the page cache
has been invalidated?

> +
> +	close(src);
> +	close(dst);
> +	return 0;
> +}
> diff --git a/tests/exfat/002 b/tests/exfat/002
> new file mode 100755
> index 0000000..c2c0d26
> --- /dev/null
> +++ b/tests/exfat/002
> @@ -0,0 +1,158 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Shaopei Zhu.  All Rights Reserved.
> +#
> +# FS QA Test No. exfat/002
                    ^^^^^^^^^
                    002

> +#
> +# Test EXFAT_IOC_COMBINE, which appends the clusters of one file to
> +# another without copying any data and then unlinks the source.  A
> +# destination that is not cluster aligned is zero-filled up to the next
> +# cluster boundary first, so the appended data always starts at a cluster
> +# boundary.  Check the result before and after a remount, covering
> +# contiguous and fragmented files, a destination extended by truncate and
> +# fallocate, an already unlinked source, and the error cases, in which the
> +# source must be left alone.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw
                               ^^^^^
                               ioctl

> +
> +. ./common/filter

Feel free to remove this if it's unused.

> +
> +_require_scratch
> +_require_test_program "exfat_combine"
> +_require_xfs_io_command "falloc"
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +combine=$here/src/exfat_combine
> +mnt=$SCRATCH_MNT
> +
> +touch $mnt/probe_dst $mnt/probe_src
> +$combine $mnt/probe_dst $mnt/probe_src >> $seqres.full 2>&1
> +[ $? -eq 2 ] && _notrun "kernel does not support EXFAT_IOC_COMBINE"

You're currently ignoring other errors and keep running, shouldn't
we _fail directly?

Thanks,
Zorro

> +rm -f $mnt/probe_dst $mnt/probe_src
> +
> +# st_blksize is the cluster size on exFAT
> +clu=$(stat -c %o $mnt)
> +echo "cluster size $clu" >> $seqres.full
> +
> +# write <file> <pattern> <offset> <length>, to a scratch file and to the
> +# file holding its expected contents
> +write()
> +{
> +	$XFS_IO_PROG -f -c "pwrite -S $2 $3 $4" $mnt/$1 >> $seqres.full
> +	$XFS_IO_PROG -f -c "pwrite -S $2 $3 $4" $tmp.$1 >> $seqres.full
> +}
> +
> +# what the kernel does to <dst>: zero-fill to a cluster boundary and
> +# append the contents of <src>, which is then unlinked
> +expect_combine()
> +{
> +	local size=$(stat -c %s $tmp.$1)
> +	local src_size=$(stat -c %s $tmp.$2)
> +
> +	[ $src_size -eq 0 ] && { rm -f $tmp.$2; return; }
> +	size=$(( (size + clu - 1) / clu * clu ))
> +	$XFS_IO_PROG -c "truncate $size" $tmp.$1
> +	cat $tmp.$2 >> $tmp.$1
> +}
> +
> +do_combine()
> +{
> +	$combine "$@" $mnt/$dst $mnt/$src || echo "combine $dst $src failed"
> +	[ -e $mnt/$src ] && echo "$src still exists"
> +	expect_combine $dst $src
> +	rm -f $tmp.$src
> +}
> +
> +check()
> +{
> +	local f
> +
> +	for f in "$@"; do
> +		cmp $mnt/$f $tmp.$f || echo "$f: wrong contents"
> +	done
> +}
> +
> +echo "aligned destination, source still in the page cache"
> +dst=a src=b
> +write $dst 0x61 0 $((4 * clu))
> +$XFS_IO_PROG -c fsync $mnt/$dst
> +write $src 0x62 0 $((3 * clu + 123))
> +do_combine
> +
> +echo "unaligned destination"
> +dst=c src=d
> +write $dst 0x63 0 $((clu + 1))
> +write $src 0x64 0 $clu
> +do_combine
> +
> +echo "empty destination"
> +dst=e src=f
> +touch $mnt/$dst $tmp.$dst
> +write $src 0x65 0 $clu
> +do_combine
> +
> +echo "empty source does not pad the destination"
> +dst=g src=h
> +write $dst 0x66 0 100
> +touch $mnt/$src $tmp.$src
> +do_combine
> +
> +echo "fragmented source, contiguous destination"
> +dst=i src=j
> +write $dst 0x67 0 $((2 * clu))
> +$XFS_IO_PROG -c fsync $mnt/$dst
> +for n in 0 1 2; do
> +	write $src 0x68 $((n * clu)) $clu
> +	$XFS_IO_PROG -c fsync $mnt/$src
> +	write spacer 0x78 $((n * clu)) $clu
> +	$XFS_IO_PROG -c fsync $mnt/spacer
> +done
> +write $src 0x68 $((3 * clu)) 100
> +do_combine
> +
> +echo "destination extended by truncate"
> +dst=k src=l
> +write $dst 0x69 0 1000
> +$XFS_IO_PROG -c fsync -c "truncate $((3 * clu + 10))" $mnt/$dst
> +$XFS_IO_PROG -c "truncate $((3 * clu + 10))" $tmp.$dst
> +write $src 0x6a 0 $clu
> +do_combine
> +
> +echo "destination extended by fallocate"
> +dst=m src=n
> +write $dst 0x6b 0 10
> +$XFS_IO_PROG -c "falloc 0 $((2 * clu + 5))" $mnt/$dst
> +$XFS_IO_PROG -c "truncate $((2 * clu + 5))" $tmp.$dst
> +write $src 0x6c 0 $((clu + 7))
> +do_combine
> +
> +echo "source unlinked before combining"
> +dst=o src=p
> +write $dst 0x6d 0 $((3 * clu))
> +write $src 0x6e 0 $((2 * clu + 77))
> +do_combine -U
> +
> +echo "invalid requests"
> +dst=q src=r
> +write $dst 0x6f 0 $clu
> +write $src 0x70 0 $clu
> +$combine $mnt/$dst $mnt/$dst 2>&1
> +$combine -f 1 $mnt/$dst $mnt/$src 2>&1
> +$combine -r $mnt/$dst $mnt/$src 2>&1
> +$combine -w $mnt/$dst $mnt/$src 2>&1
> +
> +check a c e g i k m o q r
> +
> +echo "after remount"
> +_scratch_cycle_mount
> +check a c e g i k m o q r
> +for f in b d f h j l n p; do
> +	[ -e $mnt/$f ] && echo "$f exists after remount"
> +done
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/exfat/002.out b/tests/exfat/002.out
> new file mode 100644
> index 0000000..f061ae8
> --- /dev/null
> +++ b/tests/exfat/002.out
> @@ -0,0 +1,15 @@
> +QA output created by 002
> +aligned destination, source still in the page cache
> +unaligned destination
> +empty destination
> +empty source does not pad the destination
> +fragmented source, contiguous destination
> +destination extended by truncate
> +destination extended by fallocate
> +source unlinked before combining
> +invalid requests
> +EXFAT_IOC_COMBINE: Invalid argument
> +EXFAT_IOC_COMBINE: Invalid argument
> +EXFAT_IOC_COMBINE: Bad file descriptor
> +EXFAT_IOC_COMBINE: Bad file descriptor
> +after remount
> -- 
> 2.53.0
> 
