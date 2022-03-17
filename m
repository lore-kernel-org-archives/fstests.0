Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902A0C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Mar 2022 16:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbiCQQeV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Mar 2022 12:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbiCQQeU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Mar 2022 12:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B9E64507B
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 09:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647534782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zamv+MIZDxQY3SJAVVaZ5Q4mk6VP5QY3g7Dja/9Yyoo=;
        b=WkWslXj2gAltV+JVRgvlfwgBwv0gAq7UqMa1fVfpqnT4Mw7uOS1K6dZqo7Pe/j+9evDVjG
        UFvyLC82IetGHBLrvC/EHJIE/BxtOUGalS3hKr+FF5mebaD920nZwXn7ZgEPY34RDWsrnK
        3gadR8kFfelv27tKaweYsxZalrbRKdg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-h99N65WbMsug5y_nXV7mKQ-1; Thu, 17 Mar 2022 12:33:00 -0400
X-MC-Unique: h99N65WbMsug5y_nXV7mKQ-1
Received: by mail-pl1-f199.google.com with SMTP id d13-20020a170902b70d00b0015317d9f08bso2958109pls.1
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 09:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zamv+MIZDxQY3SJAVVaZ5Q4mk6VP5QY3g7Dja/9Yyoo=;
        b=trwjbovyuUSXTT5ky/M65bs4Cqb64stkYV54MSO5XXFiouJ0lJTvW0Ubm95y9w8R0Y
         n9u2Z5nD/m49a+BuyUgIMlPaOG1jPPUjkULEPfRtYe72/vjlV3taV/5MjneWOWso+ICe
         rHzsKKZY32ueuFeU9/XU1Jaq3BJIY9QtKkMgyk6fvD9IPIuX8e+Uig8mZhhrB/JL5xn0
         FDqAVmsS1oGJZ7auFk0VoGSxRAeV/p2gN8Pf9FLfez3ZiVQXayw39IP9I4FiMPJPy4Vm
         v5uK5xI9eg7wv4jutqHnOkPXK4BAfpuGWCRs8FAPwQRcVtIFtIgvXNF2IkyXC2ORW41F
         hwPg==
X-Gm-Message-State: AOAM531oUOripbYndUgIgcnvn+0M4z90aFb3bEuX3u6GukVScDxFpAyr
        BJU4STZTKkR39+2ndVog4kXD6Ry3/MozJnbihLOI1iL7QuCXr97JedU4nVTT02k7bczfJ/+XC0C
        g0FB7F1429/GPPvRD2wbn9jphvk618eq1Pg==
X-Received: by 2002:a17:90b:4f8c:b0:1bf:3ef:d668 with SMTP id qe12-20020a17090b4f8c00b001bf03efd668mr6159752pjb.219.1647534776385;
        Thu, 17 Mar 2022 09:32:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPezaqi4dVfXAVchjeWWm+FIqR4CFjau10XdfTwd7IUY1Ibaz5Xr4BlaGm3MJPNUNPs9jlTAfUfq5PNdBYH4c=
X-Received: by 2002:a17:90b:4f8c:b0:1bf:3ef:d668 with SMTP id
 qe12-20020a17090b4f8c00b001bf03efd668mr6159728pjb.219.1647534776044; Thu, 17
 Mar 2022 09:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220317100842.1237893-1-bxue@redhat.com> <20220317100842.1237893-2-bxue@redhat.com>
 <20220317151144.GG8200@magnolia>
In-Reply-To: <20220317151144.GG8200@magnolia>
From:   Boyang Xue <bxue@redhat.com>
Date:   Fri, 18 Mar 2022 00:32:45 +0800
Message-ID: <CAHLe9YY0JckWJZpMr=GdEuHK-SiMqJthaOMnxd59hP-7UT1-BQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] generic/674: check for dedupe support on scratch fs
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

(Resend due to previous email being rejected. Sorry)

Thanks Darrick. I will replace the "_require_scratch_reflink" with
"_require_scratch_dedupe" in v2 patch.

-Boyang

On Thu, Mar 17, 2022 at 11:11 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Thu, Mar 17, 2022 at 06:08:41PM +0800, bxue@redhat.com wrote:
> > From: Boyang Xue <bxue@redhat.com>
> >
> > Signed-off-by: Boyang Xue <bxue@redhat.com>
> > ---
> >  tests/generic/674 | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tests/generic/674 b/tests/generic/674
> > index bf0bcffb..7e5e4e29 100755
> > --- a/tests/generic/674
> > +++ b/tests/generic/674
> > @@ -19,6 +19,7 @@ _begin_fstest auto clone quick
> >  _supported_fs generic
> >  _require_user
> >  _require_scratch_reflink
> > +_require_scratch_dedupe
>
> I think you could replace the _require_scratch_reflink with
> _require_scratch_dedupe here, right?  I probably copypasta'd this.
>
> --D
>
> >  _require_xfs_io_command dedupe
> >
> >  _scratch_mkfs >> $seqres.full
> > --
> > 2.27.0
> >
>

