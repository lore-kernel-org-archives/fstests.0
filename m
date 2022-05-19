Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BF8C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 19 May 2022 18:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244238AbiESSxp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 May 2022 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244310AbiESSxZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 May 2022 14:53:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEC81271A9
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 11:52:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4B3761B4B
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 18:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2C0C385AA;
        Thu, 19 May 2022 18:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652986372;
        bh=92s3tt5HHpSnexUB7ZOsnCP5rS4cNU7y6N9u3rf+3vA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNcdGHoVK7VT7/M32nlMo0zt+57dEJlGep5V5PzfN/Ki/qcaUhS/sJiometIp1BXr
         lPbInfd0r0JKfazyNIGYx+8rVcvX7qBfIBVTM4ClUetktIiqvsdWzDtOAMorvPWkuM
         eaZZWZ5WX0bQq3Mv3GBnJX2q7/v6bHC63IUpZYOPKEaD5AM3CcQwe6RLfQctZcCiB0
         i0V2d0m7I8IeiSWUymklZg2pXkBB1oSR9F3j4pPIoLwbA7GTbGD4w2oszlp9AXciEr
         dvvet/X3T+kihC6V1NoGhkQoR19fm/RIC9tRd30sZ+H25ZCnSArIJgzqNHVmOdhQV7
         TcZ1mHChknddw==
Date:   Thu, 19 May 2022 11:52:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 04/12] fstests: fix group list generation for whacky test
 names
Message-ID: <YoaSA8i2+Xa2HqDx@magnolia>
References: <20220517070111.1381936-1-david@fromorbit.com>
 <20220517070111.1381936-5-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517070111.1381936-5-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 17, 2022 at 05:01:03PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Darrick noticed that tests/xfs/191-input-validation didn't get
> generated properly. Fix the regex to handle this.
> 
> $ grep -I -R "^_begin_fstest" tests/xfs | \
>   sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' |grep 191
> tests/xfs/191-input-validation:_begin_fstest auto quick mkfs realtime
> $
> $ grep -I -R "^_begin_fstest" tests/xfs | \
>   sed -e 's/^.*\/\([0-9]*\).*:_begin_fstest/\1/ ' |grep 191
> 191 auto quick mkfs realtime
> $
> 
> Use the regexes for matching test names defined in common/test_names
> rather than trying to open code it.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Definitely an improvement, thank you.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tools/mkgroupfile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/mkgroupfile b/tools/mkgroupfile
> index 24435898..414cb538 100755
> --- a/tools/mkgroupfile
> +++ b/tools/mkgroupfile
> @@ -19,6 +19,8 @@ if [ ! -x ../../check ]; then
>  	exit 1
>  fi
>  
> +. ../../common/test_names
> +
>  cleanup()
>  {
>  	rm -f $new_groups.check
> @@ -60,7 +62,8 @@ ENDL
>  
>  	# Aggregate the groups each test belongs to for the group file
>  	grep -I -R "^_begin_fstest" $test_dir/ | \
> -		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' >> $new_groups
> +		sed -e "s/^.*\/\($VALID_TEST_NAME\):_begin_fstest/\1/" \
> +		>> $new_groups
>  
>  	# Create the list of unique groups for existence checking
>  	grep -I -R "^_begin_fstest" $test_dir/ | \
> -- 
> 2.35.1
> 
