Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9D6C77B73
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Apr 2023 08:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjDSIpz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Apr 2023 04:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjDSIpy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Apr 2023 04:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A64493C2
        for <fstests@vger.kernel.org>; Wed, 19 Apr 2023 01:45:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA08361520
        for <fstests@vger.kernel.org>; Wed, 19 Apr 2023 08:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58866C433EF;
        Wed, 19 Apr 2023 08:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681893952;
        bh=zL4ojnwPIxzVkqyGIl8NwnvCRsaR9K42+lwGFScLWig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fGLIQqBk1Mc7e2fCIDuqLdfyCTENuAiv1smOW5mZkEPyb0KCFeWhHk8+av/02GKPp
         lVUasTzY0RsZmLNfLQ3/vaOlJloq+NXo/19uJNU39wz/FUrvW/cOP8WFHa2WTMukbo
         LeWxhlGQ9mhulWGWB8tRFrJkNDwzVENmj2SfkDUsKkXVqDDA2AD9sPVnWF9t0oZv61
         udSD1/Zx09RPR9lmBkmjmNsFmwyagQZ8jXPyN4FxXH0A02VRsuXG83pvy1m3EiMmxc
         qbQV9SBuBHY4o8PuBs9JsHD4SqpqkWG4l1ZAE8Xkk4CoFnTKv1MihzICvJLDMRey/I
         xhANeXUxEUj+w==
Date:   Wed, 19 Apr 2023 10:45:47 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] src: fix detached_mounts_propagation compile errors
Message-ID: <20230419-fahnden-sonderlich-b2968abdec77@brauner>
References: <20230419032955.114278-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230419032955.114278-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 19, 2023 at 11:29:55AM +0800, Gao Xiang wrote:
> Newer glibc such as glibc 2.36 also defines 'struct mount_attr'
> in addition to <linux/mount.h>.  It will report as below when
> compiling with old linux kernel headers (without idmapped mounts,
> such as kernel-headers 5.10.134) but with newer glibc (here checked
> with glibc 2.36.6):
> 
>     [CC]    detached_mounts_propagation
> In file included from detached_mounts_propagation.c:29:
> vfs/missing.h:115:8: error: redefinition of 'struct mount_attr'
>   115 | struct mount_attr {
>       |        ^~~~~~~~~~
> In file included from detached_mounts_propagation.c:23:
> /usr/include/sys/mount.h:210:8: note: originally defined here
>   210 | struct mount_attr
>       |        ^~~~~~~~~~
> gmake[3]: *** [Makefile:102: detached_mounts_propagation] Error 1
> gmake[2]: *** [include/buildrules:31: src] Error 2
> make[1]: *** [Makefile:51: default] Error 2
> make: *** [Makefile:49: default] Error 2
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---

This header mount.h mess is a neverending nightmare...

> 
> Not quite look into that, but at a quick glance of tester reports
> it seems the cases.
> 
>  configure.ac                      | 5 ++++-
>  src/detached_mounts_propagation.c | 1 -
>  src/vfs/missing.h                 | 1 +
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 4687d8a3..517b4c18 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -74,7 +74,10 @@ AC_HAVE_FIEXCHANGE
>  
>  AC_CHECK_FUNCS([renameat2])
>  AC_CHECK_FUNCS([reallocarray])
> -AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <linux/mount.h>]])
> +AC_CHECK_TYPES([struct mount_attr], [], [], [[
> +#include <linux/mount.h>
> +#include <sys/mount.h>

I think we should only rely on sys/mount.h. linux/mount.h and
sys/mount.h are incompatible because linux/mount.h might have a #define
where sys/mount.h has an enum.
