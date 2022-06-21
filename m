Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31A9C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Jun 2022 04:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiFUEFe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Jun 2022 00:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiFUEFc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2022 00:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 074411DA67
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 21:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655784329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bDKX8uzwatQCi1rP3ITBzZWzz/OFMkcQVEMl0M9ezzE=;
        b=Oecqgb/cZdrgSWiuP2pscB1JSnrEBhdSpoALMuwIllfMG0o0OndKQ9WFf5BcQ+Du+TzJUI
        JKzKiEi7b7XXgE4Tme8K8SbjpWH4HR8OHpHvWy0bLvE/OIStbjdL4u62Uyu/j3dHHFZDiF
        rBxVW29NRC+5w0aQmnJX5z5iEyc3W1E=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-w4Y8VxlXM1ueea7ef6LHfA-1; Tue, 21 Jun 2022 00:05:26 -0400
X-MC-Unique: w4Y8VxlXM1ueea7ef6LHfA-1
Received: by mail-qk1-f197.google.com with SMTP id h22-20020a05620a245600b006ac46bda40eso7942134qkn.18
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 21:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bDKX8uzwatQCi1rP3ITBzZWzz/OFMkcQVEMl0M9ezzE=;
        b=liVd395IZQeQRkt/tCFw/JSmG1XfI5/4aBsbdUyWO212aCQxvt8zMBWNttV3OUCqzN
         gNkiS5X3xwhjW8iuX02A2I/JYZAGVtCscNYmwxopa+CEuZch0l4cg3tOYPcRTjtmP5yk
         LNRpIn4rB56C8QSc2MlkPJdpWd0pfHmRx/ifzbbsw5bFzaQdWwPbqDeIs4rpoyX+9JmH
         /P4/1LNZeXWgbJoKlBre+A+tGzBfIrXLzr70vIWaGI7bkHcaIpWNVrVoiCpcwdA0mIl9
         Xj1XBbNu83vJEDKCIdnyTBXFT0/m1f82biO2YOlsWWelHhLJppfhpyBThVKE6ZDyItlJ
         G8RQ==
X-Gm-Message-State: AJIora8nwUGOmEinxow/sIUcA6uwfy8nCKqhJzBQPlTSqSzEpEdz+w+y
        tnniGi3KPMjdtCD0mH+GfhhK1LMbQ4aF2a/4OCK8U8umTzukldt7RiTEBuQiiF50MTP25Dc1sfY
        U7TjNC1HIHwEAz5nB6g==
X-Received: by 2002:a05:620a:2992:b0:6a7:6244:e7fe with SMTP id r18-20020a05620a299200b006a76244e7femr17804521qkp.370.1655784326034;
        Mon, 20 Jun 2022 21:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1viekAJXepz45+GNeLbCbaUAz1U5whrS7u+t6+LAg8kKOTaGUAMxAoTCY+THtcpbzh6wHgAPg==
X-Received: by 2002:a05:620a:2992:b0:6a7:6244:e7fe with SMTP id r18-20020a05620a299200b006a76244e7femr17804506qkp.370.1655784325697;
        Mon, 20 Jun 2022 21:05:25 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l7-20020a378907000000b006a6ae636ce0sm13134201qkd.131.2022.06.20.21.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 21:05:25 -0700 (PDT)
Date:   Tue, 21 Jun 2022 12:05:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Long An <lan@suse.com>
Cc:     fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2 0/2] Fix input value to _scratch_mkfs_sized
Message-ID: <20220621040519.pydhkslf4j3eds7w@zlang-mailbox>
References: <20220616043845.14320-1-lan@suse.com>
 <20220617035836.GZ1098723@dread.disaster.area>
 <20220617175212.f5pikh6zdgud2qjl@zlang-mailbox>
 <20220617222405.GA1098723@dread.disaster.area>
 <20220618031413.j6pgaucpinl5csc5@zlang-mailbox>
 <20220620231229.GD1098723@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620231229.GD1098723@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 21, 2022 at 09:12:29AM +1000, Dave Chinner wrote:
> On Sat, Jun 18, 2022 at 11:14:13AM +0800, Zorro Lang wrote:
> > On Sat, Jun 18, 2022 at 08:24:05AM +1000, Dave Chinner wrote:
> > > On Sat, Jun 18, 2022 at 01:52:12AM +0800, Zorro Lang wrote:
> > > > On Fri, Jun 17, 2022 at 01:58:36PM +1000, Dave Chinner wrote:
> > > > > On Thu, Jun 16, 2022 at 12:38:43PM +0800, An Long wrote:
> > > > > > Function _scratch_mkfs_sized cannot recognize the size descriptor.
> > > > > > 
> > > > > > For example, we set MKFS_OPTIONS="-b 4k" and then run generic/416 on
> > > > > > ext4, will fail with "mkfs.ext4: invalid block size - 4".
> > > > > 
> > > > > So isn't the correct fix for this to use the correct format in
> > > > > MKFS_OPTIONS? ie. "-b 4096"?
> > > > > 
> > > > > i.e. why do we need ito add code to fix something that the user must
> > > > > specify themselves and could easily just use an integer to begin
> > > > > with?
> > > > 
> > > > The fstests doesn't notice users that they *must* use pure number in
> > > > MKFS_OPTIONS, especially the block size.
> > > 
> > > So why not just document the requirement? I mean,
> > > _mkfs_scratch_sized is documented to take the size in bytes primarly
> > > because some mkfs binaries only suport bytes and not shortform human
> > > numbers. We did that because it was seen that consistency in all the
> > > tests of using byte counts was much preferable to having a random
> > > smattering of different units. It's much easier to programatically
> > > calculate the size if it is in bytes, and that results in simpler
> > > and easier to understand code.
> > > 
> > > The main issue I have here is that we need to reduce the overhead of
> > > setting up every test - adding more complex parameter parsing to
> > > _scratch_mkfs_sized means every test that calls it now takes just a
> > > little bit longer to run. That's about a 100 tests that now take
> > > just a little longer to run, meaning fstests takes a few seconds
> > > more to run.
> > 
> > Oh, so that's what's your really worry about. Understand. But will this
> > change takes that long time? If the user still use pure integer as usual,
> > it'll through:
> > 
> >     elif [[ $str =~ ^[0-9]+$ ]] ; then
> >             size=$str
> > 
> > then return directly, won't through those complex calculation.
> 
> It's still additional unnecessary overhead to be adding to
> _mkfs_scratch_sized as user supplied MKFS_OPTIONS do not change from
> test to test.  So why do we even want to do this verification every
> time _mkfs_scratch_sized is run?  Look at the *big picture*, not the
> individual test context . Validate the user supplied MKFS_OPTIONS
> once at startup, not every time _mkfs_scratch_sized is run!
> 
> And looking at the big picture, we have a bunch of scratch_mkfs
> operations that take byte counts.  _scratch_mkfs_geom that takes
> stripe aligment parameters in bytes, _scratch_mkfs_blocksized that
> takes block size in bytes, _mkfs_scratch_sized that takes the fs
> size (and block size) in bytes, etc.
> 
> Bytes as an integer count  is the common unit across all tests,
> filesystems and APIs. We can do math directly on them, we don't need
> to care if different filesystems support some form of human readable
> or not (e.g. some filesystems will recognise "k" but not "K" for
> kilobytes), etc.
> 
> So if you've going to actually support human readable units for byte
> values, think through the consequences of doing that. Think about
> the difficultly that then poses for tests that are written as
> 
> _mkfs_scratch_sized 1G
> 
> and now someone else comes along, needs to modify the test and do
> calculations based on the size of the filesystem. Do we expect the
> test to now have string parsing in it to convert the filesystem size
> to an integer for this new functionality? Or do we then have to
> convert every part of the test to use byte units instead of human
> units before making the modification? Either way, it adds more work
> to future changes than the amount of tiem and work it might save
> now.
> 
> Hence to me, the big picture implications of allowing human readable
> units in fstests code and configs just does not add up to be a net
> positive.
> 
> > So if we don't merge this patchset. I'd like to make something wrong to
> > remind that "must use pure integer in MKFS_OPTIONS". What do you think?
> 
> IMO, a single validation check after section config loading in check
> is all that is necessary....

OK, so we agree on this.

Hi Long, if you're still interested in fixing this issue, please change it as:
1) Check MKFS_OPTIONS (and other options if need) at local.config loading time,
   make sure it follow the rules (pure integer)
2) Add this rule into doc (README)

Or I can help to do that, and mark you as "Reported-by", if you don't have
time to do that.

Thanks,
Zorro

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

