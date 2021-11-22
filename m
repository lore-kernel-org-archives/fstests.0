Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CFBC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 22 Nov 2021 08:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbhKVIwg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Nov 2021 03:52:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238919AbhKVIwb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Nov 2021 03:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637570965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dt4hjqUJZyY9OljOXzZo096+YfRkWaB9RwIUT/gS6BM=;
        b=Llb01A5ktQSaK+Rf/iw2EP4zxLAcAAXCA5gTMSn1PgC/G1rK4RoFKkChXM9mFGjFZWEKGH
        G/pzkpw4chUpiHoTubIFT/x4++gaAuZ6aXdKzAw0Ws1xnRCgbPcLyBv8D3q8Jv6K0Tg7sE
        yXoG8MxmsuY7yXorRs+JXV64uqHuVQA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-565-P4ZtY9gAOF6wOumFmWc65w-1; Mon, 22 Nov 2021 03:49:22 -0500
X-MC-Unique: P4ZtY9gAOF6wOumFmWc65w-1
Received: by mail-ed1-f71.google.com with SMTP id i19-20020a05640242d300b003e7d13ebeedso14112467edc.7
        for <fstests@vger.kernel.org>; Mon, 22 Nov 2021 00:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=Dt4hjqUJZyY9OljOXzZo096+YfRkWaB9RwIUT/gS6BM=;
        b=f3391WQFQcNCJU/OdH3QUgBfCuSBuc+z1p45Hhbc6LNqxIaRV03uQQMj1zt51YI/E0
         IBNH6pOYAZudKnCT1E5pihva0dNuE8VgGvmC28Wx3ElO/809daQDwRP/5e0ZLpgpLoKM
         h6uxRfwLEB/1ds2IBPhOjiJMUQNuvJq+17cmVZK4afPejAZRrljTZGMeiITSiuB1DdL8
         RNoNGZj8irnGgZtgMf8X+Fm7Ecbgi8mSahX7Gh6zygkXWRp4zxXNpTx9XKVj7W9WIMZK
         UO8Sn0jnwvYEI5SqlKi6VRyiXS5I7jajXWSC01K8XTe9hWI+tWrxOBF3DXBBc/5l5CPu
         UdXA==
X-Gm-Message-State: AOAM53113RkNazu+lJbeTwKeG5ppNWgZGZaZl6i6cyK1DKFRaM84B+WM
        ZmD0whHJLw6EXSP2E3g1qShz290EKlGQtf5zCAZnHrOIV52jMmhCECluKrtHVbqQXqHKLAbKx+X
        t3307TvfFiRnwqlDwlBYjf4Js7BULzZGC9YrgAJ//YGlSDjV4VAttvIk3uwbP5ny/6LrZR7Y=
X-Received: by 2002:a17:907:7664:: with SMTP id kk4mr37192813ejc.319.1637570961251;
        Mon, 22 Nov 2021 00:49:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymAxIyUYRode+6TRw601Q/9gYqjfOiXymBqg+/Ta9XuCx9a9vANZsE9wYmRoWZ9tZlWZscbg==
X-Received: by 2002:a17:907:7664:: with SMTP id kk4mr37192774ejc.319.1637570960919;
        Mon, 22 Nov 2021 00:49:20 -0800 (PST)
Received: from andromeda.lan (ip4-46-39-172-19.cust.nbox.cz. [46.39.172.19])
        by smtp.gmail.com with ESMTPSA id hc10sm3351979ejc.99.2021.11.22.00.49.18
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 00:49:19 -0800 (PST)
Date:   Mon, 22 Nov 2021 09:49:17 +0100
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH V2 0/2] xfstests: Fix generic/643 on ext2 and ext3
Message-ID: <20211122084917.qki4cortq5gumdzw@andromeda.lan>
Mail-Followup-To: fstests@vger.kernel.org
References: <20211110124119.43974-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110124119.43974-1-cmaiolino@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Ping.

> 
> This is the 2nd version of this series to fix test g/643.
> 
> This version ensures _format_swapfile helper returns the swap size in bytes
> every time (previous version returned it in a different unit, depending on the
> swap's size) and updates remaining users of _format_swapfile() to discard its
> return value.
> 
> This also slightly change patch 2, making g/643 to use swapon to retrieve swap
> size (more details in the patch's description).
> 
> Original cover-letter below.
> 
> 
> Currently, generic/643 test fails on ext2 and ext3 filesystems when using 1k
> block sizes.
> The failure itself happens due the mapping of indirect blocks to iomap extents
> and the aligment constraints imposed by iomap. Specific details are described in
> patch 2.
> 
> To fix the test, I modified it to use the swapfile size described in the swap
> header (patch 2), and to retrieve such information, at mkswap time, I modified
> the _format_swapfile() function, and I believe such modification requires its own
> patch (patch 1).
> 
> These changes have also been tested on 64k pages (both on arm and PPC) to ensure
> it doesn't break the test on such architectures.
> 
> Carlos Maiolino (2):
>   common/rc: Enable _format_swapfile to return the swap size
>   generic/643: Fix for 1k block sizes for ext2 and ext3
> 
>  common/rc         | 10 +++++++---
>  tests/btrfs/173   |  2 +-
>  tests/btrfs/174   |  2 +-
>  tests/btrfs/175   |  4 ++--
>  tests/btrfs/176   |  2 +-
>  tests/btrfs/177   |  2 +-
>  tests/generic/356 |  2 +-
>  tests/generic/357 |  2 +-
>  tests/generic/493 |  2 +-
>  tests/generic/494 |  2 +-
>  tests/generic/554 |  2 +-
>  tests/generic/569 |  2 +-
>  tests/generic/643 | 27 +++++++++------------------
>  13 files changed, 28 insertions(+), 33 deletions(-)
> 
> -- 
> 2.31.1
> 

-- 
Carlos

