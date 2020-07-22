Return-Path: <SRS0=o+XN=BB=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5CCC433E4
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jul 2020 17:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B8A20787
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jul 2020 17:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeJA7nCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgGVRom (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:44:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53084 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728936AbgGVRol (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Jul 2020 13:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595439879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iGNgtLg4NIS4RRwgNQfXDiwuufVpfYXojguyKEhKCN8=;
        b=UeJA7nCqapzHcSI1laDBMiWXonUHKBxbKw1tFD2e4x2QbLcGa4oJKx/5A2172nW8GW5HlU
        wrz+SoB4ZUMAc4n3fd/JeN21g/RJgtP1kgZiMTlRNufCha/cHh2LnGX3Grrz+0FJjW/Cav
        o7WU80fT0Q/UEV3TnH5/8FlXdWAILlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-q_MNMk5MN0ur9JF-oyVI4A-1; Wed, 22 Jul 2020 13:44:35 -0400
X-MC-Unique: q_MNMk5MN0ur9JF-oyVI4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27B3180BCAB
        for <fstests@vger.kernel.org>; Wed, 22 Jul 2020 17:44:35 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96B5588D45
        for <fstests@vger.kernel.org>; Wed, 22 Jul 2020 17:44:34 +0000 (UTC)
Date:   Thu, 23 Jul 2020 01:56:43 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/501: count with PAGE_SIZE instead of KB
Message-ID: <20200722175643.GC2937@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: fstests <fstests@vger.kernel.org>
References: <20200722063832.dpxn7weosdy2zp64@xzhoux.usersys.redhat.com>
 <20200722115848.GB2937@dhcp-12-102.nay.redhat.com>
 <CAL3q7H7_H_FOZA0e60JR0BiiXq-t_-itXpfdpPCxdgTKFe21_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7_H_FOZA0e60JR0BiiXq-t_-itXpfdpPCxdgTKFe21_g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 22, 2020 at 12:52:16PM +0100, Filipe Manana wrote:
> On Wed, Jul 22, 2020 at 12:48 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Wed, Jul 22, 2020 at 02:38:32PM +0800, Murphy Zhou wrote:
> > > Hard coded reflink offset/length numbers are not working well on 64K page
> > > size arch like ppc64le, reporting:
> > >       +XFS_IOC_CLONE_RANGE: Invalid argument
> > >
> > > Because they are not aligned with the current PAGE_SIZE.
> > >
> > > Translate original numbers into multiples of PAGE_SIZE. Then we're writing
> > > different testfiles with different md5sums when PAGE_SIZE is different.
> > > So we need to link different output file based on the current PAGE_SIZE.
> > >
> > > This testcase is covering a btrfs regression which has been fixed in
> > > v4.18. I tried to reproduce it on 4.17 kernel but failed with and
> > > without this patch.
> > >
> > > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > > ---
> > >  .gitignore                            |  1 +
> > >  tests/generic/501                     | 17 +++++++++++++----
> > >  tests/generic/{501.out => 501.out.4K} |  0
> > >  tests/generic/501.out.64K             |  5 +++++
> > >  4 files changed, 19 insertions(+), 4 deletions(-)
> > >  rename tests/generic/{501.out => 501.out.4K} (100%)
> > >  create mode 100644 tests/generic/501.out.64K
> > >
> > > diff --git a/.gitignore b/.gitignore
> > > index 5f5c4a0f..39318615 100644
> > > --- a/.gitignore
> > > +++ b/.gitignore
> > > @@ -263,6 +263,7 @@
> > >  /tests/xfs/033.out
> > >  /tests/xfs/071.out
> > >  /tests/xfs/096.out
> > > +/tests/generic/501.out
> > >
> > >  # cscope files
> > >  cscope.*
> > > diff --git a/tests/generic/501 b/tests/generic/501
> > > index 0d1f6ffe..4e589cda 100755
> > > --- a/tests/generic/501
> > > +++ b/tests/generic/501
> > > @@ -9,6 +9,7 @@
> > >  # the file again and then power fail, after we mount again the filesystem, no
> > >  # file data was lost or corrupted.
> > >  #
> > > +seqfull=$0
> > >  seq=`basename $0`
> > >  seqres=$RESULT_DIR/$seq
> > >  echo "QA output created by $seq"
> > > @@ -42,14 +43,22 @@ _require_metadata_journaling $SCRATCH_DEV
> > >  _init_flakey
> > >  _mount_flakey
> > >
> > > -$XFS_IO_PROG -f -c "pwrite -S 0x18 9000K 6908K" $SCRATCH_MNT/foo >>$seqres.full
> > > -$XFS_IO_PROG -f -c "pwrite -S 0x20 2572K 156K" $SCRATCH_MNT/bar >>$seqres.full
> > > +pagesz=$(getconf PAGE_SIZE)
> > > +
> > > +if [ $pagesz -eq 65536 ] ; then
> > > +     ln -sf $seqfull.out.64K $seqfull.out
> > > +elif [ $pagesz -eq 4096 ] ; then
> > > +     ln -sf $seqfull.out.4K $seqfull.out
> > > +fi
> >
> > You can't sure there're only 4k and 64k system.
> > This case trys to make sure the md5 of $SCRATCH_MNT/bar isn't changed before and
> > after _flakey_drop_and_remount. So if you turn to use different pagesize, you
> > can silence the golden image, and compare the md5 quietly. Something likes(just
> > example):
> 
> This can be simpler. The test can be changed to use multiples of 64K,
> so it will work everywhere (like other reflink tests).
> I'll try it out and test on 4.17 to confirm it still reproduces the
> original btrfs bug.

Sure, if so, it's a simpler way to fix this failure.

Thanks,
Zorro

> 
> Thanks.
> 
> >
> > diff --git a/tests/generic/501 b/tests/generic/501
> > index 0d1f6ffe..7e7f9be5 100755
> > --- a/tests/generic/501
> > +++ b/tests/generic/501
> > @@ -53,18 +53,21 @@ $XFS_IO_PROG -c "fsync" \
> >              -c "fsync" \
> >              $SCRATCH_MNT/bar >>$seqres.full
> >
> > -echo "File bar digest before power failure:"
> > -md5sum $SCRATCH_MNT/bar | _filter_scratch
> > +# File bar digest before power failure
> > +md5sum $SCRATCH_MNT/bar > $tmp.md5.org
> >
> >  # Simulate a power failure and mount the filesystem to check that no file data
> >  # was lost or corrupted.
> >  _flakey_drop_and_remount
> >
> > -echo "File bar digest after power failure:"
> > -md5sum $SCRATCH_MNT/bar | _filter_scratch
> > +# File bar digest after power failure
> > +md5sum $SCRATCH_MNT/bar > $tmp.md5.new
> > +diff -u $tmp.md5.org $tmp.md5.new
> >
> >  _unmount_flakey
> >  _cleanup_flakey
> >
> > +echo "Silence is golden"
> > +
> >  status=0
> >  exit
> > diff --git a/tests/generic/501.out b/tests/generic/501.out
> > index 5d7da017..00133b63 100644
> > --- a/tests/generic/501.out
> > +++ b/tests/generic/501.out
> > @@ -1,5 +1,2 @@
> >  QA output created by 501
> > -File bar digest before power failure:
> > -95a95813a8c2abc9aa75a6c2914a077e  SCRATCH_MNT/bar
> > -File bar digest after power failure:
> > -95a95813a8c2abc9aa75a6c2914a077e  SCRATCH_MNT/bar
> > +Silence is golden
> >
> > Thanks,
> > Zorro
> >
> > > +
> > > +$XFS_IO_PROG -f -c "pwrite -S 0x18 $((2250*pagesz)) $((1727*pagesz))" $SCRATCH_MNT/foo >>$seqres.full
> > > +$XFS_IO_PROG -f -c "pwrite -S 0x20 $((643*pagesz)) $((39*pagesz))" $SCRATCH_MNT/bar >>$seqres.full
> > >
> > >  # We clone from file foo into a range of file bar that overlaps the existing
> > >  # extent at file bar. The destination offset of the reflink operation matches
> > > -# the eof position of file bar minus 4Kb.
> > > +# the eof position of file bar minus 1 PAGE_SIZE.
> > >  $XFS_IO_PROG -c "fsync" \
> > > -          -c "reflink ${SCRATCH_MNT}/foo 0 2724K 15908K" \
> > > +          -c "reflink ${SCRATCH_MNT}/foo 0 $((681*pagesz)) $((3977*pagesz))" \
> > >            -c "fsync" \
> > >            $SCRATCH_MNT/bar >>$seqres.full
> > >
> > > diff --git a/tests/generic/501.out b/tests/generic/501.out.4K
> > > similarity index 100%
> > > rename from tests/generic/501.out
> > > rename to tests/generic/501.out.4K
> > > diff --git a/tests/generic/501.out.64K b/tests/generic/501.out.64K
> > > new file mode 100644
> > > index 00000000..7e1013b2
> > > --- /dev/null
> > > +++ b/tests/generic/501.out.64K
> > > @@ -0,0 +1,5 @@
> > > +QA output created by 501
> > > +File bar digest before power failure:
> > > +3058797b969076e91c518cb206b21163  SCRATCH_MNT/bar
> > > +File bar digest after power failure:
> > > +3058797b969076e91c518cb206b21163  SCRATCH_MNT/bar
> > > --
> > > 2.20.1
> > >
> >
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
> 

