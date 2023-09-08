Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F033EEB570
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Sep 2023 23:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbjIHXgk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Sep 2023 19:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242428AbjIHXgk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Sep 2023 19:36:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793FD18E
        for <fstests@vger.kernel.org>; Fri,  8 Sep 2023 16:36:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9D9C433C9;
        Fri,  8 Sep 2023 23:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694216196;
        bh=w5qtAlTP9HyN5dzhHOsVLfrD/bfHDK4p9oJx2a6Gy5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qkCcA8fq8nNuntk/Ji79/949Icyv25DZuBWYS2tRG7TW7O3KqoZmCY3vDDYVNi/NL
         ADLOIQEfrNrzghZ0YbuUuK81ugnME4V4KLambPtuFyCndklcXdcH6Xkjk0QaJ6Bpj3
         gj5KYX/Q8msmxwvMxAXFBg0WkrAPDf3BBTWoaX1YV8OOj2h1YWA0Vf3cqASntDMquy
         8HYYqdYFUEvu1rajYu1hd5Ewq35XjEBj228c/Nbb0umJcdc3cHXke9M4M9xaNE79/h
         CUMY86s9vXnsDAD0xh997Xa4nzku0oHov3iNX8z/UZV1RbuVGF3CiAQH57LyV4reMS
         lDZZ+W1r4+AOA==
Date:   Fri, 8 Sep 2023 16:36:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org, Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH v3] tools/mvtest: ensure testcase is executable (755)
Message-ID: <20230908233635.GC28170@frogsfrogsfrogs>
References: <20230906071349.3643040-1-ruansy.fnst@fujitsu.com>
 <20230908054335.13625-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908054335.13625-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 08, 2023 at 01:43:35PM +0800, Shiyang Ruan wrote:
> Some test cases lack executable permission ('x'). Before running each
> test case, `./check` checks and grants them 'x' permission. However,
> this always leads to a dirty git repo. And the absence of 'x' permission
> in test cases is often overlooked during reviews.
> 
> Since maintainers use mvtest to assign new case, add this change for
> convenience of maintainers.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> ---
>  tools/mvtest | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/mvtest b/tools/mvtest
> index 99b154142..bd4006eb2 100755
> --- a/tools/mvtest
> +++ b/tools/mvtest
> @@ -34,6 +34,8 @@ did="$(basename "${dest}")"
>  
>  git mv "tests/${src}" "tests/${dest}"
>  git mv "tests/${src}.out" "tests/${dest}.out"
> +# make sure testcase is executable
> +chmod 755 "tests/${dest}"

No objections to forcing 0755, though "a+x" here would have gotten the
job done as well.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  sed -e "s/^# FS[[:space:]]*QA.*Test.*[0-9]\+$/# FS QA Test No. ${did}/g" -i "tests/${dest}"
>  sed -e "s/^QA output created by ${sid}$/QA output created by ${did}/g" -i "tests/${dest}.out"
>  sed -e "s/test-${sid}/test-${did}/g" -i "tests/${dest}.out"
> -- 
> 2.42.0
> 
