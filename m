Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE10C433ED
	for <linux-fstests@archiver.kernel.org>; Thu, 20 May 2021 16:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 824EC6101E
	for <linux-fstests@archiver.kernel.org>; Thu, 20 May 2021 16:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhETQdV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 May 2021 12:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231655AbhETQdV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 20 May 2021 12:33:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9853660FD9;
        Thu, 20 May 2021 16:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621528319;
        bh=1BfX4jy9r4eSs20Qef7bZLw5d6frCG2xaiQo34SeI7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QpbPc5t2tvceiS4W9vPGDQLz1tIXCw2R+Qis8Q34w1TQLHGWB8cbBbMh6Akjc3Y1l
         xfi/18f86wPDuJjQN+WPt3olRdiNyrxUzlFUD5Uqd/cQG9Pj6WLwakWuO+WP90K0vd
         kmK21VIDQyBfq02YR8QZ/d82clKBSVHTRM6kWA4wHz2M0vCMtBPBIql4TpwA++eLC7
         JzNLL96GZm6oMVszELNYQjueKhex1iHlVysXMdnJJicdXF/H7WBXQOVcuWvRsk1jl6
         a4rl/ecQaLi/b+KvLq3ZU2XlODtwJZMQuNFnQR3KMg4pR84sHiJKM6eouqtbhGKSRv
         vr8dPAEyozV2Q==
Date:   Thu, 20 May 2021 09:31:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v4] generic/637: Test page faults during read and write
Message-ID: <20210520163159.GF9648@magnolia>
References: <20210520114218.1595735-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520114218.1595735-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 20, 2021 at 01:42:18PM +0200, Andreas Gruenbacher wrote:
> Some filesystems have problems when the buffer passed to read or write is
> memory-mapped to the file being read from or written to and the buffer is
> faulted in during the read or write.  (That's probably not a recommended
> use case, but it should work nevertheless.)
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  src/Makefile          |   3 +-
>  src/mmap-rw-fault.c   | 164 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/637     |  40 +++++++++++
>  tests/generic/637.out |   2 +
>  tests/generic/group   |   1 +
>  5 files changed, 209 insertions(+), 1 deletion(-)
>  create mode 100644 src/mmap-rw-fault.c
>  create mode 100755 tests/generic/637
>  create mode 100644 tests/generic/637.out
> 
> diff --git a/src/Makefile b/src/Makefile
> index cc0b9579..13cdf19b 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -17,7 +17,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
>  	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
>  	t_ofd_locks t_mmap_collision mmap-write-concurrent \
> -	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc
> +	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> +	mmap-rw-fault
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/mmap-rw-fault.c b/src/mmap-rw-fault.c
> new file mode 100644
> index 00000000..b9c58af6
> --- /dev/null
> +++ b/src/mmap-rw-fault.c
> @@ -0,0 +1,164 @@
> +/* Trigger mmap page faults in the same file during pread and pwrite. */

Missing SPDX header.

(Let's not make the implicit license mess in src/ worse, please.)

> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE /* to get definition of O_DIRECT flag. */
> +#endif
> +
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/mman.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <err.h>
> +
> +char *filename;
> +unsigned int page_size;
> +void *page;
> +char *addr;
> +int fd;
> +ssize_t ret;
> +
> +/*
> + * Leave a hole at the beginning of the test file and initialize a block of
> + * @page_size bytes at offset @page_size to @c.  Then, reopen the file and
> + * mmap the first two pages.
> + */
> +void init(char c, int flags)
> +{
> +	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY | O_DIRECT, 0666);
> +	if (fd == -1)
> +		goto fail;
> +	memset(page, c, page_size);
> +	ret = pwrite(fd, page, page_size, page_size);
> +	if (ret != page_size)
> +		goto fail;
> +	if (close(fd))
> +		goto fail;
> +
> +	fd = open(filename, flags);
> +	if (fd == -1)
> +		goto fail;
> +	addr = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> +	if (addr == MAP_FAILED)
> +		err(1, NULL);
> +	return;
> +
> +fail:
> +	err(1, "%s", filename);
> +}
> +
> +void done(void)
> +{
> +	if (fsync(fd))
> +		goto fail;
> +	if (close(fd))
> +		goto fail;
> +	return;
> +
> +fail:
> +	err(1, "%s", filename);
> +}
> +
> +static ssize_t do_read(int fd, void *buf, size_t count, off_t offset)
> +{
> +	ssize_t count2 = 0, ret;
> +
> +	do {
> +		ret = pread(fd, buf, count, offset);
> +		if (ret == -1) {
> +			if (errno == EINTR)
> +				continue;
> +			break;
> +		}
> +		if (ret == 0)
> +			break;
> +		count2 += ret;
> +		buf += ret;
> +		count -= ret;
> +	} while (count);
> +	return count2;
> +}
> +
> +static ssize_t do_write(int fd, const void *buf, size_t count, off_t offset)
> +{
> +	ssize_t count2 = 0, ret;
> +
> +	do {
> +		ret = pwrite(fd, buf, count, offset);
> +		if (ret == -1) {
> +			if (errno == EINTR)
> +				continue;
> +			break;
> +		}
> +		if (ret == 0)
> +			break;
> +		count2 += ret;
> +		buf += ret;
> +		count -= ret;
> +	} while (count);
> +	return count2;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	if (argc != 2)
> +		errx(1, "no test filename argument given");
> +	filename = argv[1];
> +
> +	page_size = ret = sysconf(_SC_PAGE_SIZE);
> +	if (ret == -1)
> +		err(1, NULL);
> +
> +	ret = posix_memalign(&page, page_size, page_size);
> +	if (ret) {
> +		errno = ENOMEM;
> +		err(1, NULL);
> +	}
> +
> +	/*
> +	 * Make sure page faults during pread are handled correctly.
> +	 */
> +	init('a', O_RDWR);
> +	ret = do_read(fd, addr, page_size, page_size);
> +	if (ret != page_size)
> +		err(1, "pread %s: %ld != %u", filename, ret, page_size);
> +	if (memcmp(addr, page, page_size))
> +		errx(1, "pread is broken");
> +	done();
> +
> +	init('b', O_RDWR | O_DIRECT);
> +	ret = do_read(fd, addr, page_size, page_size);
> +	if (ret != page_size)
> +		err(1, "pread %s (O_DIRECT): %ld != %u", filename, ret, page_size);
> +	if (memcmp(addr, page, page_size))
> +		errx(1, "pread (D_DIRECT) is broken");
> +	done();
> +
> +	/*
> +	 * Make sure page faults during pwrite are handled correctly.
> +	 */
> +	init('c', O_RDWR);
> +	ret = do_write(fd, addr + page_size, page_size, 0);
> +	if (ret != page_size)
> +		err(1, "pwrite %s: %ld != %u", filename, ret, page_size);
> +	if (memcmp(addr, page, page_size))
> +		errx(1, "pwrite is broken");
> +	done();
> +
> +	init('d', O_RDWR | O_DIRECT);
> +	ret = do_write(fd, addr + page_size, page_size, 0);
> +	if (ret != page_size)
> +		err(1, "pwrite %s (O_DIRECT): %ld != %u", filename, ret, page_size);
> +	if (memcmp(addr, page, page_size))
> +		errx(1, "pwrite (O_DIRECT) is broken");
> +	done();
> +
> +	if (unlink(filename))
> +		err(1, "unlink %s", filename);
> +
> +	return 0;
> +}
> diff --git a/tests/generic/637 b/tests/generic/637
> new file mode 100755
> index 00000000..d3c3f235
> --- /dev/null
> +++ b/tests/generic/637
> @@ -0,0 +1,40 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 637
> +#
> +# Trigger mmap page faults in the same file during pread and pwrite
> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_test

_require_test_program mmap-rw-fault

> +
> +$here/src/mmap-rw-fault $TEST_DIR/mmap-rw-fault.tmp \
> +|| exit

If you redirected stderr to stdout then the error messages and whatnot
will be captured in the golden output, which will automatically cause
the test to fail if anything happens.  Then you don't need the 'exit'.

$here/src/mmap-rw-fault $TEST_DIR/mmap-rw-fault.tmp 2>&1

By the way, what happens if the fs gets it wrong?  Does the kernel lock
up or crash or something?

--D

> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/637.out b/tests/generic/637.out
> new file mode 100644
> index 00000000..55a3d825
> --- /dev/null
> +++ b/tests/generic/637.out
> @@ -0,0 +1,2 @@
> +QA output created by 637
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index 105763c4..01996b48 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -639,3 +639,4 @@
>  634 auto quick atime bigtime
>  635 auto quick atime bigtime shutdown
>  636 auto quick swap
> +637 auto
> -- 
> 2.26.3
> 
