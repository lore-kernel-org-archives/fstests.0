Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EEBEB64DD
	for <linux-fstests@archiver.kernel.org>; Tue,  1 Aug 2023 08:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjHAI2U (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 1 Aug 2023 04:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjHAI2T (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 1 Aug 2023 04:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAB6E0
        for <fstests@vger.kernel.org>; Tue,  1 Aug 2023 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690878454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jybatbLWHiEwyKo/IsH0h+m5b95a2rFTTILOHDZqwkM=;
        b=euefUrAaNywCXjTwgkaUQBgLcEdTFjPLxMw3Kt6ZzNiuWwu9LBAgR8JdBGnUW4sTkp6JlT
        T9NT76ejmBKhel2Ed/0BetoIXSpcIT92qf7uE8PDuR0jtbneMhAu8O9NuV37+9JzJGNcZm
        ji7MyCKIV4X4r4jYEWcjjyi505JDxiw=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-5eArl3-OMtGGJMl1qV7IuQ-1; Tue, 01 Aug 2023 04:27:32 -0400
X-MC-Unique: 5eArl3-OMtGGJMl1qV7IuQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a3df1e1f38so10697864b6e.2
        for <fstests@vger.kernel.org>; Tue, 01 Aug 2023 01:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690878452; x=1691483252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jybatbLWHiEwyKo/IsH0h+m5b95a2rFTTILOHDZqwkM=;
        b=TYVJahefh/cD+XrZ2Gxp4pq3hDZtHvbf+IeekmX30oJ6je862cpiTefnaKR14wYdA8
         qRkC3qbo9kV+JO0VT2zCMx+ddMwnlagmg5GZFLE0HsD1irJpxNfM3J9EDA8lmzgXkWeY
         KQwwXxn15WxLJcQ1XH/wDCyN5qazCjNckGWtxccHTCNWOldb+mlNPV8RLsLeILODqpuN
         uXE2ZqRd2DxsCsBEjWXSW6Lp8q3rx+8G6HwAGkmzHKcNZYTEefUj4M2DAVddj4tER44a
         Zbhy253NegXndAPh88lWViNNDi5jfClRIYMR28oTzDi1yBME3OZPaZzC9VDbA/9HhbfO
         DB8A==
X-Gm-Message-State: ABy/qLY4WzxPpzkQs95KOu+H1YZf+mPil1gnOTOA64GDQXPxt9PvE92k
        0zbMWeYZWavYG1VL/y1+jvGB8KJifJCWPURaRmWPxky4WOTgoIm80Js07b017/OBVQ971W+I/Yq
        eGLC5pJPvodjk68E85a8ngSZBMn83utY=
X-Received: by 2002:a05:6358:5e0e:b0:134:e631:fd2b with SMTP id q14-20020a0563585e0e00b00134e631fd2bmr2482154rwn.0.1690878451962;
        Tue, 01 Aug 2023 01:27:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGv+U6HUugzeuT7/hKa1O4tgvwH8pQoXhqbW/bG1fQxCGyMmBNDvbTqMZ8gcg+1Q3NqVgcorA==
X-Received: by 2002:a05:6358:5e0e:b0:134:e631:fd2b with SMTP id q14-20020a0563585e0e00b00134e631fd2bmr2482146rwn.0.1690878451650;
        Tue, 01 Aug 2023 01:27:31 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o12-20020a637e4c000000b005579f12a238sm9426502pgn.86.2023.08.01.01.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 01:27:31 -0700 (PDT)
Date:   Tue, 1 Aug 2023 16:27:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic: add missing $FSX_AVOID to fsx invocations
Message-ID: <20230801082728.ztm2osg5mqwbkii7@zlang-mailbox>
References: <20221105182918.24099-1-tytso@mit.edu>
 <20221106121031.ywrlqu6w54kgnn2i@zlang-mailbox>
 <Y2gqpYhf5n8Y43eZ@mit.edu>
 <20221107020236.gdlmb5hxsaxxislo@zlang-mailbox>
 <Y2kzxKnYf8CLj49v@mit.edu>
 <20230207182656.ekjt2lhbid6xf2cs@zlang-mailbox>
 <20230728203040.GA610919@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728203040.GA610919@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jul 28, 2023 at 04:30:40PM -0400, Theodore Ts'o wrote:
> On Wed, Feb 08, 2023 at 02:26:56AM +0800, Zorro Lang wrote:
> > fstests has merged below change 2 month ago:
> >   [PATCH] fstests: update group name according to xfs_io command requirement
> >   https://lore.kernel.org/fstests/20221108183242.3362013-1-zlang@kernel.org/
> > 
> > So I'd like to check if it helps for the problem you described above?
> > If not, I think we can think about the patch you metioned above.
> 
> Oops, sorry, this got lost in my inbox.  :-(
> 
> It definitely helped, thanks.  My one observation about this patch is
> that it's a one-time fix-up.  I tried rerunning the script referenced
> in the patch, and there were 11 tests that it "fixed up".  Now, they
> were all adding tests to the "prealloc" group, which I think you had
> deliberately excluded, because they weren't actually testing prealloc,
> but it's the worry that future fstests developers might forget to set
> the group name correctly, which is why I still have "common: introduce
> XFS_IO_AVOID env var"[1] as an out of tree patch.
> 
> [1] https://lore.kernel.org/all/1445107518-32022-1-git-send-email-tytso@mit.edu/
> 
> It's a small change, it almost never conflicts with upstream changes
> (generally the only time I have to deal with a conflcit when rebasing
> is when a new environment variable is added to the documentation in
> README), and it means that when I run "kvm-xfstests --no-collapse", my
> wrapper scripts do this:
> 
>     no_collapse)
>         ALL_FSSTRESS_AVOID="$ALL_FSSTRESS_AVOID -f collapse=0"
>         ALL_FSX_AVOID="$ALL_FSX_AVOID -C"
>         ALL_XFS_IO_AVOID="$ALL_XFS_IO_AVOID fcollapse"
>         FSTESTSET="$FSTESTSET -x collapse"
>         ;;
> 
> and I'm *guaranteed* to make sure that any tests involving
> collapse_range will be skipped.  Do I strictly speaking need the
> out-of-tree patch in [1], probably not, assuming the group list is
> always kept up to date, and to be honest it's been a *long* time since
> I've never needed to use gce-xfstests --no-collapse or --no-insert.

Many thanks, glad to know that helps.

Tell the truth, the "XFS_IO_AVOID" is more like a trick of the "exclude
individual tests (./check -X)". If a case contains an operation (e.g. collapse),
we can't skip it by group name, but can do that through a trick. That
cause fstests leave a "group name missing bug" there, and we even try to hide
it.

So the best way I think is anyone who can't skip a test properly by a
group name, please report that bug to fstests. Let's fix it. BTW, I really
tried to notice the missed group name from that day when I review new cases,
especially if there're some obvious xfs_io operations. But some operations
might be hide, feel free to report/fix that if anyone find :)

Thanks,
Zorro

> 
> However, the cost of keeping the out-of-tree patch in my local
> xfstests git repo is quite low, so I've just kept it.  But do I *need*
> it?  Arguably, no, which is why I haven't been bugging you about it.
> :-)
> 
> 						- Ted
> 

