Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482DDC433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Dec 2021 17:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbhLCRLX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 3 Dec 2021 12:11:23 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33652 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhLCRLX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Dec 2021 12:11:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3558462B5E
        for <fstests@vger.kernel.org>; Fri,  3 Dec 2021 17:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74382C53FAD;
        Fri,  3 Dec 2021 17:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638551278;
        bh=rpemMmXTgnxBFMjqgOUnJ/uFSq80ZtjDGAkanbUVQyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4RvYq/bNaDaibAVHtengTHW2ZqfU3vfyOQkLCwAZLvct4HbiGyBUKPBMpYpxd7yF
         xWA1ghzmHOmNNGWef5VsTtthy9ZuDxNIJG8Tby80HzC6GpkFYkoYPvXq3SnMOw569y
         Va7V6aQcrDoii6BU7RXBNS4Lqc5dIuRBmjEt4CaaBDlrjN8jGqgQDUw58nYtpDXlPw
         FjkmyTAPdqOaLtpa6o7kZA43X4ZVVTHF2hcZerJPlug/j+mFKqTX1+MQ0BvDgi3/V3
         72cWzy4dIGGyTsL3MBYW6n2htwSV8BC/sONJi8Koilc9zKJbQ8zcrLn/wuzqpHlfdp
         719Zyk/11ivVA==
Date:   Fri, 3 Dec 2021 09:07:57 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zhu Yifei <yifeix.zhu@intel.com>
Cc:     fstests <fstests@vger.kernel.org>, Philip Li <philip.li@intel.com>
Subject: Re: [PATCH v1 xfstests-dev] common/populate: remove wrong check
Message-ID: <20211203170757.GA8442@magnolia>
References: <20211203095441.56318-1-yifeix.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203095441.56318-1-yifeix.zhu@intel.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Dec 03, 2021 at 05:54:41PM +0800, Zhu Yifei wrote:
> used btree_dir to check dformat, this was a wrong operation

Huh?  The __populate_check_xfs_dformat you propose removing checks that
the btree-format directory that we just created actually has a data fork
in BTREE format.

The change is incorrect, NAK.

--D

> Signed-off-by: Zhu Yifei <yifeix.zhu@intel.com>
> ---
>  common/populate | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/common/populate b/common/populate
> index 867776cd..8ad561b4 100644
> --- a/common/populate
> +++ b/common/populate
> @@ -605,7 +605,6 @@ _scratch_xfs_populate_check() {
>  	__populate_check_xfs_dir "${leafn_dir}" "leafn"
>  	__populate_check_xfs_dir "${node_dir}" "node"
>  	__populate_check_xfs_dir "${btree_dir}" "btree"
> -	__populate_check_xfs_dformat "${btree_dir}" "btree"
>  	__populate_check_xfs_dformat "${bdev}" "dev"
>  	__populate_check_xfs_dformat "${cdev}" "dev"
>  	__populate_check_xfs_dformat "${fifo}" "dev"
> -- 
> 2.20.1
> 
