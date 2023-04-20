Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7F2C77B73
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Apr 2023 08:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbjDTIm3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 Apr 2023 04:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbjDTIm3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Apr 2023 04:42:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DC42D56
        for <fstests@vger.kernel.org>; Thu, 20 Apr 2023 01:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1AEC64609
        for <fstests@vger.kernel.org>; Thu, 20 Apr 2023 08:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC11C433EF;
        Thu, 20 Apr 2023 08:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681980147;
        bh=H260OtEFHURpzw1WavXxI6d6DkGRYUSxDlZYf8wCpWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k7CPNG6l+EkP6rZXUfiUywSdlFQn36dHujQM4Rhqkp+/ahTfI+uLl0Sn0CC2IDsRO
         79WAVhkpzA0k3ZQKmYE41OWWLjlBo4UV4pdPNDOWuEay3DbXHbO/9L5be+IOSQ1m9x
         yTDDIiYwh2AkrUycV8cUqrpCdu74PKs2qGuV8sO5soWtwbnaBwtT8MBrvLkg4JcRAH
         y16+eNNU0Bopztrrom5JYHAT+qhH3AnZXT2mIRUAL+SKQJVfFvnaQWIrFmcOKo9niR
         ACp2/7Fl8vTeX6uTovTy0eEXnvm7MHda0WHG7K+9HO/LMG4AZn0naDp1uid2ElzEBh
         +SgoHmBrE6tpA==
Date:   Thu, 20 Apr 2023 10:42:23 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     fstests@vger.kernel.org,
        "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH v2] src: fix detached_mounts_propagation compile errors
Message-ID: <20230420-arithmetik-gasleitung-3426cbcb79bb@brauner>
References: <20230419032955.114278-1-hsiangkao@linux.alibaba.com>
 <20230420021106.41970-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230420021106.41970-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 20, 2023 at 10:11:06AM +0800, Gao Xiang wrote:
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
> Let's get rid of <linux/mount.h> as Christian suggested to avoid
> potential incompatibility between these two headers.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---

Seems good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>
