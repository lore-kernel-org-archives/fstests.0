Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1F4C433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Jul 2022 15:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbiGHPrv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Jul 2022 11:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238439AbiGHPru (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Jul 2022 11:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 057D42F03F
        for <fstests@vger.kernel.org>; Fri,  8 Jul 2022 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657295269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1x7w4B8KkRbbLPOBK5w5COBwCSETd53dAVljfr2ix5E=;
        b=C7xHDIYT+4Lm+Ge0phqdHusa4+AxETpo0dz7HgNtL8Q4LT3q2zoSNP9q+gu5sTMz+ABR+t
        QBWsvbJNdujvO9YeIASzNl4uiYOKGcKIse0puWSffx2u5npvTaX9r8gYf+U4+UHelEan8D
        CQDc5VltJ2zb0XTqdkTmQ2yzyyqYMy8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-xePwP7RKMz-u-bK3y50Dyg-1; Fri, 08 Jul 2022 11:47:48 -0400
X-MC-Unique: xePwP7RKMz-u-bK3y50Dyg-1
Received: by mail-qk1-f197.google.com with SMTP id f10-20020a05620a408a00b006b267fdf71fso19241318qko.6
        for <fstests@vger.kernel.org>; Fri, 08 Jul 2022 08:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1x7w4B8KkRbbLPOBK5w5COBwCSETd53dAVljfr2ix5E=;
        b=fWwjmd48QP+TKt1JuYAWwBHS+rqn35aHaWX19B/43TYCe+0Q0BjhCInAfoIdqFvrR9
         4mHA550HuZvhH7bTo+1ErOn/QWcsZtIcPfAwiQpkzYYp4T8YEg5rEhxV/dRoU8bm54gL
         9h0aqzVKAtSgZELNtxgnVpbF5GPOv70OXAmbZ8D2Qlfsj4RRM46V+b1+G+ozQHCdE9OL
         uQ2xv9PTIM2lJN38LEeRSwu7iRwCP9kQeijHAdWo7YypVSrD6M8LvD6h8UWiEwb6tQSo
         SWIVumb6nlr/6wk4Y2ewmf3Cs7FUDEDz6ypIdqSbJRFIZd82S4nUr3OgDmEEb5a0Ffqn
         c1Lw==
X-Gm-Message-State: AJIora9dxjc8fn+PPmFZjbQIz8/go3eA7WulT6qphfj02PmFXE280CNG
        QtLWNq/KrlmOBkBOVD3IeIfxIJOZCkF1uRCm/kIk2G/y05qIAAGvp6/LjSg9u+M4Pof6nKYLuBK
        MvR3M2GEsKlpBlWAhIw==
X-Received: by 2002:a05:620a:d54:b0:6b2:5a9b:ef2e with SMTP id o20-20020a05620a0d5400b006b25a9bef2emr2786425qkl.715.1657295267243;
        Fri, 08 Jul 2022 08:47:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vPSt5KNlOnkU/SYB+AC3XD5ZpJVVYDDOVQRKvwSOqEDp/UTr/LW6Cmrp/TMB0a4D22GJBoiQ==
X-Received: by 2002:a05:620a:d54:b0:6b2:5a9b:ef2e with SMTP id o20-20020a05620a0d5400b006b25a9bef2emr2786410qkl.715.1657295266963;
        Fri, 08 Jul 2022 08:47:46 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y21-20020ac87095000000b0031b18d29864sm21940875qto.64.2022.07.08.08.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 08:47:46 -0700 (PDT)
Date:   Fri, 8 Jul 2022 23:47:41 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs/288: skip repair -n when checking empty root
 leaf block behavior
Message-ID: <20220708154741.elvskagzrsynbw4o@zlang-mailbox>
References: <165705854325.2821854.10317059026052442189.stgit@magnolia>
 <165705855433.2821854.6003804324518144422.stgit@magnolia>
 <20220707122525.so6alaa63hdz3bbx@zlang-mailbox>
 <YschFMW4rVuQz9Mi@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YschFMW4rVuQz9Mi@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 07, 2022 at 11:08:20AM -0700, Darrick J. Wong wrote:
> On Thu, Jul 07, 2022 at 08:25:25PM +0800, Zorro Lang wrote:
> > On Tue, Jul 05, 2022 at 03:02:34PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Update this test to reflect the (once again) corrected behavior of the
> > > xattr leaf block verifiers.
> > > 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  tests/xfs/288 |   32 +++++++++++++-------------------
> > >  1 file changed, 13 insertions(+), 19 deletions(-)
> > > 
> > > 
> > > diff --git a/tests/xfs/288 b/tests/xfs/288
> > > index e3d230e9..aa664a26 100755
> > > --- a/tests/xfs/288
> > > +++ b/tests/xfs/288
> > > @@ -8,7 +8,7 @@
> > >  # that leaf directly (as xfsprogs commit f714016).
> > >  #
> > >  . ./common/preamble
> > > -_begin_fstest auto quick repair fuzzers
> > > +_begin_fstest auto quick repair fuzzers attr
> > >  
> > >  # Import common functions.
> > >  . ./common/filter
> > > @@ -50,25 +50,19 @@ if [ "$count" != "0" ]; then
> > >  	_notrun "xfs_db can't set attr hdr.count to 0"
> > >  fi
> > >  
> > > -# make sure xfs_repair can find above corruption. If it can't, that
> > > -# means we need to fix this bug on current xfs_repair
> > > -_scratch_xfs_repair -n >> $seqres.full 2>&1
> > 
> > So we drop the `xfs_repair -n` test.
> 
> Yep.
> 
> > Will the latest xfs_repair fail or pass on that? I'm wondering what's the expect
> > result of `xfs_repair -n` on a xfs with empty leaf? Should it report errors,
> > or nothing wrong?
> 
> xfs_repair -n no longer fails on attr block 0 being an empty leaf block
> since those are part of the ondisk format and are not a corruption.
> 
> xfs_repair (without the -n) will clear the attr fork since there aren't
> any xattrs if attr block 0 is empty.

Thanks for the explain.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > -if [ $? -eq 0 ];then
> > > -	_fail "xfs_repair can't find the corruption"
> > > -else
> > > -	# If xfs_repair can find this corruption, then this repair
> > > -	# should junk above leaf attribute and fix this XFS.
> > > -	_scratch_xfs_repair >> $seqres.full 2>&1
> > > +# Check that xfs_repair discards the attr fork if block 0 is an empty leaf
> > > +# block.  Empty leaf blocks at the start of the xattr data can be a byproduct
> > > +# of a shutdown race, and hence are not a corruption.
> > > +_scratch_xfs_repair >> $seqres.full 2>&1
> > >  
> > > -	# Old xfs_repair maybe find and fix this corruption by
> > > -	# reset the first used heap value and the usedbytes cnt
> > > -	# in ablock 0. That's not what we want. So check if
> > > -	# xfs_repair has junked the whole ablock 0 by xfs_db.
> > > -	_scratch_xfs_db -x -c "inode $inum" -c "ablock 0" | \
> > > -		grep -q "no attribute data"
> > > -	if [ $? -ne 0 ]; then
> > > -		_fail "xfs_repair didn't junk the empty attr leaf"
> > > -	fi
> > > +# Old xfs_repair maybe find and fix this corruption by
> > > +# reset the first used heap value and the usedbytes cnt
> > > +# in ablock 0. That's not what we want. So check if
> > > +# xfs_repair has junked the whole ablock 0 by xfs_db.
> > > +_scratch_xfs_db -x -c "inode $inum" -c "ablock 0" | \
> > > +	grep -q "no attribute data"
> > > +if [ $? -ne 0 ]; then
> > > +	_fail "xfs_repair didn't junk the empty attr leaf"
> > >  fi
> > >  
> > >  echo "Silence is golden"
> > > 
> > 
> 

