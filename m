Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20270C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 13 May 2022 05:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiEMFKD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 13 May 2022 01:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiEMFKC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 13 May 2022 01:10:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 018822854A9
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 22:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652418599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jsNFGzxts9gLtq8OHgRwKStoV+rpdrA8Tiouy/Yy0/k=;
        b=NHK2QANK+F8B6OMFXe8psxgD3H90g323UoWLiCD2QJHJL6B8wHeagpfHRkPawTpY6SQTuH
        CJKPUuPZyEwngZSNJlAxj5jSmf9ygnP9HO+6yQ3VMrxw/fY+AOUaUffoJFhgzPinOoWPOA
        Lgedtil5/hl0xYHIvdqVDfbQvZ9WdLM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-NDRBAImfMJ-H-k_9qD2kVg-1; Fri, 13 May 2022 01:09:58 -0400
X-MC-Unique: NDRBAImfMJ-H-k_9qD2kVg-1
Received: by mail-qt1-f200.google.com with SMTP id i11-20020ac85e4b000000b002f3d8c3a96dso5515106qtx.9
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 22:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=jsNFGzxts9gLtq8OHgRwKStoV+rpdrA8Tiouy/Yy0/k=;
        b=vs7F6Mzo6SoBgg1awxemCfohudByk7ekiGBpCFERnd3ICcUz57qbmDmzVVLvKbfGso
         32zB7OLpi0gE5Rwr0j0WsrCC8aRawI1WN211iUXcfko4cExcNcAfVvCuTz8D8mpRhOEZ
         VABBs5Epcx2xwasjKBvFytjcTNHeV2d4dP8boNlfTIVngsg+z775Y3R3ehJaoytaD+I5
         6noDvIPlt3XpDskR/kDT6e7vNthkGeotc7+LDa5rshWp/xRrHssmmDMgfnlI8czUyEdF
         A2+KSfZjRVHI8cykm9cxQdUG98GNTyVSzo9sl9a4GcipBjBs6ritePGOuCniKKw21TL5
         eg8Q==
X-Gm-Message-State: AOAM533EkmdGt/q7o7HomSQsx96FU1LQ6gwvXZniaBFXvGMPO2DUlEA/
        +Ar7M3o7crUxPOAesEQwC8Wn4N96LDiD/f2jIG6J2mNdq+GM6siZLE9DwoaN3VwL1oZhhleqcyY
        xZr6dgpfLACWnkKjCHA==
X-Received: by 2002:ac8:580c:0:b0:2f3:ec02:80ba with SMTP id g12-20020ac8580c000000b002f3ec0280bamr3013932qtg.162.1652418597884;
        Thu, 12 May 2022 22:09:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRUoR9SZ8kF73+IrQPHSnak6kOBN3L9dud5k3PVK8GRN7ukzLsNuf25IxexLr9449g49DJlA==
X-Received: by 2002:ac8:580c:0:b0:2f3:ec02:80ba with SMTP id g12-20020ac8580c000000b002f3ec0280bamr3013923qtg.162.1652418597621;
        Thu, 12 May 2022 22:09:57 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l26-20020a37f91a000000b006a0ff3ec18bsm851720qkj.122.2022.05.12.22.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 22:09:56 -0700 (PDT)
Date:   Fri, 13 May 2022 13:09:51 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3 1/2] generic: soft quota limits testing within grace
 time
Message-ID: <20220513050951.ealqnhg6bgp4io4e@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        fstests@vger.kernel.org
References: <20220512182203.2839593-1-zlang@kernel.org>
 <20220512190647.GC27174@magnolia>
 <20220512201651.yvi3hiwkln3dgojs@zlang-mailbox>
 <20220513005814.GE27174@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513005814.GE27174@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 12, 2022 at 05:58:14PM -0700, Darrick J. Wong wrote:
> On Fri, May 13, 2022 at 04:16:51AM +0800, Zorro Lang wrote:
> > On Thu, May 12, 2022 at 12:06:47PM -0700, Darrick J. Wong wrote:
> > > On Fri, May 13, 2022 at 02:22:02AM +0800, Zorro Lang wrote:
> > > > After soft limits are exceeded, within the grace time, fs quota
> > > > should allow more space allocation before exceeding hard limits,
> > > > even if allocating many small files.
> > > > 
> > > > This case can cover bc37e4fb5cac (xfs: revert "xfs: actually bump
> > > > warning counts when we send warnings"). And will help to expose
> > > > later behavior changes on this side.
> > > > 
> > > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > > ---
> > > > 
> > > > According to the review points of:
> > > >   https://lore.kernel.org/fstests/20220511163806.uc4z7td2remhdru3@zlang-mailbox/T/#m23940b47261165a0442c7ae1eb4d96a1489a2935
> > > > V3 did below changes:
> > > > 1) fix some comments description
> > > > 2) add a few hard limit test
> > > > 3) And bring in [PATCH 2/2], to help g/603 to use the common functions of this
> > > >    patch.
> > > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > >  common/quota          | 48 +++++++++++++++++++++
> > > >  tests/generic/999     | 99 +++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/generic/999.out |  2 +
> > > >  3 files changed, 149 insertions(+)
> > > >  create mode 100755 tests/generic/999
> > > >  create mode 100644 tests/generic/999.out
> > > > 
> > 
> > [snip]
> > 
> > > > +
> > > > +	setquota -${type} $qa_user 1M 200M 0 0 $SCRATCH_MNT
> > > > +	setquota -${type} -t 86400 86400 $SCRATCH_MNT
> > > > +	repquota -v -${type} $SCRATCH_MNT | grep -v "^root" >>$seqres.full 2>&1
> > > > +	# Exceed the soft quota limit a bit at first
> > > > +	su $qa_user -c "$XFS_IO_PROG -f -t -c 'pwrite 0 2m' -c fsync ${file}.0" >>$seqres.full 2>&1
> > > > +	# Write more data more times under soft quota limit exhausted condition,
> > > > +	# but not reach hard limit. To make sure each write won't trigger EDQUOT.
> > > > +	for ((i=1; i<=100; i++));do
> > > > +		su "$qa_user" -c "$XFS_IO_PROG -f -c 'pwrite 0 1m' -c fsync ${file}.$i" >>$seqres.full 2>&1
> > > 
> > > Hmm -- if pwrite or fsync hit an error, shouldn't we let that end up in
> > > 999.out so that the golden output diff fails?
> > 
> > Sure, will remove the "2>&1".
> > 
> > > 
> > > > +		if [ $? -ne 0 ];then
> > > > +			echo "Unexpected error (type=$type)!"
> > > > +			break
> > > > +		fi
> > > > +	done
> > > > +	repquota -v -${type} $SCRATCH_MNT | grep -v "^root" >>$seqres.full 2>&1
> > > > +
> > > > +	# As we've tested soft limit, now exceed the hard limit and give it a
> > > > +	# test in passing.
> > > > +	su $qa_user -c "$XFS_IO_PROG -f -t -c 'pwrite 0 100m' -c fsync ${file}.hard.0" >>$seqres.full 2>&1
> > > > +	for ((i=1; i<=10; i++));do
> > > > +		su "$qa_user" -c "$XFS_IO_PROG -f -c 'pwrite 0 1m' -c fsync ${file}.hard.$i" >>$seqres.full 2>&1
> > > 
> > > Don't we want to encode the actual error in the golden output?
> > 
> > Hmm... due to I have to filter the ENOSPC or EDQUOT output again for project
> > quota, as I did in generic/603 :-P Or put the that function into common/quota
> > too.
> 
> I think it'd be fine if the golden output contained:
> 
> pwrite: Insufficient quota
> pwrite: Insufficient quota
> pwrite: Not enough space

Sorry I didn't explain that clearly :)

When FSTYP=ext4, it got:
pwrite: Disk quota exceeded
pwrite: Disk quota exceeded
pwrite: Disk quota exceeded
...

When FSTYP=xfs, it got:
SCRATCH_MNT/testfile.hard.1: Disk quota exceeded
SCRATCH_MNT/testfile.hard.1: Disk quota exceeded
SCRATCH_MNT/t/testfile.hard.1: No space left on device
...

There're 2 differences:
1) ext4 fails on write -- "-c pwrite", but xfs fails on open(O_CREAT) -- "xfs_io -f"
2) For project quota, xfs returns ENOSPC, ext4 returns EDQUOT.

If these're all as expected, I need to filter these differences. And I don't
know what other filesystems will print, besides xfs and ext4.

Thanks,
Zorro

> 
> for each of the user/group/project quota tests.  Or did I misunderstand?
> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > 
> > > --D
> > > 
> > > > +		if [ $? -eq 0 ];then
> > > > +			echo "Unexpected success (type=$type)!"
> > > > +			break
> > > > +		fi
> > > > +	done
> > > > +}
> > > > +
> > > > +_qmount_option "usrquota"
> > > > +exercise u
> > > > +_qmount_option "grpquota"
> > > > +exercise g
> > > > +_qmount_option "prjquota"
> > > > +exercise P
> > > > +
> > > > +echo "Silence is golden"
> > > > +# success, all done
> > > > +status=0
> > > > +exit
> > > > diff --git a/tests/generic/999.out b/tests/generic/999.out
> > > > new file mode 100644
> > > > index 00000000..3b276ca8
> > > > --- /dev/null
> > > > +++ b/tests/generic/999.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 999
> > > > +Silence is golden
> > > > -- 
> > > > 2.31.1
> > > > 
> > > 
> 

