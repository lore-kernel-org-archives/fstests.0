Return-Path: <SRS0=n5xI=4M=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9C7C35670
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Feb 2020 01:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E122071C
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Feb 2020 01:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJd7fb62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgBXBfP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Feb 2020 20:35:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34445 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgBXBfP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Feb 2020 20:35:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id j4so4280391pgi.1
        for <fstests@vger.kernel.org>; Sun, 23 Feb 2020 17:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HypwtMwzm3OMiU18WgtmMvsLetNuUnfXzhmDDXSXZIM=;
        b=KJd7fb62CkJOYjZrG9esgQxIdpdcqux92qk22qRWBwjick1FJq3+Rc46m6bWPMR3/l
         Y0Z+LDlRfAk9dz8poIX3iYqAIJWv9ey8cfAfRbC+sV+uDd8QYdDjdvhEjKF9OzN68cLM
         BFb/TmeCHYX0/djleHCjNkeJ+yFeYyh47NuWWuB5uKH4ECD1xRNG1f9BejLJbONVGnQw
         I4ww6EBl16zNo24kj0En9D3bFyVDrCNEx5eaw06bEZewS24QsXGezCHSXQVaWvkZsAQy
         xq9oLskbYDnDiJ2NU+sqkQ++YxwFrCiojdXL92BZlPgjpdXjf2vA+StJMICGfAkU1Obc
         097Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HypwtMwzm3OMiU18WgtmMvsLetNuUnfXzhmDDXSXZIM=;
        b=VAgazI+N4T4VIQFmdBQfwQsUvmxgAdjEFyhYl6Qn5Qx9mx1RhoIujgARetBZfpRPRC
         gtoDTYFv5ZoKXqKmj+S2r0O0OqXGTsLN4jj+g/QlZrOfv7Oj7gf0dtf7mynQLyT/4K0l
         obYoQJ53SJgBwNS/wLc/4UJO2uuCapPekub/7GhP+FoGCnAM0Sp+W2Xtjav8De5Fn99u
         bXXnC56csM/Y5/0etueo10fzaFaB6oXAsHMVoM8x8rQnzuHoM3i/CuQfefkPhShFGCAL
         uGaD5pQjPttoCXQ5DjehjRSscWHE377V+Vte9jaA2Q6s/jPKobKYGYgiGbdt6ZAR4Q2f
         1+Kw==
X-Gm-Message-State: APjAAAWjfFKQgaRTVA+J3LL0mx2dwEWBnZRyBsq+MifC+lqjJgSrY0Bw
        yjOnYsmrQVe1SWoGdXFbwQx9DQK9JI3mKg==
X-Google-Smtp-Source: APXvYqz52R5lEGyP1oNa1Vm3C8z7ZJoXrD8hFObBXVXEgLG2M4lvT5g4HQx1wQY+b+2wDOJY+c00DQ==
X-Received: by 2002:a63:d90c:: with SMTP id r12mr53505689pgg.106.1582508113213;
        Sun, 23 Feb 2020 17:35:13 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id o29sm10395895pfp.124.2020.02.23.17.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 17:35:12 -0800 (PST)
Date:   Mon, 24 Feb 2020 09:35:05 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     zlang@redhat.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/513: fix 4k allocsize fails on 64k pagesize
Message-ID: <20200224013502.GH3840@desktop>
References: <20200218165818.21066-1-zlang@redhat.com>
 <20200223124545.GB3840@desktop>
 <20200223161818.GN14282@dhcp-12-102.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223161818.GN14282@dhcp-12-102.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Feb 24, 2020 at 12:18:19AM +0800, Zorro Lang wrote:
> On Sun, Feb 23, 2020 at 08:45:48PM +0800, Eryu Guan wrote:
> > On Wed, Feb 19, 2020 at 12:58:18AM +0800, Zorro Lang wrote:
> > > The minimal I/O preallocation size is page size. The allocsize=4k
> > > always fails on 64k pagesize machine. So change the fs blocksize
> > > allocsize test to allocsize=64k.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > 
> > I think it's better to make the page size auto-detected, and filter out
> > the actual size to something like "PAGESIZE" in .out file.
> > 
> > > ---
> > >  tests/xfs/513     | 4 ++--
> > >  tests/xfs/513.out | 2 +-
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/tests/xfs/513 b/tests/xfs/513
> > > index 70bc2f1c..3c3f5163 100755
> > > --- a/tests/xfs/513
> > > +++ b/tests/xfs/513
> > > @@ -178,13 +178,13 @@ do_test()
> > >  
> > >  echo "** start xfs mount testing ..."
> > >  # Test allocsize=size
> > > -# Valid values for this option are page size (typically 4KiB) through to 1GiB
> > > +# Valid values for this option are page size through to 1GiB

From this test description, it seems we're not only testing the
arg-parsing part, but also testing if kernel could mount the ending fs.
So I thought changing 4k to 64k would lose some test coverage, the
normal 4k pagesize case is lost.

> > >  do_mkfs
> > >  if [ $dbsize -ge 1024 ];then
> > >  	blsize="$((dbsize / 1024))k"
> > >  fi
> > >  do_test "" pass "allocsize" "false"
> > > -do_test "-o allocsize=$blsize" pass "allocsize=$blsize" "true"
> > > +do_test "-o allocsize=64k" pass "allocsize=64k" "true"
> > 
> > do_test "-o allocsize=PAGESIZE" pass "allocsize=PAGESIZE" "true"
> > 
> > And do_test converts the "PAGESIZE" to actual page size.
> 
> I thought about that too, but due to this case only uses PAGESIZE once
> at here. So I don't know if it's worth changing much code for that.
> And I don't think the PAGESIZE is necessary for this test, 4k and 64k
> are all fine for me. The case just trys to make sure 4k/64k can be parsed by
> fs_parse().

If it only wants to make sure fs_parse() could parse the arg, then I'm
fine with the fix.

Thanks,
Eryu

> 
> What do you think?
> 
> Thanks,
> Zorro
> 
> > 
> > >  do_test "-o allocsize=1048576k" pass "allocsize=1048576k" "true"
> > >  do_test "-o allocsize=$((dbsize / 2))" fail
> > >  do_test "-o allocsize=2g" fail
> > > diff --git a/tests/xfs/513.out b/tests/xfs/513.out
> > > index 9be18dd8..2d9f8384 100644
> > > --- a/tests/xfs/513.out
> > > +++ b/tests/xfs/513.out
> > > @@ -5,7 +5,7 @@ QA output created by 513
> > >  ** start xfs mount testing ...
> > >  FORMAT: 
> > >  TEST: "" "pass" "allocsize" "false"
> > > -TEST: "-o allocsize=4k" "pass" "allocsize=4k" "true"
> > > +TEST: "-o allocsize=64k" "pass" "allocsize=64k" "true"
> > 
> > So .out prints "... allocsize=PAGESIZE" ...
> > 
> > Thanks,
> > Eryu
> > 
> > >  TEST: "-o allocsize=1048576k" "pass" "allocsize=1048576k" "true"
> > >  TEST: "-o allocsize=2048" "fail"
> > >  TEST: "-o allocsize=2g" "fail"
> > > -- 
> > > 2.20.1
> > > 
> > 
> 
