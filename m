Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F0AC433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 22 May 2022 01:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbiEVBZs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 21 May 2022 21:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbiEVBZr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 21 May 2022 21:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A69035ABF
        for <fstests@vger.kernel.org>; Sat, 21 May 2022 18:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653182744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zdPBWrD96fSukOd+Ai3cFI4v6cCBG6ng6yMWWNFHJEg=;
        b=R35JN47KOlaXKg279Jmm3iaJvBGf6W9Y5LzA7u6Ix79FJOxWbiuMhujIpd4M+nxKs/uaRd
        3cy18veHaUjQZXVi5wCHtw4sZJutoCdfj3TapasXUqvooFNiKrYDnSyAPDquLM6b6YCrA/
        1vfkURbSah47wW8auiNpysVOYWa+/JM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-cAoWYQ9UOqSJLCDd4pl7QA-1; Sat, 21 May 2022 21:25:03 -0400
X-MC-Unique: cAoWYQ9UOqSJLCDd4pl7QA-1
Received: by mail-qt1-f197.google.com with SMTP id t25-20020a05622a181900b002f3b32a6e30so9171510qtc.11
        for <fstests@vger.kernel.org>; Sat, 21 May 2022 18:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zdPBWrD96fSukOd+Ai3cFI4v6cCBG6ng6yMWWNFHJEg=;
        b=x1AE1pCro/JGTlr+y0tbdxhX6lTIEvbGnVUqFS3M1Zz0taNB9nlA6pLYImcmiqggQR
         bTqeoGqSFEZ1I54LqpST0V9Xh/MTy6Y00NR28v9waoJnKHPGlp0q3zg5KO7w6V8DeyFn
         +tneYutoXVhZ+ksfr7ETyvOHP8NMA743WKloETKXMUn8UGXG5l3OK+m8HC8GCMLYsMrS
         Nu4FT/2G0dInckvK/y7jPBBG++JVCs2Rw6+6Sa/akFInJT/ylVDWMgO/IcmqVSpWdSDD
         OXOOu9C30Lj4GS/E7XnWYGAXy7+W55S67xdYSaf507G6Y7xlmni6VqFXkUoWzX25RVtd
         UTDw==
X-Gm-Message-State: AOAM531rHKgyoDkx7CDxR6YORjhByv+6zJqh+LWOEmTbQgvX30xQVB+T
        1GCT03DEJQmQjPySGNcfjvxJAo7zqpfiq1OAz2+IOTaiVJHPSrgUzW/I54nmefjLh7yuGuT0zab
        6OMvp/VxJrnP/VbfYYA==
X-Received: by 2002:a37:5587:0:b0:6a3:62ff:ee8c with SMTP id j129-20020a375587000000b006a362ffee8cmr3686840qkb.694.1653182702403;
        Sat, 21 May 2022 18:25:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfAABaxkOKhWWjGijkbk+9Tt2EN8AKqGd9ZGuYWHDlzrbj1bvjWvR0pInzfEKR4AOGBbQz5Q==
X-Received: by 2002:a37:5587:0:b0:6a3:62ff:ee8c with SMTP id j129-20020a375587000000b006a362ffee8cmr3686834qkb.694.1653182702096;
        Sat, 21 May 2022 18:25:02 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v15-20020ac8748f000000b002f9114d2ebcsm2009990qtq.17.2022.05.21.18.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 18:25:01 -0700 (PDT)
Date:   Sun, 22 May 2022 09:24:55 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
        djwong@kernel.org
Subject: Re: [PATCH] tools/mkgroupfile: help the cases of group.list in
 number order
Message-ID: <20220522012455.catu32p2tsijlk7m@zlang-mailbox>
References: <20220521054349.1691473-1-zlang@kernel.org>
 <20220521231748.GZ2306852@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521231748.GZ2306852@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, May 22, 2022 at 09:17:48AM +1000, Dave Chinner wrote:
> On Sat, May 21, 2022 at 01:43:49PM +0800, Zorro Lang wrote:
> > The mkgroupfile doesn't sort cases in number order, that cause
> > fstests' ./new script can't find a proper number which isn't taken.
> > The unsorted case number might cause more problems, so fix it.
> 
> Yet more reason for these group lists to die and get replaced with a
> common generation function.
> 
> > Fixes: 441606d28681 ("fstests: faster group file creation")
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> > 
> > Hi,
> > 
> > If you'd like to fix this issue seperately, I can merge this patch with Dave's
> > "[PATCH 04/12] fstests: fix group list generation for whacky test names"
> > together.
> 
> It needs documentation updates, too. I had no idea that the group

I've merged below changes[1]. As other two patches[2] need more changes, so how
about we add it into doc by "[PATCH 05/12] README: document _begin_fstests
better"? Or I can send another documentation patch to do that next week :) I
hope to fix this regression issue today, due to it's been 2 weeks since we
brought in it.

[1]
68497440 tools/mkgroupfile: help the cases of group.list in number order
1a04a7c9 fstests: fix group list generation for whacky test names
e6d4d963 fstests: remove xfs deprecated test
c1941d6f xfs/191: remove broken test
6812c3b2 xfs/148: fix failure from bad shortform size assumptions
460c4604 xfs/148: make test debuggable
dbcc5493 xfs/348: golden output is not correct
9a392f8d xfs/122: add attribute log formats to test output.
307f0514 fstests: filter quota warnings

[2]
[PATCH 05/12] README: document _begin_fstests better
[PATCH 08/12] generic/081: don't run on DAX capable devices


> list files were used by the new script or that there was a
> requirement for them to be sorted into numerical order.

Sorry, I didn't notice that either, until I tried to write a new case.
When you have any better idea to replace the current group list method,
feel free to share :)

Thanks,
Zorro

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

