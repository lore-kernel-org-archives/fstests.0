Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE78C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Mar 2022 15:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiCQPcB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Mar 2022 11:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiCQPb6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Mar 2022 11:31:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069FC16F6C9
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 08:30:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A23B4B81E9E
        for <fstests@vger.kernel.org>; Thu, 17 Mar 2022 15:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFFFC340E9;
        Thu, 17 Mar 2022 15:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647531039;
        bh=jy5dEzn4W48+SuYJlXWRLJLpmT9jqdShmETR3Ac17TY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cy4QNj2hIHWlul80m1+7XnNk85ce1xSRWGkmJ59FC9UPrXsUnIRD8Bmyn2xvWZvAO
         aCcq0yyjeYUZRjANuGF96/iRsjAgzr8GmwR1AQi1PJTUjItPs49gSXeZhK4WX1dR7F
         Aj6DaKxAz4KKUNTTKOfH2XebEGsJb9Nsbr/B7A8xm9MxsEGJkYfdAywC6tMdMYhGU1
         kfRgrkkK5M+aqxoiqIRepZUwJ2C6Ufu9I1RZUo8J6PwUEpWXr/1cZLRz3RXlbTfHTZ
         qHe2Balve9fURKxjKLEl/OO/215wDazH2ox9UKm2MBsQUKHkw2c8SCxInGALLAhSvE
         JaOlKrImhMayg==
Date:   Thu, 17 Mar 2022 08:30:38 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     bxue@redhat.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v1 2/2] generic/513,675: check for security namespace
 support
Message-ID: <20220317153038.GH8200@magnolia>
References: <20220317100842.1237893-1-bxue@redhat.com>
 <20220317100842.1237893-3-bxue@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317100842.1237893-3-bxue@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 17, 2022 at 06:08:42PM +0800, bxue@redhat.com wrote:
> From: Boyang Xue <bxue@redhat.com>
> 

Er... what does this patch do, and why?

--D

> Signed-off-by: Boyang Xue <bxue@redhat.com>
> ---
>  tests/generic/513 | 2 ++
>  tests/generic/675 | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/tests/generic/513 b/tests/generic/513
> index dc082787..6e897fa0 100755
> --- a/tests/generic/513
> +++ b/tests/generic/513
> @@ -12,10 +12,12 @@ _begin_fstest auto quick clone
>  # Import common functions.
>  . ./common/filter
>  . ./common/reflink
> +. ./common/attr
>  
>  # real QA test starts here
>  _supported_fs generic
>  _require_scratch_reflink
> +_require_attrs security
>  _require_command "$GETCAP_PROG" getcap
>  _require_command "$SETCAP_PROG" setcap
>  
> diff --git a/tests/generic/675 b/tests/generic/675
> index 23b7e545..311860dc 100755
> --- a/tests/generic/675
> +++ b/tests/generic/675
> @@ -12,12 +12,14 @@ _begin_fstest auto clone quick
>  # Import common functions.
>  . ./common/filter
>  . ./common/reflink
> +. ./common/attr
>  
>  # real QA test starts here
>  
>  # Modify as appropriate.
>  _supported_fs generic
>  _require_user
> +_require_attrs security
>  _require_command "$GETCAP_PROG" getcap
>  _require_command "$SETCAP_PROG" setcap
>  _require_scratch_reflink
> -- 
> 2.27.0
> 
