Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148B9C7EE24
	for <linux-fstests@archiver.kernel.org>; Fri,  2 Jun 2023 10:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbjFBKpg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbjFBKpf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 2 Jun 2023 06:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FDE1A7
        for <fstests@vger.kernel.org>; Fri,  2 Jun 2023 03:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685702670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8fLx5nqYFdoi4aYNs+x7GThtndsgT56ngBP2dvtkN8E=;
        b=NcbvG7i2EHDIRZ4/i0/8aRB3NAAHzHqTUDC2x2iVkYC8nKvbK82uzeUiXf43Z/hUBJbCm7
        uqiiVXm8RHmpjGHa/8Q0ISwEEA1AQDsHxbqwQu7allZHqcjdzvJwljdSyKyElbIHGTzWPO
        fo27Mxn0SwBt39lBPPFiFswiv7GAtUg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-k2rkKjebOm6fTI-1yBM0ew-1; Fri, 02 Jun 2023 06:44:29 -0400
X-MC-Unique: k2rkKjebOm6fTI-1yBM0ew-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-53feeb13906so1895912a12.1
        for <fstests@vger.kernel.org>; Fri, 02 Jun 2023 03:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685702668; x=1688294668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fLx5nqYFdoi4aYNs+x7GThtndsgT56ngBP2dvtkN8E=;
        b=CKP9WRgr0rD45vjUrodDTrWqkecTRsiRPfv6S+QDGqHW3MtXzWCZPUI5z7wxHn9lq8
         tp1ObWuCd8X9VSU2K4AASk9qOiywfeuzPY3O9VbJ1IybnbETAXy+fIPpGtqFxoUEOzjG
         R8wgqGUQshlKxexnkEb84m7+e7L8DlC4ptFjPDQ3ZgOes7pPjshmT0ZgR0Xd6e0aF76B
         9xC74u92RLW2rJOT8qZ5G4bHnUhfVnMXx4RAA0ZMSBSmZesPxTQyoYNnFlb+JTSxpOCl
         7ZzpwnRjG0BzFPqpnRYwOmuPLVag1wgjvrGmj+uBW/dGWUvzZc2YysZo16AbZ6/eKQNy
         pT3Q==
X-Gm-Message-State: AC+VfDzbDuq/F7+QpKK2AhGDRnN2fFGX/DMK4KJ+/iNldh33r5Y8Kz1k
        zAuecC58b37+fjePaJFX/yyD/aHR2OMvZirkUZttMvJz/yCOlvhr7i7SwpFuOGbyIdXD7tkPFpH
        dFTFAhrf7mYZGzZ+J5nub+lMRPeIH
X-Received: by 2002:a05:6a20:2447:b0:10f:708b:bb28 with SMTP id t7-20020a056a20244700b0010f708bbb28mr15467891pzc.7.1685702668560;
        Fri, 02 Jun 2023 03:44:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zcs35WlygjcqM3qNbA6yN0KQewmxv1tapU743ighcI0+obZvWnGEh3crP6auu1pvwofZkhw==
X-Received: by 2002:a05:6a20:2447:b0:10f:708b:bb28 with SMTP id t7-20020a056a20244700b0010f708bbb28mr15467869pzc.7.1685702668164;
        Fri, 02 Jun 2023 03:44:28 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e11-20020a63544b000000b0051b9e82d6d6sm944517pgm.40.2023.06.02.03.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:44:27 -0700 (PDT)
Date:   Fri, 2 Jun 2023 18:44:24 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Carlos Maiolino <cem@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] xfstests: Enable _test_mkfs to force a mkfs on a xfs
 filesystem
Message-ID: <20230602104424.bb4dww6zws7xsiyo@zlang-mailbox>
References: <20230524134207.38224-1-cem@kernel.org>
 <20230524151650.GC11607@frogsfrogsfrogs>
 <20230525043605.hxivdzodlh7vvpow@zlang-mailbox>
 <20230525191312.GE11607@frogsfrogsfrogs>
 <BMAB3h6IL8VKaU10gncYx4R6Qf91YQY_Mocd2xrurFWPhuLRtK7fwvd8H9xoeCA_GhaOLUaoSPETJRd1hGHgfw==@protonmail.internalid>
 <20230526195234.soug6nwxho5rkinq@zlang-mailbox>
 <20230529075839.myw65y56r46j6sun@andromeda>
 <20230602011535.GC16856@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602011535.GC16856@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 01, 2023 at 06:15:35PM -0700, Darrick J. Wong wrote:
> On Mon, May 29, 2023 at 09:58:39AM +0200, Carlos Maiolino wrote:
> > On Sat, May 27, 2023 at 03:52:34AM +0800, Zorro Lang wrote:
> > > On Thu, May 25, 2023 at 12:13:12PM -0700, Darrick J. Wong wrote:
> > > > On Thu, May 25, 2023 at 12:36:05PM +0800, Zorro Lang wrote:
> > > > > On Wed, May 24, 2023 at 08:16:50AM -0700, Darrick J. Wong wrote:
> > > > > > On Wed, May 24, 2023 at 03:42:07PM +0200, cem@kernel.org wrote:
> > > > > > > From: Carlos Maiolino <cmaiolino@redhat.com>
> > > > > > >
> > > > > > > Calling _test_mkfs on an already initialized xfs FS will fail as the
> > > > > > > initialization is not enforced by '-f' argument, unless it's included in
> > > > > > > MKFS_OPTIONS.
> > > > > > > So, adding 'RECREATE_TEST_DEV=true' to the config file end up being useless
> > > > > > > for xfs filesystems.
> > > > > > >
> > > > > > > So, adding the a specific xfs optiong in _test_mkfs using -f argument
> > > > > > > makes RECREATE_TEST_DEV actually useful.
> > > > > > >
> > > > > > > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > > > > >
> > > > > > Makese sense to me,
> > > > > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > > >
> > > > > Hi Darrick,
> > > > >
> > > > > I just noticed that there's not any place use "_test_options mkfs", I remembered
> > > > > SCRATCH_DEV support rtdev and logdev, the TEST_DEV looks not support that, but
> > > > > the "_test_options()" looks like hoping to support.
> > > >
> > > > Hmmm, that's a very good point -- _test_mkfs() fails to format a test
> > > > filesystem with external logs or rt volumes even if the config specified
> > > > that.  Perhaps change the patch to add:
> > > >
> > > >     xfs)
> > > >         _test_options mkfs
> > > 
> > > Current _test_options() only works for xfs, it returns directly if FSTYP != XFS.
> > > It more likes a _test_xfs_options. We don't have _test_$FSTYP_options() function,
> > > so if we'd like to have a common _test_options(), I think we should deal with
> > > fs specific things in _test_options() inside, then call _test_options once before
> > > the "case $FSTYP in ...".
> > 
> > This seems fine, I'm short on time these days, I'll try to find some time to
> > work on this.
> > 
> > But in meantime, wouldn't it required the '-f' option to be passed to mkfs.xfs
> > anyway? Calling _test_options before 'case $FSTYP ...' will still require use to
> > call mkfs.xfs -f, so, can't the initial patch be applied already? If Darrick's
> > updated solution isn't good enough for now, the original patch will fix at
> > least part of the problem (without external log/rtdev cases) right away.
> 
> Yes, let's please get at least the bare fix merged.

OK, we can have this fix at first, then think about _test_options in another
patch.

Thanks,
Zorro

> 
> --D
> 
> > -- 
> > Carlos
> > 
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > > >         $MKFS_XFS_PROG -f $TEST_OPTIONS $MKFS_OPTIONS $* $TEST_DEV
> > > >         ;;
> > > >
> > > > Does that look right?
> > > >
> > > > --D
> > > >
> > > > > Thanks,
> > > > > Zorro
> > > > >
> > > > > >
> > > > > > --D
> > > > > >
> > > > > > > ---
> > > > > > >  common/rc | 3 +++
> > > > > > >  1 file changed, 3 insertions(+)
> > > > > > >
> > > > > > > diff --git a/common/rc b/common/rc
> > > > > > > index 37074371..dd5d7bc1 100644
> > > > > > > --- a/common/rc
> > > > > > > +++ b/common/rc
> > > > > > > @@ -605,6 +605,9 @@ _test_mkfs()
> > > > > > >      ext2|ext3|ext4)
> > > > > > >  	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
> > > > > > >  	;;
> > > > > > > +    xfs)
> > > > > > > +	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* $TEST_DEV
> > > > > > > +	;;
> > > > > > >      *)
> > > > > > >  	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
> > > > > > >  	;;
> > > > > > > --
> > > > > > > 2.30.2
> > > > > > >
> > > > > >
> > > > >
> > > >
> > > 
> 

