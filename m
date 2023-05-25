Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C981C77B7A
	for <linux-fstests@archiver.kernel.org>; Thu, 25 May 2023 04:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjEYEhU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 May 2023 00:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEYEhT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 May 2023 00:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F4783
        for <fstests@vger.kernel.org>; Wed, 24 May 2023 21:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684989391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FdyoVRyOWS2Lw6MzQj5e6b9hSYbBMS/lUO5ESosYogQ=;
        b=ZHDMppiOpU7LQ3UqelWuWozUeyABz03nxb7dUM/uwr2ySQKcgCDziCeA50SjAJw1yvqyP8
        y/eGzHvFrqXefM++6rll/o+ItXNCPk7B+skEs/+hH7e/C/KtSFqJjDRLVXR30eW28pZgb4
        caL1IHtpLKHuTTaJCiFSJbQEGuzwDco=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-HB9052wLMtqfxBPmyZozvA-1; Thu, 25 May 2023 00:36:29 -0400
X-MC-Unique: HB9052wLMtqfxBPmyZozvA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-530277cf88bso1046202a12.3
        for <fstests@vger.kernel.org>; Wed, 24 May 2023 21:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684989388; x=1687581388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdyoVRyOWS2Lw6MzQj5e6b9hSYbBMS/lUO5ESosYogQ=;
        b=bN89OhHM+rfKwcLe7MQsHG3IOBpSDwxgR8M4mK9m8x1CMYWKa2LLFMl2MOcCdQiMN9
         sc6DoHwGuzpCvLGZCUWpFqIa6QFxoCX9jK2oh+BZHWrhW0plfrkQ9mk5Tbc3yaXbZa0r
         NeFkhnK2C10PJ9VucLK20d2guhQNxAqIR65NlUrkhNCXUp0NlPmXEznN0Y0aVjp/vcC6
         79WhMfZ8n6wvMsnNc54heyArIvpSbFvQb3rXDlpin+SBgvPpqiJPxRcnV+tmrafMinVR
         a1q9dSam1IojXcDLfIlsBOjJjmDMV2eF214JFyv9Cf0M8p0k/Jpj7vgepY+1xVDMCIuc
         otRQ==
X-Gm-Message-State: AC+VfDz0CmXwNKgwYBGHr+cPKPrNZapAHThKlObSQYQ+H63c1fP3tA07
        r0h81gvEoKpqY4eqhONGlwJqEb4hbf5MiZXIKu4Gt2bdrpDMyOr37yQFil2EBKfYEB7c/UPt8xL
        eDDjOi/1A40sBv/QOGse9kBlnqE1lTzI=
X-Received: by 2002:a05:6a20:7d95:b0:10c:9ba8:5953 with SMTP id v21-20020a056a207d9500b0010c9ba85953mr8248313pzj.59.1684989388059;
        Wed, 24 May 2023 21:36:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6tN92ucdx52YXN+Fomb2Ijn5f0LZCX0MBRjF/yWPO+hHmHeLmf/mHxQug7kfjInIKrYCrzUg==
X-Received: by 2002:a05:6a20:7d95:b0:10c:9ba8:5953 with SMTP id v21-20020a056a207d9500b0010c9ba85953mr8248297pzj.59.1684989387746;
        Wed, 24 May 2023 21:36:27 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d70500b001acad024c8asm313531ply.40.2023.05.24.21.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 21:36:21 -0700 (PDT)
Date:   Thu, 25 May 2023 12:36:05 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     cem@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] xfstests: Enable _test_mkfs to force a mkfs on a xfs
 filesystem
Message-ID: <20230525043605.hxivdzodlh7vvpow@zlang-mailbox>
References: <20230524134207.38224-1-cem@kernel.org>
 <20230524151650.GC11607@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524151650.GC11607@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 24, 2023 at 08:16:50AM -0700, Darrick J. Wong wrote:
> On Wed, May 24, 2023 at 03:42:07PM +0200, cem@kernel.org wrote:
> > From: Carlos Maiolino <cmaiolino@redhat.com>
> > 
> > Calling _test_mkfs on an already initialized xfs FS will fail as the
> > initialization is not enforced by '-f' argument, unless it's included in
> > MKFS_OPTIONS.
> > So, adding 'RECREATE_TEST_DEV=true' to the config file end up being useless
> > for xfs filesystems.
> > 
> > So, adding the a specific xfs optiong in _test_mkfs using -f argument
> > makes RECREATE_TEST_DEV actually useful.
> > 
> > Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> 
> Makese sense to me,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Hi Darrick,

I just noticed that there's not any place use "_test_options mkfs", I remembered
SCRATCH_DEV support rtdev and logdev, the TEST_DEV looks not support that, but
the "_test_options()" looks like hoping to support.

Thanks,
Zorro

> 
> --D
> 
> > ---
> >  common/rc | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 37074371..dd5d7bc1 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -605,6 +605,9 @@ _test_mkfs()
> >      ext2|ext3|ext4)
> >  	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
> >  	;;
> > +    xfs)
> > +	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* $TEST_DEV
> > +	;;
> >      *)
> >  	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
> >  	;;
> > -- 
> > 2.30.2
> > 
> 

