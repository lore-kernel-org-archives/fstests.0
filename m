Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE12CC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Mar 2022 15:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiCQPNF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Mar 2022 11:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiCQPNE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Mar 2022 11:13:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9476F204CB6
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 08:11:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA415B81EF7
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 15:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81373C340E9;
        Thu, 17 Mar 2022 15:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647529905;
        bh=itekjf7O77o7RFNvbuVkGZWG5P7JlvLKygy4+al0bzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cnv5HNabJUdot2R/3rS/VMg+x38L6swEtzi3mZf1F7eCe1MXF8UT6a9t6URPriD2u
         mZl34XN75PX7egrKRUUYQWdcLKL9ZHAKDnzCStagpyYYH3/TWbkNMA3eDiR8ynZg/2
         O6Vayyy5Jzo2oFMjtqb7/gbTSlReP+qZs6Ybe4SMCVi/QD2zL/PtP1uO4BNpFSEiXE
         QPyXSaNCdeRPlACAiUWTBapHbUjBOgp8ZO/e6LxPf5Wej6dLDWGEsNYkEQquektell
         bq6ghOvJRu/Sm8fbE1FV/s00j4BSz9X1jx2gWqmKJ1PAsTwD2Fr84fr2s9984cO5XK
         aQFURjUgF/rXQ==
Date:   Thu, 17 Mar 2022 08:11:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     bxue@redhat.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v1 1/2] generic/674: check for dedupe support on scratch
 fs
Message-ID: <20220317151144.GG8200@magnolia>
References: <20220317100842.1237893-1-bxue@redhat.com>
 <20220317100842.1237893-2-bxue@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317100842.1237893-2-bxue@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 17, 2022 at 06:08:41PM +0800, bxue@redhat.com wrote:
> From: Boyang Xue <bxue@redhat.com>
> 
> Signed-off-by: Boyang Xue <bxue@redhat.com>
> ---
>  tests/generic/674 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/674 b/tests/generic/674
> index bf0bcffb..7e5e4e29 100755
> --- a/tests/generic/674
> +++ b/tests/generic/674
> @@ -19,6 +19,7 @@ _begin_fstest auto clone quick
>  _supported_fs generic
>  _require_user
>  _require_scratch_reflink
> +_require_scratch_dedupe

I think you could replace the _require_scratch_reflink with
_require_scratch_dedupe here, right?  I probably copypasta'd this.

--D

>  _require_xfs_io_command dedupe
>  
>  _scratch_mkfs >> $seqres.full
> -- 
> 2.27.0
> 
