Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C2DC7EE24
	for <linux-fstests@archiver.kernel.org>; Fri,  2 Jun 2023 10:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbjFBKiS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbjFBKiC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 2 Jun 2023 06:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4431FC8
        for <fstests@vger.kernel.org>; Fri,  2 Jun 2023 03:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685702040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U1lwTihYxNq4wB1VqocEVTDzHF3gZim1ab3pspXfcqc=;
        b=Xu3oByrxSDTUSOfaTv0BsntD9t7OYG993SuWEsLRqwkfaMktXwHbEWBw2J0zU7/xIyO3/q
        /HYOjEl5XU55FMoGxDbjMRT6FSrypJQc785WBVauc163liaPxcYtGPNLjzCtBG5Yv217EP
        AbXeoeKwmdfjxWk+JHvZlDtVRriPBG0=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-LQFc4ZyGP86CPpZiOBwb0Q-1; Fri, 02 Jun 2023 06:27:50 -0400
X-MC-Unique: LQFc4ZyGP86CPpZiOBwb0Q-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-397f122786fso1627330b6e.1
        for <fstests@vger.kernel.org>; Fri, 02 Jun 2023 03:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701669; x=1688293669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1lwTihYxNq4wB1VqocEVTDzHF3gZim1ab3pspXfcqc=;
        b=hQE59IvvJ4Jelkv9HjWxAbCEyj80C/dFA0RCA0CSFpOUTB5FoLPawVadnOIJu2n/UJ
         9aiIVlmGkkg/bzw+ZGezGhGHvPooRu0Yaa8AzL5UsD7BN90uEACJAEHY/KBUUp6fq9ys
         0RPM485g/64SvaCdOfXnRzKi77+kIAMC6xPCkpIR5A3bzKKDJ2YiX0Uris/fZvN8Q1Nn
         59HziWMylZgKKSCiD/mFjdjybuWSP0JVCB+qekgTiYgotvO6jFhr4k6npo0Osf4OZAwD
         rVK5OgtS2d/HBw5rv+cR/8VXK6aa3nyO/OYHx2Pg7hM1dcPAu/axY/rMgeFZEyG8aQzr
         vb9g==
X-Gm-Message-State: AC+VfDwGAI/d3WGoXrn5gvOjxJSICMsnb/qOTjudukAAlyK71QLRSA9K
        dgpsz5oO2J65LBJrzbOrrPJ7xJaW2hyHj9i32wjMZBRDX26w02gtyTi6Musdq3ZwwgRt1vDjfla
        FRfAUc8liID3VI9DXaQ==
X-Received: by 2002:a05:6808:9a3:b0:398:29f4:366d with SMTP id e3-20020a05680809a300b0039829f4366dmr2187890oig.5.1685701669397;
        Fri, 02 Jun 2023 03:27:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ40AlQoFkRK63/PJMMHRJ/Wy939rmkzEULDx8JAnEsIryCWjvSVPXPutv2jt7TTnB/72FcrwA==
X-Received: by 2002:a05:6808:9a3:b0:398:29f4:366d with SMTP id e3-20020a05680809a300b0039829f4366dmr2187881oig.5.1685701669086;
        Fri, 02 Jun 2023 03:27:49 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x23-20020a62fb17000000b0064fe06fe712sm723960pfm.129.2023.06.02.03.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:27:48 -0700 (PDT)
Date:   Fri, 2 Jun 2023 18:27:44 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 06/11] xfs/018: disable parent pointers for this test
Message-ID: <20230602102744.3wxbayhfwknvnqbm@zlang-mailbox>
References: <168506060845.3732476.15364197106064737675.stgit@frogsfrogsfrogs>
 <168506060929.3732476.6482579916222371853.stgit@frogsfrogsfrogs>
 <20230526200134.cnhlqop277ntyyah@zlang-mailbox>
 <20230602010645.GB16891@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602010645.GB16891@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 01, 2023 at 06:06:45PM -0700, Darrick J. Wong wrote:
> On Sat, May 27, 2023 at 04:01:34AM +0800, Zorro Lang wrote:
> > On Thu, May 25, 2023 at 07:03:39PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > This test depends heavily on the xattr formats created for new files.
> > > Parent pointers break those assumptions, so force parent pointers off.
> > > 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  tests/xfs/018 |    7 ++++++-
> > >  tests/xfs/191 |    7 ++++++-
> > >  tests/xfs/288 |    7 ++++++-
> > >  3 files changed, 18 insertions(+), 3 deletions(-)
> > > 
> > > 
> > > diff --git a/tests/xfs/018 b/tests/xfs/018
> > > index 1ef51a2e61..34b6e91579 100755
> > > --- a/tests/xfs/018
> > > +++ b/tests/xfs/018
> > > @@ -100,7 +100,12 @@ attr32l="X$attr32k"
> > >  attr64k="$attr32k$attr32k"
> > >  
> > >  echo "*** mkfs"
> > > -_scratch_mkfs >/dev/null
> > > +
> > > +# Parent pointers change the xattr formats sufficiently to break this test.
> > > +# Disable parent pointers if mkfs supports it.
> > > +mkfs_args=()
> > > +$MKFS_XFS_PROG 2>&1 | grep -q parent=0 && mkfs_args+=(-n parent=0)
> > 
> > Maybe we need a _require_no_xfs_parent() ?
> 
> We still want to run the test, we just don't want parent pointer
> xattrs muddying up the golden output.

But if there's a specified MKFS_OPTIONS="... -n parent=1", this change will cause
the whole test fails, right?

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > +_scratch_mkfs "${mkfs_args[@]}" >/dev/null
> > >  
> > >  blk_sz=$(_scratch_xfs_get_sb_field blocksize)
> > >  err_inj_attr_sz=$(( blk_sz / 3 - 50 ))
> > > diff --git a/tests/xfs/191 b/tests/xfs/191
> > > index 7a02f1be21..0a6c20dad7 100755
> > > --- a/tests/xfs/191
> > > +++ b/tests/xfs/191
> > > @@ -33,7 +33,12 @@ _fixed_by_kernel_commit 7be3bd8856fb "xfs: empty xattr leaf header blocks are no
> > >  _fixed_by_kernel_commit e87021a2bc10 "xfs: use larger in-core attr firstused field and detect overflow"
> > >  _fixed_by_git_commit xfsprogs f50d3462c654 "xfs_repair: ignore empty xattr leaf blocks"
> > >  
> > > -_scratch_mkfs_xfs | _filter_mkfs >$seqres.full 2>$tmp.mkfs
> > > +# Parent pointers change the xattr formats sufficiently to break this test.
> > > +# Disable parent pointers if mkfs supports it.
> > > +mkfs_args=()
> > > +$MKFS_XFS_PROG 2>&1 | grep -q parent=0 && mkfs_args+=(-n parent=0)
> > > +
> > > +_scratch_mkfs_xfs "${mkfs_args[@]}" | _filter_mkfs >$seqres.full 2>$tmp.mkfs
> > >  cat $tmp.mkfs >> $seqres.full
> > >  source $tmp.mkfs
> > >  _scratch_mount
> > > diff --git a/tests/xfs/288 b/tests/xfs/288
> > > index aa664a266e..6bfc9ac0c8 100755
> > > --- a/tests/xfs/288
> > > +++ b/tests/xfs/288
> > > @@ -19,8 +19,13 @@ _supported_fs xfs
> > >  _require_scratch
> > >  _require_attrs
> > >  
> > > +# Parent pointers change the xattr formats sufficiently to break this test.
> > > +# Disable parent pointers if mkfs supports it.
> > > +mkfs_args=()
> > > +$MKFS_XFS_PROG 2>&1 | grep -q parent=0 && mkfs_args+=(-n parent=0)
> > > +
> > >  # get block size ($dbsize) from the mkfs output
> > > -_scratch_mkfs_xfs 2>/dev/null | _filter_mkfs 2>$tmp.mkfs >/dev/null
> > > +_scratch_mkfs_xfs "${mkfs_args[@]}" 2>/dev/null | _filter_mkfs 2>$tmp.mkfs >/dev/null
> > >  . $tmp.mkfs
> > >  
> > >  _scratch_mount
> > > 
> > 
> 

