Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B47C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Nov 2021 13:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhKVNDM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Nov 2021 08:03:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230322AbhKVNDL (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Nov 2021 08:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637586004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NABRchgt1bIQaYNSEi4wHn3EV3yZw+hGbQbrHxG/i+0=;
        b=Rz8CfBrPmVO/vi63vQltyIs2LpYAI9ocpgrYfxbvQF6dwzm2+ygwE8cA7y3oHDgiPLe+wY
        ml5ORb+rOSi7s4NRjRZZm0zoi+RMqiQCedAP3YHj9tHT3+ROSasO44n0oRewJrAqMGWN9L
        1r1VhG7bXRo/zF8bIQ13aB6UU3YsUpA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-poaO4odwOvSITWv59KoxCQ-1; Mon, 22 Nov 2021 08:00:02 -0500
X-MC-Unique: poaO4odwOvSITWv59KoxCQ-1
Received: by mail-ed1-f69.google.com with SMTP id p4-20020aa7d304000000b003e7ef120a37so14719034edq.16
        for <fstests@vger.kernel.org>; Mon, 22 Nov 2021 05:00:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=NABRchgt1bIQaYNSEi4wHn3EV3yZw+hGbQbrHxG/i+0=;
        b=xbxYKAH4zAwcyleRzHgD1Usph1W18Qu91zdgWlypT0DI99UAEPjTkK/4BX7toKKf9W
         L5cYfKD36cifJ1TX8XZrGyS51h44NF+bw2cKF1yIsvo2S3BN7i/omcVhTejUs0/JOBFV
         ITZGX58tnQmYPRAuhmgMBXSfhLQqC3eB0Xyg2fME046IotAnAohqB7abuAyeR71wXSip
         DTdRkDniMa+VUO2k+9NEd0ebUJQGRA7fozaSAsXdl7pQfS4bLQvuCiMNcmkPYlx0H4sY
         nS9lSJmVVWbpHbODisaDVFRONxDrwqQoqXptgQbHnFVF0NsuE6TJF78Sitibezi80oBQ
         iGOg==
X-Gm-Message-State: AOAM532PVSmKdCrlh3hla2HhGjGMN/a1r4xy7saXgCNk8Scj8mm1wQ8o
        hbfGDQ48Dyq5boqvhP2KEUx7yN+ytbI95s94GZbBjijIzi9n4IMKDp3E+bv7Be79+BExRE2HMs+
        zoJH+wWWNSha/fDCX6A==
X-Received: by 2002:a17:906:d553:: with SMTP id cr19mr39757681ejc.140.1637586000638;
        Mon, 22 Nov 2021 05:00:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwosnGYq9QjXB9SgWqqkJmkyL8/dziVKOIengG38KSTHwQv0krZgBPIIKJrWEl1ufI5P5mtgg==
X-Received: by 2002:a17:906:d553:: with SMTP id cr19mr39757634ejc.140.1637586000357;
        Mon, 22 Nov 2021 05:00:00 -0800 (PST)
Received: from andromeda.lan (ip4-46-39-172-19.cust.nbox.cz. [46.39.172.19])
        by smtp.gmail.com with ESMTPSA id h10sm4051032edr.95.2021.11.22.04.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 04:59:59 -0800 (PST)
Date:   Mon, 22 Nov 2021 13:59:58 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH V2 0/2] xfstests: Fix generic/643 on ext2 and ext3
Message-ID: <20211122125958.hfjtd4zseckkkodz@andromeda.lan>
Mail-Followup-To: Eryu Guan <eguan@linux.alibaba.com>,
        fstests@vger.kernel.org
References: <20211110124119.43974-1-cmaiolino@redhat.com>
 <20211122084917.qki4cortq5gumdzw@andromeda.lan>
 <20211122101845.GZ60846@e18g06458.et15sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122101845.GZ60846@e18g06458.et15sqa>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Eryu.

On Mon, Nov 22, 2021 at 06:18:45PM +0800, Eryu Guan wrote:
> On Mon, Nov 22, 2021 at 09:49:17AM +0100, Carlos Maiolino wrote:
> > Ping.
> 
> I think this patchset has been applied and pushed to upstream in last
> week's update. Would you please check if you could see them after
> pulling the latest update?

Yeah, I can see them. Thanks!

> 
> Thanks,
> Eryu
> 
> > 
> > > 
> > > This is the 2nd version of this series to fix test g/643.
> > > 
> > > This version ensures _format_swapfile helper returns the swap size in bytes
> > > every time (previous version returned it in a different unit, depending on the
> > > swap's size) and updates remaining users of _format_swapfile() to discard its
> > > return value.
> > > 
> > > This also slightly change patch 2, making g/643 to use swapon to retrieve swap
> > > size (more details in the patch's description).
> > > 
> > > Original cover-letter below.
> > > 
> > > 
> > > Currently, generic/643 test fails on ext2 and ext3 filesystems when using 1k
> > > block sizes.
> > > The failure itself happens due the mapping of indirect blocks to iomap extents
> > > and the aligment constraints imposed by iomap. Specific details are described in
> > > patch 2.
> > > 
> > > To fix the test, I modified it to use the swapfile size described in the swap
> > > header (patch 2), and to retrieve such information, at mkswap time, I modified
> > > the _format_swapfile() function, and I believe such modification requires its own
> > > patch (patch 1).
> > > 
> > > These changes have also been tested on 64k pages (both on arm and PPC) to ensure
> > > it doesn't break the test on such architectures.
> > > 
> > > Carlos Maiolino (2):
> > >   common/rc: Enable _format_swapfile to return the swap size
> > >   generic/643: Fix for 1k block sizes for ext2 and ext3
> > > 
> > >  common/rc         | 10 +++++++---
> > >  tests/btrfs/173   |  2 +-
> > >  tests/btrfs/174   |  2 +-
> > >  tests/btrfs/175   |  4 ++--
> > >  tests/btrfs/176   |  2 +-
> > >  tests/btrfs/177   |  2 +-
> > >  tests/generic/356 |  2 +-
> > >  tests/generic/357 |  2 +-
> > >  tests/generic/493 |  2 +-
> > >  tests/generic/494 |  2 +-
> > >  tests/generic/554 |  2 +-
> > >  tests/generic/569 |  2 +-
> > >  tests/generic/643 | 27 +++++++++------------------
> > >  13 files changed, 28 insertions(+), 33 deletions(-)
> > > 
> > > -- 
> > > 2.31.1
> > > 
> > 
> > -- 
> > Carlos
> 

-- 
Carlos

