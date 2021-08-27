Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9684AC432BE
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Aug 2021 16:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C4560FC4
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Aug 2021 16:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhH0QR6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234192AbhH0QR6 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Aug 2021 12:17:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C51760E78;
        Fri, 27 Aug 2021 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630081029;
        bh=6cbHtyAS/jG4nGHwxDi7coDuAwFVAG09UuZ8b8OUBkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSumjVC0XBYdvvDF4oVy0assKK1ZEjd8VpHWExZt2TJIlGnyGOsc+WzfCzzqCOPys
         smMHUrng0UXUgr5bLnyGpCES8HAu42aliZcRU3j5Kz6GJaaQXZeo/BSNS+wvEmQFwx
         2NIwvX8UGf0Bq/2CsCh0CMXm1RyzSSnwu9Lu56HP2Pr+qD9kkJ45fDWRRDJeibWDUV
         u1EQmwYHR+fxOUXmH21lpoJsTEfWFiAapIxGgT6SAFIU6zUZT9li2lJcuupPFHtcFJ
         +/HI+TWbntr3g7luQbf1qLq3O2Pz5N41uH3fT8WV8tdftHUwS7lZTqvfG5nMIuwEX7
         tBYZ6VB6aJ4XQ==
Date:   Fri, 27 Aug 2021 09:17:08 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/646: Test page faults during read and write
Message-ID: <20210827161708.GL12612@magnolia>
References: <20210827150603.1724638-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827150603.1724638-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Aug 27, 2021 at 05:06:03PM +0200, Andreas Gruenbacher wrote:
> Here's an update of a test case I'm trying to get merged since May.
> Please have a look; I'm tired of dragging this along.
> 
> Thanks,
> Andreas
> 
> --
> 
> Some filesystems have problems when the buffer passed to read or write
> is memory-mapped to the file being read from or written to, and the
> buffer needs to be faulted in during the read or write.  That's not
> common, but filesystems are still required to cope with it, and if they
> fail this test, then they will also fail more complex scenarios that
> involve multiple files.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  src/Makefile          |   2 +-
>  src/mmap-rw-fault.c   | 176 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/646     |  27 +++++++
>  tests/generic/646.out |   2 +
>  4 files changed, 206 insertions(+), 1 deletion(-)
>  create mode 100644 src/mmap-rw-fault.c
>  create mode 100755 tests/generic/646
>  create mode 100644 tests/generic/646.out
> 
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
> index 00000000..244d2cb6
> --- /dev/null
> +++ b/src/mmap-rw-fault.c

The generated binary needs a gitignore entry.

> @@ -0,0 +1,176 @@
> +/* Trigger mmap page faults in the same file during pread and pwrite. */

Needs a SPDX header and a copyright statement.

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

<now we skip to main>

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

These test reading from page 1 into (mmap) page 0, right?

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

...and writing from (mmap) page 1 into page 0?

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
> +	 * Reading from a hole takes a different code path in the kernel.
> +	 */

...and finally we test direct reading from page 0 into (mmap) page 0?

If that's correct, then this looks good to me, modulo the license nit at
the top.

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
> index 00000000..57d8c13d
> --- /dev/null
> +++ b/tests/generic/646
> @@ -0,0 +1,27 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 646
> +#
> +# Trigger mmap page faults in the same file during pread and pwrite
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
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

_cleanup should clean up the tempfile if the C program crashes, right?

Or use O_TMPFILE and let the kernel clean up the file for you.

--D

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
