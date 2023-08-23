Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30BFC71145
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Aug 2023 22:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjHWW2c (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Aug 2023 18:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238597AbjHWW16 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Aug 2023 18:27:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925AAE6F
        for <fstests@vger.kernel.org>; Wed, 23 Aug 2023 15:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B99562D9F
        for <fstests@vger.kernel.org>; Wed, 23 Aug 2023 22:27:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB2EC433C7;
        Wed, 23 Aug 2023 22:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692829675;
        bh=a7nYQH7jMo/oNjnGgEOvM/GAPDEwVSVduC83IUm4kAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kVyVRJRIXFFW2h+pFgcIWX7fc3WhrwScqQhdlL6XeLqnHfEz6YVFAT/AqSImO01iL
         N7uLmi7+FTa9p/nytKMsJn9SRo8NPJNIwsmCxxeVbVQ/K+NoXUPMiOlDSHjE5GWYfw
         xy67L3OTiI/efT9SMJWy5M56h73h9NtLsQdPPAiXbP8GZOv+5FZqu+yMHjj/L1V2/t
         QRf3EEUwf2K98r9BQjxkOtMeVqcJQF5xrSE95Vjv13ddDT174/oUB6oEo+pf+UbMY8
         b8g0kedhz0myzPQX6JRI04D7gZbSFdSHdquQswtq8MQm1cyulznpk3ZDtZDpJOQErI
         tMlEgX66EXc2g==
Date:   Wed, 23 Aug 2023 15:27:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Bill O'Donnell <bodonnel@redhat.com>
Cc:     fstests@vger.kernel.org, wqu@suse.com
Subject: Re: [PATCH] fstests: generic/352 should accomodate other pwrite
 behaviors
Message-ID: <20230823222754.GB11251@frogsfrogsfrogs>
References: <20230823154350.18829-1-bodonnel@redhat.com>
 <20230823164641.GA11251@frogsfrogsfrogs>
 <ZOaFmhnUAM9gjNFv@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOaFmhnUAM9gjNFv@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 23, 2023 at 05:18:02PM -0500, Bill O'Donnell wrote:
> On Wed, Aug 23, 2023 at 09:46:41AM -0700, Darrick J. Wong wrote:
> > On Wed, Aug 23, 2023 at 10:43:50AM -0500, Bill O'Donnell wrote:
> > > xfs_io pwrite issues a series of block size writes, but there is no guarantee
> > > that the resulting extent(s) will be singular or contiguous. This behavior is
> > > acceptable, but the test is flawed in that it expects a single extent for a
> > > pwrite.
> > > 
> > > Modify test to accept any layout for the reflinked logical range.
> > > 
> > > Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> > > ---
> > >  tests/generic/352     | 16 +++++++++++-----
> > >  tests/generic/352.out |  2 --
> > >  2 files changed, 11 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/tests/generic/352 b/tests/generic/352
> > > index 52ec4850..c4ee8a44 100755
> > > --- a/tests/generic/352
> > > +++ b/tests/generic/352
> > > @@ -48,19 +48,25 @@ _pwrite_byte 0xcdcdcdcd 0 $blocksize $file | _filter_xfs_io
> > >  # use reflink to create the rest of the file, whose all extents are all
> > >  # pointing to the first extent
> > >  for i in $(seq 1 $nr); do
> > > -	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize > /dev/null
> > > +	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize > $tmp1.out
> > 
> > $tmp1 isnt defined anywhere.
> > 
> > >  done
> > >  
> > >  # then call fiemap on that file to test both the shared flag and if
> > >  # reserved extent mapping search will cause soft lockup
> > > -$XFS_IO_PROG -c "fiemap -v" $file | _filter_fiemap_flags > $tmp.out
> > > -cat $tmp.out >> $seqres.full
> > > +$XFS_IO_PROG -c "fiemap -v" $file | _filter_fiemap_flags > $tmp2.out
> > > +cat $tmp2.out >> $seqres.full
> > 
> > Nor is $tmp2
> > 
> > >  
> > >  # refact the $LOAD_FACTOR to 1 to match the golden output
> > >  sed -i -e "s/$(($last_extent - 1))/$(($orig_last_extent - 1))/" \
> > >  	-e "s/$last_extent/$orig_last_extent/" \
> > > -	-e "s/$end/$orig_end/" $tmp.out
> > > -cat $tmp.out
> > > +	-e "s/$end/$orig_end/" $tmp2.out
> > > +
> > > +cat $tmp1.out > tmp.1
> > > +cat $tmp2.out > tmp.2
> > 
> > Not sure why you didn't make the _reflink_range and the fiemap above
> > output to $tmp.out1 and $tmp.out2, respectively.  If you had, then the
> > default _cleanup would delete $tmp.* automatically...
> > 
> > > +
> > > +diff tmp.[12]
> > > +rm tmp.1
> > > +rm tmp.2
> > 
> > ...and the rm here wouldn't be necessary.
> > 
> > Ok.  Nitpicking over.  Moving on to the weirder design questions of the
> > original test:
> > 
> > [add original test author to cc]
> 
> Emails to quwenruo@cn.fujitsu.com seem to be undeliverable. Maybe Joseph
> would know what btrfs intent was?

...or I guess I could have used the current email addr instead of the
one on the commit. :(

Qu: Question for you:

> > I don't know why $blocksize is set to 128k above.  If this test needs to
> > guarantee that there would only be *one* extent (and the golden output
> > implies this as you note), then it should have been written to say:
> > 
> > 	blocksize=$(_get_file_block_size $SCRATCH_MNT)
> > 
> > But I don't know if the "btrfs soft lock up and return wrong shared
> > flag" behavior required sharing a (probably multi-block) 128k range, or
> > if that was simply what the author selected because it reproduced the
> > problem.

Any thoughts?

--D

> > 
> > >  
> > >  # success, all done
> > >  status=0
> > > diff --git a/tests/generic/352.out b/tests/generic/352.out
> > > index 4ff66c21..ad90ae0d 100644
> > > --- a/tests/generic/352.out
> > > +++ b/tests/generic/352.out
> > > @@ -1,5 +1,3 @@
> > >  QA output created by 352
> > >  wrote 131072/131072 bytes at offset 0
> > >  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > -0: [0..2097151]: shared
> > > -1: [2097152..2097407]: shared|last
> > 
> > Also I suspect from the test description that the goal here was to
> > detect the golden output failing because the shared flag does not get
> > reported correctly.
> > 
> > --D
> > > -- 
> > > 2.41.0
> > > 
> > 
> 
