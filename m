Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26361C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 26 May 2022 01:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiEZBOs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 25 May 2022 21:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344228AbiEZBOr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 May 2022 21:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEE0C954B7
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 18:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653527686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6q0jaqWQdvvT/ssIVdzAmG7s+FAlKfTIV+QQ+SMhm0A=;
        b=I233XCa8c7e6jqqhuanRxG1jvHJTFoWguajqvtL6WGUYHaEnTWOqc14v1SElI33UHVJvy7
        3MJTUKtSkv34LVlPt1cNZZVOMQKAtaCSaGMxMoGO7XXwFY69yPdymdzBklotm8SmVYLijp
        wXoU2DTOa+PW1oS/IUvuiYfWRZTYoh0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-6zfKMjkAPyeNoHGMqCdPwA-1; Wed, 25 May 2022 21:14:44 -0400
X-MC-Unique: 6zfKMjkAPyeNoHGMqCdPwA-1
Received: by mail-oo1-f72.google.com with SMTP id 65-20020a4a1d44000000b0040e8fbc7720so233821oog.4
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 18:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6q0jaqWQdvvT/ssIVdzAmG7s+FAlKfTIV+QQ+SMhm0A=;
        b=1XJeNgAmF4DjngT8nezTC/KaxUd86x+1jImcNvdCwu0r5v7iL4iqAmbg4nMtWUMIPM
         eutm/spXF5O/8YLCW2EPvR516WJ+aPo+snST02ItTwELjH6jGDUqX3dXZFVa0oLzLtP9
         MrSXR1Fnc7ni1n0knG0xXTzdY3rd//8sc/Jefyfp60DrBD8vX8ZI8pJD+xHjc8fzahJY
         H667R7xI96jRBNmCoPFmMm0a5jCC1p2KdQDve+204QI0+PZQontuJ2KUzY0tfeXibp6f
         /83U+JwLN40KJxcUNsSMi7sA6h/RQflxY5XkE2KC/87JFR8B3WSHzzui4Zs4WDG+KpZu
         IS0A==
X-Gm-Message-State: AOAM530VTOh0z139juBf0BYm3EfyMmpESWXGqajLxnXYngFMRw+5UDct
        j950Sd6jRu9ZWpFaaXpi62c/HB01pUEUxpP3DavTTRYoSpDBqyjvBckOqQmj3+rpvhoRSKZ5LVl
        RWqP2lCEYMKdvCgOrPw==
X-Received: by 2002:a05:6870:c6a3:b0:f2:c66f:5afc with SMTP id cv35-20020a056870c6a300b000f2c66f5afcmr3002126oab.47.1653527683658;
        Wed, 25 May 2022 18:14:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzISG0jzr9ITsSHvyvOO1HQxY8RqWsHkNaUaOQYYQF8G7c/7z6gF0g5WP+LZJQhFdq30RJQ6g==
X-Received: by 2002:a05:6870:c6a3:b0:f2:c66f:5afc with SMTP id cv35-20020a056870c6a300b000f2c66f5afcmr3002108oab.47.1653527683369;
        Wed, 25 May 2022 18:14:43 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j17-20020a4a8891000000b0035eb4e5a6bbsm126857ooa.17.2022.05.25.18.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 18:14:42 -0700 (PDT)
Date:   Thu, 26 May 2022 09:14:37 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] tests: remove redundant common/$FSTYP importing
Message-ID: <20220526011437.a64ki3xng76djkrz@zlang-mailbox>
References: <20220525073427.3355242-1-zlang@kernel.org>
 <20220525073427.3355242-3-zlang@kernel.org>
 <20220526001326.GX2306852@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526001326.GX2306852@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 26, 2022 at 10:13:26AM +1000, Dave Chinner wrote:
> On Wed, May 25, 2022 at 03:34:27PM +0800, Zorro Lang wrote:
> > As fstests intensively source specific common/$FSTYP files in
> > common/rc, at the beginning of ./check running. Each single case
> > doesn't need to import that again.
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> >  tests/btrfs/177 | 1 -
> >  tests/btrfs/258 | 1 -
> >  tests/btrfs/259 | 1 -
> >  tests/xfs/422   | 1 -
> >  tests/xfs/423   | 1 -
> >  tests/xfs/517   | 1 -
> >  6 files changed, 6 deletions(-)
> > 
> > diff --git a/tests/btrfs/177 b/tests/btrfs/177
> > index 2fd11e89..7b004b83 100755
> > --- a/tests/btrfs/177
> > +++ b/tests/btrfs/177
> > @@ -10,7 +10,6 @@
> >  _begin_fstest auto quick swap balance
> >  
> >  . ./common/filter
> > -. ./common/btrfs
> >  
> >  # Modify as appropriate.
> >  _supported_fs btrfs
> > diff --git a/tests/btrfs/258 b/tests/btrfs/258
> > index 158eaf79..8fc828df 100755
> > --- a/tests/btrfs/258
> > +++ b/tests/btrfs/258
> > @@ -11,7 +11,6 @@
> >  _begin_fstest auto defrag quick
> >  
> >  . ./common/btrfs
> > -. ./common/filter
> 
> I think you removed the wrong line here.

Oh, sorry, we resend this patch again.

Thanks,
Zorro

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

