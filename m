Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033F7C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 27 May 2022 09:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344626AbiE0J7H (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 27 May 2022 05:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbiE0J7G (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 May 2022 05:59:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80578106365
        for <fstests@vger.kernel.org>; Fri, 27 May 2022 02:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653645544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yKDTUiVZ6gqpE2plUUHPx/eZjcHjrjGMjPuvQSgkA04=;
        b=HYIKbraaqhEfV2g3wVcIF84szQd2ZH0wJRQIRBijplWwaqjotHXYWJ1BiD8/ZOJ3ju7+T+
        ZRCW/6dBfWIZhxVfnC9SXvFtN0Uafglfuonlf7UyLsI7Kdg8dPx2TqeA3MA6Naruxx5g3I
        vJxOu/lFbII6EW+T3v17gkyETmLP1M8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-WV8K00ftOWG75XAFZWd5_w-1; Fri, 27 May 2022 05:59:03 -0400
X-MC-Unique: WV8K00ftOWG75XAFZWd5_w-1
Received: by mail-qt1-f199.google.com with SMTP id a6-20020ac81086000000b002f65fd83048so3978723qtj.6
        for <fstests@vger.kernel.org>; Fri, 27 May 2022 02:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yKDTUiVZ6gqpE2plUUHPx/eZjcHjrjGMjPuvQSgkA04=;
        b=IfZ/h+EXqIQQvkajFkGxFYL7/r42PPM9b9ryiYKChzBncY4V3QgMQxiPt+xxgZ4bLG
         BmAU8v5nrFu33DOc2BQ5ZZgVIEQbsQqsgfRa5+jK05Tie0Y3QdbDMrOASgIoWUmwIDpN
         qQu2wO3472RdS2SNFjEe0P6HWGPYp1QZMbQ3J6aKslB5abqMWkiKoZNGDskUxjxzlqb7
         b5M9wTxBzX/Fa6Z4gQLxm/n/9oX1+oyt/V3qcnYsqtd9oxUhk8MMcmdLw/kFAZeHWbB1
         oKAw7pq4PY08JgeTgwDsmm/hQTDoyAo0G0O0HmV4xi5MWe19tIMWo9sJtHOJvn1/KwEw
         MazA==
X-Gm-Message-State: AOAM530bbH5s3foj3t2mP6besOYMGghsWw2MEm98tM8lM1SPVVNwsmCN
        GFj/cg1M2cpEwed94JvErj7/qDIeLa+PooZ7p64cMws0hUHEbYq6abWNb38hU/lHN/YHsOew9m0
        3AYYiAVTLwkdhRTP0JQ==
X-Received: by 2002:a05:622a:138a:b0:2f3:e12d:a023 with SMTP id o10-20020a05622a138a00b002f3e12da023mr32293865qtk.82.1653645542159;
        Fri, 27 May 2022 02:59:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrRe9SJR5Mwe28rWl4M3IjQr02HSsecXIRqisdM1lwyYF/mx+kOWMR4vlQDtrusRjn+O9PIw==
X-Received: by 2002:a05:622a:138a:b0:2f3:e12d:a023 with SMTP id o10-20020a05622a138a00b002f3e12da023mr32293858qtk.82.1653645541834;
        Fri, 27 May 2022 02:59:01 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bq15-20020a05620a468f00b006a5a07bb868sm2725704qkb.119.2022.05.27.02.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 02:59:01 -0700 (PDT)
Date:   Fri, 27 May 2022 17:58:54 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: filter out extra mount error
Message-ID: <20220527095854.lx2xhz2kpec7zah2@zlang-mailbox>
References: <20220526095704.3772355-1-zlang@kernel.org>
 <20220526234506.GC3923443@dread.disaster.area>
 <20220527042129.n3lmqzxzeghuulxp@zlang-mailbox>
 <20220527091330.GE3923443@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527091330.GE3923443@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 27, 2022 at 07:13:30PM +1000, Dave Chinner wrote:
> On Fri, May 27, 2022 at 12:21:29PM +0800, Zorro Lang wrote:
> > On Fri, May 27, 2022 at 09:45:06AM +1000, Dave Chinner wrote:
> > > On Thu, May 26, 2022 at 05:57:04PM +0800, Zorro Lang wrote:
> > > > The lastest mount command (from util-linux) merged below commit:
> > > >   79534c0d7e0f ("mount: add hint about dmesg(8) to error messages")
> > > > which brought in a new error output when mount fails.
> > > > 
> > > > That cause some cases (e.g. xfs/005) fail as:
> > > >   mount: Structure needs cleaning
> > > >          dmesg(1) may have more information after failed mount system call
> > > > 
> > > > More failed cases like generic/050, ext4/002, xfs/154, etc ...
> > > > 
> > > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > > ---
> > > > 
> > > > Due to _try_scratch_mount is call in many places, so I'm not sure if it's good
> > > > to filter this message in _try_scratch_mount. Maybe better to filter it in each
> > > > failed cases? Or write another function (e.g. _try_scratch_mount_fail) ?
> > > > Welcome review points.
> > > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > >  common/rc | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/common/rc b/common/rc
> > > > index 70a15f9c..67342760 100644
> > > > --- a/common/rc
> > > > +++ b/common/rc
> > > > @@ -335,7 +335,8 @@ _try_scratch_mount()
> > > >  		_overlay_scratch_mount $*
> > > >  		return $?
> > > >  	fi
> > > > -	_mount -t $FSTYP `_scratch_mount_options $*`
> > > > +	_mount -t $FSTYP `_scratch_mount_options $*`  2> \
> > > > +		>(grep -v "dmesg(1) may have more information after failed mount" >&2)
> > > 
> > > _filter_error_mount()?
> > 
> > OK, how about this change [1] ?
> > 
> > Do you think doing this "filter out" in _try_scratch_mount is better, or in
> > each case which expects mount failures in .out file (e.g. xfs/005) ? Or a new
> > _try_scratch_mount_fail() ?
> 
> I think you missed my point entirely. We already have a filter for this in
> common/filter because util-linux has changed it's failure message for
> EFSCORRUPTED several times:

Oh, sorry, I didn't notice that there's a _filter_error_mount. I thought you
hope to have one. Thanks, I'll change that function and try to find out all
test cases which use mount errors as golden image.

Thanks,
Zorro

> 
> # Filter a failed mount output due to EUCLEAN and USTALE, util-linux changed
> # the message several times.
> #
> # prior to v2.21:
> # mount: Structure needs cleaning
> # v2.21 to v2.29:
> # mount: mount <device> on <mountpoint> failed: Structure needs cleaning
> # v2.30 and later:
> # mount: <mountpoint>: mount(2) system call failed: Structure needs cleaning.
> #
> # This is also true for ESTALE error. So let's remove all the changing parts
> # and keep the 'prior to v2.21' format:
> # mount: Structure needs cleaning
> # mount: Stale file handle
> _filter_error_mount()
> {
>         sed -e "s/mount:\(.*failed:\)/mount:/" | _filter_ending_dot
> }
> 
> 
> So, capture and supress the new output via _filter_error_mount() and
> use that in the specific tests that are trying to mount a corrupt
> filesystem and capture that specific error message in their golden
> output....
> 
> Cheers,
> 
> Dave.
> 
> 
> -- 
> Dave Chinner
> david@fromorbit.com
> 

