Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3328DC433ED
	for <linux-fstests@archiver.kernel.org>; Thu, 20 May 2021 17:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100F46139A
	for <linux-fstests@archiver.kernel.org>; Thu, 20 May 2021 17:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhETRCU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 May 2021 13:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231849AbhETRB7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 May 2021 13:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621530036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yzKR6exwiAs+vTbvtoB0Lq97rQn+D67iu1hYHcJrZtA=;
        b=VyQevqhJMnkRmabojRpv8CA3x5fU7UhBZBYr/TQlDzIpYpRzOVr6TFHxSRP/K307n5GZtk
        kmlVcGlR6YIthSPROgplLcKBceLGhdzwW33u3hPvhwrBFy0T6DggghEzYvbzEJxT6LI8QM
        mF9fngORTCQ4x5NaCdvQUfIAO7sJukA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-qLblupixPCO-20zf-TVRdg-1; Thu, 20 May 2021 13:00:34 -0400
X-MC-Unique: qLblupixPCO-20zf-TVRdg-1
Received: by mail-wm1-f69.google.com with SMTP id l185-20020a1c25c20000b029014b0624775eso2556653wml.6
        for <fstests@vger.kernel.org>; Thu, 20 May 2021 10:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yzKR6exwiAs+vTbvtoB0Lq97rQn+D67iu1hYHcJrZtA=;
        b=QfAel1PuGoTpqHqqd4kdwSZUd4SADMKeU7+lmsjWWZN9VbWP/wEJvCf2P1TAVLnAMp
         Vj0Dcv3EByeKUOH2WJ5YpSS2KXu2z3CVQZuFOH5RfR6cDvx2dboP3RuBeY+J82QRYTgK
         i3I7GTWG4pYoComkBk+VQJ+x0QgQr8DTtCuBb/D5z7eef3xTxpquzMhlFZ/zjk2+xPi9
         SGCzIc3Dqp7wM+JmqM8EYkYzfyvufLYyyDwoc6xa7MKGJaBENOiCSxs16VKEnO5LVzHx
         T6jc2iuJvaHXepCcrrH36sBnS1Vlj4kqudxIxkJJpPUoibcGhZWAHbtgMRb5Y9xvpYQD
         BHWg==
X-Gm-Message-State: AOAM533ZYSpZMMPA5gn5zWDLyn5UY+Um0sgN0fyT9hscaGzVdeBQiBuJ
        +JacahuopnWFL2lta4GUOQtOqrzTEzWo+gnsaTrC5HOd16zWkRay2OB2Iu0TYUhSu1N5nYeuxwp
        IoQpNxZssBwI7BM12fjYsU9lLPnpR+8rjkA==
X-Received: by 2002:a05:600c:4f4e:: with SMTP id m14mr5038618wmq.164.1621530033716;
        Thu, 20 May 2021 10:00:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHOir2pn3ZFaphfIGEbW7EfzHnUXvik4KENjbfcgAuCnEIt2LLERcw6+35B5ZmzfZ1dxt+Hsqefu7NQRCtEec=
X-Received: by 2002:a05:600c:4f4e:: with SMTP id m14mr5038600wmq.164.1621530033425;
 Thu, 20 May 2021 10:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210520114218.1595735-1-agruenba@redhat.com> <20210520163159.GF9648@magnolia>
In-Reply-To: <20210520163159.GF9648@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 20 May 2021 19:00:22 +0200
Message-ID: <CAHc6FU7WPKEHDv91xg2SBLeOwVuOBW-c9CO7Zj2fLM43nMVM+g@mail.gmail.com>
Subject: Re: [PATCH v4] generic/637: Test page faults during read and write
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 20, 2021 at 6:41 PM Darrick J. Wong <djwong@kernel.org> wrote:
> On Thu, May 20, 2021 at 01:42:18PM +0200, Andreas Gruenbacher wrote:
> > Some filesystems have problems when the buffer passed to read or write is
> > memory-mapped to the file being read from or written to and the buffer is
> > faulted in during the read or write.  (That's probably not a recommended
> > use case, but it should work nevertheless.)
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  src/Makefile          |   3 +-
> >  src/mmap-rw-fault.c   | 164 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/637     |  40 +++++++++++
> >  tests/generic/637.out |   2 +
> >  tests/generic/group   |   1 +
> >  5 files changed, 209 insertions(+), 1 deletion(-)
> >  create mode 100644 src/mmap-rw-fault.c
> >  create mode 100755 tests/generic/637
> >  create mode 100644 tests/generic/637.out
> >
> > diff --git a/src/Makefile b/src/Makefile
> > index cc0b9579..13cdf19b 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -17,7 +17,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> >       t_mmap_cow_race t_mmap_fallocate fsync-err t_mmap_write_ro \
> >       t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
> >       t_ofd_locks t_mmap_collision mmap-write-concurrent \
> > -     t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc
> > +     t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> > +     mmap-rw-fault
> >
> >  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> >       preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > diff --git a/src/mmap-rw-fault.c b/src/mmap-rw-fault.c
> > new file mode 100644
> > index 00000000..b9c58af6
> > --- /dev/null
> > +++ b/src/mmap-rw-fault.c
> > @@ -0,0 +1,164 @@
> > +/* Trigger mmap page faults in the same file during pread and pwrite. */
>
> Missing SPDX header.
>
> (Let's not make the implicit license mess in src/ worse, please.)
>
> > +
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE /* to get definition of O_DIRECT flag. */
> > +#endif
> > +
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <sys/mman.h>
> > +#include <fcntl.h>
> > +#include <unistd.h>
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +#include <err.h>
> > +
> > +char *filename;
> > +unsigned int page_size;
> > +void *page;
> > +char *addr;
> > +int fd;
> > +ssize_t ret;
> > +
> > +/*
> > + * Leave a hole at the beginning of the test file and initialize a block of
> > + * @page_size bytes at offset @page_size to @c.  Then, reopen the file and
> > + * mmap the first two pages.
> > + */
> > +void init(char c, int flags)
> > +{
> > +     fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY | O_DIRECT, 0666);
> > +     if (fd == -1)
> > +             goto fail;
> > +     memset(page, c, page_size);
> > +     ret = pwrite(fd, page, page_size, page_size);
> > +     if (ret != page_size)
> > +             goto fail;
> > +     if (close(fd))
> > +             goto fail;
> > +
> > +     fd = open(filename, flags);
> > +     if (fd == -1)
> > +             goto fail;
> > +     addr = mmap(NULL, 2 * page_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
> > +     if (addr == MAP_FAILED)
> > +             err(1, NULL);
> > +     return;
> > +
> > +fail:
> > +     err(1, "%s", filename);
> > +}
> > +
> > +void done(void)
> > +{
> > +     if (fsync(fd))
> > +             goto fail;
> > +     if (close(fd))
> > +             goto fail;
> > +     return;
> > +
> > +fail:
> > +     err(1, "%s", filename);
> > +}
> > +
> > +static ssize_t do_read(int fd, void *buf, size_t count, off_t offset)
> > +{
> > +     ssize_t count2 = 0, ret;
> > +
> > +     do {
> > +             ret = pread(fd, buf, count, offset);
> > +             if (ret == -1) {
> > +                     if (errno == EINTR)
> > +                             continue;
> > +                     break;
> > +             }
> > +             if (ret == 0)
> > +                     break;
> > +             count2 += ret;
> > +             buf += ret;
> > +             count -= ret;
> > +     } while (count);
> > +     return count2;
> > +}
> > +
> > +static ssize_t do_write(int fd, const void *buf, size_t count, off_t offset)
> > +{
> > +     ssize_t count2 = 0, ret;
> > +
> > +     do {
> > +             ret = pwrite(fd, buf, count, offset);
> > +             if (ret == -1) {
> > +                     if (errno == EINTR)
> > +                             continue;
> > +                     break;
> > +             }
> > +             if (ret == 0)
> > +                     break;
> > +             count2 += ret;
> > +             buf += ret;
> > +             count -= ret;
> > +     } while (count);
> > +     return count2;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     if (argc != 2)
> > +             errx(1, "no test filename argument given");
> > +     filename = argv[1];
> > +
> > +     page_size = ret = sysconf(_SC_PAGE_SIZE);
> > +     if (ret == -1)
> > +             err(1, NULL);
> > +
> > +     ret = posix_memalign(&page, page_size, page_size);
> > +     if (ret) {
> > +             errno = ENOMEM;
> > +             err(1, NULL);
> > +     }
> > +
> > +     /*
> > +      * Make sure page faults during pread are handled correctly.
> > +      */
> > +     init('a', O_RDWR);
> > +     ret = do_read(fd, addr, page_size, page_size);
> > +     if (ret != page_size)
> > +             err(1, "pread %s: %ld != %u", filename, ret, page_size);
> > +     if (memcmp(addr, page, page_size))
> > +             errx(1, "pread is broken");
> > +     done();
> > +
> > +     init('b', O_RDWR | O_DIRECT);
> > +     ret = do_read(fd, addr, page_size, page_size);
> > +     if (ret != page_size)
> > +             err(1, "pread %s (O_DIRECT): %ld != %u", filename, ret, page_size);
> > +     if (memcmp(addr, page, page_size))
> > +             errx(1, "pread (D_DIRECT) is broken");
> > +     done();
> > +
> > +     /*
> > +      * Make sure page faults during pwrite are handled correctly.
> > +      */
> > +     init('c', O_RDWR);
> > +     ret = do_write(fd, addr + page_size, page_size, 0);
> > +     if (ret != page_size)
> > +             err(1, "pwrite %s: %ld != %u", filename, ret, page_size);
> > +     if (memcmp(addr, page, page_size))
> > +             errx(1, "pwrite is broken");
> > +     done();
> > +
> > +     init('d', O_RDWR | O_DIRECT);
> > +     ret = do_write(fd, addr + page_size, page_size, 0);
> > +     if (ret != page_size)
> > +             err(1, "pwrite %s (O_DIRECT): %ld != %u", filename, ret, page_size);
> > +     if (memcmp(addr, page, page_size))
> > +             errx(1, "pwrite (O_DIRECT) is broken");
> > +     done();
> > +
> > +     if (unlink(filename))
> > +             err(1, "unlink %s", filename);
> > +
> > +     return 0;
> > +}
> > diff --git a/tests/generic/637 b/tests/generic/637
> > new file mode 100755
> > index 00000000..d3c3f235
> > --- /dev/null
> > +++ b/tests/generic/637
> > @@ -0,0 +1,40 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 637
> > +#
> > +# Trigger mmap page faults in the same file during pread and pwrite
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1     # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +     cd /
> > +     rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> > +_require_test
>
> _require_test_program mmap-rw-fault
>
> > +
> > +$here/src/mmap-rw-fault $TEST_DIR/mmap-rw-fault.tmp \
> > +|| exit
>
> If you redirected stderr to stdout then the error messages and whatnot
> will be captured in the golden output, which will automatically cause
> the test to fail if anything happens.  Then you don't need the 'exit'.
>
> $here/src/mmap-rw-fault $TEST_DIR/mmap-rw-fault.tmp 2>&1

Okay thanks, I've made those changes.

> By the way, what happens if the fs gets it wrong?  Does the kernel lock
> up or crash or something?

The filesystem might BUG() or simply lock up.

Thanks,
Andreas

