Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07398C48BC2
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Jun 2021 20:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DABE761075
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Jun 2021 20:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFWVBQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Jun 2021 17:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWVBP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Jun 2021 17:01:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7883FC061574
        for <fstests@vger.kernel.org>; Wed, 23 Jun 2021 13:58:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l11so2190514pji.5
        for <fstests@vger.kernel.org>; Wed, 23 Jun 2021 13:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cNlR6/IOc9Z2vGzwkD1A+iQqAfbpNboRB/7EbRqO/qw=;
        b=mGoP7eWhpFBp3ekOG+RoPseBMsKoIJW6eaFJUqv9xYbAR/qzcKATjkfQ99RAYY2pd/
         QdJ0vLiAX4ZGALHf0Ubb+Xz+YmWnLRsNO9o6WcpXiGZsvW4JCQyeUaMTAssSMG52PYUk
         tkVNm4atB8VkZHEvFFsdPNAmtXDweLyz/AnhHTxYkrC+m1gHb4AbdOSw0QHy2NAGksHW
         USmh1nClQ0/8jUVFbpKfW3QUysqr5kcS7p3oh02s0vbg93VlY4CY1mKrJr0IIQTOpxI8
         zwdmTB9NNcOGdwja0QJyaUhFmR8CTFTkWrsyiAVQg/faMrkTZdnD1Q1la1mvKg+Gav/Q
         wGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cNlR6/IOc9Z2vGzwkD1A+iQqAfbpNboRB/7EbRqO/qw=;
        b=lBZjvkO1SkBRGtZRdKRBpR/N9powogcXlKdx0ELn+gPKCD+oHOdd/E0+7fMn9osJdN
         YnQ9Yfpf4W0+18yrNf7FjmN9Dj4Dj99JC/pRcnJMTGKbu16eZz0tE+P33O5dsqrW79+9
         2uPJ/dMKOtLuSEp1vaf2icB/HSky50QkTWf9KZ+csPvk89chbZsYLrMFy6weQRXSgpfu
         8wnKZ9Nth+I8IQkJ1K1wAmB5i8TX2oOwtwvMNbLnpE5DpXrvhndhGqzksQhtAQGUpeJL
         S7sWcvZmRRg3SS+eUMyX3a1wHl/7SHtVMCA+65EK3wmnjFh8ITUVYpuWVS7JSV+mFi9v
         2q7w==
X-Gm-Message-State: AOAM533as8EwXeHDZyCgDfyFp0e5I5+Gw0Fue2YbFogf73ExyiaF6jNB
        v2oE/IYqViZB14em7KTZeCU=
X-Google-Smtp-Source: ABdhPJzmr7qNzEAptNgcgJuVFTHq7zcuK4injcPoHuHoWktpDpxV93OV9qv6TgJa2DfxB87cySMYKA==
X-Received: by 2002:a17:90a:ff0a:: with SMTP id ce10mr1560103pjb.11.1624481936919;
        Wed, 23 Jun 2021 13:58:56 -0700 (PDT)
Received: from google.com ([2601:647:4701:18d0:efda:7f9b:abe5:8dd8])
        by smtp.gmail.com with ESMTPSA id h11sm21491pgq.68.2021.06.23.13.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 13:58:56 -0700 (PDT)
Date:   Wed, 23 Jun 2021 13:58:54 -0700
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/048: skip test of filename wipe if journal
 checkpoint is not supported
Message-ID: <YNOgjnZhT/TH9D07@google.com>
References: <20210621164851.1808923-1-tytso@mit.edu>
 <YNIphT6xiluxLrOm@google.com>
 <YNKWMO0dY0hrMhqb@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNKWMO0dY0hrMhqb@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 22, 2021 at 10:02:24PM -0400, Theodore Ts'o wrote:
> On Tue, Jun 22, 2021 at 11:18:45AM -0700, Leah Rumancik wrote:
> > > diff --git a/tests/ext4/048 b/tests/ext4/048
> > > index 51189618..35e6aa7f 100755
> > > --- a/tests/ext4/048
> > > +++ b/tests/ext4/048
> > > @@ -93,6 +93,14 @@ _scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
> > >  # create scratch dir for testing
> > >  # create some files with no name a substr of another name so we can grep later
> > >  _scratch_mount >> $seqres.full 2>&1
> > > +
> > > +# Use the presence of the journal checkpoint ioctl as a proxy of filename
> > > +# wipe being supported
> > > +if test -x $here/src/checkpoint_journal && \
> > > +	! $here/src/checkpoint_journal $SCRATCH_MNT --dry-run ; then
> > > +    _notrun "filename wipe not supported"
> > > +fi
> > 
> > What if checkpoint_journal is not there? Should the test be
> > skipped in that case as well?
> 
> I went back and forth on that one.  In actual practice
> checkpoint_journal should always be built in a valid xfstests
> installation, so the case of it not existing should rarely if ever
> arise.  We don't actually _need_ checkpoint_journal to run the test;
> we're just using it as a hint as to whether the filename wipe feature
> is present.  So I decided to let the test run if we couldn't find it,
> on the theory that in the long run, all future kernels will have the
> feature.   But the case could be made in other direction....
> 
> 	       	   	      	 - Ted

Works for me.

-Leah

