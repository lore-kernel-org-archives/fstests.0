Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06467C48BC2
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Jun 2021 21:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC87C61075
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Jun 2021 21:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhFWVCh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Jun 2021 17:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhFWVCd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Jun 2021 17:02:33 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F6BC061574
        for <fstests@vger.kernel.org>; Wed, 23 Jun 2021 14:00:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id k6so3297528pfk.12
        for <fstests@vger.kernel.org>; Wed, 23 Jun 2021 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cNlR6/IOc9Z2vGzwkD1A+iQqAfbpNboRB/7EbRqO/qw=;
        b=p4po4Ghldipf3jMAlwQ/DPGRvKSzPNdnziFjsFW9SqWg/+PFb74o6CUgf8zoVwHK6j
         se/4fonByIxg4BBJvRtWdlEIAO9W2TLqOW6dAxQbY32uv3yb9geoXOBYhJ3HW3bCJ8CR
         /Uo2YdKmavyUyVI9B3OoT4dRini12p1QYhbmqhSU5YiQCu/cNofN8+oij6PfGHncYb7k
         oQXEPVqqO/bxnVRJjQNXXCcHroglsKoMureoYNk8QplvyBuW3q9LuTHVVKl+3FUvd+Me
         /g8jeeTdvGFIC+VXFmVrxtx4NzgCeNGadqxl10oOxf+jE8FYZnsZPPqxCLsCycCwo3D8
         jDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cNlR6/IOc9Z2vGzwkD1A+iQqAfbpNboRB/7EbRqO/qw=;
        b=PLFDdy9vlWwE6U0wlP903tSguD/cjSha/rK36N072fNtsZ5qkEHYstEZxIxkBhCk9c
         vz85kyQCMs8LEef2xlccz9SdeexSGTPaPW+MfQyHhrnnZIcVxo8jcU22Idsu5boX31mP
         mzTznKkk6dn0y3ifaQe3l/0sCxZZvw04BMWuORXy/P+9dF4Gul/nhR6sYbhtT++1BDQe
         +LL731JoYSnNScqnv2J9gWi40Ue6jhBFku1Y8+gG/JFcjC0wx059A1mW80WKg7NcRvMh
         z3DRBwlp/LFsPx1WaAIhURWRGezioscRKMV8r3xne+QgmcHrDiAsXC8xH3dvG0oBWVgn
         XIrA==
X-Gm-Message-State: AOAM530R2K1Q9vq0PfApglsvG1H+lpq4N7npZjoTsjS4S0CSzTO0aSeH
        S3SF4lG352MlUkr6h2wkCLQ=
X-Google-Smtp-Source: ABdhPJxWUCEQjW6FELIml7LVP1UDFmA44Jif4j4NnmxsgcT0gFd29PIhacnf34ihj0AwtMwhX85Rtg==
X-Received: by 2002:a63:1542:: with SMTP id 2mr1249588pgv.329.1624482013799;
        Wed, 23 Jun 2021 14:00:13 -0700 (PDT)
Received: from google.com ([2601:647:4701:18d0:efda:7f9b:abe5:8dd8])
        by smtp.gmail.com with ESMTPSA id u11sm414384pjf.46.2021.06.23.14.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 14:00:13 -0700 (PDT)
Date:   Wed, 23 Jun 2021 14:00:11 -0700
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/048: skip test of filename wipe if journal
 checkpoint is not supported
Message-ID: <YNOg24bw80THh4uF@google.com>
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
