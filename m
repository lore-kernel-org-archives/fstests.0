Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9819BC77B7A
	for <linux-fstests@archiver.kernel.org>; Wed, 24 May 2023 15:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjEXPQ5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 May 2023 11:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbjEXPQ4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 May 2023 11:16:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCD6123
        for <fstests@vger.kernel.org>; Wed, 24 May 2023 08:16:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14EB9617DE
        for <fstests@vger.kernel.org>; Wed, 24 May 2023 15:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3A2C433D2;
        Wed, 24 May 2023 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684941411;
        bh=ONYkv/2aLSr/a9FG4RIkTQRHpbPvhByAWxb7IlW4wAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qT+v7DsyI5L62gwTOzwCvj7+vJrwYj5wJn5FEqAq+bmGZCSUHMoqRDNtbHRR5WiP7
         C6917cysRNtLgErx3wABdNU4h4xIPWJjychP7WiIksUMF8W5M2BavxvNSeUWIJ6OSX
         zPgkSb3KawKeb9pHumQjPaWeCS/GrCpXBXi+v+YmqLybDkSHlidtFCMa3V380Qxx5V
         FWCmtnVe6p+nbaIMIHdUDWQsC+75TIER8JqWPmvg/4Gn9NIaJ8ZkNx2xFHsOgt/dur
         ZqCrkiVTeKZ+ng8LMByDzJ8IIN4DlEfw5P47h8rzLWZCpd/rBr/+oBWaKdQ37F/geu
         eUPf7h6vf0VQA==
Date:   Wed, 24 May 2023 08:16:50 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     cem@kernel.org
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfstests: Enable _test_mkfs to force a mkfs on a xfs
 filesystem
Message-ID: <20230524151650.GC11607@frogsfrogsfrogs>
References: <20230524134207.38224-1-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524134207.38224-1-cem@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 24, 2023 at 03:42:07PM +0200, cem@kernel.org wrote:
> From: Carlos Maiolino <cmaiolino@redhat.com>
> 
> Calling _test_mkfs on an already initialized xfs FS will fail as the
> initialization is not enforced by '-f' argument, unless it's included in
> MKFS_OPTIONS.
> So, adding 'RECREATE_TEST_DEV=true' to the config file end up being useless
> for xfs filesystems.
> 
> So, adding the a specific xfs optiong in _test_mkfs using -f argument
> makes RECREATE_TEST_DEV actually useful.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>

Makese sense to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/rc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 37074371..dd5d7bc1 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -605,6 +605,9 @@ _test_mkfs()
>      ext2|ext3|ext4)
>  	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
>  	;;
> +    xfs)
> +	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* $TEST_DEV
> +	;;
>      *)
>  	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
>  	;;
> -- 
> 2.30.2
> 
