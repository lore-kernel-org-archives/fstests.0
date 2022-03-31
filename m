Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5BAC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Mar 2022 12:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbiCaMCo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 31 Mar 2022 08:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbiCaMCd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Mar 2022 08:02:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA33E1C3487;
        Thu, 31 Mar 2022 04:59:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DEB37CE21B6;
        Thu, 31 Mar 2022 11:59:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDE0C340EE;
        Thu, 31 Mar 2022 11:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648727970;
        bh=X/62zgO2a7m9QlrGXnUaLeuznCrRfbtM873zyn3nPhM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uZieT0LutnWeBrckZS4nPn5IdTRZipjaHEwYjTjKczphDX9ML17QgLeOj0f2Vpxk6
         ooNtR6x58Ba/Z87h24SCVwj5YKwotbML/nR1ZYUhKoDj5JJFk4LOOf8AVrsG8cC4jg
         W2b76ybFXE02y05uiDvU3X3/xnRNYVlm/+2Uf2OeWnZlIla2gJBy6lAltwqF6a9pjo
         Po1zQNmOl2SVW5BK41g/DI5+x7EhCWy1neZuInPuWjF3qnbnAAkLKZi8TNqIPMDJCG
         13AMDR1RP159JxUsyGwkJ+S2w1YYdH5BvIYIE6FR4EFhh0Jn62w+0tk/qg98EmVn4x
         cJUjaiqQq72nw==
Date:   Thu, 31 Mar 2022 13:59:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v1 1/2] idmapped-mounts: Add mknodat operation in setgid
 test
Message-ID: <20220331115925.5tausqdavg7xmqyv@wittgenstein>
References: <1648718902-2319-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1648718902-2319-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 31, 2022 at 05:28:21PM +0800, Yang Xu wrote:
> Since mknodat can create file, we should also check whether strip S_ISGID.
> Also add new helper caps_down_fsetid to drop CAP_FSETID because strip S_ISGID
> depond on this cap and keep other cap(ie CAP_MKNOD) because create character device
> needs it when using mknod.
> 
> Only test mknod with character device in setgid_create function because the another
> two functions will hit EPERM error.

Fwiw, it's not allowed to create devices in userns as that would be a
massive attack vector. But it is possible since 5.<some version> to
create whiteouts in userns for the sake of overlayfs. So iirc that
creating a whiteout is just passing 0 as dev_t:

mknodat(t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | 0755, 0)

but you'd need to detect whether the kernel allows this and skip the
test on EPERM when it is a userns test.

> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Sidenote: I really need to rename the test binary to something other
than idmapped-mounts.c as this tests a lot of generic vfs stuff that has
nothing to do with them.

In any case, I pulled and tested this:

Tested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
