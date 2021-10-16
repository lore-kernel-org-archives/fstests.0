Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEB7C433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 16 Oct 2021 10:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD21160F9D
	for <linux-fstests@archiver.kernel.org>; Sat, 16 Oct 2021 10:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbhJPKLy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 16 Oct 2021 06:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235573AbhJPKLy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 16 Oct 2021 06:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634378985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SyK2zxTIwKVo8oO2MZCi6FpVHsEf6ESQXfMjz9/Dw8I=;
        b=h1NjX0g2gH+eSmccM6ZuWGHSwG2C6JrbUH0S5s6LilwaVjTF3dQb8TINX34Lw28zZ8B8wR
        qkdosY4mrYtlh/AsTBfgTsXWcFu+G3j5ANyUTZkl1vkisk7SsW3RnOFVR74TQVTYyrFGzi
        YmR6Cs7zMlExgPbbjnRyMD9zCXR2v9g=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-lOHVhx7YMa-f0RXpqtp1mw-1; Sat, 16 Oct 2021 06:09:44 -0400
X-MC-Unique: lOHVhx7YMa-f0RXpqtp1mw-1
Received: by mail-pf1-f199.google.com with SMTP id 4-20020a620504000000b0044be2cfac9bso6815175pff.0
        for <fstests@vger.kernel.org>; Sat, 16 Oct 2021 03:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=SyK2zxTIwKVo8oO2MZCi6FpVHsEf6ESQXfMjz9/Dw8I=;
        b=Ih849i/qaSo4QMo3kUm7Eex1wgB5LtZS3FP++xOBMwDcAOOabmxR8oXQ77qdJa18w8
         4x7k//NXStERfbFmuCfpbu6eNvIO39fXStHrWNSFqQ3QXEn7axEIi3DfRxM7nLrM2K57
         AuxvUG/HEcJLPh27qnTznvx7sb+JxQ07kQS+2ec7PIpR1ZLjSaMRzS9QS/61lc4Q/3Sc
         dpgpJHXNFeaFu/6ZW7xAu1XpiXln6AmzTGoxw6vUeGT1hvNXExTDvINohSYmLX43pPyj
         FMRnkj6EbQfcu4qZik87ia680BbpCypnXVqSShLlSqbR5iaf3sD9DWnEWuN3rhpoFAap
         65bQ==
X-Gm-Message-State: AOAM5300JnEMuHiAI4rD0msoHi5KGJHyzKeRXlgJsAmO9y3848Thmcen
        nsMUkepgTXJuExneTre7yMqybRu8Jd4IQ7+KbhtyxVaw4/66USHiZMFNF+Tm7hcuzF9rzdgzQHZ
        tGK8p1AfHqxU4Av4Www==
X-Received: by 2002:a17:902:d50b:b0:13f:69af:5ae7 with SMTP id b11-20020a170902d50b00b0013f69af5ae7mr15936856plg.39.1634378983059;
        Sat, 16 Oct 2021 03:09:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrQ4LjHKFE7/2gqFIx+mHnq6sqJEW4oFNxhxSMdfTG7nKC/inyJCalbiXuMe/N+uVcOwNSqg==
X-Received: by 2002:a17:902:d50b:b0:13f:69af:5ae7 with SMTP id b11-20020a170902d50b00b0013f69af5ae7mr15936829plg.39.1634378982679;
        Sat, 16 Oct 2021 03:09:42 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a28sm7298167pfg.33.2021.10.16.03.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 03:09:42 -0700 (PDT)
Date:   Sat, 16 Oct 2021 18:09:37 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/648: dmerror must be unmounted
Message-ID: <20211016100937.jq3i2kgnykszqmbk@fedora>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        fstests@vger.kernel.org
References: <20211016021456.3097323-1-zlang@redhat.com>
 <20211016035024.GI24282@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016035024.GI24282@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Oct 15, 2021 at 08:50:24PM -0700, Darrick J. Wong wrote:
> On Sat, Oct 16, 2021 at 10:14:56AM +0800, Zorro Lang wrote:
> > Sometimes g/648 fail to unmount dmerror with this error:
> > 
> >    umount: /mnt/xfstests/scratch: target is busy.
> > 
> > Even worse, it will cause all later test cases fail as:
> > 
> >   mount: bad usage
> >   Try 'mount --help' for more information.
> >   check: failed to mount $SCRATCH_DEV using specified options
> >   Interrupted!
> > 
> > So we shouldn't _fail directly if dmerror_unmount fails, use a while
> > loop to try to make sure it's unmounted.
> 
> Can we preserve the "iteration XXX scratch unmount failed" message,
> please?

Sure, how about this:
 -	_dmerror_unmount || _fail "iteration $i scratch unmount failed"
 +	_dmerror_unmount >> $seqres.full 2>&1
 +	while [ $? -ne 0 ]; do
 +              echo "iteration $i scratch unmount failed" >> $seqres.full
 +		sleep 1
 +		_dmerror_unmount >> $seqres.full 2>&1
 +	done

Or this (if you don't like the infinite while loop).

 +      is_unmounted=1
 +      for ((j = 0; j < 50; j++)); do
 +              sleep 1
 +              _dmerror_unmount > $tmp.unmount.err 2>&1
 +              if [ $? -eq 0 ];then
 +                      is_unmounted=0
 +                      break
 +              fi
 +      done
 +      if [ $is_unmounted -ne 0 ];then
 +              cat $tmp.unmount.err
 +              _fail "iteration $i scratch unmount failed"
 +      fi

Or other suggestions you have :)

Thanks,
Zorro

> 
> --D
> 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  tests/generic/648 | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/generic/648 b/tests/generic/648
> > index 83dd111d..218f207b 100755
> > --- a/tests/generic/648
> > +++ b/tests/generic/648
> > @@ -104,7 +104,7 @@ for i in $(seq 1 $((25 * TIME_FACTOR)) ); do
> >  		wait > /dev/null 2>&1
> >  		ps -e | grep fsstress > /dev/null 2>&1
> >  	done
> > -	for ((i = 0; i < 10; i++)); do
> > +	for ((j = 0; j < 10; j++)); do
> >  		test -e "$snap_aliveflag" || break
> >  		sleep 1
> >  	done
> > @@ -112,7 +112,11 @@ for i in $(seq 1 $((25 * TIME_FACTOR)) ); do
> >  	# Mount again to replay log after loading working table, so we have a
> >  	# consistent fs after test.
> >  	$UMOUNT_PROG $loopmnt
> > -	_dmerror_unmount || _fail "iteration $i scratch unmount failed"
> > +	_dmerror_unmount > /dev/null 2>&1
> > +	while [ $? -ne 0 ]; do
> > +		sleep 1
> > +		_dmerror_unmount > /dev/null 2>&1
> > +	done
> >  	_dmerror_load_working_table
> >  	if ! _dmerror_mount; then
> >  		_metadump_dev $DMERROR_DEV $seqres.scratch.$i.md
> > -- 
> > 2.31.1
> > 
> 

