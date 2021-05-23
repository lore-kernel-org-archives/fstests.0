Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF8DC47080
	for <linux-fstests@archiver.kernel.org>; Sun, 23 May 2021 14:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A70611ED
	for <linux-fstests@archiver.kernel.org>; Sun, 23 May 2021 14:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhEWO6Z (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 May 2021 10:58:25 -0400
Received: from out20-14.mail.aliyun.com ([115.124.20.14]:42260 "EHLO
        out20-14.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbhEWO6Y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 May 2021 10:58:24 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0540884-0.000342724-0.945569;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.KHc1HGq_1621781816;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KHc1HGq_1621781816)
          by smtp.aliyun-inc.com(10.147.43.95);
          Sun, 23 May 2021 22:56:56 +0800
Date:   Sun, 23 May 2021 22:56:56 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v5] generic: Test page faults during read and write
Message-ID: <YKptOEuBHO5rARGp@desktop>
References: <20210520165741.1607453-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520165741.1607453-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 20, 2021 at 06:57:41PM +0200, Andreas Gruenbacher wrote:
> Some filesystems have problems when the buffer passed to read or write is
> memory-mapped to the file being read from or written to and the buffer is
> faulted in during the read or write.  (That's probably not a recommended
> use case, but it should work nevertheless.)

Is there any kernel fixes that this test is targeting at? It'd better to
mention the coressponding kernel fixes in commit log or test
description. I noticed that btrfs currently hangs with v5.13-rc1 kernel,
ext4 and xfs all pass the test.

> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  src/Makefile          |   3 +-
>  src/mmap-rw-fault.c   | 169 ++++++++++++++++++++++++++++++++++++++++++

Missing an entry in .gitignore file.

>  tests/generic/639     |  40 ++++++++++
>  tests/generic/639.out |   2 +
>  tests/generic/group   |   1 +
>  5 files changed, 214 insertions(+), 1 deletion(-)
>  create mode 100644 src/mmap-rw-fault.c
>  create mode 100755 tests/generic/639
>  create mode 100644 tests/generic/639.out
> 
> diff --git a/src/mmap-rw-fault.c b/src/mmap-rw-fault.c
> new file mode 100644
> index 00000000..31778769
> --- /dev/null
> +++ b/src/mmap-rw-fault.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Trigger mmap page faults in the same file during pread and pwrite.
> + * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
> + * Written by Andreas Gruenbacher <agruenba@redhat.com>
> + */
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
> diff --git a/tests/generic/639 b/tests/generic/639
> new file mode 100755
> index 00000000..cbb3d119
> --- /dev/null
> +++ b/tests/generic/639
> @@ -0,0 +1,40 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 639
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
> +_require_test_program mmap-rw-fault

_require_odirect as mmap-rw-fault is doing direct I/O as well.

> +
> +$here/src/mmap-rw-fault $TEST_DIR/mmap-rw-fault.tmp 2>&1

And better to describe the behavior with comments, as you replied to
Darrick in previous mail, so people know what's to expect if bug
reproduced.

Thanks,
Eryu

> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/639.out b/tests/generic/639.out
> new file mode 100644
> index 00000000..55a3d825
> --- /dev/null
> +++ b/tests/generic/639.out
> @@ -0,0 +1,2 @@
> +QA output created by 639
> +Silence is golden
> -- 
> 2.26.3
