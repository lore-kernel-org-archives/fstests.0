Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DC5C6FA8F
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Aug 2023 12:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbjHXMNQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 24 Aug 2023 08:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241371AbjHXMNH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 24 Aug 2023 08:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07EA1BE3
        for <fstests@vger.kernel.org>; Thu, 24 Aug 2023 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692879122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dwCqTzV631LOlZc1zDYibQndY/d2hxRHABS62juVJmg=;
        b=QOYvjZTUgM0aTFeoIRJYTqDYjhVcUGbRCOozbaqsnniioFzAL2YTVbJBEG4nZ0b0if/xtg
        t8aOjNm8Xv2MUxeSAohg/2dQkIGmceigmMUwy9YXmEuXK85KnqLndoE96giB7S1Pm3yds2
        jaN/44RvfU6h7rR01eWxJA6W5HrxRI8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439-FzwYjBPWOX6PXXLmtjwj_w-1; Thu, 24 Aug 2023 08:12:01 -0400
X-MC-Unique: FzwYjBPWOX6PXXLmtjwj_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D38353806712;
        Thu, 24 Aug 2023 12:12:00 +0000 (UTC)
Received: from redhat.com (unknown [10.22.16.107])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9878FC1602B;
        Thu, 24 Aug 2023 12:12:00 +0000 (UTC)
Date:   Thu, 24 Aug 2023 07:11:59 -0500
From:   Bill O'Donnell <bodonnel@redhat.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/352 should accomodate other pwrite
 behaviors
Message-ID: <ZOdJD9vY02EaX3Pd@redhat.com>
References: <20230823154350.18829-1-bodonnel@redhat.com>
 <20230823164641.GA11251@frogsfrogsfrogs>
 <ZOaFmhnUAM9gjNFv@redhat.com>
 <20230823222754.GB11251@frogsfrogsfrogs>
 <9e0d9bcd-0820-4dd0-a43f-519a9b54c656@gmx.com>
 <ZObQw4amc3D60RSr@redhat.com>
 <1b1ae25f-518f-4614-89d1-8fd564d82678@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b1ae25f-518f-4614-89d1-8fd564d82678@gmx.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 24, 2023 at 02:46:10PM +0800, Qu Wenruo wrote:
> 
> 
> On 2023/8/24 11:38, Bill O'Donnell wrote:
> > On Thu, Aug 24, 2023 at 08:03:23AM +0800, Qu Wenruo wrote:
> > > 
> > > 
> > > On 2023/8/24 06:27, Darrick J. Wong wrote:
> > > > On Wed, Aug 23, 2023 at 05:18:02PM -0500, Bill O'Donnell wrote:
> > > > > On Wed, Aug 23, 2023 at 09:46:41AM -0700, Darrick J. Wong wrote:
> > > > > > On Wed, Aug 23, 2023 at 10:43:50AM -0500, Bill O'Donnell wrote:
> > > > > > > xfs_io pwrite issues a series of block size writes, but there is no guarantee
> > > > > > > that the resulting extent(s) will be singular or contiguous.
> > > 
> > > However this doesn't make much difference, at least for btrfs.
> > > 
> > > Btrfs would do the merging emitting the fiemap entry, thus even if the
> > > write didn't result a singular extent, as long as they are contiguous
> > > (under most cases they are) the fiemap result would still be a single one.
> > > 
> > > > > > > This behavior is
> > > > > > > acceptable, but the test is flawed in that it expects a single extent for a
> > > > > > > pwrite.
> > > 
> > > I'm more interested in if you're hitting any test failure?
> > 
> > Yes we are.
> 
> I guess it's using XFS?

Yes. The problem begins with the initial pwrite, with unpredictable mapping.
It's happening under the following configuration:

export TEST_DEV=/dev/pmem0
export TEST_DIR=/mnt/test
export SCRATCH_DEV=/dev/pmem0.1
export SCRATCH_MNT=/mnt/scratch
export MKFS_OPTIONS="-m reflink=1 -m rmapbt=0 -b size=4096"
export MOUNT_OPTIONS="-o dax=always"
export TEST_FS_MOUNT_OPTS="-o dax=always"

-Bill

> 
> Then the idea of using proper block size looks good to me.
> 
> And since we're getting rid of the golden output, it's also a good
> timing to get rid of the refactoring to match the golden output completely.
> 
> Thanks,
> Qu
> > 
> > thanks-
> > Bill
> > 
> > 
> > > 
> > > > > > > 
> > > > > > > Modify test to accept any layout for the reflinked logical range.
> > > > > > > 
> > > > > > > Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> > > > > > > ---
> > > > > > >    tests/generic/352     | 16 +++++++++++-----
> > > > > > >    tests/generic/352.out |  2 --
> > > > > > >    2 files changed, 11 insertions(+), 7 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/tests/generic/352 b/tests/generic/352
> > > > > > > index 52ec4850..c4ee8a44 100755
> > > > > > > --- a/tests/generic/352
> > > > > > > +++ b/tests/generic/352
> > > > > > > @@ -48,19 +48,25 @@ _pwrite_byte 0xcdcdcdcd 0 $blocksize $file | _filter_xfs_io
> > > > > > >    # use reflink to create the rest of the file, whose all extents are all
> > > > > > >    # pointing to the first extent
> > > > > > >    for i in $(seq 1 $nr); do
> > > > > > > -	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize > /dev/null
> > > > > > > +	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize > $tmp1.out
> > > > > > 
> > > > > > $tmp1 isnt defined anywhere.
> > > > > > 
> > > > > > >    done
> > > > > > > 
> > > > > > >    # then call fiemap on that file to test both the shared flag and if
> > > > > > >    # reserved extent mapping search will cause soft lockup
> > > > > > > -$XFS_IO_PROG -c "fiemap -v" $file | _filter_fiemap_flags > $tmp.out
> > > > > > > -cat $tmp.out >> $seqres.full
> > > > > > > +$XFS_IO_PROG -c "fiemap -v" $file | _filter_fiemap_flags > $tmp2.out
> > > > > > > +cat $tmp2.out >> $seqres.full
> > > > > > 
> > > > > > Nor is $tmp2
> > > > > > 
> > > > > > > 
> > > > > > >    # refact the $LOAD_FACTOR to 1 to match the golden output
> > > > > > >    sed -i -e "s/$(($last_extent - 1))/$(($orig_last_extent - 1))/" \
> > > > > > >    	-e "s/$last_extent/$orig_last_extent/" \
> > > > > > > -	-e "s/$end/$orig_end/" $tmp.out
> > > > > > > -cat $tmp.out
> > > > > > > +	-e "s/$end/$orig_end/" $tmp2.out
> > > > > > > +
> > > > > > > +cat $tmp1.out > tmp.1
> > > > > > > +cat $tmp2.out > tmp.2
> > > > > > 
> > > > > > Not sure why you didn't make the _reflink_range and the fiemap above
> > > > > > output to $tmp.out1 and $tmp.out2, respectively.  If you had, then the
> > > > > > default _cleanup would delete $tmp.* automatically...
> > > > > > 
> > > > > > > +
> > > > > > > +diff tmp.[12]
> > > > > > > +rm tmp.1
> > > > > > > +rm tmp.2
> > > > > > 
> > > > > > ...and the rm here wouldn't be necessary.
> > > > > > 
> > > > > > Ok.  Nitpicking over.  Moving on to the weirder design questions of the
> > > > > > original test:
> > > > > > 
> > > > > > [add original test author to cc]
> > > > > 
> > > > > Emails to quwenruo@cn.fujitsu.com seem to be undeliverable. Maybe Joseph
> > > > > would know what btrfs intent was?
> > > > 
> > > > ...or I guess I could have used the current email addr instead of the
> > > > one on the commit. :(
> > > > 
> > > > Qu: Question for you:
> > > 
> > > Thanks a lot for referring it to me.
> > > 
> > > > 
> > > > > > I don't know why $blocksize is set to 128k above.  If this test needs to
> > > > > > guarantee that there would only be *one* extent (and the golden output
> > > > > > implies this as you note), then it should have been written to say:
> > > > > > 
> > > > > > 	blocksize=$(_get_file_block_size $SCRATCH_MNT)
> > > > > > 
> > > > > > But I don't know if the "btrfs soft lock up and return wrong shared
> > > > > > flag" behavior required sharing a (probably multi-block) 128k range, or
> > > > > > if that was simply what the author selected because it reproduced the
> > > > > > problem.
> > > 
> > > It's quite sometime ago, thus my memory may not be reliable, but IIRC
> > > the blocksize has no specific requirement other than allowing all
> > > possible blocksize (4K to 64K).
> > > 
> > > And at that time, at least I was preferring to use golden output to
> > > detect errors, thus I choose a larger blocksize to allow all blocksizes
> > > to work.
> > > 
> > > > 
> > > > Any thoughts?
> > > > 
> > > > --D
> > > > 
> > > > > > 
> > > > > > > 
> > > > > > >    # success, all done
> > > > > > >    status=0
> > > > > > > diff --git a/tests/generic/352.out b/tests/generic/352.out
> > > > > > > index 4ff66c21..ad90ae0d 100644
> > > > > > > --- a/tests/generic/352.out
> > > > > > > +++ b/tests/generic/352.out
> > > > > > > @@ -1,5 +1,3 @@
> > > > > > >    QA output created by 352
> > > > > > >    wrote 131072/131072 bytes at offset 0
> > > > > > >    XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > > > > > -0: [0..2097151]: shared
> > > > > > > -1: [2097152..2097407]: shared|last
> > > > > > 
> > > > > > Also I suspect from the test description that the goal here was to
> > > > > > detect the golden output failing because the shared flag does not get
> > > > > > reported correctly.
> > > 
> > > Could explain more on why the shared flag detection is not correct here?
> > > 
> > > If a file extent is shared, no matter if it's shared by another inode or
> > > not, shouldn't it be marked with SHARED flag?
> > > 
> > > Thanks,
> > > Qu
> > > 
> > > > > > 
> > > > > > --D
> > > > > > > --
> > > > > > > 2.41.0
> > > > > > > 
> > > > > > 
> > > > > 
> > > 
> > 
> 

