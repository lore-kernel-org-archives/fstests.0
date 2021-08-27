Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED33C432BE
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Aug 2021 23:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE7B60FE6
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Aug 2021 23:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhH0Xda (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 27 Aug 2021 19:33:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232405AbhH0Xda (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Aug 2021 19:33:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9445460560;
        Fri, 27 Aug 2021 23:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630107160;
        bh=F0+VF2IKkEo+5c2dEPL2T/l636n2p2Kfn38J7r08+zE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W2dLTi9vdRqGkbh3cWOFoQnZwx+Rtw295RjWmZT1IGB4GgqlaUAoapo9p1UW9AMK9
         rRcE+QeN7+Ij1TJNdGd94aEBrUZ/yoFnHzgtcZFoNS0OmSwhwgMfXzrrqYZz1FprZS
         ZAIoKLKR74rgivXwA0tzKjVXlaPJ9Scoz9MFqXik2+TA4HSOK6xjzz2gwilI5QzJOj
         LPghAxOxrb6IxxdAyfGDlTd8neDLhBtTKlotsdBrXIcnlj41KrbZLXma4N4wczr13G
         elDnWfiBzVKMP7gytS+Xe8nvpCwh2un6Z7gOh1ewetzp/cAwGv0gCxjSwsdLadHB4p
         VlHkq1dinSlaQ==
Date:   Fri, 27 Aug 2021 16:32:40 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/646: Test page faults during read and write
Message-ID: <20210827233240.GM12612@magnolia>
References: <20210827210209.1730181-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827210209.1730181-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Aug 27, 2021 at 11:02:09PM +0200, Andreas Gruenbacher wrote:
> Some filesystems have problems when the buffer passed to read or write
> is memory-mapped to the file being read from or written to, and the
> buffer needs to be faulted in during the read or write.  That's not
> common, but filesystems are still required to cope with it, and if they
> fail this test, then they will also fail more complex scenarios that
> involve multiple files.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks good to me!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  .gitignore            |   1 +
>  src/Makefile          |   2 +-
>  src/mmap-rw-fault.c   | 186 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/646     |  35 ++++++++
>  tests/generic/646.out |   2 +
>  5 files changed, 225 insertions(+), 1 deletion(-)
>  create mode 100644 src/mmap-rw-fault.c
>  create mode 100755 tests/generic/646
>  create mode 100644 tests/generic/646.out
> 
> diff --git a/.gitignore b/.gitignore
> index 2d72b064..9e6d2fd5 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -105,6 +105,7 @@ tags
>  /src/metaperf
>  /src/mkswap
>  /src/mmapcat
> +/src/mmap-rw-fault
>  /src/mmap-write-concurrent
>  /src/multi_open_unlink
>  /src/nametest
> diff --git a/src/Makefile b/src/Makefile
> index 884bd86a..25ab061d 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -18,7 +18,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
>  	t_ofd_locks t_mmap_collision mmap-write-concurrent \
>  	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> -	t_mmap_writev_overlap checkpoint_journal
> +	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/mmap-rw-fault.c b/src/mmap-rw-fault.c
> new file mode 100644
> index 00000000..82f9d978
> --- /dev/null
> +++ b/src/mmap-rw-fault.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
> + * Written by Andreas Gruenbacher (agruenba@redhat.com)
> + */
> +
> +/* Trigger page faults in the same file during read and write. */
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
> +	 * Make sure page faults during pread are handled correctly:
> +	 * read from an allocated area on disk into page 0.
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
> +	 * Make sure page faults during pwrite are handled correctly:
> +	 * write from an allocated area on disk into page 0.
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
> +	/*
> +	 * Reading from a hole under O_DIRECT takes a different code path in
> +	 * the kernel.  Read from a hole into page 0 to test that.  (It
> +	 * shouldn't matter that the hole and page 0 coincide.)
> +	 */
> +	init('e', O_RDWR | O_DIRECT);
> +	ret = do_read(fd, addr, page_size, 0);
> +	if (ret != page_size)
> +		err(1, "pread %s (O_DIRECT) from hole: %ld != %u", filename, ret, page_size);
> +	memset(page, 0, page_size);
> +	if (memcmp(addr, page, page_size))
> +		errx(1, "pread (D_DIRECT) from hole is broken");
> +	done();
> +
> +	if (unlink(filename))
> +		err(1, "unlink %s", filename);
> +
> +	return 0;
> +}
> diff --git a/tests/generic/646 b/tests/generic/646
> new file mode 100755
> index 00000000..a6a4d457
> --- /dev/null
> +++ b/tests/generic/646
> @@ -0,0 +1,35 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 646
> +#
> +# Trigger page faults in the same file during read and write
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +	rm -f $TEST_DIR/mmap-rw-fault.tmp
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs generic
> +_require_test
> +_require_test_program mmap-rw-fault
> +
> +echo "Silence is golden"
> +
> +$here/src/mmap-rw-fault $TEST_DIR/mmap-rw-fault.tmp
> +
> +status=$?
> +exit
> diff --git a/tests/generic/646.out b/tests/generic/646.out
> new file mode 100644
> index 00000000..8357006e
> --- /dev/null
> +++ b/tests/generic/646.out
> @@ -0,0 +1,2 @@
> +QA output created by 646
> +Silence is golden
> -- 
> 2.26.3
> 
