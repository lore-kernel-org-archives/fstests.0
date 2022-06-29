Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAFEC43334
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 09:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiF2JNA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 05:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiF2JM7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 05:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A5251D0FD
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 02:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656493978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PHkzl/CtxfMEiDrBCMjqTBVk/1t45A9zbY4QPN+Lk68=;
        b=PYS7CLE6VPrm4xpLu/AJo+WDORxN6GcrS6ZMDx78hmSZ5GlPGVmypEpxI/V0MkdmSmjg8t
        PqCO54d8Yfk2w/Hr8HbQtkMHJmM80B96N2vv+Tz4oo61WH7uoYRbD8C4AzSFMwYWhnPaDG
        B7ssXOi1zwgrKOd3/5voJ++9FkBlE5o=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-rzQnKaklNOOnM0ndyX--aQ-1; Wed, 29 Jun 2022 05:12:56 -0400
X-MC-Unique: rzQnKaklNOOnM0ndyX--aQ-1
Received: by mail-qv1-f70.google.com with SMTP id f6-20020a0cbec6000000b004728234508bso5274022qvj.8
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 02:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PHkzl/CtxfMEiDrBCMjqTBVk/1t45A9zbY4QPN+Lk68=;
        b=eENWb7779q/VQEd3lEuTaJKaf59Hk9omwKqGRJKTHkFIlg8Jd++zXWLaF3t+hcjyaz
         6lYOQ1jCbtoM9aN9mLlO86g0k936UJxFJW2z8IhrHkkrYVqzojPBFEuU3zucKDJHcnJ4
         fZUemDETR4OZbRqEROu7GeSsEo0kvTDy5ATOo5seRuHT+kyubwUtDC2Jb7Uk2NOPlVa8
         d+GoISzJcwD0k+IRLKiXqAvqra5QK6qPKvKaFwbFK+Gx0BJLX8X+FlmhPJJAylySVSQw
         TmQni5Miwtn46rC2h2DO4g/bsdEcyYWgpyJpanzdYpvO3K7yYwsi3YlV+RpIxOE6Gysu
         jPHg==
X-Gm-Message-State: AJIora8SkOcpCRs8m+j3KSXiJ7PZsN+igP/W7laYKzTPcwCdf8Z9CJNQ
        M7TV2tlpw/uWIhgaJxxjZ2VcgNn/eom6Wbxw5jIQQfrLRvESoxAmbCO/jVQt+9JKiXM15h8CzM0
        rh9NzpJcOssJuLY2kNQ==
X-Received: by 2002:ac8:584b:0:b0:31b:efad:e020 with SMTP id h11-20020ac8584b000000b0031befade020mr1461179qth.425.1656493976170;
        Wed, 29 Jun 2022 02:12:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vxPr2jKgDwkUQSZ+OnlrTusU8D4te8AP8eevk1tsKEwY1lBipsJ+RbHgcqLIL8sr82M3GFYw==
X-Received: by 2002:ac8:584b:0:b0:31b:efad:e020 with SMTP id h11-20020ac8584b000000b0031befade020mr1461165qth.425.1656493975905;
        Wed, 29 Jun 2022 02:12:55 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r4-20020ac84244000000b00317ca023e33sm10056891qtm.80.2022.06.29.02.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:12:55 -0700 (PDT)
Date:   Wed, 29 Jun 2022 17:12:48 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH 2/9] xfs/070: filter new superblock verifier messages
Message-ID: <20220629091248.vtqtlk2wvqkmtxkm@zlang-mailbox>
References: <165644767753.1045534.18231838177395571946.stgit@magnolia>
 <165644768886.1045534.3177166462110135738.stgit@magnolia>
 <20220629041547.GO1098723@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629041547.GO1098723@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 29, 2022 at 02:15:47PM +1000, Dave Chinner wrote:
> On Tue, Jun 28, 2022 at 01:21:28PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > In Linux 5.19, the superblock verifier logging changed to elaborate on
> > what was wrong.  Fix the xfs_repair filtering function to accomodate
> > this development.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  common/repair |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > 
> > diff --git a/common/repair b/common/repair
> > index 463ef9db..398e9904 100644
> > --- a/common/repair
> > +++ b/common/repair
> > @@ -29,6 +29,7 @@ _filter_repair()
> >  # for sb
> >  /- agno = / && next;	# remove each AG line (variable number)
> >  s/(pointer to) (\d+)/\1 INO/;
> > +s/Superblock has bad magic number.*/bad magic number/;
> >  # Changed inode output in 5.5.0
> >  s/sb root inode value /sb root inode /;
> >  s/realtime bitmap inode value /realtime bitmap inode /;
> 
> Didn't I already fix that in commit 4c76d0ba ("xfs/070: filter the
> bad sb magic number error")?

Yes, you've added a line as below:
  s/^Superblock has (bad magic number) 0x.*/\1/;
which is equal to:
  s/Superblock has bad magic number.*/bad magic number/;
So we need to fix it again.

> 
> Cheers,
> 
> Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
> 

