Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B34C433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Oct 2022 13:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiJQN31 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJQN30 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Oct 2022 09:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07823C6C
        for <fstests@vger.kernel.org>; Mon, 17 Oct 2022 06:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666013364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=icm0fqH8mWH/waJrgrlMnYc8YSz+Am8tGhKz5Mh0SBY=;
        b=bWGODFx0TwPqu1sodz+fLoPg3EbAr4EdEvZM0/Jz4HywWoBVvrXLiGiXhgm5qXLlg1/qeu
        EHbRh3elTApm/rwR6gbZaX85WiDRF20E8TDLwlHa2/jlRusO5hA24vGzUL/mqxpzrq1KjG
        h+R6lnl8fEuBsXVDshLL5LgK+V4KfLs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-237-57LBuDkWOL-hcSjEtCDeAQ-1; Mon, 17 Oct 2022 09:29:20 -0400
X-MC-Unique: 57LBuDkWOL-hcSjEtCDeAQ-1
Received: by mail-pj1-f69.google.com with SMTP id lx11-20020a17090b4b0b00b0020d7c0b426dso9864283pjb.6
        for <fstests@vger.kernel.org>; Mon, 17 Oct 2022 06:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icm0fqH8mWH/waJrgrlMnYc8YSz+Am8tGhKz5Mh0SBY=;
        b=bQzK4dEvPIuWP+FlG/gez4Vb/mLKywI006Qso+M175Q1z8yyBbpE9dJFqc0BhaWoUa
         zWVmfKOUk+qL7fxztPQGSuW8knWnXbzzPqJUtWM/uFdwJ7f8zyItDvPe07Y/ZDLCgazJ
         FEG8L5wi0EgavxpWGOVYIpMgMhjtYSZknv7k9NUjec3nxtUNTD79kOM6yEL1yY9aIJxD
         bjQJEkE6e6YAWJHKDxTVOf5w2xP3CXsLWsyGleMNgsMZLN0Y6tWeA0BAbzap07NWng5n
         Zl/yNidWiu+tIijhQ2uebUId27Sm7DAi7C2EpbXnS0gMkV4YC4EyQtUxmVVDSvD+xIQ+
         bxHQ==
X-Gm-Message-State: ACrzQf2Ayd4qioQVBfUN2UbfKXtp8oZWhsvQn6RcL8HNdi07gGyosP+f
        TiSc238qhllyvmxbQq9PDoV6LMFupRh7VJgOiXWXYAvvQrybG3iK/4AqYhpYcOxiJ2SDu03IawZ
        juHh1BTDSOiZoietz3g==
X-Received: by 2002:a17:902:e191:b0:181:b25e:9c17 with SMTP id y17-20020a170902e19100b00181b25e9c17mr12287629pla.57.1666013359562;
        Mon, 17 Oct 2022 06:29:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5SeEXzRDX32pPl3YmQCf0Kfa/ZJMVYfvaNsWz99y8Bx3glqLTTSTMbJMy+CxZIUPtdAKJdFQ==
X-Received: by 2002:a17:902:e191:b0:181:b25e:9c17 with SMTP id y17-20020a170902e19100b00181b25e9c17mr12287610pla.57.1666013359225;
        Mon, 17 Oct 2022 06:29:19 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id on13-20020a17090b1d0d00b0020d48bc6661sm9655255pjb.31.2022.10.17.06.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 06:29:18 -0700 (PDT)
Date:   Mon, 17 Oct 2022 21:29:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/193: add to perms group
Message-ID: <20221017132914.zj3lou5cizuuxluv@zlang-mailbox>
References: <20221017095311.68280-1-brauner@kernel.org>
 <7eb737f8-5fb2-97ac-6ad7-eb1ce8a59f30@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eb737f8-5fb2-97ac-6ad7-eb1ce8a59f30@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 17, 2022 at 10:01:13AM +0000, xuyang2018.jy@fujitsu.com wrote:
> 
> 
> on 2022/10/17 17:53, Christian Brauner wrote:
> > This test changes permissions and specifically tests for setuid and
> > setgid bits to be dropped or kept. It really needs to be run when -g
> > perms is specified.
> 
> Yes, Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> 
> ps: generic/67[3-4] and generic/68[3-7] test suid and sgid, they should 
> also add perms group.

OK, if Christian agrees with this point and would like to help that, please
help to check and add "perms" to more proper cases in one patch.

Thanks,
Zorro

> 
> Best Regards
> Yang Xu
> > 
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
> >   tests/generic/193 | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/193 b/tests/generic/193
> > index ddaff69b..e2710b07 100755
> > --- a/tests/generic/193
> > +++ b/tests/generic/193
> > @@ -7,7 +7,7 @@
> >   # Test permission checks in ->setattr
> >   #
> >   . ./common/preamble
> > -_begin_fstest metadata auto quick
> > +_begin_fstest metadata auto quick perms
> >   
> >   _register_cleanup "_cleanup_files"
> >   tag="added by qa $seq"
> > 
> > base-commit: a75c5f50584e03ca7862ad51f48efd2d524d1dc5

