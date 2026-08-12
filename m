Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E712D2487
	for <fstests@vger.kernel.org>; Wed, 12 Aug 2026 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563583; cv=none; b=CkELsT8HrDkkOH+QjCng8dVs2Bo3Ro1ZljF37lqm0AKt5c5t6O4RF1sRDRbQ7toLT+jmzdoW/lkzH7sC+J089Izi0CQFxdViPgI7rix+oLwhvqHoYXRhjB9pn+aixd02h6rHcqZhHLgPxTkuUB5SvoDMHS8ZlLERAqUwjNpsD+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563583; c=relaxed/simple;
	bh=2XE/OhLGfHpXWPtSZzOdxmwiMxXu5HXiLuHGvTkzDUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJFVaPEHA5+1DtMYqis9PTpVZ3e2MVWgg4BJonY92ZcvrydKicDZyvafwbfJzJcHs6WtGiqHGTaTNhjV2ZZ4sZl1LBwNbAFZcrHza+EQlBoaD3ay8Umf2dA6hguxSojkwkj4wYXrxTsKCDEVn+kfYjBjvgrZmNjyIOMLt6zca/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZd7szxr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZd7szxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DD11F000E9;
	Wed, 12 Aug 2026 19:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786563581;
	bh=DPChTW/OYvdRmppbZAQLVJFErDpiEClDPN+6AQcN1ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LZd7szxrjXmphhjpQ/ng+NEhxRlfSMrtMozt+51qRpSFZywEZOUuECJRab7FNCnVE
	 T36+rzIxjziELD5Zo+mDcR0nuOdFotAp0QGAKlVYj3qw7ngSaYjZX5b9kpo2gzUXiC
	 DCF6RH/stl1ySSdNkLE5RAkJv6+2kw6iR5KEw437652Zc49klRU4ZCBNio0F8CpzSr
	 0wQICQXIpCR7BawZSiyeZgLyLFcnfwHXHrlbEOuAy98dzzY4veUeC61FXCaGTPbk4X
	 99z4OmflDrlD95hNtC4W9XXABgaqyyA7xXj45eL8Lna9IH7OQvMUHam2KSN6IX2Mq4
	 eC9cQQ4KKqsxQ==
Date: Thu, 13 Aug 2026 03:39:37 +0800
From: Zorro Lang <zlang@kernel.org>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] generic: test FIDEDUPERANGE result reporting
Message-ID: <any8FDY-v2TmIxcW@zlang-mailbox>
Mail-Followup-To: Matthias Goergens <matthias.goergens@gmail.com>, 
	fstests@vger.kernel.org
References: <20260805071839.3423779-1-matthias.goergens@gmail.com>
 <20260805071839.3423779-3-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805071839.3423779-3-matthias.goergens@gmail.com>

On Wed, Aug 05, 2026 at 03:18:39PM +0800, Matthias Goergens wrote:
> xfs_io retries shortened dedupe operations, so its output cannot verify one
> raw multi-destination ioctl or distinguish an explicit zero-length request
> from a nonzero request shortened to zero.
> 
> Add a small FIDEDUPERANGE helper that reports each destination's raw
> bytes_deduped and status fields.  Use it in generic/806 to check an explicit
> zero-length success, a request that is shortened for an interior destination
> but remains full-length at EOF, and a sub-block request that returns -EINVAL
> for the interior destination while succeeding at EOF.
> 
> Compute the request lengths from the filesystem block size so the expected
> semantics do not assume 4K blocks.  The paired kernel series is linked from
> the cover letter.
> 
> The test passes on btrfs and XFS with the paired kernel changes.
> 
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
>  src/Makefile          |   2 +-
>  src/fideduperange.c   | 138 ++++++++++++++++++++++++++++++++++++++++++

Need to update .gitignore file too.

>  tests/generic/806     |  83 +++++++++++++++++++++++++
>  tests/generic/806.out |   4 ++
>  4 files changed, 226 insertions(+), 1 deletion(-)
>  create mode 100644 src/fideduperange.c
>  create mode 100755 tests/generic/806
>  create mode 100644 tests/generic/806.out
> 
> diff --git a/src/Makefile b/src/Makefile
> index 76cf50c3..e686fe27 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -25,7 +25,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> -	locktest unwritten_mmap bulkstat_unlink_test deduperace \
> +	locktest unwritten_mmap bulkstat_unlink_test deduperace fideduperange \
>  	bulkstat_unlink_test_modified t_dir_offset t_futimens t_immutable \
>  	stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test \
>  	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
> diff --git a/src/fideduperange.c b/src/fideduperange.c
> new file mode 100644
> index 00000000..24813de8
> --- /dev/null
> +++ b/src/fideduperange.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Issue a raw FIDEDUPERANGE ioctl and report each destination's result.
> + */
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <inttypes.h>
> +#include <linux/fs.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <unistd.h>
> +
> +#ifndef FIDEDUPERANGE
> +/* These definitions must match the kernel UAPI. */
> +#define FILE_DEDUPE_RANGE_SAME		0
> +#define FILE_DEDUPE_RANGE_DIFFERS	1
> +
> +struct file_dedupe_range_info {
> +	__s64 dest_fd;
> +	__u64 dest_offset;
> +	__u64 bytes_deduped;
> +	__s32 status;
> +	__u32 reserved;
> +};
> +
> +struct file_dedupe_range {
> +	__u64 src_offset;
> +	__u64 src_length;
> +	__u16 dest_count;
> +	__u16 reserved1;
> +	__u32 reserved2;
> +	struct file_dedupe_range_info info[0];
> +};
> +
> +#define FIDEDUPERANGE _IOWR(0x94, 54, struct file_dedupe_range)
> +#endif
> +
> +static void
> +usage(const char *progname)
> +{
> +	fprintf(stderr,
> +		"Usage: %s src src_offset length dest dest_offset "
> +		"[dest dest_offset ...]\n",
> +		progname);
> +	exit(EXIT_FAILURE);
> +}
> +
> +static uint64_t
> +parse_u64(const char *arg, const char *name)
> +{
> +	char *end;
> +	unsigned long long value;
> +
> +	errno = 0;
> +	value = strtoull(arg, &end, 0);
> +	if (errno || end == arg || *end != '\0') {
> +		fprintf(stderr, "Invalid %s: %s\n", name, arg);
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	return value;
> +}
> +
> +int
> +main(int argc, char **argv)
> +{
> +	struct file_dedupe_range *range;
> +	size_t range_size;
> +	unsigned int dest_count;
> +	unsigned int i;
> +	int src_fd;
> +	int ret;
> +
> +	if (argc < 6 || (argc - 4) % 2 != 0)
> +		usage(argv[0]);
> +
> +	dest_count = (argc - 4) / 2;
> +	if (dest_count > UINT16_MAX) {
> +		fprintf(stderr, "Too many destinations: %u\n", dest_count);
> +		return EXIT_FAILURE;
> +	}
> +
> +	range_size = sizeof(*range) +
> +			dest_count * sizeof(struct file_dedupe_range_info);
> +	range = calloc(1, range_size);
> +	if (!range) {
> +		perror("calloc");
> +		return EXIT_FAILURE;
> +	}
> +
> +	src_fd = open(argv[1], O_RDONLY);
> +	if (src_fd < 0) {
> +		perror(argv[1]);
> +		free(range);
> +		return EXIT_FAILURE;
> +	}
> +
> +	range->src_offset = parse_u64(argv[2], "source offset");
> +	range->src_length = parse_u64(argv[3], "length");
> +	range->dest_count = dest_count;
> +
> +	for (i = 0; i < dest_count; i++) {
> +		const char *dest_path = argv[4 + i * 2];
> +
> +		range->info[i].dest_fd = open(dest_path, O_RDWR);
> +		if (range->info[i].dest_fd < 0) {
> +			perror(dest_path);
> +			ret = EXIT_FAILURE;
> +			goto close_destinations;
> +		}
> +		range->info[i].dest_offset =
> +			parse_u64(argv[5 + i * 2], "destination offset");
> +	}
> +
> +	if (ioctl(src_fd, FIDEDUPERANGE, range) < 0) {
> +		perror("FIDEDUPERANGE");
> +		ret = EXIT_FAILURE;
> +		goto close_destinations;
> +	}
> +
> +	for (i = 0; i < dest_count; i++)
> +		printf("destination %u: bytes=%" PRIu64 " status=%d\n", i,
> +		       (uint64_t)range->info[i].bytes_deduped,
> +		       range->info[i].status);
> +	ret = EXIT_SUCCESS;
> +
> +close_destinations:
> +	while (i > 0) {
> +		i--;
> +		close(range->info[i].dest_fd);
> +	}
> +	close(src_fd);
> +	free(range);
> +	return ret;
> +}
> diff --git a/tests/generic/806 b/tests/generic/806
> new file mode 100755
> index 00000000..98254b79
> --- /dev/null
> +++ b/tests/generic/806
> @@ -0,0 +1,83 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Matthias Goergens. All Rights Reserved.
> +#
> +# FS QA Test No. 806
> +#
> +# Check FIDEDUPERANGE result reporting for zero-length requests and for a
> +# multi-destination request where the VFS shortens only some destinations.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick dedupe clone
> +
> +. ./common/reflink
> +
> +_require_scratch_dedupe
> +_require_test_program "fideduperange"
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +block_size=$(_get_block_size "$SCRATCH_MNT")

Better to use "_get_file_block_size".

This new test looks good, but let's wait until kernel patches
get acked first.

> +short_length=$((2 * block_size))
> +full_length=$((short_length + 100))
> +
> +src=$SCRATCH_MNT/src
> +src_short=$SCRATCH_MNT/src-short
> +dest_interior=$SCRATCH_MNT/dest-interior
> +dest_eof=$SCRATCH_MNT/dest-eof
> +dest_short_eof=$SCRATCH_MNT/dest-short-eof
> +
> +$XFS_IO_PROG -f -c "pwrite -S 0x6b 0 $full_length" "$src" \
> +	>>$seqres.full 2>&1
> +$XFS_IO_PROG -f -c "pwrite -S 0x6b 0 100" "$src_short" \
> +	>>$seqres.full 2>&1
> +$XFS_IO_PROG -f -c "pwrite -S 0x6b 0 $((full_length + block_size))" \
> +	"$dest_interior" >>$seqres.full 2>&1
> +$XFS_IO_PROG -f -c "pwrite -S 0x6b 0 $full_length" "$dest_eof" \
> +	>>$seqres.full 2>&1
> +$XFS_IO_PROG -f -c "pwrite -S 0x6b 0 100" "$dest_short_eof" \
> +	>>$seqres.full 2>&1
> +
> +check_results()
> +{
> +	local description="$1"
> +	local expected="$2"
> +	shift 2
> +	local result
> +	local ret
> +
> +	result=$($here/src/fideduperange "$@" 2>&1)
> +	ret=$?
> +	{
> +		echo "$description"
> +		echo "$result"
> +	} >>$seqres.full
> +
> +	if [ $ret -ne 0 ]; then
> +		_fail "$description: ioctl helper failed"
> +	fi
> +	if [ "$result" != "$expected" ]; then
> +		_fail "$description: unexpected ioctl result"
> +	fi
> +
> +	echo "$description"
> +}
> +
> +expected="destination 0: bytes=0 status=0"
> +check_results "zero length: 0 bytes, SAME" "$expected" \
> +	"$src" 0 0 "$dest_interior" 0
> +
> +expected="destination 0: bytes=$short_length status=0
> +destination 1: bytes=$full_length status=0"
> +check_results "mixed partial request: shortened, full" "$expected" \
> +	"$src" 0 "$full_length" "$dest_interior" 0 "$dest_eof" 0
> +
> +expected="destination 0: bytes=0 status=-22
> +destination 1: bytes=100 status=0"
> +check_results "mixed sub-block request: EINVAL, full" "$expected" \
> +	"$src_short" 0 100 "$dest_interior" 0 "$dest_short_eof" 0
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/806.out b/tests/generic/806.out
> new file mode 100644
> index 00000000..d7226e34
> --- /dev/null
> +++ b/tests/generic/806.out
> @@ -0,0 +1,4 @@
> +QA output created by 806
> +zero length: 0 bytes, SAME
> +mixed partial request: shortened, full
> +mixed sub-block request: EINVAL, full
> -- 
> 2.55.0
> 
