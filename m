Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FD7C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Dec 2022 19:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiLSTCR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 19 Dec 2022 14:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiLSTCP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Dec 2022 14:02:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C80825EC
        for <fstests@vger.kernel.org>; Mon, 19 Dec 2022 11:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671476470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0q5UJuP9h45gJi3HybrDEvY0RvQUcRnvRSZzzGvEx2I=;
        b=ArLVaLLrgb0n710wYwch+ISbKhjM/wqcCkgo5q6zmMXotaUNvJgCRRrhD/FlHCrP8hI7Dm
        xGI96wGmz6twkwzkc9YBGqDELX4ICkPEpsW+xbglquAlkGN27icmhn0DJ+qDX8YUJDJBTp
        FObdIemYg5VYtpM9xGz+CFvVhAwWkxI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-107-CUGv2AX8MvWthsjCd3zkcw-1; Mon, 19 Dec 2022 14:01:09 -0500
X-MC-Unique: CUGv2AX8MvWthsjCd3zkcw-1
Received: by mail-pg1-f199.google.com with SMTP id x79-20020a633152000000b004785d1cf6bbso5903347pgx.6
        for <fstests@vger.kernel.org>; Mon, 19 Dec 2022 11:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0q5UJuP9h45gJi3HybrDEvY0RvQUcRnvRSZzzGvEx2I=;
        b=h968uY3QeUGwGUedDPErw6Lc9Y5yda95yFxtq2/HIdGDK7IdxgWGnJ1PXuJXLayEBw
         E0Aib5uNn+7MzI/rPvvESxMZHx/voByJIsKrjti7eg2pPtGPCGcxrPGsaRUg6CtZKFFm
         vMQgf8dHhQ52gYTanUau6yGba3tzoUP8lY7yLwLu9IhdEyVqkOuNKcYAiLAd9P82zCzt
         eamn+DMgO5Z63cMZRvykPC/OPioxKxz0DzsCYARxaUGyKaeRtVH+7jX52eTwStxIvJtK
         E7+ErOV1nY467OuDoEDnae4Zss4icVREUg4FdZKsWnH2jvw380c4uQdbsEh3LQul2B82
         3TOg==
X-Gm-Message-State: ANoB5pkwNUWrPvJHI1Gvy/A7QzIJGva93Yp5V/8QkWIYFPDGZDydPIZZ
        hoin4uwZrh+Bwh4RK7fej51JSiUJsOicCnn3QBi/vPLN/ahUq+6ltHoyMyRGCy9zFNZTtpM7Ng2
        xlOJDuJVU9W54rvmh/Q==
X-Received: by 2002:a17:903:22cd:b0:189:e16f:c268 with SMTP id y13-20020a17090322cd00b00189e16fc268mr61060331plg.20.1671476467953;
        Mon, 19 Dec 2022 11:01:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf48Q+jkloexmUN2m+8Bga7l9+DDj/BQcu59EiXLtpij/IAljW4N7DFg1VhNrT+5LMbYFxt5uw==
X-Received: by 2002:a17:903:22cd:b0:189:e16f:c268 with SMTP id y13-20020a17090322cd00b00189e16fc268mr61060288plg.20.1671476467553;
        Mon, 19 Dec 2022 11:01:07 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9-20020a170903230900b00176dc67df44sm7538108plh.132.2022.12.19.11.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:01:05 -0800 (PST)
Date:   Tue, 20 Dec 2022 03:01:00 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs/122: fix EFI/EFD log format structure size after
 flex array conversion
Message-ID: <20221219190100.rmpmaks7ssnlclij@zlang-mailbox>
References: <167096073708.1750519.5668846655153278713.stgit@magnolia>
 <167096074260.1750519.311637326793150150.stgit@magnolia>
 <20221214184047.k3iaxggotcli4423@zlang-mailbox>
 <Y516UhlSugONPpVp@magnolia>
 <20221217100029.x4su3x5n3tlnuldi@zlang-mailbox>
 <Y6CcCsKPZWb4LMnq@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6CcCsKPZWb4LMnq@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 19, 2022 at 09:14:50AM -0800, Darrick J. Wong wrote:
> On Sat, Dec 17, 2022 at 06:00:29PM +0800, Zorro Lang wrote:
> > On Sat, Dec 17, 2022 at 12:14:10AM -0800, Darrick J. Wong wrote:
> > > On Thu, Dec 15, 2022 at 02:40:47AM +0800, Zorro Lang wrote:
> > > > On Tue, Dec 13, 2022 at 11:45:42AM -0800, Darrick J. Wong wrote:
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > > 
> > > > > Adjust this test since made EFI/EFD log item format structs proper flex
> > > > > arrays instead of array[1].
> > > > > 
> > > > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > > > ---
> > > > 
> > > > So we let this case fail on all older system/kernel? Is the kernel patch
> > > > recommended to be merged on downstream kernel?
> > > 
> > > Yes, since there are certain buggy compilers that mishandle the array
> > > size computation.  Prior to the introduction of xfs_ondisk.h, they were
> > > silently writing out filesystem structures that would not be recognized
> > > by more mainstream systems (e.g. x86).
> > > 
> > > OFC nearly all those reports about buggy compilers are for tiny
> > > architectures that XFS doesn't work well on anyways, so in practice it
> > > hasn't created any user problems (AFAIK).
> > 
> > Thanks, may you provide this detailed explanation in commit log, and better
> > to point out the kernel commits which is related with this testing change.
> 
> Will do.
> 
> > Due to this case isn't a case for a known issue, I think it might be no
> > suitable to add _fixed_by_kernel_commit in this case, but how about giving
> > more details in commit log.
> 
> Er.... xfs/122 isn't a regression test, so it's not testing previously
> broken and now fixed code.  While I sense that a few peoples'
> understanding of _fixed_by_kernel_commit might be constrained to "if
> this test fails, check that your kernel/*fsprogs have commit XXXXX", I
> myself have started `grep _fixed_by_kernel_commit' to find bug fixes and
> their related regression tests to suggest backports.

I generally check _fixed_by_*, secondly check the comments in the code and
the commit log related with the case.

> 
> ...although I wonder if perhaps we should have a second set of
> _by_commit helpers that encode "not a regression test, but you might
> check such-and-such commit"?

Yeah, the "fixed_by" sounds not precise for xfs/122. Maybe "_cover_commit" or
some better names you have :)

Thanks,
Zorro

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > > 
> > > --D
> > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > > >  tests/xfs/122.out |    8 ++++----
> > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > 
> > > > > 
> > > > > diff --git a/tests/xfs/122.out b/tests/xfs/122.out
> > > > > index a56cbee84f..95e53c5081 100644
> > > > > --- a/tests/xfs/122.out
> > > > > +++ b/tests/xfs/122.out
> > > > > @@ -161,10 +161,10 @@ sizeof(xfs_disk_dquot_t) = 104
> > > > >  sizeof(xfs_dq_logformat_t) = 24
> > > > >  sizeof(xfs_dqblk_t) = 136
> > > > >  sizeof(xfs_dsb_t) = 264
> > > > > -sizeof(xfs_efd_log_format_32_t) = 28
> > > > > -sizeof(xfs_efd_log_format_64_t) = 32
> > > > > -sizeof(xfs_efi_log_format_32_t) = 28
> > > > > -sizeof(xfs_efi_log_format_64_t) = 32
> > > > > +sizeof(xfs_efd_log_format_32_t) = 16
> > > > > +sizeof(xfs_efd_log_format_64_t) = 16
> > > > > +sizeof(xfs_efi_log_format_32_t) = 16
> > > > > +sizeof(xfs_efi_log_format_64_t) = 16
> > > > >  sizeof(xfs_error_injection_t) = 8
> > > > >  sizeof(xfs_exntfmt_t) = 4
> > > > >  sizeof(xfs_exntst_t) = 4
> > > > > 
> > > > 
> > > 
> > 
> 

