Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF5BC433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 11 Oct 2022 14:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJKOSK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 Oct 2022 10:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJKOSJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Oct 2022 10:18:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBBA97D57
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2022 07:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665497886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jv/adB2S0eElPiPBvvfvuGQO+DRhO/v6kKDzHKS3ugQ=;
        b=HlpbDf7s6VbWU+rz5mGOmuu4/UTGkPzD04jk/l6iD0+kgGAzjgxFIroESyOrmXHWwVchMH
        V/TS5DcFcYHp3HDZw8eWAp8Jb2qjL3JmV1KFK9AaxfIV7QQ1tiViUUCUZ0u14dMQctxQ/A
        sIG+xjvkWFenRqIBWomHXAWi/rMKQpw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-670-ZRcV1417MJOX5_fVrivccw-1; Tue, 11 Oct 2022 10:18:04 -0400
X-MC-Unique: ZRcV1417MJOX5_fVrivccw-1
Received: by mail-qt1-f197.google.com with SMTP id gc10-20020a05622a59ca00b003951e095c04so8122297qtb.4
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2022 07:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jv/adB2S0eElPiPBvvfvuGQO+DRhO/v6kKDzHKS3ugQ=;
        b=oenclGtxC/bkLVs+BSffZbaN+JoRL6xmThuHznD1oDLbHJV5w6dVfgrrJl5cAEJvoY
         ep9NCL73sdur8VYczq8iXgzm+5bGxEbUB7X8E+kO6RohSCOv0Fnvt+pElczV8p5M0NbR
         wVDegDiQ84cTvwuqvQr6LDJiWsyIj/xBsms2KVOPT5RQzP3xPPFTxZW0Q0eQM85xafzH
         7/MfHsyZekANy55Ew7x//MQefSU0Lh/mKH6BdwoQ1peyfuxSaXET06LAhr9oqNJkdjp7
         +hh2Qn7ibGicFoHiKdbBleLLNOdQB79o/7t6mR6uwd6I+v3LpsY81fBdTWtQ0HslCcqA
         CTPg==
X-Gm-Message-State: ACrzQf3JvHLN5AMQAhlfaf5HuaiR2AX15G+H7RxxBzyJxe/iAybMzFhl
        MzhyJ3N81jJHZCO03QOKRpkPznfw6/tHdmqDWMRAksTZy7MbnthymgEY3FGe6Jj4kWUjQdhedwY
        ui2c/0xjxMyDTW22xTA==
X-Received: by 2002:a37:655:0:b0:6ee:8f4e:6ce5 with SMTP id 82-20020a370655000000b006ee8f4e6ce5mr556055qkg.765.1665497880942;
        Tue, 11 Oct 2022 07:18:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4wcfsiLbViOWCldkJFZdslasYCtXEcaflaBhdoJDmUyu0IEK0csfWqjl6LYVitv3W0oXHuTQ==
X-Received: by 2002:a37:655:0:b0:6ee:8f4e:6ce5 with SMTP id 82-20020a370655000000b006ee8f4e6ce5mr556042qkg.765.1665497880658;
        Tue, 11 Oct 2022 07:18:00 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id cr12-20020a05622a428c00b003434d3b5938sm10666573qtb.2.2022.10.11.07.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 07:18:00 -0700 (PDT)
Date:   Tue, 11 Oct 2022 22:17:55 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     fstests@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: get section config after RUN_SECTION checks
Message-ID: <20221011141755.h363qjm2doz5jhbc@zlang-mailbox>
References: <f214d554b294bd3d2515742ad3bd7eeeab4d361f.1661369519.git.josef@toxicpanda.com>
 <20220825144242.25zstpvox5dcrvmg@zlang-mailbox>
 <20220923141958.jps5bddtsnbli7ed@zlang-mailbox>
 <Y0RAwGyGsa+mL7hW@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0RAwGyGsa+mL7hW@localhost.localdomain>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 10, 2022 at 11:56:48AM -0400, Josef Bacik wrote:
> On Fri, Sep 23, 2022 at 10:19:58PM +0800, Zorro Lang wrote:
> > On Thu, Aug 25, 2022 at 10:42:42PM +0800, Zorro Lang wrote:
> > > On Wed, Aug 24, 2022 at 03:32:10PM -0400, Josef Bacik wrote:
> > > > While trying to do
> > > > 
> > > > ./check -s <some section>
> > > > 
> > > > I was failing because I had a section defined higher than <some section>
> > > > that had TEST_DEV=/some/nonexistent/device, since I was using the other
> > > > section to test an experimental drive.  This appears to be because we
> > > > run through all of the sections, and when getting the section config we
> > > > check to see if it's valid, and in this case the section wasn't valid.
> > > > 
> > > > The section I was actually trying to use was valid however.  Fix check
> > > > to see if the section we're trying to run is in our list of sections to
> > > > run first, and then if it is get the config at that point.
> > > > 
> > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > > ---
> > > 
> > > May you provide any specific config examples to clarify what kind of issue
> > > you feel wrong, and what kind of usage you hope to support :)
> > 
> > Hi Josef,
> > 
> > Although you didn't reply this email, but I think I might hit similar
> > problem with you recently when I tried to do a btrfs test. I wrote a
> > config.file likes:
> > 
> 
> Sorry I don't actually get emails to my inbox, I use lei so sometimes miss
> simple things like this.
> 
> I'm using kdevops, and I had a general config that I was using for all hosts,
> except one host has a PCI passthrough ZNS device.  So I have something akin to
> this
> 
> [defaut]
> TEST_DIR=/mnt/test
> SCRATCH_MNT=/mnt/scratch
> 
> [btrfs-normal]
> TEST_DEV=/dev/sda
> SCRATCH_DEV_POOL="/dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh"
> SCRATCH_LOGDEV=/dev/loop0
> 
> [btrfs-zns]
> TEST_DEV=/dev/nvme0n1
> SCRATCH_DEV=/dev/nvme1n1
> 
> [btrfs-compress]
> TEST_DEV=/dev/sda
> SCRATCH_DEV_POOL="/dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh"
> SCRATCH_LOGDEV=/dev/loop0
> MOUNT_OPTIONS="-o compress"
> 
> If I tried to run
> 
> ./check -s btrfs-compress
> 
> it would fail because it couldn't find /dev/nvme0n1, despite it not being in the
> section I'm running.  Thanks,

Thanks Josef, I'm OK to have this patch. Due to fstests "section" related rules
changing might affect some people's daily/weekly regression test script. I don't
use fstests' "section" too much, I've asked Darrick, he said he don't either.

But I think Dave and Ted might use it much, so I'd like to cc them to make sure
this change won't cause their nightly testing broken suddently. Welcome more
review points from anyone.

Thanks,
Zorro

> 
> Josef
> 

