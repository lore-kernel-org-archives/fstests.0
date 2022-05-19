Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAF5C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 19 May 2022 23:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbiESXTY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 May 2022 19:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiESXTW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 May 2022 19:19:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBFDEAB85
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 16:19:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C818B82241
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 23:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B81CC385B8;
        Thu, 19 May 2022 23:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653002359;
        bh=jG7AF98WXMpeBUm2qEumvd79k30/luLpJ0A4bF4yVOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gF50IjKaqkKgPwV0hoyJSd0IWrFNtynGhC6tzgTbE9EWjC5ekauiHzGN1IerlSENE
         c1EYoMCf2+rb396F7nOxrEAdA+oWxMxd6xETqYnmHU8LcR3RjDgFinzdk/PcBNVaiV
         FiOp20Cej/NGH6MR3LWDsHxkTJGLZNQRR+oToBlraaWbp7/LY1R1529l4up4JRsJ8X
         f78vVT25AzoaTNMxKumT17XfAjc+0pYO08mMzlUaVqtrlAiZFq8LUqCcEW8mHrWThu
         ++qZJqWULIRxNsTZLGWpbibMzeWlHS1vmNwFiYBQmbzwE240IS6SY27vIe6xMhjXm8
         5Zt8bNWGsfX4A==
Date:   Thu, 19 May 2022 16:19:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     zlang@redhat.com, fstests@vger.kernel.org, ebiggers@kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH v2] generic/556: Filter touch error message
Message-ID: <YobQdni9L1zs731q@magnolia>
References: <20220519220836.21888-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220519220836.21888-1-krisman@collabora.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 19, 2022 at 06:08:36PM -0400, Gabriel Krisman Bertazi wrote:
> Coreutils commit d435cfc0bc55 ("touch: fix wrong
> diagnostic (Bug#48106)"), released in coreutils v9.0, changed the error
> reported by the tool when openat() fails with EINVAL.  Instead of
> reporting a generic message for the failure of either openat() or the
> following utimensat(), it now differentiates both failures with
> different messages.
> 
> This change breaks generic/556, which relied on the parsing of that
> message.  This test was originally developed by me on a Debian
> Buster (coreutils v8.x), so I used the generic error message.  Now that
> I tried to run it on a more modern distro, it reports a different error
> message, which fails the test.
> 
> The patch filters out the touch-specific parts of the touch error
> messages, to prevent breakage from future changes, but preserves the
> return code information, which is actually useful (and more stable).
> 
> There is no change in behavior on the kernel side, just a broken test.
> On both older and new distros, the kernel correctly rejects this invalid
> sequence with -EINVAL, as shown in the strace hunk below:
> 
> ...
> openat(AT_FDCWD, "/scratch_mnt/strict/corac\314\247\303", ...) = -1 EINVAL
> utimensat(AT_FDCWD, "/scratch_mnt/strict/corac\314\247\303", ...) = -1 EINVAL
> ...
> 
> Tested on Debian sid (coreutils v8.32) and Fedora (coreutils 9.0).
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Would you mind pasting the failure messages from 8.32 and 9.0 in the
commit message so that it's a bit more obvious how things changed?

With that added,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> ---
> Changes since v1:
>   - Dont break on older distros
> ---
>  common/filter         | 8 ++++++++
>  tests/generic/556     | 9 +++++++--
>  tests/generic/556.out | 4 ++--
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index 5b20e848c9b9..a6a42b7a6ad2 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -478,6 +478,14 @@ _filter_stat()
>  	sed -e "s/\<cannot stat\>/cannot statx/"
>  }
>  
> +# touch v9.0+ modified part of the message printed on error.  Filter the
> +# generic part out, but preserve the strerror() part, which is
> +# actually useful for debugging and usually stable.
> +_filter_touch()
> +{
> +	sed -e "s/.* '\(.*\)':\(.*\)/touch: '\1':\2/"
> +}
> +
>  _filter_lostfound()
>  {
>  	sed -e '/^lost+found$/d'
> diff --git a/tests/generic/556 b/tests/generic/556
> index 7ef2f6f4106b..1296e241552c 100755
> --- a/tests/generic/556
> +++ b/tests/generic/556
> @@ -44,6 +44,11 @@ jp_file2=$(echo -e "japanese_\xe3\x82\xb1\xe3\x82\x99.txt")
>  blob_file1=$(echo -e "corac\xcc\xa7\xc3")
>  blob_file2=$(echo -e "coraç\xc3")
>  
> +filter_touch()
> +{
> +    _filter_touch | _filter_scratch
> +}
> +
>  # Test helpers
>  basic_create_lookup()
>  {
> @@ -456,8 +461,8 @@ test_strict_mode_invalid_filename()
>  
>  	# These creation commands should fail, since we are on strict
>  	# mode.
> -	touch "${basedir}/${blob_file1}" 2>&1 | _filter_scratch
> -	touch "${basedir}/${blob_file2}" 2>&1 | _filter_scratch
> +	touch "${basedir}/${blob_file1}" 2>&1 | filter_touch
> +	touch "${basedir}/${blob_file2}" 2>&1 | filter_touch
>  }
>  
>  #############
> diff --git a/tests/generic/556.out b/tests/generic/556.out
> index f9dd9542fb12..a689a3e2311c 100644
> --- a/tests/generic/556.out
> +++ b/tests/generic/556.out
> @@ -12,5 +12,5 @@ user.foo="bar"
>  # file: SCRATCH_MNT/xattrs/x/f1
>  user.foo="bar"
>  
> -touch: setting times of 'SCRATCH_MNT/strict/corac'$'\314\247\303': Invalid argument
> -touch: setting times of 'SCRATCH_MNT/strict/cora'$'\303\247\303': Invalid argument
> +touch: 'SCRATCH_MNT/strict/corac'$'\314\247\303': Invalid argument
> +touch: 'SCRATCH_MNT/strict/cora'$'\303\247\303': Invalid argument
> -- 
> 2.36.1
> 
