Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA34AC433E0
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Mar 2021 15:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781A365002
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Mar 2021 15:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhCLPTD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 12 Mar 2021 10:19:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232093AbhCLPTC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 12 Mar 2021 10:19:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615562342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kj5oZXuHyIi9m87E0ij1hZzPU5DAiQfu0GrgV/1bu9c=;
        b=QF1eGNb4BM9cRvNk7aJIE14Qa9ljBAkh8wfEida25S7mMi+nyjFkIvoQ97XJVT9gP+wA+C
        DUhyJ0hke+wQzmVBMyTsvwo3MbeViPsaHhlV1Rnu+Np3ZasYs9ICp7BC/GCgadM6niAEb/
        kvc92zL3hZpkGI1rwLCx03JGd85hTVk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-5fxWoYCIMt-2si7cZfNaUw-1; Fri, 12 Mar 2021 10:18:59 -0500
X-MC-Unique: 5fxWoYCIMt-2si7cZfNaUw-1
Received: by mail-pl1-f200.google.com with SMTP id i12so13480667plb.13
        for <fstests@vger.kernel.org>; Fri, 12 Mar 2021 07:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kj5oZXuHyIi9m87E0ij1hZzPU5DAiQfu0GrgV/1bu9c=;
        b=MklqwN+VoSFg72eJhZIToO5BTSXpfW2dVSxoM55Ajzdv+kVC7BwphCXF+na6mRo0Wm
         d4r18ykItIgTed7RrrbaR9QXshzq9tUtLzPMzAFXWv2nCnTSnKR0sfP+rIxAy8SiW7Ee
         NoPLq2VHIhZJBxSB0gfIEA7i9xls8YiMa+Mimnb6GL1P+xymAmwz1bVhS6vShmhYkVjK
         rwjQF3ekiPgSyzF5UeDgpYZB9XomR43wEUzG9mAbnMWGnQOu+Mdbb4DZqUl8ltSy2A+A
         mJqKkCZbCUTUa+MGFHxAm6cl18G2grJlkLqcWe6hXCQ8cMK2qZQNqxNd3pNErcAyiZ4X
         i2CA==
X-Gm-Message-State: AOAM5309zCEEBu/rLOPyW4aHJ2AnElg03Fy8bzzveh7O+cWG7lLAYUfL
        3LH+IRS66OtCXkAXtEjk9cnnfPgoT+6wtA2VyYy+E3CetAaRWfcf0giPQk2WXLWgIxRNWjW5Gv1
        7jJ/vjn5qDESXVwa4bQ==
X-Received: by 2002:a17:902:f54e:b029:e6:3d74:eb3 with SMTP id h14-20020a170902f54eb02900e63d740eb3mr14103588plf.14.1615562338426;
        Fri, 12 Mar 2021 07:18:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw3n9I34vyt1jzguAtbcB3/knsxjW0ZZZLt89JdGbaE382I+7QB5zAfEwACXuQ5V0tLG7CojA==
X-Received: by 2002:a17:902:f54e:b029:e6:3d74:eb3 with SMTP id h14-20020a170902f54eb02900e63d740eb3mr14103566plf.14.1615562338183;
        Fri, 12 Mar 2021 07:18:58 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d22sm2598884pjx.24.2021.03.12.07.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:18:57 -0800 (PST)
Date:   Fri, 12 Mar 2021 23:18:47 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] common/xfs: add a _require_xfs_shrink helper
Message-ID: <20210312151847.GA272122@xiangao.remote.csb>
References: <20210312132300.259226-1-hsiangkao@redhat.com>
 <20210312132300.259226-2-hsiangkao@redhat.com>
 <20210312152506.GJ3499219@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210312152506.GJ3499219@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Zorro,

On Fri, Mar 12, 2021 at 11:25:06PM +0800, Zorro Lang wrote:
> On Fri, Mar 12, 2021 at 09:22:58PM +0800, Gao Xiang wrote:
> > In order to detect whether the current kernel supports XFS shrinking.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> > ---
> > use -D1 rather than -D0 since xfs_growfs would report unchanged size
> > instead.
> > 
> >  common/xfs | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/common/xfs b/common/xfs
> > index 2156749d..326edacc 100644
> > --- a/common/xfs
> > +++ b/common/xfs
> > @@ -432,6 +432,16 @@ _supports_xfs_scrub()
> >  	return 0
> >  }
> >  
> > +_require_xfs_shrink()
> > +{
> > +	_scratch_mkfs_xfs >/dev/null 2>&1
> > +
> > +	_scratch_mount
> > +	$XFS_GROWFS_PROG -D1 "$SCRATCH_MNT" 2>&1 | grep -q 'Invalid argument' || { \
> > +		_scratch_unmount; _notrun "kernel does not support shrinking"; }
> 	        ^^^^
> 		I think this unmount isn't necessary, due to after "_notrun" the
> 		$SCRATCH_DEV will be umounted "automatically".

I didn't dig into it more. Just follow _require_xfs_scratch_rmapbt().

If it's not necessary (assumed ./check does that), will update it in
the next version. Thanks for your suggestion.

Thanks,
Gao Xiang

