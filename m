Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C717C433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 10 Oct 2022 15:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiJJP4w (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 10 Oct 2022 11:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJJP4v (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 Oct 2022 11:56:51 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8965BC33
        for <fstests@vger.kernel.org>; Mon, 10 Oct 2022 08:56:50 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id x25so3266629qki.2
        for <fstests@vger.kernel.org>; Mon, 10 Oct 2022 08:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr/IdHXUBC5o5sSh1+oYlL+SeGy6hMZVycAp91mAftQ=;
        b=WGimGTLjshEM2qrpez7iFsahA5bQg0sKJXG6aqjjWRi3VUjX1hDnk5mJ38KbxDNu9G
         9x55D1dDS/UiELZEY2ug6U1tZ4fN7PPe/T7vuGozGMs+/4EtEVh/1rPUWw01jkxYfJ/h
         Yuhd3OMqyOvnkUpJPnzxUDAb2DisrxkK/jWRM7IJrGKSLsZmUSZ7exhZNayt9b6AwiZ5
         kPkGw69g+0rr/TwHZ3MP3Jpse77hmnCCBcNRJIuO9+PB59lJFovCMsylnyU1umXVbjj6
         m/t3GUEbhB35QIoGO1jBQvUO2hdX1WBcL+i71Ia7ZmN9zrKnA/ow9Bh7W6xZujOb2AYE
         HOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lr/IdHXUBC5o5sSh1+oYlL+SeGy6hMZVycAp91mAftQ=;
        b=M8f0AKH3Ldut4aJjUCESsmohpqgxtcVGcV/GEbO5ZBwvc0H0OcAHfwkDrUONW3e7+H
         R0/VrZxUVG/UkbBYILIYg89Rx7He7WfWRec137iPZlGrkwG3Ty/i5bajeJFtgmesQfdg
         zpkiOXB9rXLdvWFvbBsduF9SdVTK/ycjjHBPkicXT4ysj/shCQOacQiX+Bh3wjB+lP8G
         iIu5+w1QVJyAcROevtFMv5cNRfjy1CAg9zMoTumuU3+swLDvFGO8rc68wct2y98J6lQo
         uxzSTg0s/GbIOLvX1xwukglSON50mzq1iOIyb81cXSVMMMyhyQz3o8QnP8LiSdMeiE4u
         IiBg==
X-Gm-Message-State: ACrzQf2CIVQmnikSeI/24oyjdNgZ40MVGUmX2kgeo+2gLbF1XGwq/OuF
        dVCwKb8U4qZUr1BXbuSMIZxy4v0FsMDhkg==
X-Google-Smtp-Source: AMsMyM4tzfYE2TRtbO+jPrSvhXPZbZp/HJzZO9gMKc72/mg0k4TnbYbRVGHPLFdhS3iGkxfeiqd4Bg==
X-Received: by 2002:a05:620a:4015:b0:6ed:a8db:32c0 with SMTP id h21-20020a05620a401500b006eda8db32c0mr2176326qko.656.1665417409888;
        Mon, 10 Oct 2022 08:56:49 -0700 (PDT)
Received: from localhost (2603-6080-7808-8c00-f5b5-8829-a8a7-c191.res6.spectrum.com. [2603:6080:7808:8c00:f5b5:8829:a8a7:c191])
        by smtp.gmail.com with ESMTPSA id m8-20020ac84448000000b0039a1146e0e1sm2863306qtn.33.2022.10.10.08.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 08:56:49 -0700 (PDT)
Date:   Mon, 10 Oct 2022 11:56:48 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: get section config after RUN_SECTION checks
Message-ID: <Y0RAwGyGsa+mL7hW@localhost.localdomain>
References: <f214d554b294bd3d2515742ad3bd7eeeab4d361f.1661369519.git.josef@toxicpanda.com>
 <20220825144242.25zstpvox5dcrvmg@zlang-mailbox>
 <20220923141958.jps5bddtsnbli7ed@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923141958.jps5bddtsnbli7ed@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 23, 2022 at 10:19:58PM +0800, Zorro Lang wrote:
> On Thu, Aug 25, 2022 at 10:42:42PM +0800, Zorro Lang wrote:
> > On Wed, Aug 24, 2022 at 03:32:10PM -0400, Josef Bacik wrote:
> > > While trying to do
> > > 
> > > ./check -s <some section>
> > > 
> > > I was failing because I had a section defined higher than <some section>
> > > that had TEST_DEV=/some/nonexistent/device, since I was using the other
> > > section to test an experimental drive.  This appears to be because we
> > > run through all of the sections, and when getting the section config we
> > > check to see if it's valid, and in this case the section wasn't valid.
> > > 
> > > The section I was actually trying to use was valid however.  Fix check
> > > to see if the section we're trying to run is in our list of sections to
> > > run first, and then if it is get the config at that point.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > 
> > May you provide any specific config examples to clarify what kind of issue
> > you feel wrong, and what kind of usage you hope to support :)
> 
> Hi Josef,
> 
> Although you didn't reply this email, but I think I might hit similar
> problem with you recently when I tried to do a btrfs test. I wrote a
> config.file likes:
> 

Sorry I don't actually get emails to my inbox, I use lei so sometimes miss
simple things like this.

I'm using kdevops, and I had a general config that I was using for all hosts,
except one host has a PCI passthrough ZNS device.  So I have something akin to
this

[defaut]
TEST_DIR=/mnt/test
SCRATCH_MNT=/mnt/scratch

[btrfs-normal]
TEST_DEV=/dev/sda
SCRATCH_DEV_POOL="/dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh"
SCRATCH_LOGDEV=/dev/loop0

[btrfs-zns]
TEST_DEV=/dev/nvme0n1
SCRATCH_DEV=/dev/nvme1n1

[btrfs-compress]
TEST_DEV=/dev/sda
SCRATCH_DEV_POOL="/dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh"
SCRATCH_LOGDEV=/dev/loop0
MOUNT_OPTIONS="-o compress"

If I tried to run

./check -s btrfs-compress

it would fail because it couldn't find /dev/nvme0n1, despite it not being in the
section I'm running.  Thanks,

Josef
