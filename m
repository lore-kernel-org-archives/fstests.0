Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA96C3DA6F
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Aug 2023 03:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbjHXDj6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Aug 2023 23:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239662AbjHXDjs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Aug 2023 23:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE151704
        for <fstests@vger.kernel.org>; Wed, 23 Aug 2023 20:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692848327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5kgf7pggnJ0N/DbZzd/CUNauBq3UgVQXzwou+VBsXfo=;
        b=FyecuXTEjgYsNp8kgZyT0JYHBNhEmKOuIxes3+qFvv7qAmXYbEvobPSxI/ea32/8lsK7sj
        ETh4yIGbtF8mQC2CJR05xftc/2h3ucPIZykW59+/3xZuOWUI7wf3Uyl9Trw+SDVem4sYbL
        7+DEhkgQwF9twjGf+jQJ3GjhlBJ/Nt0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-Eqze8en8OpKuhx8rNvDe-Q-1; Wed, 23 Aug 2023 23:38:45 -0400
X-MC-Unique: Eqze8en8OpKuhx8rNvDe-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84795800270;
        Thu, 24 Aug 2023 03:38:45 +0000 (UTC)
Received: from redhat.com (unknown [10.22.16.107])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F74863F7A;
        Thu, 24 Aug 2023 03:38:45 +0000 (UTC)
Date:   Wed, 23 Aug 2023 22:38:43 -0500
From:   Bill O'Donnell <bodonnel@redhat.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/352 should accomodate other pwrite
 behaviors
Message-ID: <ZObQw4amc3D60RSr@redhat.com>
References: <20230823154350.18829-1-bodonnel@redhat.com>
 <20230823164641.GA11251@frogsfrogsfrogs>
 <ZOaFmhnUAM9gjNFv@redhat.com>
 <20230823222754.GB11251@frogsfrogsfrogs>
 <9e0d9bcd-0820-4dd0-a43f-519a9b54c656@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e0d9bcd-0820-4dd0-a43f-519a9b54c656@gmx.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 24, 2023 at 08:03:23AM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/8/24 06:27, Darrick J. Wong wrote:
> > On Wed, Aug 23, 2023 at 05:18:02PM -0500, Bill O'Donnell wrote:
> > > On Wed, Aug 23, 2023 at 09:46:41AM -0700, Darrick J. Wong wrote:
> > > > On Wed, Aug 23, 2023 at 10:43:50AM -0500, Bill O'Donnell wrote:
> > > > > xfs_io pwrite issues a series of block size writes, but there is no guarantee
> > > > > that the resulting extent(s) will be singular or contiguous.
> 
> However this doesn't make much difference, at least for btrfs.
> 
> Btrfs would do the merging emitting the fiemap entry, thus even if the
> write didn't result a singular extent, as long as they are contiguous
> (under most cases they are) the fiemap result would still be a single one.
> 
> > > > > This behavior is
> > > > > acceptable, but the test is flawed in that it expects a single extent for a
> > > > > pwrite.
> 
> I'm more interested in if you're hitting any test failure?

Yes we are.

thanks-
Bill


> 
> > > > > 
> > > > > Modify test to accept any layout for the reflinked logical range.
> > > > > 
> > > > > Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> > > > > ---
> > > > >   tests/generic/352     | 16 +++++++++++-----
> > > > >   tests/generic/352.out |  2 --
> > > > >   2 files changed, 11 insertions(+), 7 deletions(-)
> > > > > 
> > > > > diff --git a/tests/generic/352 b/tests/generic/352
> > > > > index 52ec4850..c4ee8a44 100755
> > > > > --- a/tests/generic/352
> > > > > +++ b/tests/generic/352
> > > > > @@ -48,19 +48,25 @@ _pwrite_byte 0xcdcdcdcd 0 $blocksize $file | _filter_xfs_io
> > > > >   # use reflink to create the rest of the file, whose all extents are all
> > > > >   # pointing to the first extent
> > > > >   for i in $(seq 1 $nr); do
> > > > > -	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize > /dev/null
> > > > > +	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize > $tmp1.out
> > > > 
> > > > $tmp1 isnt defined anywhere.
> > > > 
> > > > >   done
> > > > > 
> > > > >   # then call fiemap on that file to test both the shared flag and if
> > > > >   # reserved extent mapping search will cause soft lockup
> > > > > -$XFS_IO_PROG -c "fiemap -v" $file | _filter_fiemap_flags > $tmp.out
> > > > > -cat $tmp.out >> $seqres.full
> > > > > +$XFS_IO_PROG -c "fiemap -v" $file | _filter_fiemap_flags > $tmp2.out
> > > > > +cat $tmp2.out >> $seqres.full
> > > > 
> > > > Nor is $tmp2
> > > > 
> > > > > 
> > > > >   # refact the $LOAD_FACTOR to 1 to match the golden output
> > > > >   sed -i -e "s/$(($last_extent - 1))/$(($orig_last_extent - 1))/" \
> > > > >   	-e "s/$last_extent/$orig_last_extent/" \
> > > > > -	-e "s/$end/$orig_end/" $tmp.out
> > > > > -cat $tmp.out
> > > > > +	-e "s/$end/$orig_end/" $tmp2.out
> > > > > +
> > > > > +cat $tmp1.out > tmp.1
> > > > > +cat $tmp2.out > tmp.2
> > > > 
> > > > Not sure why you didn't make the _reflink_range and the fiemap above
> > > > output to $tmp.out1 and $tmp.out2, respectively.  If you had, then the
> > > > default _cleanup would delete $tmp.* automatically...
> > > > 
> > > > > +
> > > > > +diff tmp.[12]
> > > > > +rm tmp.1
> > > > > +rm tmp.2
> > > > 
> > > > ...and the rm here wouldn't be necessary.
> > > > 
> > > > Ok.  Nitpicking over.  Moving on to the weirder design questions of the
> > > > original test:
> > > > 
> > > > [add original test author to cc]
> > > 
> > > Emails to quwenruo@cn.fujitsu.com seem to be undeliverable. Maybe Joseph
> > > would know what btrfs intent was?
> > 
> > ...or I guess I could have used the current email addr instead of the
> > one on the commit. :(
> > 
> > Qu: Question for you:
> 
> Thanks a lot for referring it to me.
> 
> > 
> > > > I don't know why $blocksize is set to 128k above.  If this test needs to
> > > > guarantee that there would only be *one* extent (and the golden output
> > > > implies this as you note), then it should have been written to say:
> > > > 
> > > > 	blocksize=$(_get_file_block_size $SCRATCH_MNT)
> > > > 
> > > > But I don't know if the "btrfs soft lock up and return wrong shared
> > > > flag" behavior required sharing a (probably multi-block) 128k range, or
> > > > if that was simply what the author selected because it reproduced the
> > > > problem.
> 
> It's quite sometime ago, thus my memory may not be reliable, but IIRC
> the blocksize has no specific requirement other than allowing all
> possible blocksize (4K to 64K).
> 
> And at that time, at least I was preferring to use golden output to
> detect errors, thus I choose a larger blocksize to allow all blocksizes
> to work.
> 
> > 
> > Any thoughts?
> > 
> > --D
> > 
> > > > 
> > > > > 
> > > > >   # success, all done
> > > > >   status=0
> > > > > diff --git a/tests/generic/352.out b/tests/generic/352.out
> > > > > index 4ff66c21..ad90ae0d 100644
> > > > > --- a/tests/generic/352.out
> > > > > +++ b/tests/generic/352.out
> > > > > @@ -1,5 +1,3 @@
> > > > >   QA output created by 352
> > > > >   wrote 131072/131072 bytes at offset 0
> > > > >   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > > > -0: [0..2097151]: shared
> > > > > -1: [2097152..2097407]: shared|last
> > > > 
> > > > Also I suspect from the test description that the goal here was to
> > > > detect the golden output failing because the shared flag does not get
> > > > reported correctly.
> 
> Could explain more on why the shared flag detection is not correct here?
> 
> If a file extent is shared, no matter if it's shared by another inode or
> not, shouldn't it be marked with SHARED flag?
> 
> Thanks,
> Qu
> 
> > > > 
> > > > --D
> > > > > --
> > > > > 2.41.0
> > > > > 
> > > > 
> > > 
> 

