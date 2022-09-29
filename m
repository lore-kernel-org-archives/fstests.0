Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E366C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 29 Sep 2022 14:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiI2OGT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 29 Sep 2022 10:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbiI2OGO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Sep 2022 10:06:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307E5160E42
        for <fstests@vger.kernel.org>; Thu, 29 Sep 2022 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664460372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3xUfxrUlnPa302WMqJuwHhl7GKgLDJ9rA/szu7Wwvvg=;
        b=enjufIkBUNeoKaYO3ulhWPOyFm7fOn6ZgWi6FqWaradKuDoehZyFr84XSOCc9IWfBDGuxM
        DzYGskyj614+TC8GR32wqwRBBgHXc77uFxDZZ3IDOjmq6BzEfgeujvf3xXiScJaG/xcCTB
        NjIn7SZV9fIpbS6AwGwX8LR/GrIc55g=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-456-nlZ7NN8PNfy3ITB0b7wMhQ-1; Thu, 29 Sep 2022 10:06:10 -0400
X-MC-Unique: nlZ7NN8PNfy3ITB0b7wMhQ-1
Received: by mail-pl1-f197.google.com with SMTP id y16-20020a17090322d000b0017848b6f556so1070934plg.19
        for <fstests@vger.kernel.org>; Thu, 29 Sep 2022 07:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=3xUfxrUlnPa302WMqJuwHhl7GKgLDJ9rA/szu7Wwvvg=;
        b=ES+/vuW19mvKsgaCwkJmlrih0mgAFKXmhSF4XrB5PimMIOO3IOXc9Zn8z41m8XODDT
         lcVbM3HWHtU/moEkRv4/6JV+LFtZynJjghDSYfYn06LESQypA0H4HwIHk5Ngksto7FeZ
         0b0Nr+DsL0sIvfNWVCysD+yrnBHuQDWxj/3/CanRSJE6kJGBQHjpWwQVlmk6u+/E1HGJ
         ftM6s+wwzX10WvQESSq89U7WQsKq8jtxQmfDHMnmQTWd7ZYnEHkgd7VIZ9y2OAQeWLgv
         F4Zv2FXDBJWHxgTRqwc94CvhWmT8c0RInjfhKTMNh/SrTu5uuUY71BLn2QTMv3imAT1B
         aZEQ==
X-Gm-Message-State: ACrzQf3Ri+FIGUf40gJG0hi2JSS7Q+144NGCAkybZL2wN5QOqlUpYNKs
        KCTs6tnRg57bYHZAi9RGfJLrxOirkqewOQwQbhbYACK6hNM8jQnNpdEwh/d8+GI/sVRHCKWGJYY
        Koo91Hq2oAmMmMQFHgg==
X-Received: by 2002:a63:2cce:0:b0:434:e004:a218 with SMTP id s197-20020a632cce000000b00434e004a218mr3045891pgs.241.1664460369320;
        Thu, 29 Sep 2022 07:06:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5zSCuJVZsNsx9fUONef8AaexSagg4Xuh2iJ0C5ZSMOP0DRFDr8bs2WL2xDubQFnxrHnBrwKw==
X-Received: by 2002:a63:2cce:0:b0:434:e004:a218 with SMTP id s197-20020a632cce000000b00434e004a218mr3045873pgs.241.1664460368932;
        Thu, 29 Sep 2022 07:06:08 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b00170d34cf7f3sm5020738plg.257.2022.09.29.07.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 07:06:08 -0700 (PDT)
Date:   Thu, 29 Sep 2022 22:06:04 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: test active zone tracking
Message-ID: <20220929140604.phlru3cjcqfsbsr2@zlang-mailbox>
References: <cover.1664419525.git.naohiro.aota@wdc.com>
 <7390d3a918ce574d5349d31ab26fed0ae79952a9.1664419525.git.naohiro.aota@wdc.com>
 <20220929060106.dy7enioljc3hi3lt@zlang-mailbox>
 <20220929120400.GG13389@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929120400.GG13389@twin.jikos.cz>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 29, 2022 at 02:04:00PM +0200, David Sterba wrote:
> On Thu, Sep 29, 2022 at 02:01:06PM +0800, Zorro Lang wrote:
> > On Thu, Sep 29, 2022 at 01:19:25PM +0900, Naohiro Aota wrote:
> > > A ZNS device limits the number of active zones, which is the number of
> > > zones can be written at the same time. To deal with the limit, btrfs's
> > > zoned mode tracks which zone (corresponds to a block group on the SINGLE
> > > profile) is active, and finish a zone if necessary.
> > > 
> > > This test checks if the active zone tracking and the finishing of zones
> > > works properly. First, it fills <number of max active zones> zones
> > > mostly. And, run some data/metadata stress workload to force btrfs to use a
> > > new zone.
> > > 
> > > This test fails on an older kernel (e.g, 5.18.2) like below.
> > > 
> > > btrfs/292
> > > [failed, exit status 1]- output mismatch (see /host/btrfs/292.out.bad)
> > >     --- tests/btrfs/292.out     2022-09-15 07:52:18.000000000 +0000
> > >     +++ /host/btrfs/292.out.bad 2022-09-15 07:59:14.290967793 +0000
> > >     @@ -1,2 +1,5 @@
> > >      QA output created by 292
> > >     -Silence is golden
> > >     +stress_data_bgs failed
> > >     +stress_data_bgs_2 failed
> > >     +failed: '/bin/btrfs subvolume snapshot /mnt/scratch /mnt/scratch/snap825'
> > >     +(see /host/btrfs/292.full for details)
> > >     ...
> > >     (Run 'diff -u /var/lib/xfstests/tests/btrfs/292.out /host/btrfs/292.out.bad'  to see the entire diff)
> > > 
> > > The failure is fixed with a series "btrfs: zoned: fix active zone tracking
> > > issues" [1] (upstream commits from 65ea1b66482f ("block: add bdev_max_segments()
> > > helper") to 2ce543f47843 ("btrfs: zoned: wait until zone is finished when
> > > allocation didn't progress")).
> > 
> > If this's a regression test case for known fix, we'd better to use:
> > _fixed_by_kernel_commit 65ea1b66482f block: add bdev_max_segments (patchset)
> 
> This is very misleading as the commit only adds a helper that's used in
> later commits. If anything, the last commit in the series should be
> mentioned.

Sure, I just gave an example, you learned about that patchset more than me, so
feel free to pick up a proper commit and description :)

> 

