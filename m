Received: from mail-pg1-f195.google.com ([209.85.215.195]:44603 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbeHVPKF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Aug 2018 11:10:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so808705pgp.11
        for <fstests@vger.kernel.org>; Wed, 22 Aug 2018 04:45:30 -0700 (PDT)
Date: Wed, 22 Aug 2018 19:45:24 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] xfstests: generic/062: Change output of empty attribute
 values
Message-ID: <20180822114524.GI2791@desktop>
References: <20180822083201.14851-1-suy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822083201.14851-1-suy.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Su Yue <suy.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 22, 2018 at 04:32:01PM +0800, Su Yue wrote:
> Since v2.4.47 of attr(5)[1], commit 0550d2bc989d (Properly
> set and report empty attribute values) changed output format of
> empty attribute value with quotes.
> 
> Here, change generic/062.out to match the actual output.
> 
> [1]: https://git.savannah.nongnu.org/git/attr.git
> 
> Signed-off-by: Su Yue <suy.fnst@cn.fujitsu.com>
> ---
>  tests/generic/062.out | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/generic/062.out b/tests/generic/062.out
> index 8cc3c655..9b9cd744 100644
> --- a/tests/generic/062.out
> +++ b/tests/generic/062.out
> @@ -13,7 +13,7 @@ SCRATCH_MNT/reg
>  
>  *** set/get one initially empty attribute
>  # file: SCRATCH_MNT/reg
> -user.name
> +user.name=""

This breaks tests with old attr version, we should filter the output so
that both old and new attr could pass the test.

Please see the discussions in this thread.

https://patchwork.kernel.org/patch/10521875/

Thanks,
Eryu
