Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6930C433C1
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Mar 2021 18:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A90AB6195D
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Mar 2021 18:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhC2SpN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 29 Mar 2021 14:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhC2So5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 29 Mar 2021 14:44:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AB5F61969;
        Mon, 29 Mar 2021 18:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617043497;
        bh=urLeeOEJC9aY0TkJhkyC5gPbqvZoTWJFA3UfLI6+tdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ezuw16I8STovaZy01l/S0OXmR7IvK/oFiaFWVHl3SRdd3dqKxVj7B9Pn6PRmYUk8z
         9l5BwAgHWT3feH9mjb93EX4jsYRDcrbrGzVgmCfA0jzN/wN/lOEuV9uuppx0yJZD5t
         OJ2+PgovMxC8tqbMvmHanlLVDFjD7Q5ap9B2TZmyGRHY5yRyc0w9ZJgxAakDB7HOKa
         h+Z3d+ja1epq2TeO8qqjAq1A0vrcrZkl9MyehpeKi4mAxluojiVDo/gACyty8SRXlJ
         VCCXueE34EqFkAuEWkwfIHhCFeGF7MqaE4Njjjesur7B9n63uX5kT2kWJNelDuWsF4
         Nh56bQoRYqsew==
Date:   Mon, 29 Mar 2021 11:44:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     fstests@vger.kernel.org, guan@eryu.me, chao@kernel.org
Subject: Re: [PATCH] generic/629: add missing copy_range command check
Message-ID: <20210329184456.GS1670408@magnolia>
References: <20210329014013.4953-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329014013.4953-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 29, 2021 at 09:40:13AM +0800, Chao Yu wrote:
> Otherwise, if xfs_io doesn't support this command, it will report
> that filesystem fails on this testcase.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Yep, thanks for catching this.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/629 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/629 b/tests/generic/629
> index ad86ab5bb0c0..13d433a4e470 100755
> --- a/tests/generic/629
> +++ b/tests/generic/629
> @@ -36,6 +36,7 @@ _cleanup()
>  _supported_fs generic
>  _require_dm_target error
>  _require_xfs_io_command "chattr" "s"
> +_require_xfs_io_command "copy_range"
>  _require_scratch
>  
>  rm -f $seqres.full
> -- 
> 2.29.2
> 
