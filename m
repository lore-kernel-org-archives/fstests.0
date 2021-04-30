Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B95C433B4
	for <linux-fstests@archiver.kernel.org>; Fri, 30 Apr 2021 15:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C309061466
	for <linux-fstests@archiver.kernel.org>; Fri, 30 Apr 2021 15:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhD3PkF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 30 Apr 2021 11:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhD3PkF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 30 Apr 2021 11:40:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D8366145D;
        Fri, 30 Apr 2021 15:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619797156;
        bh=CZKPzz5q0XTmV24CZwuHjiiopwbln7eCrjWrUTEUDsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tw9MOUmBiBUFiP8tCQD72zQnIPfHBFAtjC/DB4EU7LG4uN/d9Jwu6JRBzbsOu0n65
         WErh+xcOnOhlcp7GwCV5/EZl76oeUEHkPTfULrvlBiB3hkdECbfXAVjoqcGx/1HNPC
         o8ZWi+Rz6qEMA6GGwGhF00hmjBL+oSO0aYHn+KBTKDzxpWKjEsOxFBPfn45ZhaTb8p
         6tFVaNVHOWF/0AOQleSF7wg2UOGcHFS/j4fPiuCSSKxn2DhA2Zb00aJfJVhp0YavD2
         anFpBntuodOCq2+wBy188+jAtbREUDM7c8JAcSlAaPJVYMyMDSWcF9K0FFKFcoC3CQ
         dvExPdMK1TBNQ==
Date:   Fri, 30 Apr 2021 08:39:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/153: add _require_idmapped_mounts check
Message-ID: <20210430153915.GN3122235@magnolia>
References: <1619775081-3941-1-git-send-email-huangjh.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619775081-3941-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 30, 2021 at 05:31:21PM +0800, Jinhui Huang wrote:
> When this case runs on system without mount_setattr syscall support, it
> will report errors rather than skip. so we add _require_idmapped_mounts
> to check if mount_setattr syscall is supported.
> 
> Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>

Seems pretty straightforward...

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/xfs/153 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/xfs/153 b/tests/xfs/153
> index ab2469d..19cfc46 100755
> --- a/tests/xfs/153
> +++ b/tests/xfs/153
> @@ -39,6 +39,7 @@ chmod a+rwx $seqres.full	# arbitrary users will write here
>  _require_scratch
>  _require_xfs_quota
>  _require_user fsgqa
> +_require_idmapped_mounts
>  _require_test_program "idmapped-mounts/mount-idmapped"
>  
>  _scratch_mkfs >/dev/null 2>&1
> -- 
> 1.8.3.1
> 
