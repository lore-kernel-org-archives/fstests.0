Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E26C433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Jun 2022 05:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243263AbiFJFTi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 10 Jun 2022 01:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245093AbiFJFTh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Jun 2022 01:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12B7735DE6
        for <fstests@vger.kernel.org>; Thu,  9 Jun 2022 22:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654838375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W9zS6tK5XJM/DE2Y2uh87XDtX9BXb3Fho1rL8dy/lsc=;
        b=f8wuGLGgYrW/yCdac517DaKtNblfZW5SoF/5xR60hj75+iCYcMRCeJIFFuQV9Mqvg7Qf7l
        37C4FzAPiIujGI0zx9BrBlB75JPMC8jRuQWtyHPIby9/dFH72nViNNzFUfPq1OvoJzcM/k
        uL08gPmZW1x1UquUysyeKz4bXWF8iiE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-1c4RTFkIMPq-xAKVghSwYg-1; Fri, 10 Jun 2022 01:19:33 -0400
X-MC-Unique: 1c4RTFkIMPq-xAKVghSwYg-1
Received: by mail-qk1-f199.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso20544020qkb.11
        for <fstests@vger.kernel.org>; Thu, 09 Jun 2022 22:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W9zS6tK5XJM/DE2Y2uh87XDtX9BXb3Fho1rL8dy/lsc=;
        b=qQ+8oVRJoqP7MPAeOM7PVjN6FF8j/GCi3uLeAAowkzQnjCS7kH4jVKtlP+0OohEeTE
         Kl5Cahd7gj/k+jj1/SplIBYHqHjYDczEoqYOB86doULSE6sg4mOq/VeE4pSQ5q2dMRi7
         cu6CgweIQiZyd32S2/Jxq+7kod2Tkp/3C4RVEv1iVl78NjqoP7BN3P/QQHsdHj7/D6W8
         5BpcyOVeVEAxt1DGhwKsJoCvdwaguMdgpKT5SdC3euAWxTutfs1CyYP64z4nnmVVWPB7
         TgMQzJHp0SBCdGivqU9KmiMp0oZa9RXOJ9FKiA8Cequdt3x96FIrfvU1TEYT59ErdNNT
         KGcA==
X-Gm-Message-State: AOAM530OESLOMKvrzXmauGSBVLek/ji7Ep3y4nJDHjwMqAxYkd5wYkoQ
        Z3c3HACvNY7wpHjlEOik4KB1xVio9WY+qSk8xw3gKRpjshxb+DRqAZHT2DiUCfQ/WC6El2s33mY
        tUw3H2Io+S7yINt6iVA==
X-Received: by 2002:a0c:e54e:0:b0:464:5155:b7ac with SMTP id n14-20020a0ce54e000000b004645155b7acmr45402369qvm.87.1654838372317;
        Thu, 09 Jun 2022 22:19:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyye4ZQO5sFB3DBv7rRVgTuuyh1MP3/MHBA87Hy/wgo42vZONR6L4JN1dIOpKcvqIKwE/I3bQ==
X-Received: by 2002:a0c:e54e:0:b0:464:5155:b7ac with SMTP id n14-20020a0ce54e000000b004645155b7acmr45402365qvm.87.1654838372076;
        Thu, 09 Jun 2022 22:19:32 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bj18-20020a05620a191200b006a71398f06fsm5280608qkb.32.2022.06.09.22.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 22:19:31 -0700 (PDT)
Date:   Fri, 10 Jun 2022 13:19:26 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/297: fix the delta time based on stat
Message-ID: <20220610051926.75oiyafys56dfdy3@zlang-mailbox>
References: <20220610023553.24418-1-wangyugui@e16-tech.com>
 <20220610042405.z2ou4uwwgoiympxx@zlang-mailbox>
 <20220610123623.D773.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610123623.D773.409509F4@e16-tech.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 10, 2022 at 12:36:24PM +0800, Wang Yugui wrote:
> Hi,
> 
> > On Fri, Jun 10, 2022 at 10:35:53AM +0800, Wang Yugui wrote:
> > > stat -c '%Y' report seconds as int, so the delta 2.01s may result as 3s.
> > > 
> > > Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
> > > ---
> > >  tests/generic/297 | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tests/generic/297 b/tests/generic/297
> > > index 6bdc3e1c..e3082202 100755
> > > --- a/tests/generic/297
> > > +++ b/tests/generic/297
> > > @@ -51,7 +51,7 @@ for i in $(seq 0 $fnr); do
> > >  	touch $TEST_DIR/after
> > >  	before=$(stat -c '%Y' $TEST_DIR/before)
> > >  	after=$(stat -c '%Y' $TEST_DIR/after)
> > > -	delta=$((after - before))
> > > +	delta=$((after - before -1)) # 2.01s may result as 3s; so -1
> > 
> > What issue is this change trying to fix? "timeout=8"s is not long enough?
> 
> for the command
> $TIMEOUT_PROG -s INT ${kill_after}s
> 
> delta=$((after - before )) may report 'kill_after+1' in some case.
> 
> so no relationship to "timeout=8" or "timeout=2".
> 
> '$XFS_IO_PROG -f -c reflink' without '$TIMEOUT_PROG -s INT ${kill_after}s'
> may take 20s because this is a very complex reflink.

Hmm... still don't understand what are you trying to fix.

That reflink operation need long time, that's expected. The first time it's
running in a while loop for getting a proper testing size, no matter 8.01s
or 9s, I think it's all good.

The second time the reflink run with `TIMEOUT_PROG 2s`, we expect it can be
killed in 'timeout=8s', that's long enough. I think it's not necessary to
care about it's keep running in 8.01s or 9s.

Thanks,
Zorro

> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/06/10
> 
> 
> 

