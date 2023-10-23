Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D7AC25B42
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Oct 2023 22:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjJWWlY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 Oct 2023 18:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJWWlX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Oct 2023 18:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CE510D
        for <fstests@vger.kernel.org>; Mon, 23 Oct 2023 15:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698100835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/p3Av0NE/QeR2NCH5ET74M70MHIoJHXu8swHV/P1yus=;
        b=Kgo9QF7sNhwbrPKUlAgl8HOi85lRsDo3MPzgYPgJEz1SHUgRSO8ncYak5jjq9ysfvzRigS
        dBfdBi3RGtf2u57B17MwJvW1QkbWYCg3NwoZUx0dbBMrJM0RLM/b3r8XEGhTa5DQ36XG0G
        k/M2zJMemiv1yX8K+EDsKUja5Yp22sI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-6_7q9nv_N6yFIRoZG6whBQ-1; Mon, 23 Oct 2023 18:40:34 -0400
X-MC-Unique: 6_7q9nv_N6yFIRoZG6whBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7FBA185A7A7;
        Mon, 23 Oct 2023 22:40:33 +0000 (UTC)
Received: from redhat.com (unknown [10.22.8.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 677A740C6F79;
        Mon, 23 Oct 2023 22:40:33 +0000 (UTC)
Date:   Mon, 23 Oct 2023 17:40:31 -0500
From:   Bill O'Donnell <bodonnel@redhat.com>
To:     Bill O'Donnell <bodonnel@redhat.com>
Cc:     Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        quwenruo.btrfs@gmx.com, esandeen@redhat.com
Subject: Re: [PATCH v2] fstests: generic/353 should accomodate other pwrite
 behaviors
Message-ID: <ZTb2Xy4vTi6/RGQo@redhat.com>
References: <20230901161816.148854-1-bodonnel@redhat.com>
 <20230929050651.7rlyclnxlmzrot3z@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ZRbUQveXYWjhlvAN@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRbUQveXYWjhlvAN@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

ping?

On Fri, Sep 29, 2023 at 08:42:26AM -0500, Bill O'Donnell wrote:
> On Fri, Sep 29, 2023 at 01:06:51PM +0800, Zorro Lang wrote:
> > On Fri, Sep 01, 2023 at 11:18:16AM -0500, Bill O'Donnell wrote:
> > > xfs_io pwrite issues a series of block size writes, but there is no
> > > guarantee that the resulting extent(s) will be singular or contiguous.
> > > This behavior is acceptable, but the test is flawed in that it expects
> > > a single extent for a pwrite.
> > > 
> > > Modify test to use actual blocksize for pwrite and reflink. Also
> > > modify it to accommodate pwrite and reflink that produce different
> > > mapping results.
> > > 
> > > Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> > > ---
> > 
> > This patch makes sense to me, but this case looks like a regression test
> > test for a known btrfs issue. But this test case doesn't point out which
> > bug/fix does it test for. So I don't know if the 64k blocksize is a
> > necessary condition to reproduce the bug.
> > 
> > If we can prove it still can reproduce that bug with this patch at least,
> > then it's good to me to merge it.
> 
> I'd like Qu to weigh in on this from the btrfs standpoint.
> 
> Thanks-
> Bill
> 
> > 
> > Thanks,
> > Zorro
> > 
> > >  tests/generic/353     | 29 ++++++++++++++++-------------
> > >  tests/generic/353.out | 15 +--------------
> > >  2 files changed, 17 insertions(+), 27 deletions(-)
> > > 
> > > diff --git a/tests/generic/353 b/tests/generic/353
> > > index 9a1471bd..c5639725 100755
> > > --- a/tests/generic/353
> > > +++ b/tests/generic/353
> > > @@ -29,31 +29,34 @@ _require_xfs_io_command "fiemap"
> > >  _scratch_mkfs > /dev/null 2>&1
> > >  _scratch_mount
> > >  
> > > -blocksize=64k
> > > +blocksize=$(_get_file_block_size $SCRATCH_MNT)
> > > +
> > >  file1="$SCRATCH_MNT/file1"
> > >  file2="$SCRATCH_MNT/file2"
> > > +extmap1="$SCRATCH_MNT/extmap1"
> > > +extmap2="$SCRATCH_MNT/extmap2"
> > >  
> > >  # write the initial file
> > > -_pwrite_byte 0xcdcdcdcd 0 $blocksize $file1 | _filter_xfs_io
> > > +_pwrite_byte 0xcdcdcdcd 0 $blocksize $file1 > /dev/null
> > >  
> > >  # reflink initial file
> > > -_reflink_range $file1 0 $file2 0 $blocksize | _filter_xfs_io
> > > +_reflink_range $file1 0 $file2 0 $blocksize > /dev/null
> > >  
> > >  # check their fiemap to make sure it's correct
> > > -echo "before sync:"
> > > -echo "$file1" | _filter_scratch
> > > -$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags
> > > -echo "$file2" | _filter_scratch
> > > -$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags
> > > +$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags > $extmap1
> > > +$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags > $extmap2
> > > +
> > > +cmp -s $extmap1 $extmap2 || echo "mismatched extent maps before sync"
> > >  
> > >  # sync and recheck, to make sure the fiemap doesn't change just
> > >  # due to sync
> > >  sync
> > > -echo "after sync:"
> > > -echo "$file1" | _filter_scratch
> > > -$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags
> > > -echo "$file2" | _filter_scratch
> > > -$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags
> > > +$XFS_IO_PROG -c "fiemap -v" $file1 | _filter_fiemap_flags > $extmap1
> > > +$XFS_IO_PROG -c "fiemap -v" $file2 | _filter_fiemap_flags > $extmap2
> > > +
> > > +cmp -s $extmap1 $extmap2 || echo "mismatched extent maps after sync"
> > > +
> > > +echo "Silence is golden"
> > >  
> > >  # success, all done
> > >  status=0
> > > diff --git a/tests/generic/353.out b/tests/generic/353.out
> > > index 4f6e0b92..16ba4f1f 100644
> > > --- a/tests/generic/353.out
> > > +++ b/tests/generic/353.out
> > > @@ -1,15 +1,2 @@
> > >  QA output created by 353
> > > -wrote 65536/65536 bytes at offset 0
> > > -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > -linked 65536/65536 bytes at offset 0
> > > -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > -before sync:
> > > -SCRATCH_MNT/file1
> > > -0: [0..127]: shared|last
> > > -SCRATCH_MNT/file2
> > > -0: [0..127]: shared|last
> > > -after sync:
> > > -SCRATCH_MNT/file1
> > > -0: [0..127]: shared|last
> > > -SCRATCH_MNT/file2
> > > -0: [0..127]: shared|last
> > > +Silence is golden
> > > -- 
> > > 2.41.0
> > > 
> > 
> 

