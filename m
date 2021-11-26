Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146D0C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Nov 2021 23:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhKZXdd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 26 Nov 2021 18:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbhKZXbd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Nov 2021 18:31:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8A8C061574
        for <fstests@vger.kernel.org>; Fri, 26 Nov 2021 15:28:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 057846238B
        for <fstests@vger.kernel.org>; Fri, 26 Nov 2021 23:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0D3C004E1;
        Fri, 26 Nov 2021 23:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637969298;
        bh=+WE6ZIfHPLcTUkIQ/s3kygfbZxXEllRHLOBm+pemHoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OjAccN6PXlyYFzxnGRKxKhC4wbq2AdRNQw2Uq9c0eRdBCcsCqJdE9hndxGzMJ4uDw
         4S1+M/haM79pynFAqcnAalvQqCO/CIfjBMdcoixhyQ/r5poZ/dU2/UBt2OEWnR2Y76
         BdVNXaA9xZLPXe/CqQ2BUE+XxDPIkTVdEdVYyMNx7wIem8/YecqpMA75IPWVWIdbEj
         jeq/u0TPsjbtpqQ9JkHSE5b3LLu9bg7GVNcFPFy+qKssOlXyLbPoE8gajKoto4ksmZ
         eGyUFB3XIF8jAAbHATZ3iNEjdg1mz46KlY1n3zymDlsiRr7qJ5YoNTBoCjUXT4V0rP
         iCQCCu7p29AoQ==
Date:   Fri, 26 Nov 2021 15:28:17 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] xfs/126: Add a getxattr opeartion after corrupted
 xattr
Message-ID: <20211126232817.GA266000@magnolia>
References: <1637817207-2164-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637817207-2164-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Nov 25, 2021 at 01:13:27PM +0800, Yang Xu wrote:
> It is design to reproduce a deadlock on upstream kernel. It is introduced by kernel
> commit 07120f1abdff ("xfs: Add xfs_has_attr and subroutines") and fixed by kernel
> commit a1de97fe296c ("xfs: Fix the free logic of state in xfs_attr_node_hasname")[1].
> 
> [1]https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=for-next&id=a1de97fe296c

NAK, this is a general fuzz test.  Please create a separate targeted
regression test for the kernel bugfix so that you can control exactly
which part of the attr leaf block gets corrupted so that the verifier
will signal error.

--D

> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/xfs/126 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/126 b/tests/xfs/126
> index c3a74b1c..5496f3d7 100755
> --- a/tests/xfs/126
> +++ b/tests/xfs/126
> @@ -7,6 +7,10 @@
>  # Create and populate an XFS filesystem, corrupt a leaf xattr's data extent,
>  # then see how the kernel and xfs_repair deal with it.
>  #
> +# It is also a regression test for kernel commit:
> +# a1de97fe296c ("xfs: Fix the free logic of state in xfs_attr_node_hasname")
> +#
> +
>  . ./common/preamble
>  _begin_fstest fuzzers
>  
> @@ -69,7 +73,7 @@ done
>  
>  echo "+ mount image && modify xattr"
>  if _try_scratch_mount >> $seqres.full 2>&1; then
> -
> +	getfattr "${SCRATCH_MNT}/attrfile" -n "user.x00000000" 2> /dev/null && _fail "got corrupt xattr"
>  	setfattr -x "user.x00000000" "${SCRATCH_MNT}/attrfile" 2> /dev/null && _fail "modified corrupt xattr"
>  	umount "${SCRATCH_MNT}"
>  fi
> -- 
> 2.23.0
> 
