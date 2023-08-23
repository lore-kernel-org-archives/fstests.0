Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A46C7113B
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Aug 2023 19:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjHWT5V (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Aug 2023 15:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjHWT4y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Aug 2023 15:56:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A759610F3
        for <fstests@vger.kernel.org>; Wed, 23 Aug 2023 12:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692820555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VUXIAj89O9hSlk+oBaqdijhpCOgroAcIqdpKMDxyknw=;
        b=epHMFEbGBH0hI0CU1zvJU8EW+Sgqc7XEu5j1O9qC4bn741euHE3cvTdRkbIItEcT7KswTF
        qzUmt9GMu9wlRsBUpmrJ9timRVp91aeOlw93i7n0bt9LAaYAGd/NdvDt3hrTAgqWYUNCPJ
        hMG28E0ZNdaM5xvksGemp7weFIOpfCM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-_T4t0o-hNVyFu6DOig4onQ-1; Wed, 23 Aug 2023 15:55:52 -0400
X-MC-Unique: _T4t0o-hNVyFu6DOig4onQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 162303C025B5;
        Wed, 23 Aug 2023 19:55:52 +0000 (UTC)
Received: from redhat.com (unknown [10.22.16.107])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D179D140E950;
        Wed, 23 Aug 2023 19:55:51 +0000 (UTC)
Date:   Wed, 23 Aug 2023 14:55:50 -0500
From:   Bill O'Donnell <bodonnel@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, quwenruo@cn.fujitsu.com
Subject: Re: [PATCH] fstests: generic/352 should accomodate other pwrite
 behaviors
Message-ID: <ZOZkRkAliLCTOzdI@redhat.com>
References: <20230823154350.18829-1-bodonnel@redhat.com>
 <20230823164641.GA11251@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823164641.GA11251@frogsfrogsfrogs>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 23, 2023 at 09:46:41AM -0700, Darrick J. Wong wrote:
> On Wed, Aug 23, 2023 at 10:43:50AM -0500, Bill O'Donnell wrote:
> > xfs_io pwrite issues a series of block size writes, but there is no guarantee
> > that the resulting extent(s) will be singular or contiguous. This behavior is
> > acceptable, but the test is flawed in that it expects a single extent for a
> > pwrite.
> > 
> > Modify test to accept any layout for the reflinked logical range.
> > 
> > Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>
> > ---
> >  tests/generic/352     | 16 +++++++++++-----
> >  tests/generic/352.out |  2 --
> >  2 files changed, 11 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tests/generic/352 b/tests/generic/352
> > index 52ec4850..c4ee8a44 100755
> > --- a/tests/generic/352
> > +++ b/tests/generic/352
> > @@ -48,19 +48,25 @@ _pwrite_byte 0xcdcdcdcd 0 $blocksize $file | _filter_xfs_io
> >  # use reflink to create the rest of the file, whose all extents are all
> >  # pointing to the first extent
> >  for i in $(seq 1 $nr); do
> > -	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize > /dev/null
> > +	_reflink_range $file 0 $file $(($i * $blocksize)) $blocksize > $tmp1.out
> 
> $tmp1 isnt defined anywhere.
> 
> >  done
> >  
> >  # then call fiemap on that file to test both the shared flag and if
> >  # reserved extent mapping search will cause soft lockup
> > -$XFS_IO_PROG -c "fiemap -v" $file | _filter_fiemap_flags > $tmp.out
> > -cat $tmp.out >> $seqres.full
> > +$XFS_IO_PROG -c "fiemap -v" $file | _filter_fiemap_flags > $tmp2.out
> > +cat $tmp2.out >> $seqres.full
> 
> Nor is $tmp2

Do $tmp1 and $tmp2 actually need to be declared?

> 
> >  
> >  # refact the $LOAD_FACTOR to 1 to match the golden output
> >  sed -i -e "s/$(($last_extent - 1))/$(($orig_last_extent - 1))/" \
> >  	-e "s/$last_extent/$orig_last_extent/" \
> > -	-e "s/$end/$orig_end/" $tmp.out
> > -cat $tmp.out
> > +	-e "s/$end/$orig_end/" $tmp2.out
> > +
> > +cat $tmp1.out > tmp.1
> > +cat $tmp2.out > tmp.2
> 
> Not sure why you didn't make the _reflink_range and the fiemap above
> output to $tmp.out1 and $tmp.out2, respectively.  If you had, then the
> default _cleanup would delete $tmp.* automatically...
> 
> > +
> > +diff tmp.[12]
> > +rm tmp.1
> > +rm tmp.2
> 
> ...and the rm here wouldn't be necessary.

But how to [diff $tmp.out1 $tmp.out2]? I don't see that working.

> 
> Ok.  Nitpicking over.  Moving on to the weirder design questions of the
> original test:
> 
> [add original test author to cc]
> 
> I don't know why $blocksize is set to 128k above.  If this test needs to
> guarantee that there would only be *one* extent (and the golden output
> implies this as you note), then it should have been written to say:
> 
> 	blocksize=$(_get_file_block_size $SCRATCH_MNT)
> 
> But I don't know if the "btrfs soft lock up and return wrong shared
> flag" behavior required sharing a (probably multi-block) 128k range, or
> if that was simply what the author selected because it reproduced the
> problem.
> 
> >  
> >  # success, all done
> >  status=0
> > diff --git a/tests/generic/352.out b/tests/generic/352.out
> > index 4ff66c21..ad90ae0d 100644
> > --- a/tests/generic/352.out
> > +++ b/tests/generic/352.out
> > @@ -1,5 +1,3 @@
> >  QA output created by 352
> >  wrote 131072/131072 bytes at offset 0
> >  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > -0: [0..2097151]: shared
> > -1: [2097152..2097407]: shared|last
> 
> Also I suspect from the test description that the goal here was to
> detect the golden output failing because the shared flag does not get
> reported correctly.

That's my interpretation as well.

Thanks-
Bill


> 
> --D
> > -- 
> > 2.41.0
> > 
> 

