Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E00FC43217
	for <linux-fstests@archiver.kernel.org>; Thu, 19 May 2022 15:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbiESPsi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 May 2022 11:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241278AbiESPrq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 May 2022 11:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0C1FD809B
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 08:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652975071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHo4viihgLRt7UNPxe5xxzFkQUkDA+qFFkKh1E4W9Ek=;
        b=QP+DC0DujKHpfghbec5GorKZKzBeXwjWFLwI0FVu/uoWayEKAEUUYCVKeedEyg3SU6l9lV
        U+WHO7DOjHpkKK8f9CmBCyJ3IlK+HX3xnLxxpL4vq/F3eJjcTk33yiFkCJSY2x2fJyZVam
        pI8s0644Dw+ogDEQ2Q495RIr4lmI5Dg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-u_BXbPWcPbWjiCHdjdHmaA-1; Thu, 19 May 2022 11:44:29 -0400
X-MC-Unique: u_BXbPWcPbWjiCHdjdHmaA-1
Received: by mail-qv1-f72.google.com with SMTP id kl23-20020a056214519700b0046200065604so1405342qvb.19
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 08:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JHo4viihgLRt7UNPxe5xxzFkQUkDA+qFFkKh1E4W9Ek=;
        b=edCvVtKQwk+BVfdX0rFkue90oQgmesw0whzyWYfSEIiVzOO8nPF0Xs29v/dptU3zWu
         F//sbYicb8vHDZ+D5UYN7A62gSoqzhHBt0ng6dtMRSZzDMpaj7KPwU+7v6uQmd9L3l8j
         n3KF01NaQKryOkCTyWLASJw8QA1HHyLnFMFpMzcr2OiB0GEnT6VY+qJKachyMb0frFzd
         vuo4NBc+bru7tzfyYU2RGlJYRYHOLtzNcaoGczBsbaU2ia/g78uTKhWJdVj0zfqL4Vio
         mP8mzHUBkzDLHgPrXrBNlfj2A1fHh+VPLt4nBOr9Wrse0SmxA2Z80oXZg/fG0hyuVk3U
         S85w==
X-Gm-Message-State: AOAM533aliNMVBWaVYc3qah6Bj+OYWKnc8CVpwUKTU2Elp/kmXU6tDjs
        OcGR3VOCuEwfa2oNIRW4YczK3k5fDfL2r48fn+Zjq1SYzXltykXp/ULe6q9uW/FpsJfsj2rw++Y
        Rmyg/I4fUxdwWqzIKFg==
X-Received: by 2002:a05:622a:134d:b0:2f3:bd4b:68d with SMTP id w13-20020a05622a134d00b002f3bd4b068dmr4279948qtk.169.1652975068743;
        Thu, 19 May 2022 08:44:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK/zb4CcD5/OFHJlpmWZ/bU5MeXCrj0CA31HfJq/aphmpdiDzdQIQTXwM2JY1a6elLAPXyng==
X-Received: by 2002:a05:622a:134d:b0:2f3:bd4b:68d with SMTP id w13-20020a05622a134d00b002f3bd4b068dmr4279930qtk.169.1652975068483;
        Thu, 19 May 2022 08:44:28 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i2-20020ac813c2000000b002f39b99f689sm1415292qtj.35.2022.05.19.08.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 08:44:27 -0700 (PDT)
Date:   Thu, 19 May 2022 23:44:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, pankydev8@gmail.com,
        Theodore Tso <tytso@mit.edu>,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <20220519154419.ziy4esm4tgikejvj@zlang-mailbox>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <CAOQ4uxhKHMjGq0QKKMPFAV6iJFwe1H5hBomCVVeT1EWJzo0eXg@mail.gmail.com>
 <20220519112450.zbje64mrh65pifnz@zlang-mailbox>
 <YoZbF90qS+LlSDfS@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZbF90qS+LlSDfS@casper.infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 19, 2022 at 03:58:31PM +0100, Matthew Wilcox wrote:
> On Thu, May 19, 2022 at 07:24:50PM +0800, Zorro Lang wrote:
> > Yes, we talked about this, but if I don't rememeber wrong, I recommended each
> > downstream testers maintain their own "testing data/config", likes exclude
> > list, failed ratio, known failures etc. I think they're not suitable to be
> > fixed in the mainline fstests.
> 
> This assumes a certain level of expertise, which is a barrier to entry.
> 
> For someone who wants to check "Did my patch to filesystem Y that I have
> never touched before break anything?", having non-deterministic tests
> run by default is bad.
> 
> As an example, run xfstests against jfs.  Hundreds of failures, including
> some very scary-looking assertion failures from the page allocator.
> They're (mostly) harmless in fact, just being a memory leak, but it
> makes xfstests useless for this scenario.
> 
> Even for well-maintained filesystems like xfs which is regularly tested,
> I expect generic/270 and a few others to fail.  They just do, and they're
> not an indication that *I* broke anything.
> 
> By all means, we want to keep tests around which have failures, but
> they need to be restricted to people who have a level of expertise and
> interest in fixing long-standing problems, not people who are looking
> for regressions.

It's hard to make sure if a failure is a regression, if someone only run
the test once. The testers need some experience, at least need some
history test data.

If a tester find a case has 10% chance fail on his system, to make sure
it's a regression or not, if he doesn't have history test data, at least
he need to do the same test more times on old kernel version with his
system. If it never fail on old kernel version, but can fail on new kernel.
Then we suspect it's a regression.

Even if the tester isn't an expert of the fs he's testing, he can report
this issue to that fs experts, to get more checking. For downstream kernel,
he has to report to the maintainers of downstream, or check by himself.
If a case pass on upstream, but fail on downstream, it might mean there's
a patchset on upstream can be backported.

So, anyway, the testers need their own "experience" (include testing history
data, known issue, etc) to judge if a failure is a suspected regression, or
a known issue of downstream which hasn't been fixed (by backport).

That's my personal perspective :)

Thanks,
Zorro

> 

