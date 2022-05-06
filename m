Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBBDC433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  6 May 2022 15:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348163AbiEFPgz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 6 May 2022 11:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390409AbiEFPg2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 May 2022 11:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37EA76EB07
        for <fstests@vger.kernel.org>; Fri,  6 May 2022 08:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651851150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xPKkraI1M2m4ob6FeFqSeP6IpwTvfgtBu6QJp90rz3k=;
        b=Ig9Unt/ABIux47E6bKPn7az5a60OrUIE41NKF5abopnu5AECzheT6ZvzAdXXE55zGsKaGn
        DznYwwZm7wOjt+qSxWuZUf9jrtXkokhYLNn8KKNlWk553rq7NCyOQEkT+eJKl5iq69zC5K
        l3AT1mSYbkmBjlQdTKd6KNclpqF0M8w=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-p6lbJsJeOh2abbkw8jCqpg-1; Fri, 06 May 2022 11:32:29 -0400
X-MC-Unique: p6lbJsJeOh2abbkw8jCqpg-1
Received: by mail-lj1-f197.google.com with SMTP id m6-20020a2eb6c6000000b002509fdb1dbaso517642ljo.1
        for <fstests@vger.kernel.org>; Fri, 06 May 2022 08:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xPKkraI1M2m4ob6FeFqSeP6IpwTvfgtBu6QJp90rz3k=;
        b=agXE2jey920gQqoQFRMn5AO+YEIDlmLaoDTB4XWVrquE2OquuWCL9NQCJ7iGYc5CC5
         EmambCLsVHu74vPaFyCfQ40B/6YumDhmlCFQLmvcRLB33e6O/4Cu1ilzTjo/2MexT99s
         OR3UbCo+6uqe++4s996SdUInAHWpTtEqcCy5pwDjfO50dqdswHRrwRMMJkUwOo/ucGgy
         oOahuSbeE6oaZPIpME9QIEQidJWfQkoINWudo9zaownrxzQHrJqei/iEcN+5YyU8FDE3
         IvtrWVQawgho9UEv8Dd7qKWRmr1cItSZKTv1yu8xGODyj6QT/fDrYlshAJTpmmR7qA4e
         /SFQ==
X-Gm-Message-State: AOAM532EvYWy/Vk43I5k4qv0+lCYl6EzEa/dMHQdFTXn236gcO0VS4CQ
        IHZuae455wrssQjhUB/WD+kRibgYpkYFnF3N/r9T2YwJ9830pIjEq9qFO8in2bqSPX41t2llzE3
        H8M+KAuvOhJBSUtBH3AYtoS48hXNQMryjOw==
X-Received: by 2002:a2e:a550:0:b0:250:5ae3:c172 with SMTP id e16-20020a2ea550000000b002505ae3c172mr2253241ljn.265.1651851147456;
        Fri, 06 May 2022 08:32:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoH1bjIO290aW/xsqlSAGQZafrMdwUaHEKfEkJHSrtU56Ta9NQlM1MBlrdGPtZtoB7giQ6fkDjLa2bz+dWILI=
X-Received: by 2002:a2e:a550:0:b0:250:5ae3:c172 with SMTP id
 e16-20020a2ea550000000b002505ae3c172mr2253237ljn.265.1651851147214; Fri, 06
 May 2022 08:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220419175811.602126-1-ridave@redhat.com> <20220427083943.rc4alejvbl2wbw2z@zlang-mailbox>
In-Reply-To: <20220427083943.rc4alejvbl2wbw2z@zlang-mailbox>
From:   Rishabh Dave <ridave@redhat.com>
Date:   Fri, 6 May 2022 21:02:16 +0530
Message-ID: <CA+jMu4SnQdwOYa9Gz6CFG7-=XgyP-D43w+7-bynCSZuv2b=fVQ@mail.gmail.com>
Subject: Re: [PATCH] cephfs: add ceph-fuse suport for ceph-fuse
To:     Rishabh Dave <ridave@redhat.com>, fstests@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>,
        Rishabh Dave <rishabhddave@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, 27 Apr 2022 at 14:18, Zorro Lang <zlang@kernel.org> wrote:
>
> > diff --git a/common/rc b/common/rc
> > index 553ae350..868b3ddd 100644
> > --- a/common/rc
> > +++ b/common/rc
>
> [snip]
>
> >
> >       if [ -n "$type" -a "`_fs_type $dev`" != "$type" ]; then
> > @@ -1869,6 +1890,7 @@ _require_test()
> >               if [ ! -d "$TEST_DIR" ]; then
> >                       _notrun "this test requires a valid \$TEST_DIR"
> >               fi
>
> This place missed a ";;", it'll cause all cases fail directly when they try to
> ". common/rc". As this patch has been RVB, I'll fix it when I merge it. But better
> to give a patch a mimimum test before sending (except it's simple enough:), to make
> sure it won't break the most fundamental things at least, it's hard for me to test
> all fs that fstests supports before merging, Thanks for understanding :)
>

Sorry for the inconvenience. I guess I made a last minute error
because normally I test my patch against CephFS. Should I be running
more tests, besides just this one? Please let me know if so because I
am new to xfstests-dev.

I've resent my patch under subject "[PATCH test] common: add support
for ceph-fuse". It should've been [PATCH v2] since it's a newer
version of this patch but I guess I made a mistake while running "git
send-email" (I'm new to it).

Thanks for the patch review!

