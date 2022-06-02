Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26DAC43334
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 00:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiFBAvO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 20:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiFBAvN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 20:51:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EE9227199
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 17:51:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25839B81BA5
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 00:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C624EC385A5;
        Thu,  2 Jun 2022 00:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654131069;
        bh=lHpo97yc9no/XvHsvbVZvWQz3DnC6u8QJBNU7onuY2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QqXey1XxmM6bYPRSekZ390jbY+icjt2q9KUC+jN349W8kizzIAjGJJc7b7/BWpPu3
         oJ8wkV1GjUZG406H5TMpGVe31CEKwiaQVFHE5MB+m3JxN4w30AE+1MXCFFA5cVr8nT
         104t6rPhF6k2U27AgWynD4VIjp3yEeOR7hmgUvj5I0fYCLmDef+kOjzK0/6eDf8qF0
         Lmb9TIeSCwASbP5DGTq02ki3u1TELNft9UBcRiCFjA5Nagcfe2V1b0V3RiE0+ZxlPi
         ldF40hQ9D7UXViqw39WQR3dKSx+oTkflh6VJithrjdJcqmglwZZ6ptubuk4FuHR7rJ
         qqD3AL7abjGXA==
Date:   Wed, 1 Jun 2022 17:51:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/8] README: document _begin_fstests better
Message-ID: <YpgJfbkaZJjA3EhZ@magnolia>
References: <20220602003126.2903779-1-david@fromorbit.com>
 <20220602003126.2903779-3-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602003126.2903779-3-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 02, 2022 at 10:31:20AM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Because how it actually gets used by the fstests infrastructure
> has been undocumented and that has impact on how it should be set
> up.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  README | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/README b/README
> index 7da66cb6..80d148be 100644
> --- a/README
> +++ b/README
> @@ -368,19 +368,41 @@ Test script environment:
>  
>       6. Test group membership: Each test can be associated with any number
>  	of groups for convenient selection of subsets of tests.  Group names
> -	can be any sequence of non-whitespace characters.  Test authors
> -	associate a test with groups by passing the names of those groups as
> -	arguments to the _begin_fstest function.  For example, the code:
> +	must  be human readable using only characters in the set [:alnum:_-].
>  
> -	_begin_fstest auto quick subvol snapshot
> +	Test authors associate a test with groups by passing the names of those
> +	groups as arguments to the _begin_fstest function. While _begin_fstests
> +	is a shell function that must be called at the start of a test to
> +	initialise the test environment correctly, the the build infrastructure
> +	also scans the test files for _begin_fstests invocations. It does this
> +	to compile the group lists that are used to determine which tests to run
> +	when `check` is executed. In other words, test files files must call
> +	_begin_fstest with their intended groups or they will not be run.
> +
> +	However, because the build infrastructure also uses _begin_fstests as
> +	a defined keyword, addition restrictions are placed on how it must be
> +	formatted:
> +
> +	(a) It must be a single line with no multi-line continuations.
> +
> +	(b) group names should be separated by spaces and not other whitespace
> +
> +	(c) A '#' placed anywhere in the list, even in the middle of a group
> +	    name, will cause everything from the # to the end of the line to be
> +	    ignored.
> +
> +	For example, the code:
> +
> +	_begin_fstest auto quick subvol snapshot # metadata
>  
>  	associates the current test with the "auto", "quick", "subvol", and
> -	"snapshot" groups.  It is not necessary to specify the "all" group
> -	in the list because that group is computed at run time.
> +	"snapshot" groups. Because "metadata" is after the "#" comment
> +	delimiter, it is ignored by the build infrastructure and so it will not
> +	be associated with that group.
> +
> +	It is not necessary to specify the "all" group in the list because that
> +	group is always computed at run time from the group lists.
>  
> -	The build process scans test files for _begin_fstest invocations and
> -	compiles the group list from that information.  In other words, test
> -	files must call _begin_fstest or they will not be run.
>  
>  Verified output:
>  
> -- 
> 2.35.1
> 
