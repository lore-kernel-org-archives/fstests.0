Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3504C38A02
	for <linux-fstests@archiver.kernel.org>; Fri, 28 Oct 2022 05:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJ1FoO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 28 Oct 2022 01:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJ1FoN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Oct 2022 01:44:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0961B65F0
        for <fstests@vger.kernel.org>; Thu, 27 Oct 2022 22:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666935798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0j4gnCVL6NM7Nbvyj5JHHnZVMzTo3vHJGnU3eakIC8E=;
        b=Dgx+FL87s0+bLY/QBlvNpvhyTLeV23DC5RUl5plfgk3BkQfPoAG7miMwYMkCxoD1BB472T
        3exbEdok9taReuo+awGvudjX7pVvan6jBHJNgkWfmp3hwEh4mWubnGeeX+C8b0i4NPudb6
        Jb5NdiKW9RMf6dPMiMuChyKFQAVe1bI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-675-PTvcmedvN6uM-0xmYd9MOQ-1; Fri, 28 Oct 2022 01:43:14 -0400
X-MC-Unique: PTvcmedvN6uM-0xmYd9MOQ-1
Received: by mail-pf1-f197.google.com with SMTP id m6-20020aa79006000000b0056bc283f477so2029476pfo.19
        for <fstests@vger.kernel.org>; Thu, 27 Oct 2022 22:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j4gnCVL6NM7Nbvyj5JHHnZVMzTo3vHJGnU3eakIC8E=;
        b=GlJ6k3et0LYbVwfCZmmWXkAx6gz1TeLS76Ru0CdX5fBaJ2pryfSREjoF41Be5Xjbk3
         gJ737r3zbx9bTy3z8q2lJ5QDkcO8Mkk+DEKUYVf6IZDN5agGlmRmpChRcvwnEmTIVlP4
         51tJekL0O6k1tX9iv1ifRBGUJZtlZjoq9CE31I9rNEqmkDtJz+cVEbws+jJFDE+j7Gft
         iZCsAIHEIKIGlIJVHzvNgYjjNHVmnQ25X3fVRzXlq+RfOrwuaVrsxs9jDreeptcKrhoA
         528K6SUwcACG3r44OxoE2hCHBxNOl/52FV6QHugMZpHnyAxUGPXWN6TJSHQ+gCeTJQRv
         /lYA==
X-Gm-Message-State: ACrzQf0GVeH++4ofXY4UluHPqC/Hqn4LrQJS+wCc37rDKIu/QAMpbtji
        RftsnvElCbhLq941SGA9EO7VZ0kVUb1et2Q6C2oh/yinXPupLff3FEr9MCqR8IUl9YTffOKuK1I
        IEEPCU/j+BsGVMBcP6g==
X-Received: by 2002:a05:6a00:13aa:b0:56b:c782:107f with SMTP id t42-20020a056a0013aa00b0056bc782107fmr25278013pfg.43.1666935793084;
        Thu, 27 Oct 2022 22:43:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6je3tb2EpHtv09/a6ZbC6RjzN9BkUCl1cSFqogSHssUiCBTtqnJ4LPqx4BHHYZuBbU8GtJxg==
X-Received: by 2002:a05:6a00:13aa:b0:56b:c782:107f with SMTP id t42-20020a056a0013aa00b0056bc782107fmr25277992pfg.43.1666935792752;
        Thu, 27 Oct 2022 22:43:12 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t1-20020a62d141000000b0056beae3dee2sm2110249pfl.145.2022.10.27.22.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 22:43:11 -0700 (PDT)
Date:   Fri, 28 Oct 2022 13:43:07 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] xfs: new test on xfs with corrupted sb_inopblock
Message-ID: <20221028054307.jnxk3bju4qv76lro@zlang-mailbox>
References: <20221027164254.1472306-1-zlang@kernel.org>
 <Y1q5Wkkzq/7PIeyL@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1q5Wkkzq/7PIeyL@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 27, 2022 at 10:01:14AM -0700, Darrick J. Wong wrote:
> On Fri, Oct 28, 2022 at 12:42:54AM +0800, Zorro Lang wrote:
> > There's a known bug fix 392c6de98af1 ("xfs: sanitize sb_inopblock in
> > xfs_mount_validate_sb"). So try to corrupt the sb_inopblock of xfs,
> > to cover this bug.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  tests/xfs/555     | 27 +++++++++++++++++++++++++++
> >  tests/xfs/555.out |  4 ++++
> >  2 files changed, 31 insertions(+)
> >  create mode 100755 tests/xfs/555
> >  create mode 100644 tests/xfs/555.out
> > 
> > diff --git a/tests/xfs/555 b/tests/xfs/555
> > new file mode 100755
> > index 00000000..7f46a9af
> > --- /dev/null
> > +++ b/tests/xfs/555
> > @@ -0,0 +1,27 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 555
> > +#
> > +# Corrupt xfs sb_inopblock, make sure no crash. This's a test coverage of
> > +# 392c6de98af1 ("xfs: sanitize sb_inopblock in xfs_mount_validate_sb")
> 
> _fixed_by_kernel_commit?

Sure

> 
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick
> > +
> > +# real QA test starts here
> > +_supported_fs xfs
> > +_require_scratch_nocheck
> > +
> > +_scratch_mkfs >>$seqres.full
> > +
> > +echo "corrupt inopblock of sb 0"
> > +_scratch_xfs_set_metadata_field "inopblock" "500" "sb 0" >> $seqres.full
> > +echo "try to mount ..."
> > +_try_scratch_mount 2>> $seqres.full && _fail "mount should not succeed"
> > +
> > +echo "no crash or hang"
> 
> You might want to check the scratch fs to make sure repair will deal
> with the problem...?

I thought it's not a part of the original reproducer, so tried to save this
time, especially xfs/350 xfs/351 already covered this part testing :) But if
you think it's worth, I'll add it in next version.

Thanks,
Zorro

> 
> --D
> 
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/xfs/555.out b/tests/xfs/555.out
> > new file mode 100644
> > index 00000000..36c3446e
> > --- /dev/null
> > +++ b/tests/xfs/555.out
> > @@ -0,0 +1,4 @@
> > +QA output created by 555
> > +corrupt inopblock of sb 0
> > +try to mount ...
> > +no crash or hang
> > -- 
> > 2.31.1
> > 
> 

