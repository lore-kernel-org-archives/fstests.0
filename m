Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D93C433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 11 Dec 2021 00:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345525AbhLKAuI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Dec 2021 19:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345515AbhLKAuH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Dec 2021 19:50:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD8AC061714
        for <fstests@vger.kernel.org>; Fri, 10 Dec 2021 16:46:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3747DCE2DDB
        for <fstests@vger.kernel.org>; Sat, 11 Dec 2021 00:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAD1C341C8;
        Sat, 11 Dec 2021 00:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639183588;
        bh=5FQOm6KPZU6QfXesKrAOtgZTnDlhuVjPIJNLCxQz3jg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HqHmWeJNJWGiULzlX+W+tvvYA9IcKMgh1zHyG2aTFM+ubKU9gcO8/iAvndaq7vDxk
         Irq32Jd1VEsThnVugoeWDPVoqyNsIkfGG8DT/N8AyHdLQOsMj8CR5FFJRk3uBcKcV/
         aj98nN3mgsYOmJ2SAmhrwpd7g8U4WsYOgUu1Y79b57vH3ca2IMJgtIy8yl4lTaJIMb
         PcmHVI+zSSOfIVAUEZcjWZmrnxMaYbfim2xm4Xh31ITVaNJsuxsgAEUMu/lz9Si33T
         hfGPRC1A5tkY74v9hOov20XxLFyu4/ik6V53r0LDr3M4tP9QKs1KUcLXV0HUjDB9oz
         MmkVZilfEPmdw==
Date:   Fri, 10 Dec 2021 16:46:28 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 13/16] generic: add mmap CoW test for mixed&source
 extents
Message-ID: <20211211004628.GN69210@magnolia>
References: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
 <20211125074752.274176-14-ruansy.fnst@fujitsu.com>
 <20211207004040.GF8442@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207004040.GF8442@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 06, 2021 at 04:40:40PM -0800, Darrick J. Wong wrote:
> On Thu, Nov 25, 2021 at 03:47:49PM +0800, Shiyang Ruan wrote:
> > Ensuring that copy on write in buffered mode works when the CoW
> > range originally covers multiple extents, mixed with reflinked, unwritten,
> > hole, regular and delalloc blocks.
> > 
> > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> 
> Looks ok,

...with a _require_command $FILEFRAG_PROG filefrag added.

(Serves me right for reviewing in backwards order.)

--D

> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> > ---
> >  tests/generic/912     | 67 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/912.out | 12 ++++++++
> >  2 files changed, 79 insertions(+)
> >  create mode 100755 tests/generic/912
> >  create mode 100644 tests/generic/912.out
> > 
> > diff --git a/tests/generic/912 b/tests/generic/912
> > new file mode 100755
> > index 00000000..4f0d94dd
> > --- /dev/null
> > +++ b/tests/generic/912
> > @@ -0,0 +1,67 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test No. 912
> > +#
> > +# Ensuring that copy on write in mmap mode works when the CoW
> > +# range originally covers multiple extents, mixed with reflinked, unwritten,
> > +# hole, regular and delalloc blocks.
> > +#   - Create a file with the following repeating sequence of blocks:
> > +#     1. reflinked
> > +#     2. unwritten
> > +#     3. hole
> > +#     4. regular block
> > +#     5. delalloc
> > +#   - mmap CoW across the halfway mark, starting with the unwritten extent.
> > +#   - Check that the files are now different where we say they're different.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick clone punch
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +. ./common/reflink
> > +
> > +# real QA test starts here
> > +_require_scratch_reflink
> > +_require_xfs_io_command "falloc"
> > +_require_xfs_io_command "fpunch"
> > +_require_cp_reflink
> > +_require_odirect
> > +
> > +echo "Format and mount"
> > +_scratch_mkfs > $seqres.full 2>&1
> > +_scratch_mount >> $seqres.full 2>&1
> > +
> > +testdir=$SCRATCH_MNT/test-$seq
> > +mkdir $testdir
> > +
> > +echo "Create the original files"
> > +blksz=65536
> > +nr=64
> > +filesize=$((blksz * nr))
> > +_sweave_reflink_rainbow $blksz $nr $testdir/file1 $testdir/file3 >> $seqres.full
> > +_scratch_cycle_mount
> > +
> > +echo "Compare files"
> > +md5sum $testdir/file1 | _filter_scratch
> > +md5sum $testdir/file3 | _filter_scratch
> > +md5sum $testdir/file1.chk | _filter_scratch
> > +
> > +echo "mmap CoW across the transition"
> > +cowoff=$((filesize / 4))
> > +cowsz=$((filesize / 2))
> > +_sweave_reflink_rainbow_delalloc $blksz $nr $testdir/file1 >> $seqres.full
> > +# now cow
> > +mmapsz=$((cowoff + cowsz))
> > +_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file1 >> $seqres.full
> > +_mwrite_byte 0x63 $cowoff $cowsz $mmapsz $testdir/file1.chk >> $seqres.full
> > +_scratch_cycle_mount
> > +
> > +echo "Compare files"
> > +md5sum $testdir/file1 | _filter_scratch
> > +md5sum $testdir/file3 | _filter_scratch
> > +md5sum $testdir/file1.chk | _filter_scratch
> > +
> > +# success, all done
> > +status=0
> > diff --git a/tests/generic/912.out b/tests/generic/912.out
> > new file mode 100644
> > index 00000000..32f25a1d
> > --- /dev/null
> > +++ b/tests/generic/912.out
> > @@ -0,0 +1,12 @@
> > +QA output created by 912
> > +Format and mount
> > +Create the original files
> > +Compare files
> > +6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-912/file1
> > +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-912/file3
> > +6366fd359371414186688a0ef6988893  SCRATCH_MNT/test-912/file1.chk
> > +mmap CoW across the transition
> > +Compare files
> > +26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-912/file1
> > +bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-912/file3
> > +26aa3a0749b867ec58363c8539ee5471  SCRATCH_MNT/test-912/file1.chk
> > -- 
> > 2.34.0
> > 
> > 
> > 
