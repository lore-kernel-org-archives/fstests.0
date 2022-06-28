Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC90C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Jun 2022 14:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347459AbiF1Oya (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jun 2022 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346942AbiF1Oya (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2022 10:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE06CD3
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 07:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27C0B61A46
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 14:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75343C3411D;
        Tue, 28 Jun 2022 14:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656428068;
        bh=mYh8oxiR/UoKH72I70fXd6IrDwosMiKKcqCFwSaGwmw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lwMqeZ2dT3yyNsL99NtHC7ziZgc7qFpmf06ihUsuRNOz5+MkImAxYqkgeywc/QTlh
         RFhUNJFRi21m6oKXyA9qcsgvsu0bVXxErUD++9LeyKy7bmqeUh16z4fmAn8XB9gV3B
         e8TTMPMxP/oHw0zgbIoRbYUJnIa19MajDnde0/yJQOloiqf8qnmLqgwiY7Gn7aQO34
         xOm1A8ahajb1w7R5CLEN67Dt4sSIhFi7elaTyVOnUyUi5zklG8eAbUnlk3XpOY0Wdv
         AMVwk+heiTQ5pwCtBnAJMzQuHKCJCorDRRrWeAPcWjtTC6qu9nDD1tQcBfre1Ejr5B
         lTSwBzdwQkHSQ==
Date:   Tue, 28 Jun 2022 07:54:27 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, tytso@mit.edu
Subject: Re: [RFC PATCH v2 1/6] report: use array for REPORT_ENV_LIST
Message-ID: <YrsWI/NwDTQf2GJk@magnolia>
References: <20220627222256.14175-1-ddiss@suse.de>
 <20220627222256.14175-2-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627222256.14175-2-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 28, 2022 at 12:22:51AM +0200, David Disseldorp wrote:
> There's no need for multiple assignments.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  common/report | 26 +++++---------------------
>  1 file changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/common/report b/common/report
> index 84d9e0a7..2b8285d8 100644
> --- a/common/report
> +++ b/common/report
> @@ -4,26 +4,10 @@
>  
>  # List of xfstests's enviroment variables to include reports
>  ## TODO automate list population inside common/conf
> -REPORT_ENV_LIST="$REPORT_ENV_LIST SECTION"
> -REPORT_ENV_LIST="$REPORT_ENV_LIST FSTYP"
> -REPORT_ENV_LIST="$REPORT_ENV_LIST PLATFORM"
> -REPORT_ENV_LIST="$REPORT_ENV_LIST MKFS_OPTIONS"
> -REPORT_ENV_LIST="$REPORT_ENV_LIST MOUNT_OPTIONS"
> -
> -REPORT_ENV_LIST="$REPORT_ENV_LIST HOST_OPTIONS"
> -REPORT_ENV_LIST="$REPORT_ENV_LIST CHECK_OPTIONS"
> -REPORT_ENV_LIST="$REPORT_ENV_LIST XFS_MKFS_OPTIONS"
> -REPORT_ENV_LIST="$REPORT_ENV_LIST TIME_FACTOR"
> -REPORT_ENV_LIST="$REPORT_ENV_LIST LOAD_FACTOR"
> -
> -REPORT_ENV_LIST="$REPORT_ENV_LIST TEST_DIR"
> -REPORT_ENV_LIST="$REPORT_ENV_LIST TEST_DEV"
> -REPORT_ENV_LIST="$REPORT_ENV_LIST SCRATCH_DEV"
> -REPORT_ENV_LIST="$REPORT_ENV_LIST SCRATCH_MNT"
> -
> -REPORT_ENV_LIST="$REPORT_ENV_LIST OVL_UPPER"
> -REPORT_ENV_LIST="$REPORT_ENV_LIST OVL_LOWER"
> -REPORT_ENV_LIST="$REPORT_ENV_LIST OVL_WORK"
> +REPORT_ENV_LIST=("SECTION" "FSTYP" "PLATFORM" "MKFS_OPTIONS" "MOUNT_OPTIONS" \
> +		 "HOST_OPTIONS" "CHECK_OPTIONS" "XFS_MKFS_OPTIONS" \
> +		 "TIME_FACTOR" "LOAD_FACTOR" "TEST_DIR" "TEST_DEV" \
> +		 "SCRATCH_DEV" "SCRATCH_MNT" "OVL_UPPER" "OVL_LOWER" "OVL_WORK")

Cheers for the end of a stringbuilder pattern,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
>  encode_xml()
>  {
> @@ -70,7 +54,7 @@ _xunit_make_section_report()
>  
>  	# Properties
>  	echo -e "\t<properties>" >> $REPORT_DIR/result.xml
> -	for p in $REPORT_ENV_LIST;do
> +	for p in "${REPORT_ENV_LIST[@]}"; do
>  		_xunit_add_property "$p"
>  	done
>  	echo -e "\t</properties>" >> $REPORT_DIR/result.xml
> -- 
> 2.35.3
> 
