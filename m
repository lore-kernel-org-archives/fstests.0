Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CEFC433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 20:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344761AbiELURA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 16:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244169AbiELUQ7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 16:16:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C0813CA16
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 13:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30048B827F5
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 20:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244CEC385B8;
        Thu, 12 May 2022 20:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652386615;
        bh=wO/0CeXSXX813WlNRKqe4MllZjZK+MhrjEVWc/LDnr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JOMNlxvtcugrfHhQDgaNphzvOBd0kjB2sGmgUaO2JGaLEa+7cp66tuAH4AubLPxKQ
         IIdvMHQsk8SFpx65oLyKuKhAKbnFDFus0yjVqc76Wl0cTkjECTdAhfvzlyx24TvJU+
         x2p5OrLblHJ1rhKbOd5rTGPZpGDFYp/vhcg51Gn/oW1ZF/r7dc4xY9kcHR9N9mytdQ
         ht9K/18A+uECNiRtF45k+wS0uiQUzNkhway0iQpEywCbeHm6AxC1dBufcRPnK79Fr4
         ve50Y+Jrxa04XauTUHGvPx0rFlakQqnHJz4GFLy7U7z83mQAzaYCYO03YX+ETqm2MJ
         2Xj/bwpZDoYAQ==
Date:   Fri, 13 May 2022 04:16:51 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3 1/2] generic: soft quota limits testing within grace
 time
Message-ID: <20220512201651.yvi3hiwkln3dgojs@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        fstests@vger.kernel.org
References: <20220512182203.2839593-1-zlang@kernel.org>
 <20220512190647.GC27174@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512190647.GC27174@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 12, 2022 at 12:06:47PM -0700, Darrick J. Wong wrote:
> On Fri, May 13, 2022 at 02:22:02AM +0800, Zorro Lang wrote:
> > After soft limits are exceeded, within the grace time, fs quota
> > should allow more space allocation before exceeding hard limits,
> > even if allocating many small files.
> > 
> > This case can cover bc37e4fb5cac (xfs: revert "xfs: actually bump
> > warning counts when we send warnings"). And will help to expose
> > later behavior changes on this side.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> > 
> > According to the review points of:
> >   https://lore.kernel.org/fstests/20220511163806.uc4z7td2remhdru3@zlang-mailbox/T/#m23940b47261165a0442c7ae1eb4d96a1489a2935
> > V3 did below changes:
> > 1) fix some comments description
> > 2) add a few hard limit test
> > 3) And bring in [PATCH 2/2], to help g/603 to use the common functions of this
> >    patch.
> > 
> > Thanks,
> > Zorro
> > 
> >  common/quota          | 48 +++++++++++++++++++++
> >  tests/generic/999     | 99 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/999.out |  2 +
> >  3 files changed, 149 insertions(+)
> >  create mode 100755 tests/generic/999
> >  create mode 100644 tests/generic/999.out
> > 

[snip]

> > +
> > +	setquota -${type} $qa_user 1M 200M 0 0 $SCRATCH_MNT
> > +	setquota -${type} -t 86400 86400 $SCRATCH_MNT
> > +	repquota -v -${type} $SCRATCH_MNT | grep -v "^root" >>$seqres.full 2>&1
> > +	# Exceed the soft quota limit a bit at first
> > +	su $qa_user -c "$XFS_IO_PROG -f -t -c 'pwrite 0 2m' -c fsync ${file}.0" >>$seqres.full 2>&1
> > +	# Write more data more times under soft quota limit exhausted condition,
> > +	# but not reach hard limit. To make sure each write won't trigger EDQUOT.
> > +	for ((i=1; i<=100; i++));do
> > +		su "$qa_user" -c "$XFS_IO_PROG -f -c 'pwrite 0 1m' -c fsync ${file}.$i" >>$seqres.full 2>&1
> 
> Hmm -- if pwrite or fsync hit an error, shouldn't we let that end up in
> 999.out so that the golden output diff fails?

Sure, will remove the "2>&1".

> 
> > +		if [ $? -ne 0 ];then
> > +			echo "Unexpected error (type=$type)!"
> > +			break
> > +		fi
> > +	done
> > +	repquota -v -${type} $SCRATCH_MNT | grep -v "^root" >>$seqres.full 2>&1
> > +
> > +	# As we've tested soft limit, now exceed the hard limit and give it a
> > +	# test in passing.
> > +	su $qa_user -c "$XFS_IO_PROG -f -t -c 'pwrite 0 100m' -c fsync ${file}.hard.0" >>$seqres.full 2>&1
> > +	for ((i=1; i<=10; i++));do
> > +		su "$qa_user" -c "$XFS_IO_PROG -f -c 'pwrite 0 1m' -c fsync ${file}.hard.$i" >>$seqres.full 2>&1
> 
> Don't we want to encode the actual error in the golden output?

Hmm... due to I have to filter the ENOSPC or EDQUOT output again for project
quota, as I did in generic/603 :-P Or put the that function into common/quota
too.

Thanks,
Zorro

> 
> --D
> 
> > +		if [ $? -eq 0 ];then
> > +			echo "Unexpected success (type=$type)!"
> > +			break
> > +		fi
> > +	done
> > +}
> > +
> > +_qmount_option "usrquota"
> > +exercise u
> > +_qmount_option "grpquota"
> > +exercise g
> > +_qmount_option "prjquota"
> > +exercise P
> > +
> > +echo "Silence is golden"
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/999.out b/tests/generic/999.out
> > new file mode 100644
> > index 00000000..3b276ca8
> > --- /dev/null
> > +++ b/tests/generic/999.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 999
> > +Silence is golden
> > -- 
> > 2.31.1
> > 
> 
