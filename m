Received: from mail-pl1-f195.google.com ([209.85.214.195]:37904 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeHZQlA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 26 Aug 2018 12:41:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id u11-v6so2955322plq.5
        for <fstests@vger.kernel.org>; Sun, 26 Aug 2018 05:58:30 -0700 (PDT)
Date: Sun, 26 Aug 2018 20:58:11 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] xfstests: filter redundant output by getfattr
Message-ID: <20180826125811.GB3651@desktop>
References: <20180823024124.5341-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823024124.5341-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 23, 2018 at 10:41:24AM +0800, Zorro Lang wrote:
> When getfattr dumps values of all extended attributes (-d option),
> it doesn't print empty extended attributes. e.g: user.name. But
> from attr-2.4.48 this behavior is changed,  new getfattr prints
> user.name="".
> 
> The {=""} will break the golden image, so filter the redundant =""
> at the end if it has.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
> 
> Hi,
> 
> Sorry I took long time to write this V2, due to it changed many
> cases, I have to test them one by one. V1 patch refer to:
> https://patchwork.kernel.org/patch/10521875/
> 
> V2 did below changes:
> 1) Bring in a common function named _getfattr()
> 2) Replace all $GETFATTR_PROG with _getfattr

Thanks a lot for the work!

> 
> Thanks,
> Zorro
> 
>  common/attr       | 11 +++++++++++
>  tests/ext4/022    |  2 +-
>  tests/ext4/026    |  4 ++--
>  tests/generic/020 |  8 ++++----
>  tests/generic/037 |  2 +-
>  tests/generic/062 |  4 ++--
>  tests/generic/066 |  4 ++--
>  tests/generic/093 |  2 +-
>  tests/generic/097 |  2 +-
>  tests/generic/337 |  2 +-
>  tests/generic/364 |  4 ++--

This test and ..

>  tests/generic/403 |  2 +-
>  tests/generic/454 |  6 +++---
>  tests/generic/489 |  2 +-
>  tests/overlay/011 |  2 +-
>  tests/overlay/026 |  4 ++--
>  tests/overlay/038 |  4 ++--
>  tests/overlay/041 |  4 ++--
>  tests/overlay/046 |  6 +++---
>  tests/overlay/056 |  2 +-
>  tests/overlay/060 |  4 ++--

this one requires sourcing common/attr before using _getfattr. I've
fixed them on commit.

Thanks,
Eryu
