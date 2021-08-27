Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C78DC432BE
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Aug 2021 20:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E42260E97
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Aug 2021 20:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhH0Uvr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 27 Aug 2021 16:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231346AbhH0Uvq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 Aug 2021 16:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630097457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XiQFCgQYfxRusUa8GCDRfvAbB0/2glr6+V0RR3B1E/4=;
        b=GSjer8jNwGfjPQ454gVnBJPg2W16cfnGayYJr6e3M1TMJBMIe+fpAcEjBoYAF95nBN/x/v
        b4SRNqq82aAJG4R0kALrAa/HZyhi3sG0nX3G44gMAMxC8egpItvaNh2BvZg1OTmeYCpmRo
        3Yudtg8BgDogbSzn//3tYQLVwY8YIvI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-sRBhPs7xNtyXaYl4x4GSiQ-1; Fri, 27 Aug 2021 16:50:55 -0400
X-MC-Unique: sRBhPs7xNtyXaYl4x4GSiQ-1
Received: by mail-wm1-f70.google.com with SMTP id z18-20020a1c7e120000b02902e69f6fa2e0so2506342wmc.9
        for <fstests@vger.kernel.org>; Fri, 27 Aug 2021 13:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XiQFCgQYfxRusUa8GCDRfvAbB0/2glr6+V0RR3B1E/4=;
        b=Dom0ksHG12oqJBWJu85KiMW3ZuspUu4D2sLRyDTlrjcAuVUq+d9TNTRp3PgSmzv4bt
         l5kcCT/T/kV3wzT0LhygHZHQ46Rv4lYsGnBp3t5btnmKBZg16WooOlrwf3yQsBAq+vrB
         wdJPt1mXTBWr1689bEToQM082YgpxfBHaXZealO8Wrqj+cs2vyXlblgE7bkGE9tbzXJN
         Udj2G5jTXKtjxGEo/sM05DnDv2h0px+XctNblC8H4BeyDwrVyijEZsrHxeOsiE/D/LDg
         yPVpoVsgz0yQrEwlmpxtZ5QNbX283GhYsNUXyGD/9R/9qz9RKlOvx6zfs7KIWfxbHX4R
         demQ==
X-Gm-Message-State: AOAM532vJ7Uig7Cwwifc7CzOifGlrPFbZGcjlhnmaDWtBLmaK8FIzEBl
        MI+8O93Qv3tVzplHxrU/6/yhtGHWJVxdmhdBIgZV9fA4O9G4wsCFRCIUlRuPM5eArJ6x68nOduU
        xc7lSLPndjtdyP0DG3If3VEJ1zsVyQZNJlA==
X-Received: by 2002:a05:600c:1906:: with SMTP id j6mr10613291wmq.166.1630097454100;
        Fri, 27 Aug 2021 13:50:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySieWtZ6zmd1I0ps/mxuLBzuAhTZrBC/Y7hTHeuDhAlV4Spc/cMxFpFAeiwATl+rH6/fZ4A7kflFjQeewT6qM=
X-Received: by 2002:a05:600c:1906:: with SMTP id j6mr10613278wmq.166.1630097453836;
 Fri, 27 Aug 2021 13:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210827150603.1724638-1-agruenba@redhat.com> <20210827161708.GL12612@magnolia>
In-Reply-To: <20210827161708.GL12612@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 27 Aug 2021 22:50:42 +0200
Message-ID: <CAHc6FU6Wn9jB1-aVW=mtxq08RFefR6wSeAoKFRV4=1Bk66DsDw@mail.gmail.com>
Subject: Re: [PATCH] generic/646: Test page faults during read and write
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Aug 27, 2021 at 6:17 PM Darrick J. Wong <djwong@kernel.org> wrote:
> On Fri, Aug 27, 2021 at 05:06:03PM +0200, Andreas Gruenbacher wrote:
> > Here's an update of a test case I'm trying to get merged since May.
> > Please have a look; I'm tired of dragging this along.
> >
> > Thanks,
> > Andreas
> >
> > --
> >
> > Some filesystems have problems when the buffer passed to read or write
> > is memory-mapped to the file being read from or written to, and the
> > buffer needs to be faulted in during the read or write.  That's not
> > common, but filesystems are still required to cope with it, and if they
> > fail this test, then they will also fail more complex scenarios that
> > involve multiple files.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > ---
> >  src/Makefile          |   2 +-
> >  src/mmap-rw-fault.c   | 176 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/646     |  27 +++++++
> >  tests/generic/646.out |   2 +
> >  4 files changed, 206 insertions(+), 1 deletion(-)
> >  create mode 100644 src/mmap-rw-fault.c
> >  create mode 100755 tests/generic/646
> >  create mode 100644 tests/generic/646.out
> >
> > diff --git a/src/Makefile b/src/Makefile
> > index 884bd86a..25ab061d 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -18,7 +18,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> >       t_ext4_dax_journal_corruption t_ext4_dax_inline_corruption \
> >       t_ofd_locks t_mmap_collision mmap-write-concurrent \
> >       t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> > -     t_mmap_writev_overlap checkpoint_journal
> > +     t_mmap_writev_overlap checkpoint_journal mmap-rw-fault
> >
> >  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> >       preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > diff --git a/src/mmap-rw-fault.c b/src/mmap-rw-fault.c
> > new file mode 100644
> > index 00000000..244d2cb6
> > --- /dev/null
> > +++ b/src/mmap-rw-fault.c
>
> The generated binary needs a gitignore entry.
>
> > @@ -0,0 +1,176 @@
> > +/* Trigger mmap page faults in the same file during pread and pwrite. */
>
> Needs a SPDX header and a copyright statement.
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
>
> <now we skip to main>
>
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
>
> These test reading from page 1 into (mmap) page 0, right?

Yes. I've added more comments.

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
>
> ...and writing from (mmap) page 1 into page 0?

Yes.

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
> > +     /*
> > +      * Reading from a hole takes a different code path in the kernel.
> > +      */
>
> ...and finally we test direct reading from page 0 into (mmap) page 0?
>
> If that's correct, then this looks good to me, modulo the license nit at
> the top.

Yes.

> > +     init('e', O_RDWR | O_DIRECT);
> > +     ret = do_read(fd, addr, page_size, 0);
> > +     if (ret != page_size)
> > +             err(1, "pread %s (O_DIRECT) from hole: %ld != %u", filename, ret, page_size);
> > +     memset(page, 0, page_size);
> > +     if (memcmp(addr, page, page_size))
> > +             errx(1, "pread (D_DIRECT) from hole is broken");
> > +     done();
> > +
> > +     if (unlink(filename))
> > +             err(1, "unlink %s", filename);
> > +
> > +     return 0;
> > +}
> > diff --git a/tests/generic/646 b/tests/generic/646
> > new file mode 100755
> > index 00000000..57d8c13d
> > --- /dev/null
> > +++ b/tests/generic/646
> > @@ -0,0 +1,27 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 646
> > +#
> > +# Trigger mmap page faults in the same file during pread and pwrite
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +
> > +_supported_fs generic
> > +_require_test
> > +_require_test_program mmap-rw-fault
> > +
> > +echo "Silence is golden"
> > +
> > +$here/src/mmap-rw-fault $TEST_DIR/mmap-rw-fault.tmp
>
> _cleanup should clean up the tempfile if the C program crashes, right?
>
> Or use O_TMPFILE and let the kernel clean up the file for you.

Yep, I'll go for the _cleanup approach.

Thanks,
Andreas

