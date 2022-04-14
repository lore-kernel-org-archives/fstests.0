Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3210BC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 14 Apr 2022 19:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240239AbiDNTTU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 14 Apr 2022 15:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiDNTTS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Apr 2022 15:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22D788C7EA
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 12:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649963812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BtxEfEB5llKDNLRUQf5m7XNmlqIUwFOrvDLOaIHayus=;
        b=QVEASv1PTSbv3ggI07Afd3JIn9QPoHCD7inFiZ/KvwVI7FuDWJkuaWcDh/9xY3+jG1aYQT
        B/pEKOUl6VOrCTHMJf4zBXirM6CTMswXzsYvLjlaiCWzvrwNWiMLqZbotZPGw/3gsOmMDx
        WWvwelMm8FmEs217i1ewtPheN2cBJV0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-O67x9QVQOHGYe1iuv6p3aw-1; Thu, 14 Apr 2022 15:16:50 -0400
X-MC-Unique: O67x9QVQOHGYe1iuv6p3aw-1
Received: by mail-qk1-f200.google.com with SMTP id y13-20020a05620a44cd00b0069c35f1ea3eso3968185qkp.0
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 12:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=BtxEfEB5llKDNLRUQf5m7XNmlqIUwFOrvDLOaIHayus=;
        b=ODgz5ikkn17Xe+STTlefu/ymVogtQ1qBLsQTSoQmedckjk8CkAYhRtKKptgPpZ9kfe
         2HBMiXTI+dRkNa9taR3DPeCYfrosNGc8S9ZrwQDMZGNgAoUy3QYZ6x/IuGssDeak6Hrv
         oWlCSJmEm7mjor1nXRAwi8gD/a5E+kUc66A9OPNa+Igu+YE+LPmfimOkcsxIBo4Oaleo
         Oy3J/8oneoZcAIUO5tS9QZeO82t0zCMQz5/E45NRNMY7cneb2JsgYOT4vh/kQ2Nx/Xbo
         Hxgl533mmZJTk57xWfy4UMRhzPLkKUHA2VrdoAE9/12QCKgqMeVks+4vmdktUhy8E1+p
         ABVQ==
X-Gm-Message-State: AOAM531BMumdyJkdEZbB3dhqNJ6/L65hYoCqVs3QNywyjueiriOlLOTJ
        8YuJvlA7eNiztB/38Xs+RciOdUSXF2lvJhGjxHh2p96rbMNAityaGegoDoiVsnEFwzoa5w/M5eT
        +kxexHVNHZYTPz6fhrQ==
X-Received: by 2002:a05:620a:4256:b0:67e:87a1:ffdd with SMTP id w22-20020a05620a425600b0067e87a1ffddmr2962098qko.647.1649963809814;
        Thu, 14 Apr 2022 12:16:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxV0dpZ5RcG1G0Xx4df2XpqfAvjH99hFLApuqgTHnzB0x3qTlrHZKIE19ZyCPCbz7uY9UN94A==
X-Received: by 2002:a05:620a:4256:b0:67e:87a1:ffdd with SMTP id w22-20020a05620a425600b0067e87a1ffddmr2962085qko.647.1649963809552;
        Thu, 14 Apr 2022 12:16:49 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s15-20020a05620a29cf00b00680ca4b3755sm1403554qkp.119.2022.04.14.12.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 12:16:49 -0700 (PDT)
Date:   Fri, 15 Apr 2022 03:16:43 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>,
        David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/019: kill background processes on interrupt
Message-ID: <20220414191643.5udsx6kdarlumyfn@zlang-mailbox>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
References: <20220411054833.2157779-1-david@fromorbit.com>
 <20220412145942.0a268875@suse.de>
 <20220412142500.ubkbw2fvbxowzo5p@zlang-mailbox>
 <20220413002656.GL1609613@dread.disaster.area>
 <20220414162544.kiesx5muc5ddtbzd@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414162544.kiesx5muc5ddtbzd@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 15, 2022 at 12:25:44AM +0800, Zorro Lang wrote:
> On Wed, Apr 13, 2022 at 10:26:56AM +1000, Dave Chinner wrote:
> > On Tue, Apr 12, 2022 at 10:25:00PM +0800, Zorro Lang wrote:
> > > On Tue, Apr 12, 2022 at 02:59:42PM +0200, David Disseldorp wrote:
> > > > On Mon, 11 Apr 2022 15:48:33 +1000, Dave Chinner wrote:
> > > > 
> > > > > From: Dave Chinner <dchinner@redhat.com>
> > > > > 
> > > > > If you ctrl-c generic/019, it leaves fsstress processes running.
> > > > > Kill them in the cleanup function so that they don't have to be
> > > > > manually killed after interrupting the test.
> > > > > 
> > > > > While touching the _cleanup() function, make it do everything that
> > > > > the generic _cleanup function it overrides does and fix the
> > > > > indenting.
> > > > > 
> > > > > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > > > > ---
> > > > >  tests/generic/019 | 6 ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/tests/generic/019 b/tests/generic/019
> > > > > index db56dac1..cda107f4 100755
> > > > > --- a/tests/generic/019
> > > > > +++ b/tests/generic/019
> > > > > @@ -53,8 +53,10 @@ stop_fail_scratch_dev()
> > > > >  # Override the default cleanup function.
> > > > >  _cleanup()
> > > > >  {
> > > > > -    disallow_fail_make_request
> > > > > -    rm -f $tmp.*
> > > > > +	kill $fs_pid $fio_pid &> /dev/null
> > > > > +	disallow_fail_make_request
> > > > > +	cd /
> > > > > +	rm -r -f $tmp.*
> > > > >  }
> > > > >  
> > > > >  RUN_TIME=$((20+10*$TIME_FACTOR))
> > > > 
> > > > Might be worth unset'ing the "fs_pid" and "fio_pid" variables after the
> > > > wait, but should be fine as-is:
> > > 
> > > I agree. Better to avoid killing other system processes. Or how about this place
> > > does (avoid killing system useful processes):
> > > $KILLALL_PROG -q $FSSTRESS_PROG
> > > $KILLALL_PROG -q $FIO_PROG
> > > 
> > > Another picky question is, do we need to use a while loop checking, until the
> > > processes really get killed? :)
> > 
> > Do we really need to paint the bikeshed over how best to kill a
> > process? I don't have time to do that, this is just a drive-by fix
> > that works for me....
> 
> Sure Dave:) The while loop checking is a little picky, I just ask what do you think, no
> objection if you don't like that. Due to quick cleanup and exit is a good reason too.
> 
> I think it might be worth doing "$KILLALL_PROG -q $FSSTRESS_PROG $FIO_PROG" at least, to
> avoid killing other processes might be useful. Or as David Disseldorp suggested "unset'ing
> the "fs_pid" and "fio_pid" variables after the wait. If you're busy, I can help to make
> this simple change, no push :-D

Anyway, we'll change this a little bit when merge it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Thanks,
> Zorro
> 
> > 
> > -Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
> > 

