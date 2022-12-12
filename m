Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C42C4332F
	for <linux-fstests@archiver.kernel.org>; Mon, 12 Dec 2022 23:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiLLXSw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 12 Dec 2022 18:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiLLXSv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 12 Dec 2022 18:18:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863CC1C109
        for <fstests@vger.kernel.org>; Mon, 12 Dec 2022 15:18:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2347761168
        for <fstests@vger.kernel.org>; Mon, 12 Dec 2022 23:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79311C433EF;
        Mon, 12 Dec 2022 23:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670887129;
        bh=ViGNYJ3sOuiTFrIigcF+7YBnXTbvgNDQpFUoaFT/eUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rl2m6IC7ExPy/dlN/6onTMYuh8o3B+MTNYqz8CtG3XjU1VpO4BB4n8FN4sFh/oq89
         rtG7itmSN0JxIwV6XUgLmZRyPK0aaRYnmjx9TN+hMWMttLUEAtDMgIUfan0qm753ir
         +Vzng0Wz72FdVLdrEDHNgM3cng55drKIKkA+ZQn/uDh3wqCPBFO5MS33dELewy3rlU
         Xzpg/XdcfcFCjzSUrmsJCmGKvYG/HT/NSfIYLjlh7LL6m42MlSl8XtKpl+3YGrGd1L
         lQYshXx4TE6bzOGLIyMejwXAELS8Z0swWUzQynu3ritOCNjPzYOhUb/uKT14fBaE2b
         YGCSHIKPq9ugg==
Date:   Mon, 12 Dec 2022 15:18:49 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] check: use /var/tmp instead of /tmp
Message-ID: <Y5e22dC9jxg4NnxS@magnolia>
References: <20221212230646.4022294-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212230646.4022294-1-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 12, 2022 at 03:06:46PM -0800, Leah Rumancik wrote:
> With the results recorded in /tmp, a crashing test results in a loss
> of all prior test runs. Instead, record results in /var/tmp so that
> it is possible to recover results from completed tests.

RESULT_BASE=/some/stable/storage ./check <args> ?

> Also, make sure tmp.arglist is wiped before each run to avoid
> accidentally rerunning tests.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  check | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/check b/check
> index d2e51296..21c00524 100755
> --- a/check
> +++ b/check
> @@ -4,7 +4,7 @@
>  #
>  # Control script for QA
>  #
> -tmp=/tmp/$$
> +tmp=/var/tmp/$$
>  status=0
>  needwrap=true
>  needsum=true
> @@ -46,7 +46,7 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
>  # by default don't output timestamps
>  timestamp=${TIMESTAMP:=false}
>  
> -rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.*
> +rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.* $tmp.arglist

This part looks correct though.

--D

>  SRC_GROUPS="generic shared"
>  export SRC_DIR="tests"
> -- 
> 2.39.0.rc1.256.g54fd8350bd-goog
> 
