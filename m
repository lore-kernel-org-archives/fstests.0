Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29C1C4332F
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Oct 2022 11:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJRLLj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Oct 2022 07:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJRLLj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Oct 2022 07:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4BB8768F
        for <fstests@vger.kernel.org>; Tue, 18 Oct 2022 04:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666091496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0rL1OOo1oTyl8o49xI4/ME6aKEAO616FTJYfN4p7neA=;
        b=GdySTRz6inEuJH8PzadgpPxuqGfNxcybVcuKPgT+WpvjclHYRzFiZIjQL2GY35EItp5cIb
        qUIitCDQzUivSrsyjOEiokLTqypveE1lT0JFaDSFlRAff0V1jDcD+iaQtzGbfFUdDE4u80
        9DwUz2qbHQAZ9Dcs7+8Ubbd/KMPn3y8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-240-45mTH5lDPgeHP8CQP6A6fg-1; Tue, 18 Oct 2022 07:11:34 -0400
X-MC-Unique: 45mTH5lDPgeHP8CQP6A6fg-1
Received: by mail-pf1-f199.google.com with SMTP id n56-20020a056a000d7800b00562b27194d1so7636841pfv.19
        for <fstests@vger.kernel.org>; Tue, 18 Oct 2022 04:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rL1OOo1oTyl8o49xI4/ME6aKEAO616FTJYfN4p7neA=;
        b=4ZHiaXHp0X0/KAId7o9TrlIbmnUJojZzVZraVJNwzpG3KFADtXSjE93F594suxfubE
         yjT7ph8Ugd1m3xXu2RBUhAGuwcQF3Kths0EZdFrMSNmpzZ/N3jHahM1c330J1pSc2VRO
         UjgMxGcEw9+pxmhyr+F7jTQl9cBiF+N5fm6fyu0b3KX5C/Z9nGqu/+0qpOWbLTrDVww3
         mIqHgwXIP3gx/klYSBGMxgTS9EDufoavC7vUQiEg9Y/c5mAao/eR9D//hHKrkqQ+lh78
         l+oUBozuOJ8xm/SjWx3SVEtyFY/YLerQZtxC1GCi1QxOxodypbNcQRk3kqyQGKkGWtC+
         6Mcw==
X-Gm-Message-State: ACrzQf1klCeRtwDCPDMFlIcK6LJK2ObceKpDkKy5o/tycgRcTVi9ozFd
        ts7Qm5J1eMwwh3BA6rxUGVvUVY8Ji3zgKaqe8jwG4D3Zloz85z+eV5v6zrqzgisbZn1h0GbyVVE
        T8q5dOzy4KuGw1xdLAQ==
X-Received: by 2002:a17:90b:4d8c:b0:20d:2935:7058 with SMTP id oj12-20020a17090b4d8c00b0020d29357058mr38361107pjb.86.1666091493121;
        Tue, 18 Oct 2022 04:11:33 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM58M27WQR3283HkkCBFH6uN1hmQJXNI8eZezWrtDK2iQxbDqfKYCq0Jjt6x4ZBICUEIFgfABQ==
X-Received: by 2002:a17:90b:4d8c:b0:20d:2935:7058 with SMTP id oj12-20020a17090b4d8c00b0020d29357058mr38361070pjb.86.1666091492663;
        Tue, 18 Oct 2022 04:11:32 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709027ec100b00172973d3cd9sm8341361plb.55.2022.10.18.04.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 04:11:31 -0700 (PDT)
Date:   Tue, 18 Oct 2022 19:11:27 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "brauner@kernel.org" <brauner@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] Add more suid/sgid related cases to perms group
Message-ID: <20221018111127.kjoo6vqjwkhncca6@zlang-mailbox>
References: <1666066330-2006-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20221018061613.ul7nqupy3g34vjqe@zlang-mailbox>
 <a5c5b77d-efe7-6535-90c4-f2e0c4ffe65b@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5c5b77d-efe7-6535-90c4-f2e0c4ffe65b@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 18, 2022 at 06:25:18AM +0000, xuyang2018.jy@fujitsu.com wrote:
> Hi Zorro
> 
> > On Tue, Oct 18, 2022 at 12:12:10PM +0800, Yang Xu wrote:
> >> Just use the following ways to look for these cases
> >> 1) grep -nsr suid or grep -nsr sgid
> >> 2) grep -nsr chmod | grep "+s"
> >> 3) grep -nsr ISUID/ISGID then search execute program ie(vfstest/idmapped_mounts)
> >>
> >> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> >> ---
> >>   tests/generic/193 | 2 +-
> >>   tests/generic/355 | 2 +-
> >>   tests/generic/673 | 2 +-
> >>   tests/generic/674 | 2 +-
> >>   tests/generic/683 | 2 +-
> >>   tests/generic/684 | 2 +-
> >>   tests/generic/685 | 2 +-
> >>   tests/generic/686 | 2 +-
> >>   tests/generic/687 | 2 +-
> >>   tests/overlay/015 | 2 +-
> >>   10 files changed, 10 insertions(+), 10 deletions(-)
> > 
> > According to the definition of "perms" group:
> >    perms                   access control and permission checking
> > 
> > It's not only about suid/sgid. I try to check more (roughly), find below
> > cases[1] might be related with "perms", please double check and add more proper
> > cases into perms group (if there're more).
> 
> Ok, will do. Can you share which simple way you used to find these cases?

No special way, just "grep -rsni xxx" some key words then look into the case
source code to double check. The key words include permission, acl, chown,
chmod, suid, sgid, etc.

Thanks,
Zorro

> 
> Best Regards
> Yang Xu
> > 
> > Thanks,
> > Zorro
> > 
> > [1]
> > generic/099, generic/105, generic/128, generic/237, generic/314, generic/318,
> > generic/319, generic/362, generic/363, generic/364, generic/365, generic/366,
> > generic/367, generic/368, generic/369, generic/370, generic/375, generic/444,
> > generic/698, generic/699, overlay/004, overlay/008, overlay/023
> > 
> >>
> >> diff --git a/tests/generic/193 b/tests/generic/193
> >> index ddaff69b..e2710b07 100755
> >> --- a/tests/generic/193
> >> +++ b/tests/generic/193
> >> @@ -7,7 +7,7 @@
> >>   # Test permission checks in ->setattr
> >>   #
> >>   . ./common/preamble
> >> -_begin_fstest metadata auto quick
> >> +_begin_fstest metadata auto quick perms
> >>   
> >>   _register_cleanup "_cleanup_files"
> >>   tag="added by qa $seq"
> >> diff --git a/tests/generic/355 b/tests/generic/355
> >> index 4bc69eeb..7c108d1b 100755
> >> --- a/tests/generic/355
> >> +++ b/tests/generic/355
> >> @@ -7,7 +7,7 @@
> >>   # Test clear of suid/sgid on direct write.
> >>   #
> >>   . ./common/preamble
> >> -_begin_fstest auto quick
> >> +_begin_fstest auto quick perms
> >>   
> >>   # Import common functions.
> >>   . ./common/filter
> >> diff --git a/tests/generic/673 b/tests/generic/673
> >> index 4d8dc07e..6d1f49ea 100755
> >> --- a/tests/generic/673
> >> +++ b/tests/generic/673
> >> @@ -7,7 +7,7 @@
> >>   # Functional test for dropping suid and sgid bits as part of a reflink.
> >>   #
> >>   . ./common/preamble
> >> -_begin_fstest auto clone quick
> >> +_begin_fstest auto clone quick perms
> >>   
> >>   # Import common functions.
> >>   . ./common/filter
> >> diff --git a/tests/generic/674 b/tests/generic/674
> >> index a3130249..c3ff1b7b 100755
> >> --- a/tests/generic/674
> >> +++ b/tests/generic/674
> >> @@ -7,7 +7,7 @@
> >>   # Functional test for dropping suid and sgid bits as part of a deduplication.
> >>   #
> >>   . ./common/preamble
> >> -_begin_fstest auto clone quick
> >> +_begin_fstest auto clone quick perms
> >>   
> >>   # Import common functions.
> >>   . ./common/filter
> >> diff --git a/tests/generic/683 b/tests/generic/683
> >> index 4c93346d..302f8bb2 100755
> >> --- a/tests/generic/683
> >> +++ b/tests/generic/683
> >> @@ -7,7 +7,7 @@
> >>   # Functional test for dropping suid and sgid bits as part of a fallocate.
> >>   #
> >>   . ./common/preamble
> >> -_begin_fstest auto clone quick
> >> +_begin_fstest auto clone quick perms
> >>   
> >>   # Override the default cleanup function.
> >>   _cleanup()
> >> diff --git a/tests/generic/684 b/tests/generic/684
> >> index 03481e69..19ccb228 100755
> >> --- a/tests/generic/684
> >> +++ b/tests/generic/684
> >> @@ -7,7 +7,7 @@
> >>   # Functional test for dropping suid and sgid bits as part of a fpunch.
> >>   #
> >>   . ./common/preamble
> >> -_begin_fstest auto clone quick
> >> +_begin_fstest auto clone quick perms
> >>   
> >>   # Override the default cleanup function.
> >>   _cleanup()
> >> diff --git a/tests/generic/685 b/tests/generic/685
> >> index 6a108842..a58eccda 100755
> >> --- a/tests/generic/685
> >> +++ b/tests/generic/685
> >> @@ -7,7 +7,7 @@
> >>   # Functional test for dropping suid and sgid bits as part of a fzero.
> >>   #
> >>   . ./common/preamble
> >> -_begin_fstest auto clone quick
> >> +_begin_fstest auto clone quick perms
> >>   
> >>   # Override the default cleanup function.
> >>   _cleanup()
> >> diff --git a/tests/generic/686 b/tests/generic/686
> >> index 4279f76b..ef9ea47a 100755
> >> --- a/tests/generic/686
> >> +++ b/tests/generic/686
> >> @@ -7,7 +7,7 @@
> >>   # Functional test for dropping suid and sgid bits as part of a finsert.
> >>   #
> >>   . ./common/preamble
> >> -_begin_fstest auto clone quick
> >> +_begin_fstest auto clone quick perms
> >>   
> >>   # Override the default cleanup function.
> >>   _cleanup()
> >> diff --git a/tests/generic/687 b/tests/generic/687
> >> index 78cb6202..f4a1c1bb 100755
> >> --- a/tests/generic/687
> >> +++ b/tests/generic/687
> >> @@ -7,7 +7,7 @@
> >>   # Functional test for dropping suid and sgid bits as part of a fcollapse.
> >>   #
> >>   . ./common/preamble
> >> -_begin_fstest auto clone quick
> >> +_begin_fstest auto clone quick perms
> >>   
> >>   # Override the default cleanup function.
> >>   _cleanup()
> >> diff --git a/tests/overlay/015 b/tests/overlay/015
> >> index fd23e373..f0c05579 100755
> >> --- a/tests/overlay/015
> >> +++ b/tests/overlay/015
> >> @@ -7,7 +7,7 @@
> >>   # SGID bit inheritance over whiteout.
> >>   #
> >>   . ./common/preamble
> >> -_begin_fstest auto quick whiteout
> >> +_begin_fstest auto quick whiteout perms
> >>   
> >>   # Import common functions.
> >>   . ./common/filter
> >> -- 
> >> 2.27.0
> >>
> > 

