Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8773EC433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 21:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349300AbiEPVP0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 17:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349364AbiEPVPR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 17:15:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D141704C
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 14:09:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 764B5B81675
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 21:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD7AC34100;
        Mon, 16 May 2022 21:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652735395;
        bh=TbRBOOrEb/zE+DFf5syoCjsUzBY7pgSPCOfSy/hbtiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OUGIM2eaBMHcIZEDwgrjn/q5LGs/fG4NqJQiTT9ubWVGU0n3nj+hr9jj738ZkWVPx
         FSRVb8govwk1veH5lE2O8cbnx1o+s3PXjxV/Fk6lFZU/Q7nr3fBfoL/mJX3XdeqH43
         PPQheMCOOSynU00Ci7RU69XHUI0pWduzwWo5UpS6lioVulPQhxNUcvEo69zIPnHN8r
         LUpTHPWDs3n0JOw5L3gBhx7XDk+PBzjmHClPqAabDQgIZO6+id63R9YSFqw/6UHAW3
         smcL+3U6MtGnE9C1nGiJJBzr1cVIsXqR0AzJ9WkoAb73ZtTBvpJqWvSs9KQ48y5UzQ
         51VBiWv7DDgQw==
Date:   Mon, 16 May 2022 14:09:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/3] fstests: filter quota warnings
Message-ID: <YoK9okOa5PPSg1wy@magnolia>
References: <20220516060807.1295102-1-david@fromorbit.com>
 <20220516060807.1295102-2-david@fromorbit.com>
 <YoJtGrvDeeOmvFw0@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoJtGrvDeeOmvFw0@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 16, 2022 at 08:26:18AM -0700, Darrick J. Wong wrote:
> On Mon, May 16, 2022 at 04:08:05PM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Quota warning code has been removed from the upstream kernel and now
> > returns -EINVAL errors. Seeing as we can't set warnings anymore and
> > they have always been non-functional in the kernel, just remove the
> > calls to set warnings filter those errors out so those tests pass
> > again.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  tests/xfs/050 | 9 ---------
> >  tests/xfs/153 | 9 ---------
> >  tests/xfs/299 | 9 ---------
> >  3 files changed, 27 deletions(-)
> > 
> > diff --git a/tests/xfs/050 b/tests/xfs/050
> > index 1847611b..2220e470 100755
> > --- a/tests/xfs/050
> > +++ b/tests/xfs/050
> > @@ -84,9 +84,6 @@ _exercise()
> >  	_qsetup $1
> >  
> >  	echo "Using type=$type id=$id" >>$seqres.full
> > -
> > -	$XFS_QUOTA_PROG -x -c "warn -$type 65535 -d" $SCRATCH_DEV
> > -
> >  	echo
> >  	echo "*** report no quota settings" | tee -a $seqres.full
> >  	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> > @@ -113,7 +110,6 @@ _exercise()
> >  	_file_as_id $SCRATCH_MNT/softie3 $id $type 1024 0
> >  	_file_as_id $SCRATCH_MNT/softie4 $id $type 1024 0
> >  	_qmount
> > -	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" $SCRATCH_DEV
> 
> I don't think we can revert this line from commit e5bbd47e
> ("xfs/{050,299}: clear quota warnings in between checks") because any
> kernel released in the past two years will increment the warning
> counter, and not resetting it to zero between tests means the golden
> output will break.
> 
> We could, however, use more sed magic to force the warning counts in the
> repquota output to be zero, which (I think) enables these changes to
> move forward.

...or, redirecting stdout and stderr to /dev/null makes the test pass on
really old, 5.18, and 5.19-next kernels:

	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" $SCRATCH_DEV &>> /dev/null

--D

> --D
> 
> >  	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> >  		-c "repquota -birnN -$type" $SCRATCH_DEV |
> >  		_filter_quota_report | LC_COLLATE=POSIX sort -ru
> > @@ -122,8 +118,6 @@ _exercise()
> >  	echo "*** push past the soft block limit" | tee -a $seqres.full
> >  	_file_as_id $SCRATCH_MNT/softie $id $type $bsize 300
> >  	_qmount
> > -	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" \
> > -		-c "warn -b -$type 0 $id" $SCRATCH_DEV
> >  	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> >  		-c "repquota -birnN -$type" $SCRATCH_DEV |
> >  		_filter_quota_report | LC_COLLATE=POSIX sort -ru
> > @@ -136,8 +130,6 @@ _exercise()
> >  		_file_as_id $SCRATCH_MNT/hard$i $id $type 1024 0
> >  	done
> >  	_qmount
> > -	$XFS_QUOTA_PROG -x  -c "warn -b -$type 0 $id" \
> > -		-c "warn -i -$type 0 $id" $SCRATCH_DEV
> >  	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> >  		-c "repquota -birnN -$type" $SCRATCH_DEV |
> >  		_filter_quota_report | LC_COLLATE=POSIX sort -ru
> > @@ -149,7 +141,6 @@ _exercise()
> >  	echo "ls -l $SCRATCH_MNT" >>$seqres.full
> >  	ls -l $SCRATCH_MNT >>$seqres.full
> >  	_qmount
> > -	$XFS_QUOTA_PROG -x -c "warn -b -$type 0 $id" $SCRATCH_DEV
> >  	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> >  		-c "repquota -birnN -$type" $SCRATCH_DEV |
> >  		_filter_and_check_blks | LC_COLLATE=POSIX sort -ru
> > diff --git a/tests/xfs/153 b/tests/xfs/153
> > index 8e1430c0..dbe26b68 100755
> > --- a/tests/xfs/153
> > +++ b/tests/xfs/153
> > @@ -89,9 +89,6 @@ run_tests()
> >  	_qsetup $1
> >  
> >  	echo "Using type=$type id=$id" >>$seqres.full
> > -
> > -	$XFS_QUOTA_PROG -x -c "warn -$type 65535 -d" $SCRATCH_DEV
> > -
> >  	echo
> >  	echo "*** report no quota settings" | tee -a $seqres.full
> >  	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> > @@ -122,7 +119,6 @@ run_tests()
> >  	_file_as_id $SCRATCH_MNT/softie4 0 $type 1024 0
> >  	_scratch_umount_idmapped
> >  	_qmount
> > -	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" $SCRATCH_DEV
> >  	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> >  		-c "repquota -birnN -$type" $SCRATCH_DEV |
> >  		_filter_quota_report | LC_COLLATE=POSIX sort -ru
> > @@ -133,8 +129,6 @@ run_tests()
> >  	_file_as_id $SCRATCH_MNT/softie 0 $type $bsize 300
> >  	_scratch_umount_idmapped
> >  	_qmount
> > -	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" \
> > -		-c "warn -b -$type 0 $id" $SCRATCH_DEV
> >  	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> >  		-c "repquota -birnN -$type" $SCRATCH_DEV |
> >  		_filter_quota_report | LC_COLLATE=POSIX sort -ru
> > @@ -149,8 +143,6 @@ run_tests()
> >  		_scratch_umount_idmapped
> >  	done
> >  	_qmount
> > -	$XFS_QUOTA_PROG -x  -c "warn -b -$type 0 $id" \
> > -		-c "warn -i -$type 0 $id" $SCRATCH_DEV
> >  	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> >  		-c "repquota -birnN -$type" $SCRATCH_DEV |
> >  		_filter_quota_report | LC_COLLATE=POSIX sort -ru
> > @@ -164,7 +156,6 @@ run_tests()
> >  	echo "ls -l $SCRATCH_MNT" >>$seqres.full
> >  	ls -l $SCRATCH_MNT >>$seqres.full
> >  	_qmount
> > -	$XFS_QUOTA_PROG -x -c "warn -b -$type 0 $id" $SCRATCH_DEV
> >  	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> >  		-c "repquota -birnN -$type" $SCRATCH_DEV |
> >  		_filter_and_check_blks | LC_COLLATE=POSIX sort -ru
> > diff --git a/tests/xfs/299 b/tests/xfs/299
> > index a3077b0c..4b9df3c6 100755
> > --- a/tests/xfs/299
> > +++ b/tests/xfs/299
> > @@ -70,9 +70,6 @@ _exercise()
> >  	_qsetup $1
> >  
> >  	echo "Using type=$type id=$id" >>$seqres.full
> > -
> > -	$XFS_QUOTA_PROG -x -c "warn -$type 65535 -d" $SCRATCH_DEV
> > -
> >  	echo
> >  	echo "*** report no quota settings" | tee -a $seqres.full
> >  	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> > @@ -99,7 +96,6 @@ _exercise()
> >  	_file_as_id $SCRATCH_MNT/softie3 $id $type 1024 0
> >  	_file_as_id $SCRATCH_MNT/softie4 $id $type 1024 0
> >  	_qmount
> > -	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" $SCRATCH_DEV
> >  	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> >  		-c "repquota -birnN -$type" $SCRATCH_DEV |
> >  		_filter_quota_report | LC_COLLATE=POSIX sort -ru
> > @@ -108,8 +104,6 @@ _exercise()
> >  	echo "*** push past the soft block limit" | tee -a $seqres.full
> >  	_file_as_id $SCRATCH_MNT/softie $id $type $bsize 200
> >  	_qmount
> > -	$XFS_QUOTA_PROG -x -c "warn -i -$type 0 $id" \
> > -		-c "warn -b -$type 0 $id" $SCRATCH_DEV
> >  	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> >  		-c "repquota -birnN -$type" $SCRATCH_DEV |
> >  		_filter_quota_report | LC_COLLATE=POSIX sort -ru
> > @@ -122,8 +116,6 @@ _exercise()
> >  		_file_as_id $SCRATCH_MNT/hard$i $id $type 1024 0
> >  	done
> >  	_qmount
> > -	$XFS_QUOTA_PROG -x  -c "warn -b -$type 0 $id" \
> > -		-c "warn -i -$type 0 $id" $SCRATCH_DEV
> >  	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> >  		-c "repquota -birnN -$type" $SCRATCH_DEV |
> >  		_filter_quota_report | LC_COLLATE=POSIX sort -ru
> > @@ -135,7 +127,6 @@ _exercise()
> >  	echo "ls -l $SCRATCH_MNT" >>$seqres.full
> >  	ls -l $SCRATCH_MNT >>$seqres.full
> >  	_qmount
> > -	$XFS_QUOTA_PROG -x -c "warn -b -$type 0 $id" $SCRATCH_DEV
> >  	$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> >  		-c "repquota -birnN -$type" $SCRATCH_DEV |
> >  		_filter_and_check_blks | LC_COLLATE=POSIX sort -ru
> > -- 
> > 2.35.1
> > 
