Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892B6ECAAD8
	for <linux-fstests@archiver.kernel.org>; Fri, 23 Sep 2022 14:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiIWOUK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 23 Sep 2022 10:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiIWOUI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Sep 2022 10:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B075C9DF82
        for <fstests@vger.kernel.org>; Fri, 23 Sep 2022 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663942805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/ilkxSs8H0zN6cx1ItnU/SBaXkvSojw6KgufY+mCow=;
        b=OCdwnpRD2kZYoy6uVpn1wOEgf4wQrqsJXgAzwpyoPGjf6NxuiNldazmqDKP3G8fqW0dwHH
        dRi/yaABtc0u3kcmGk61eRk3C/HIORjavSQpraDVC0nPAEU3Y44HNXBXPlt6R/m8BYanEJ
        rahmNyqsMsisiL1zEXIOy2WF9HdRA/c=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-99-tN3kiHWLPzO_RmolTuiE_w-1; Fri, 23 Sep 2022 10:20:04 -0400
X-MC-Unique: tN3kiHWLPzO_RmolTuiE_w-1
Received: by mail-pl1-f200.google.com with SMTP id s16-20020a170902ea1000b00176cf52a348so185612plg.3
        for <fstests@vger.kernel.org>; Fri, 23 Sep 2022 07:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=a/ilkxSs8H0zN6cx1ItnU/SBaXkvSojw6KgufY+mCow=;
        b=1rKO5PvB26ToEZQ0Gn5xbQOsms+AXZ+mSbj8Y0cRv0dF9sZD7MW/uoCNe/igCiHi/N
         g4B7rvX40+Y4TVRP9W72fJ+EVEwij22jXKyt3pvlAfvzHj+F2x0+DjdWyfqNvllfhaA/
         BtQZaPkoOjsR73gCPktO+hSDlxrxC3DOcd/czBfETvf64p819OznjPyhWYK+dHbZibju
         5UMzXOWcOdjZ7xk6PVnJ9WJrAUwA99ibtKHMYU8MuJ+jE/Z05lQCw5tgZN1/Mc/XTSeH
         pHIdy5nHyo/06zMA+b5puvZNrefN+QJZ+M286SLa8RhM9WuoFf35wV2g6pb8tEG/Pu64
         7DJg==
X-Gm-Message-State: ACrzQf0yA+x8Tn6lvPoXh/7OUg5qp4REGtef8GGteu+x/zT701g4Z/kP
        tBr59dEQKbi+SiFQPjFWx1lOPiDC9FMNZsxlYCUAhDef0qr/QnQpCmiPpxRRm6GBD5DzlZg4Enq
        vmpKUkcfheyoZnHa1Ig==
X-Received: by 2002:a05:6a02:205:b0:41b:96dc:bb2a with SMTP id bh5-20020a056a02020500b0041b96dcbb2amr7855680pgb.116.1663942803383;
        Fri, 23 Sep 2022 07:20:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5b5qWsRITYnQYKVKqXGtv0hebp0M7gqYcUXAGgVJRGB6I6300+NYvcuTH6qFGC8LGXIJkW6A==
X-Received: by 2002:a05:6a02:205:b0:41b:96dc:bb2a with SMTP id bh5-20020a056a02020500b0041b96dcbb2amr7855654pgb.116.1663942803052;
        Fri, 23 Sep 2022 07:20:03 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r28-20020aa79edc000000b0053e62b6fd22sm6485311pfq.126.2022.09.23.07.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 07:20:02 -0700 (PDT)
Date:   Fri, 23 Sep 2022 22:19:58 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: get section config after RUN_SECTION checks
Message-ID: <20220923141958.jps5bddtsnbli7ed@zlang-mailbox>
References: <f214d554b294bd3d2515742ad3bd7eeeab4d361f.1661369519.git.josef@toxicpanda.com>
 <20220825144242.25zstpvox5dcrvmg@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825144242.25zstpvox5dcrvmg@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 25, 2022 at 10:42:42PM +0800, Zorro Lang wrote:
> On Wed, Aug 24, 2022 at 03:32:10PM -0400, Josef Bacik wrote:
> > While trying to do
> > 
> > ./check -s <some section>
> > 
> > I was failing because I had a section defined higher than <some section>
> > that had TEST_DEV=/some/nonexistent/device, since I was using the other
> > section to test an experimental drive.  This appears to be because we
> > run through all of the sections, and when getting the section config we
> > check to see if it's valid, and in this case the section wasn't valid.
> > 
> > The section I was actually trying to use was valid however.  Fix check
> > to see if the section we're trying to run is in our list of sections to
> > run first, and then if it is get the config at that point.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> 
> May you provide any specific config examples to clarify what kind of issue
> you feel wrong, and what kind of usage you hope to support :)

Hi Josef,

Although you didn't reply this email, but I think I might hit similar
problem with you recently when I tried to do a btrfs test. I wrote a
config.file likes:

[default]
export TEST_DEV=/dev/sda5
export TEST_DIR=/mnt/test
export SCRATCH_DEV_POOL="/dev/mapper/testvg-scratchdev1 /dev/mapper/testvg-scratchdev2 /dev/mapper/testvg-scratchdev3 /dev/mapper/testvg-scratchdev4 /dev/mapper/testvg-scratchdev5"
export SCRATCH_MNT=/mnt/scratch

[logdev]
export TEST_DEV=/dev/sda5
export TEST_DIR=/mnt/test
export SCRATCH_DEV=/dev/sda3
export SCRATCH_MNT=/mnt/scratch
export USE_EXTERNAL=yes
export SCRATCH_LOGDEV=/dev/loop0

And run:
# ./check -s default btrfs/275

Then I hit:
SECTION       -- default
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 hp-xxxxx-xxxx 6.0.0-0.rc4.20220906git53e99dcff61e.32.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Sep 7 07:51:49 UTC 2022
MKFS_OPTIONS  -- /dev/mapper/testvg-scratchdev1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/mapper/testvg-scratchdev1 /mnt/scratch

btrfs/275 2s ...  4s
Ran: btrfs/275
Passed all 1 tests

common/config: Error: $SCRATCH_DEV (/dev/sda3) should be unset when $SCRATCH_DEV_POOL (/dev/mapper/testvg-scratchdev1 /dev/mapper/testvg-scratchdev2 /dev/mapper/testvg-scratchdev3 /dev/mapper/testvg-scratchdev4 /dev/mapper/testvg-scratchdev5) is set
SECTION       -- default
=========================
Ran: btrfs/275
Passed all 1 tests

Is that the problem what you said, or you have more problems?

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
> >  check | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/check b/check
> > index 0b2f10ed..ad0ab3cf 100755
> > --- a/check
> > +++ b/check
> > @@ -678,7 +678,6 @@ function run_section()
> >  
> >  	OLD_FSTYP=$FSTYP
> >  	OLD_TEST_FS_MOUNT_OPTS=$TEST_FS_MOUNT_OPTS
> > -	get_next_config $section
> >  
> >  	# Do we need to run only some sections ?
> >  	if [ ! -z "$RUN_SECTION" ]; then
> > @@ -708,6 +707,8 @@ function run_section()
> >  		fi
> >  	fi
> >  
> > +	get_next_config $section
> > +
> >  	mkdir -p $RESULT_BASE
> >  	if [ ! -d $RESULT_BASE ]; then
> >  		echo "failed to create results directory $RESULT_BASE"
> > -- 
> > 2.26.3
> > 

