Return-Path: <SRS0=MkaF=2T=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930A1C2D0CE
	for <linux-fstests@archiver.kernel.org>; Sun, 29 Dec 2019 16:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D4C2071E
	for <linux-fstests@archiver.kernel.org>; Sun, 29 Dec 2019 16:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKDpYQ9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfL2QFo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 Dec 2019 11:05:44 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32846 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfL2QFo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 Dec 2019 11:05:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id z16so17180725pfk.0
        for <fstests@vger.kernel.org>; Sun, 29 Dec 2019 08:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nTJtiiPEyL9SoOo4XX1YbLGZHGq/is7pIRdsc9IxP3c=;
        b=kKDpYQ9vmpwYKv0JV3Ny07IteLFF8XlpmX72T4LBwJtjUKd/opudDh7SBPDuTzyKTt
         D1V5CwkRFnTQeAJs6xOhCtzOKE1atfSfK2fsDn+YMaBDqxSWosiwJe06fMSLzrdIrwZi
         G/4Hm1seP+ADttgC48fpEjkTuNPnFMrzBgCj1mgWqX7p9yueHbsDkwed/jjv+q1dEc+z
         vtv3AsltX2Ow4JCtA9gYdPAcc0vzwpgmNewj4HV3pw2AzOjr8guPr3IhnP8Ni2kS2VT6
         bF2UUM3MAwr4qMTLOQ6exIykNoxRH3eYYaJgWCGLT/AGOtlA7M7PGIGhRNhkoMe1XBvm
         FJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nTJtiiPEyL9SoOo4XX1YbLGZHGq/is7pIRdsc9IxP3c=;
        b=CL6dae5i3tCRjmeqUPlzyMKLXCii40XW7wLJugAF5ZenFQhCqDsAaFV1P8nJfpYWTu
         f5YwdBPYXwSboCBFY5KX9qWcAG+6xznNu8vQb23aV0BcBZCZBrwuWS7Dp8XNTG0DyBQS
         +2WQeDdi7srOEGp/fY5QJgKZweZT96Zivy08X2qIY+JTO7AK9wQTlbhjbCdxlbZZ1Nqd
         6jPEYvlgnb3DY2l/0ak/nv8SQ9jvKKe4282okpboX8O08Wvhwiu4NP8BhuBaRVxzSe8Y
         7ef0DoP70+M37d2ub4vSxWfYJaBjSZbT29UV/fteCSbANpmNZyY27Tm4GIHvR1BjRjI2
         C88Q==
X-Gm-Message-State: APjAAAWAFaYY6izarx3bTETd/mjJ+k84+Wobhga7BAGSULiJHR/bfrtY
        zCpaK6SsN3NIzpg1Ry52uaM=
X-Google-Smtp-Source: APXvYqyRLRhYzuynIku1XDtExhbCzntOIkf55V0ulvw906FiHD7J2kkWFAriLJG7MsBW9ZsGHQXzRw==
X-Received: by 2002:a62:8f0d:: with SMTP id n13mr54678863pfd.38.1577635543312;
        Sun, 29 Dec 2019 08:05:43 -0800 (PST)
Received: from localhost ([178.128.102.47])
        by smtp.gmail.com with ESMTPSA id e12sm20979640pjs.3.2019.12.29.08.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 08:05:42 -0800 (PST)
Date:   Mon, 30 Dec 2019 00:05:37 +0800
From:   Eryu Guan <guaneryu@gmail.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org,
        sandeen@sandeen.net
Subject: Re: [PATCH] generic/386: check the correct field from df output
Message-ID: <20191229160534.GA893866@desktop>
References: <20191222212730.378358-1-tytso@mit.edu>
 <ae961477-f14a-60b3-9784-909470bc2bc8@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae961477-f14a-60b3-9784-909470bc2bc8@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 23, 2019 at 09:24:56AM +0800, Yang Xu wrote:
> 
> 
> on 2019/12/23 5:27, Theodore Ts'o wrote:
> > The generic/386 test was checking the "Available" field when it should
> > have been checking the "1k-blocks" field, which represents the project
> > quota's hard limit.  On xfs, an empty directory takes no space, so it
> > doesn't matter.  But for ext4, an empty directory still takes 4k (or
> > whatever the file system's block size happens to be):
> > 
> > Filesystem           1K-blocks       Used  Available  Use% Pathname
> > /dev/vdc                512000          4     511996    0% /vdc/test
> > 
> > This causes generic/386 to falsely fail.  There was a confusing
> > comment claiming that for a very long device name, the df output would
> > have a line break, and for that reason, the test would extract the
> > field using $(NF-2).  However, looking at xfsprogs's quota command, I
> > see no evidence that there is any line breaking logic.  Since we now
> > want to use the second field, even if there was some line breaking
> > going on, using $2 should be a better choice.
> > 
> > This fix is needed to fix generic/386 from failing on ext4:
> Hi Theodore
> 
> I have a same fix but I use $(NF-4) field of df command. Also I wrongly
> think project quota uses a block size.
> url:
> https://patchwork.kernel.org/patch/11296657/

Yes, $(NF-4) works, as Eric suggested as well. I applied Ted's patch
(with $2->$(NF-4) fix), as the commit log is explaining well what's the
problem and why taking "1k blocks" is correct. And thank you for the fix
all the same!

Thanks,
Eryu

> 
> Best Regards
> Yang Xu
> > 
> >      hard limit 524283904 bytes, expected 524288000
> > 
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > ---
> >   tests/generic/386 | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/tests/generic/386 b/tests/generic/386
> > index 0c44c80e..37e9b943 100755
> > --- a/tests/generic/386
> > +++ b/tests/generic/386
> > @@ -62,8 +62,6 @@ _require_scratch
> >   # both the "df" and the "report" output.  For "report", the line we're
> >   # interested in contains our project name in the first field.  For "df"
> >   # it contains our project directory in the last field.
> > -# But if the device name is too long, the "df" output is broke into two
> > -# lines, the fourth field is not correct, so take $(NF-2) of "df"
> >   _filter_quota_rpt() {
> >   	awk '
> >   	BEGIN {
> > @@ -89,7 +87,7 @@ _filter_quota_rpt() {
> >   			bsize = byte_size($4);
> >   		} else if ($NF ~ proj_dir) {
> >   			# this is the "df" output
> > -			bsize = byte_size($(NF-2));
> > +			bsize = byte_size($2));
> >   		} else {
> >   			next;
> >   		}
> > 
> 
> 
