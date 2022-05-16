Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0770C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 22:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345705AbiEPWv2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 18:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347009AbiEPWv1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 18:51:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C93941982
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 15:51:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18D9860B81
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 22:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771F1C385AA;
        Mon, 16 May 2022 22:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652741485;
        bh=HSoEZwIsTBFzlPyBOoF7pi6MlHnqXRhVJ7Y7GME9tVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LEk0YGzhW825ilLIvmZ+B750oQs6K8ng5RWY3McGCZr3gJaK49oH93jbqKXtbdJIW
         lgCvRkbAAbO5up1duIJAUhyPkndk5YoDOil7802HN9zChljVA8JSOMfuuYrwVtSj+r
         kEvNERUEKHu+zhx29xpMSrBQOnWi1332br6vLhzfRSzJ+I1eaMph11PLC1mRvpaO+8
         9+NHIjTCdxzhXLaKJZLVWPZA3Iz37pQoECQwbA6O20WMnDAwAUAE0s8BwjDh7EjMrg
         EypE2hRx0szR9aOyJXClbjvr7ypjLfoFew2Tb1ALcEsXsa4gLmulcmT7p/rUI9uO5F
         WYQSYoHm+MF1w==
Date:   Mon, 16 May 2022 15:51:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Lili Deng <Lili.Deng@microsoft.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Build error for file chprojid_fail.c on ubuntu
 16.04
Message-ID: <YoLVbHQX+PvpJHFM@magnolia>
References: <SI2P153MB0476DF844D7018D0BA4C7E1CE7699@SI2P153MB0476.APCP153.PROD.OUTLOOK.COM>
 <20210318162030.GH22097@magnolia>
 <20210318162208.GI22097@magnolia>
 <SI2P153MB0476DF2BCAC21C87458F5369E7FF9@SI2P153MB0476.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2P153MB0476DF2BCAC21C87458F5369E7FF9@SI2P153MB0476.APCP153.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Apr 30, 2022 at 01:23:05PM +0000, Lili Deng wrote:
> Hi,
> 
> Could you please submit a patch for this issue? Add below lines before using them. Thanks!
> 
>         unsigned int        FS_IOC_FSSETXATTR;
>         unsigned int        FS_XFLAG_EXTSIZE;
>         unsigned int        FS_IOC_FSGETXATTR;

That will break the build on systems where the kernel headers actually
/do/ define those symbols.

Also, this is free software -- as a community member, *you* can propose
patches to fix things.

--D

> Thanks,
> Lili
> > -----Original Message-----
> > From: Darrick J. Wong <djwong@kernel.org>
> > Sent: Friday, March 19, 2021 12:22 AM
> > To: Lili Deng <Lili.Deng@microsoft.com>
> > Subject: [EXTERNAL] Re: Build error for file chprojid_fail.c on ubuntu 16.04
> > 
> > On Thu, Mar 18, 2021 at 09:20:30AM -0700, Darrick J. Wong wrote:
> > > On Thu, Mar 18, 2021 at 11:37:11AM +0000, Lili Deng wrote:
> > > >
> > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgi
> > > > t.kernel.org%2Fpub%2Fscm%2Ffs%2Fxfs%2Fxfstests-
> > dev.git%2Fcommit%2Fsr
> > > >
> > c%2Fchprojid_fail.c%3Fid%3Df6ddaf130d5b0817278afe441fdde52f464f321
> > b&
> > > >
> > amp;data=04%7C01%7CLili.Deng%40microsoft.com%7C68254dbe593f41a2
> > 50b00
> > > >
> > 8d8ea29fb1e%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637
> > 51681332
> > > >
> > 7967886%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> > V2luMzIi
> > > >
> > LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=AfkOw5bow95qd
> > p7HoTl%
> > > > 2F4lMJzE11arE0zst0jrQVMf0%3D&amp;reserved=0
> > > >
> > > > Hi Darrick,
> > > >
> > > > I hit below build error on Ubuntu 16.04. Do you know how to work
> > > > around it? Thanks.  Gcc version is gcc version 5.4.0 20160609
> > > > (Ubuntu 5.4.0-6ubuntu1~16.04.12), make version is GNU Make 4.1
> > >
> > > Sorry about that. :/
> > >
> > > Does it work if you #include "global.h" in src/chprojid_fail.c?
> > 
> > Or, does applying this patch fix it?
> > 
> > https://nam06.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Ffstests%2F1615975873-19206-1-git-send-email-
> > xuyang2018.jy%40cn.fujitsu.com%2FT%2F%23u&amp;data=04%7C01%7CLil
> > i.Deng%40microsoft.com%7C68254dbe593f41a250b008d8ea29fb1e%7C72
> > f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C637516813327967886
> > %7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi
> > LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=7TSc%2FlROJm5
> > QN5X5se25Qow3Ws8MQCw%2BH5%2F3KaZkYko%3D&amp;reserved=0
> > 
> > --D
> > 
> > > --D
> > >
> > > >
> > > > Building include
> > > > Building lib
> > > > Building ltp
> > > > Building src
> > > >     [CC]    chprojid_fail
> > > > chprojid_fail.c: In function 'main':
> > > > chprojid_fail.c:26:17: error: storage size of 'fa' isn't known
> > > >   struct fsxattr fa;
> > > >                  ^
> > > > chprojid_fail.c:42:18: error: 'FS_IOC_FSGETXATTR' undeclared (first use in
> > this function)
> > > >   ret = ioctl(fd, FS_IOC_FSGETXATTR, &fa);
> > > >                   ^
> > > > chprojid_fail.c:42:18: note: each undeclared identifier is reported
> > > > only once for each function it appears in
> > > > chprojid_fail.c:51:19: error: 'FS_IOC_FSSETXATTR' undeclared (first use in
> > this function)
> > > >    ret = ioctl(fd, FS_IOC_FSSETXATTR, &fa);
> > > >                    ^
> > > > chprojid_fail.c:82:19: error: 'FS_XFLAG_EXTSIZE' undeclared (first use in
> > this function)
> > > >   fa.fsx_xflags |= FS_XFLAG_EXTSIZE;
> > > >                    ^
> > > > chprojid_fail.c:26:17: warning: unused variable 'fa' [-Wunused-variable]
> > > >   struct fsxattr fa;
> > > >                  ^
> > > > Makefile:88: recipe for target 'chprojid_fail' failed
> > > > make[2]: *** [chprojid_fail] Error 1
> > > > include/buildrules:30: recipe for target 'src' failed
> > > > make[1]: *** [src] Error 2
> > > > Makefile:50: recipe for target 'default' failed
> > > > make: *** [default] Error 2
> > > >
> > > > Thanks,
> > > > Lili
