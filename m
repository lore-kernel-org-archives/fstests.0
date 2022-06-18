Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9D7C43334
	for <linux-fstests@archiver.kernel.org>; Sat, 18 Jun 2022 03:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbiFRDO1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jun 2022 23:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiFRDOZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jun 2022 23:14:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E64D76D181
        for <fstests@vger.kernel.org>; Fri, 17 Jun 2022 20:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655522062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nFpevWKrEJpMjcO67Wls3Hv4+fFmQiPWZbscBXeNSas=;
        b=UjOiqD45coUvOi8VQT0pfZo9dTSxBFUoDXF6EWaUM41HwTABH0yj74JZpiQH3W+cFN9O6M
        zrH1csanmMzeC/jwhGcFt4Q7ZcRbNTr5pLYdZeWCtTR6ML6bgQiz4jsrpEij09LrVCZo2j
        v2j4+KUNxy6mjaTgDSOas9s/y7nPmc0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-AK7mO5odNGyk0PnSoPr9TQ-1; Fri, 17 Jun 2022 23:14:21 -0400
X-MC-Unique: AK7mO5odNGyk0PnSoPr9TQ-1
Received: by mail-qk1-f197.google.com with SMTP id k188-20020a37a1c5000000b006a6c4ce2623so7007193qke.6
        for <fstests@vger.kernel.org>; Fri, 17 Jun 2022 20:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nFpevWKrEJpMjcO67Wls3Hv4+fFmQiPWZbscBXeNSas=;
        b=jq1Fh/GHBfCI4hpaY+7JVIn4EWhdMfWzeyjDaIF74sq/FJKCvAHlDrFQ9TVJ6n5mwd
         KbzgLpz+hd8Nm+BKQmE6W4RGleMSdrrMPr1/9+K5P5NWNiZCV0NnKLt4xHqLNyuLO4m3
         YqRn+4d6F/fmMZaVcvrslJNJusSRqWApwmiptZsSX1rBEQ9iWj3LlTUO33ZiKLlYqjNx
         Q78UeoIxAn6wpVn8G9RBaPBNXchBtU1NBS9uKuCxe4OnGlidJse1Z9y0nv9POHN7YkMt
         LcC7foTjc2DuTtl3pm2aubT5TFKXRNSLiqMKJAFliq3up9Ho/PeZmMMKb7VT9i3yLzZ8
         F3wA==
X-Gm-Message-State: AJIora+2IxoZa0lWBs8+pQBcdV5IrTav67ftL4X0LPNDpgdsuWqYrkmc
        6I7Frp+4JkQST9mWJumY2Z0vx+Qr8NHuNQZFn2Pou7MqCDDIqvVih96Y4+GV/wJvBCOJ8zsVCal
        5XAeiTY1uKLI8O1gYAA==
X-Received: by 2002:a05:6214:410d:b0:467:d399:251c with SMTP id kc13-20020a056214410d00b00467d399251cmr10802008qvb.122.1655522060030;
        Fri, 17 Jun 2022 20:14:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tOYRPqHpQAW9XMVKvFdv2yZdNvPToHMBYzNYu0uVgNVVUZzhXhVUlepF/J9IE4GQovA8KW/A==
X-Received: by 2002:a05:6214:410d:b0:467:d399:251c with SMTP id kc13-20020a056214410d00b00467d399251cmr10801999qvb.122.1655522059729;
        Fri, 17 Jun 2022 20:14:19 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g19-20020ac85813000000b00307aed25fc7sm5529872qtg.31.2022.06.17.20.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 20:14:19 -0700 (PDT)
Date:   Sat, 18 Jun 2022 11:14:13 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix input value to _scratch_mkfs_sized
Message-ID: <20220618031413.j6pgaucpinl5csc5@zlang-mailbox>
References: <20220616043845.14320-1-lan@suse.com>
 <20220617035836.GZ1098723@dread.disaster.area>
 <20220617175212.f5pikh6zdgud2qjl@zlang-mailbox>
 <20220617222405.GA1098723@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617222405.GA1098723@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jun 18, 2022 at 08:24:05AM +1000, Dave Chinner wrote:
> On Sat, Jun 18, 2022 at 01:52:12AM +0800, Zorro Lang wrote:
> > On Fri, Jun 17, 2022 at 01:58:36PM +1000, Dave Chinner wrote:
> > > On Thu, Jun 16, 2022 at 12:38:43PM +0800, An Long wrote:
> > > > Function _scratch_mkfs_sized cannot recognize the size descriptor.
> > > > 
> > > > For example, we set MKFS_OPTIONS="-b 4k" and then run generic/416 on
> > > > ext4, will fail with "mkfs.ext4: invalid block size - 4".
> > > 
> > > So isn't the correct fix for this to use the correct format in
> > > MKFS_OPTIONS? ie. "-b 4096"?
> > > 
> > > i.e. why do we need ito add code to fix something that the user must
> > > specify themselves and could easily just use an integer to begin
> > > with?
> > 
> > The fstests doesn't notice users that they *must* use pure number in
> > MKFS_OPTIONS, especially the block size.
> 
> So why not just document the requirement? I mean,
> _mkfs_scratch_sized is documented to take the size in bytes primarly
> because some mkfs binaries only suport bytes and not shortform human
> numbers. We did that because it was seen that consistency in all the
> tests of using byte counts was much preferable to having a random
> smattering of different units. It's much easier to programatically
> calculate the size if it is in bytes, and that results in simpler
> and easier to understand code.
> 
> The main issue I have here is that we need to reduce the overhead of
> setting up every test - adding more complex parameter parsing to
> _scratch_mkfs_sized means every test that calls it now takes just a
> little bit longer to run. That's about a 100 tests that now take
> just a little longer to run, meaning fstests takes a few seconds
> more to run.

Oh, so that's what's your really worry about. Understand. But will this
change takes that long time? If the user still use pure integer as usual,
it'll through:

    elif [[ $str =~ ^[0-9]+$ ]] ; then
            size=$str

then return directly, won't through those complex calculation. I didn't
test, but I think it's fast enough. We even can put this judgement to be
the first judgement, let the pure integer won't be affected much.

Then we document that "recommend pure integer in MKFS_OPTIONS". How about
that?

Due to if we only tell the users to use pure integer in document, if they
don't follow that, and cause some tests actually didn't run as expected,
but we don't report any failures. That looks I'm all talk, no clear
"bad sequent" if no one follow.

So if we don't merge this patchset. I'd like to make something wrong to
remind that "must use pure integer in MKFS_OPTIONS". What do you think?

Thanks,
Zorro

> 
> Every "lets make this pretty parsing" or "lets do complex parsing"
> change that replaces a simple, straight forward integer or construct
> adds bloat, overhead and runtime. It's a death-by-a-thousand-cuts
> scenario - each individual change can be justified, but suddenly
> we've adding another 15 minutes of runtime to fstests even for
> people who require/use none of that functionality.
> 
> Bloat, overhead and runtime are the three main things we
> need to remove from fstests, so I feel that the right thing to do is
> document that sizes for filesystems, block sizes, etc must always be
> in integer units rather than adding code to "be flexible".
> 
> > As this issue, we have to accept the size unit(k/m/g ...) or have to
> > tell the users that they must use pure integer, any of "k/m/g" is
> > unacceptable. I prefer the former, so I'd like to have this change,
> > except anyone has a better idea :)
> 
> I'd much prefer we document the existing behaviour rather than add
> more complexity and overhead....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

