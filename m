Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509C3C678D5
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 16:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCGQ4Q (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCGQzp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 11:55:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC2B7A937
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 08:51:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D5ECB81920
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 16:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB34C433D2;
        Tue,  7 Mar 2023 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678207911;
        bh=RI+RRYOi5tqaINwo2vSolkMhWq/fWB68HO+TUVI5tE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hp595tHHEUitD+R1Ogxb1wReMY1jyfxyFpZc3AgLQzyVcFq0PdEr3/Vm0LpfVzCBJ
         pYf0V9G1u/k093L8FH6p35wjlkj2OnS6JvF/ipQtdZPPZ3F2jYQRBAtAYxKFeOCoTa
         9yyfB0PFQOpUI1tGf1tK7P+G/B5k37TUrkjy7KUNBpCJUtjOWfMj114hyk96oUZy7M
         vHtr9+ObOKaZTG2Je/Lv/k6Rcusc/JXXk6geMnZYwdOleuH5xm/flGMXFkTI7dQFgk
         0LJVhOW64DdbUSBy2csRz+ePz0ncyCGitywwTkQ18LdjRV/7b7Xqw8TMRPcdv+F3eP
         hBGK7PXgNjDZA==
Date:   Tue, 7 Mar 2023 17:51:48 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc:     fstests@vger.kernel.org, Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH 08/11] vfs: Export test_setup() and test_cleanup()
Message-ID: <20230307165148.ogfe5xmgxpqmv54n@wittgenstein>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
 <20230307114507.332309-9-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230307114507.332309-9-rodrigo@sdfg.com.ar>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 07, 2023 at 12:45:04PM +0100, Rodrigo Campos wrote:
> Future patches will call existing test inside another test, so we need
> to properly setup the test environment.
> 
> Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
> ---
>  src/vfs/vfstest.c |  4 ++--
>  src/vfs/vfstest.h | 10 ++++++++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
>  create mode 100644 src/vfs/vfstest.h
> 
> diff --git src/vfs/vfstest.c src/vfs/vfstest.c
> index 3ec65dff..9e15ad9a 100644
> --- src/vfs/vfstest.c
> +++ src/vfs/vfstest.c
> @@ -81,7 +81,7 @@ static void stash_overflowgid(struct vfstest_info *info)
>  	info->t_overflowgid = atoi(buf);
>  }
>  
> -static void test_setup(struct vfstest_info *info)
> +void test_setup(struct vfstest_info *info)
>  {
>  	if (mkdirat(info->t_mnt_fd, T_DIR1, 0777))
>  		die("failure: mkdirat");
> @@ -94,7 +94,7 @@ static void test_setup(struct vfstest_info *info)
>  		die("failure: fchmod");
>  }
>  
> -static void test_cleanup(struct vfstest_info *info)
> +void test_cleanup(struct vfstest_info *info)
>  {
>  	safe_close(info->t_dir1_fd);
>  	if (rm_r(info->t_mnt_fd, T_DIR1))
> diff --git src/vfs/vfstest.h src/vfs/vfstest.h
> new file mode 100644
> index 00000000..352b57d5
> --- /dev/null
> +++ src/vfs/vfstest.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __VFSTEST_H
> +#define __VFSTEST_H
> +
> +void test_setup(struct vfstest_info *info);
> +void test_cleanup(struct vfstest_info *info);
> +
> +
> +#endif /* __IDMAPPED_MOUNTS_H */


s/__IDMAPPED_MOUNTS_H/__VFSTEST_H/ ?
