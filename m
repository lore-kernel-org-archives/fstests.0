Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D31C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 17 May 2022 08:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242858AbiEQI0n (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 May 2022 04:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242946AbiEQIYT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 May 2022 04:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16B3246146
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 01:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652775857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yx85avQ4THAlP8R4y0yWYjWsj8SDUzbxBCHkfrzfUic=;
        b=Awmx2wxU8+hVcOjIbDlY5+0yZOsLqhTcfyDFotx4OHI5C0eUVF41+xpUGaX+8JOAdC8b/7
        V5pUqOGOMgYv5cUxrjJQvmiicNusZwct13AF/PM0YUT6v/3YuWdQyOyRHKmrX+ldToRI4N
        iUrU5HQd2E9BYm0J0kGReGL/QMC1Vjk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-EbYSQvkgMGadp75ONIB9Ow-1; Tue, 17 May 2022 04:24:16 -0400
X-MC-Unique: EbYSQvkgMGadp75ONIB9Ow-1
Received: by mail-qt1-f200.google.com with SMTP id br6-20020a05622a1e0600b002f3d470aa4dso13316939qtb.21
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 01:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=yx85avQ4THAlP8R4y0yWYjWsj8SDUzbxBCHkfrzfUic=;
        b=FkBUPDoS9FVg6Ikh6fNpa32q0MJKRopXnmuvSEIwxqQjBSCGCK4N/9UU8epU4U50DI
         YE8bS8XIsLq3/JcK2rWrbD58u2myRRBJkkknVty/w4gpdJVtOIXB+RtcsNKFtZQOc6PK
         nQc/5nFXOIXD6XrsZ1+7bjCoaGgSZjgWXlegoJPzYpfwh5ZHCqy9hXOp8dyPlwP/atx1
         v4AGoWOI1FHzvUjxtJ5dDSQ6BjH8m3VuaFXvxLOIKJycCZ6H1Wol6O5VJL8NJsiVr5gZ
         QWg2jKHTuLSy7ZJRIvqT+iCqpvOX5LC0W9gKYYo7urDv7b82s4nm8cjaSEoP4Igg6N3f
         2LQw==
X-Gm-Message-State: AOAM530S36liFLVp3w55B/zV/VZ1QNsFAxDliFM+QVw9in43xViqA7hn
        29FnByee2CnhlBPscqXv8EtLxbIIU+pIi2NzPWKlPHRAUbarI6Evg5nZDca0ONWtfUXrzGML6QF
        OptFgU6SYWwS8/UIbWw==
X-Received: by 2002:a05:620a:1403:b0:69f:bb69:5a7e with SMTP id d3-20020a05620a140300b0069fbb695a7emr15109675qkj.589.1652775855283;
        Tue, 17 May 2022 01:24:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvrAwEvme3BN8NfOUxd2CDtntPs14sU8DpuEn5eQlgHCiXlRkcg6cs5O3VCUH6arss+JpC+w==
X-Received: by 2002:a05:620a:1403:b0:69f:bb69:5a7e with SMTP id d3-20020a05620a140300b0069fbb695a7emr15109668qkj.589.1652775855028;
        Tue, 17 May 2022 01:24:15 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 8-20020a05620a048800b0069fc13ce24asm7118454qkr.123.2022.05.17.01.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 01:24:14 -0700 (PDT)
Date:   Tue, 17 May 2022 16:24:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 00/13 V2] fstests: fixes and more fixes...
Message-ID: <20220517082409.anf5f5wg3yoldpki@zlang-mailbox>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        fstests@vger.kernel.org
References: <20220517070111.1381936-1-david@fromorbit.com>
 <20220517074910.GO2306852@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517074910.GO2306852@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 17, 2022 at 05:49:10PM +1000, Dave Chinner wrote:
> On Tue, May 17, 2022 at 05:00:59PM +1000, Dave Chinner wrote:
> > Hi folks,
> > 
> > This is a rollup of the two patch series I sent yesterday titled:
> > 
> > [PATCH 0/3] fstests: test updates for XFS 5.19 kernel mods
> > [PATCH 0/3] fstests: more fixes...
> > 
> > I've fixed some patches, added documentation for those changes,
> > and added a bunch of patches to remove deprecated/broken tests that
> > should ahve been removed long ago.
> > 
> > I do not know if patches 9-11 will make it through vger this time -
> > they didn't as a single patch. They are titled:

No, they didn't.

> > 
> > [PATCH 09/12] xfs/018: remove deprecated test
> > [PATCH 10/12] xfs/081: remove deprecated test
> > [PATCH 11/12] xfs/082: remove deprecated test
> > 
> > and is thould be pretty obvious what they do from the title....
> 
> Ok, it appears as though even separated vger still won't let a
> single one of them through
> 
> Zorro, all these patches are 'git rm' commands
> 
> git rm tests/xfs/018*
> git commit
> git rm tests/xfs/081*
> git commit
> git rm tests/xfs/082*
> git commit
> 
> I'm happy for you to just run them yourself, or do you want me to
> send a pull request for them?

Sure, I don't run this 3 cases either. As they're xfs specific cases, so if both
of you and Darrick agree to remove them entirely, I'm glad to help that :)

And how about remove them in single one commit/patch? Likes:
---
[PATCH] fstests: remove xfs deprecated test

Remove xfs/018, xfs/081 and xfs/082 entirely, as they're deprecated
and obsolete for long time.
---

Thanks,
Zorro

> 
> /me realises he hasn't updated his kernel.org fstests tree for 4
> years....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

