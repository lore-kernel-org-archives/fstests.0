Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658E6C77B7A
	for <linux-fstests@archiver.kernel.org>; Fri, 26 May 2023 19:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjEZTxa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 26 May 2023 15:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbjEZTx3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 May 2023 15:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E80F9E
        for <fstests@vger.kernel.org>; Fri, 26 May 2023 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685130761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XwZMPRlj2Zz8SV7GUJOzT92QeTCbcrvY3iSVvEWA5eI=;
        b=GbJAm32uyiRwwqU+0f7tt+M+291kgOlF0MPod9MeanWkqnoKYE3EsvN9dk3NfYgc/cjXSq
        ECR6DzbLfSkk+6+x1XhOvWqJBVPi+oxfLMgpbzxhuviicoYqEEqZaC6x4f3tvKFId71JGo
        qYQI9MpvQk/tLgzGykcRdqcW66avZcA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-kpjC0kXHO8usfi41-j48Yg-1; Fri, 26 May 2023 15:52:39 -0400
X-MC-Unique: kpjC0kXHO8usfi41-j48Yg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2562fbb193bso663390a91.1
        for <fstests@vger.kernel.org>; Fri, 26 May 2023 12:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685130758; x=1687722758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwZMPRlj2Zz8SV7GUJOzT92QeTCbcrvY3iSVvEWA5eI=;
        b=iLF2mfh6gt1E5lgNLQaPpeX1r/y7NcoTSdW+wfI140J0bMRDsixFmIGa+5i3eke2De
         H4mdK+5tUrHbBz5c9/S9JzaRweaeqJACeapttat8g5ZLuNgbaDkb5A2CJ/Ydj9eZXQX8
         J3H60AKTtyoUWAOjISMvtdMuLMYRVNtjEsSu+DXGPIfeoJ8lG2xgcVPjmgZ713vDi2Op
         wQLn9lsAJCPNyeMveok9AHpUKnMhFokmG1lb/m1YUSFzdAAtWKme37F+DrkMjVbgof0g
         aqiij8ky2VFpWrQeWya1EifxDDm7Bb0L+tVKePizz2pBJw5bxOqk2Mt6ZXxGzv2AP5Eo
         jLaw==
X-Gm-Message-State: AC+VfDze08i+iaqQ48SDZpH8T68Nl1HDQcz9tiDYEz14n41aeRLYdh8u
        C8tjI0danBYnXkAF/fyZnDmgfJfQmC9WQjAUPONsdj8U3QGjdyqUDR7mjolZQov/lGE96dAYTR8
        rVU76LM0O9gvKZ7lfkLmdUIVxX16l
X-Received: by 2002:a17:90a:2a49:b0:256:4196:f722 with SMTP id d9-20020a17090a2a4900b002564196f722mr1490106pjg.47.1685130758530;
        Fri, 26 May 2023 12:52:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61Xq6bCWTDhS6RqmE+TCb/gMt2f1XAflKR/P0yHHvHa1ewTectzr3IXUxKFaVKagmO7AX3vQ==
X-Received: by 2002:a17:90a:2a49:b0:256:4196:f722 with SMTP id d9-20020a17090a2a4900b002564196f722mr1490091pjg.47.1685130758187;
        Fri, 26 May 2023 12:52:38 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ne10-20020a17090b374a00b002500df72713sm5009812pjb.7.2023.05.26.12.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:52:37 -0700 (PDT)
Date:   Sat, 27 May 2023 03:52:34 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     cem@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] xfstests: Enable _test_mkfs to force a mkfs on a xfs
 filesystem
Message-ID: <20230526195234.soug6nwxho5rkinq@zlang-mailbox>
References: <20230524134207.38224-1-cem@kernel.org>
 <20230524151650.GC11607@frogsfrogsfrogs>
 <20230525043605.hxivdzodlh7vvpow@zlang-mailbox>
 <20230525191312.GE11607@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525191312.GE11607@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 25, 2023 at 12:13:12PM -0700, Darrick J. Wong wrote:
> On Thu, May 25, 2023 at 12:36:05PM +0800, Zorro Lang wrote:
> > On Wed, May 24, 2023 at 08:16:50AM -0700, Darrick J. Wong wrote:
> > > On Wed, May 24, 2023 at 03:42:07PM +0200, cem@kernel.org wrote:
> > > > From: Carlos Maiolino <cmaiolino@redhat.com>
> > > > 
> > > > Calling _test_mkfs on an already initialized xfs FS will fail as the
> > > > initialization is not enforced by '-f' argument, unless it's included in
> > > > MKFS_OPTIONS.
> > > > So, adding 'RECREATE_TEST_DEV=true' to the config file end up being useless
> > > > for xfs filesystems.
> > > > 
> > > > So, adding the a specific xfs optiong in _test_mkfs using -f argument
> > > > makes RECREATE_TEST_DEV actually useful.
> > > > 
> > > > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> > > 
> > > Makese sense to me,
> > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > 
> > Hi Darrick,
> > 
> > I just noticed that there's not any place use "_test_options mkfs", I remembered
> > SCRATCH_DEV support rtdev and logdev, the TEST_DEV looks not support that, but
> > the "_test_options()" looks like hoping to support.
> 
> Hmmm, that's a very good point -- _test_mkfs() fails to format a test
> filesystem with external logs or rt volumes even if the config specified
> that.  Perhaps change the patch to add:
> 
>     xfs)
>         _test_options mkfs

Current _test_options() only works for xfs, it returns directly if FSTYP != XFS.
It more likes a _test_xfs_options. We don't have _test_$FSTYP_options() function,
so if we'd like to have a common _test_options(), I think we should deal with
fs specific things in _test_options() inside, then call _test_options once before
the "case $FSTYP in ...".

Thanks,
Zorro

>         $MKFS_XFS_PROG -f $TEST_OPTIONS $MKFS_OPTIONS $* $TEST_DEV
>         ;;
> 
> Does that look right?
> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > 
> > > --D
> > > 
> > > > ---
> > > >  common/rc | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/common/rc b/common/rc
> > > > index 37074371..dd5d7bc1 100644
> > > > --- a/common/rc
> > > > +++ b/common/rc
> > > > @@ -605,6 +605,9 @@ _test_mkfs()
> > > >      ext2|ext3|ext4)
> > > >  	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
> > > >  	;;
> > > > +    xfs)
> > > > +	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* $TEST_DEV
> > > > +	;;
> > > >      *)
> > > >  	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
> > > >  	;;
> > > > -- 
> > > > 2.30.2
> > > > 
> > > 
> > 
> 

