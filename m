Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD27C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 19 May 2022 23:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbiESXN7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 May 2022 19:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiESXN6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 May 2022 19:13:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F80F688A
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 16:13:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73B9F61857
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 23:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08C9C385B8;
        Thu, 19 May 2022 23:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653002036;
        bh=Rh2leovEuWXoo8a04W87XJxR1OwM7EEygSqN1Unw7OY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E2sYHxOhwot3+TtWRtTXZXx3zHPnu55cKOfU/HOpjvtAjjPauh1kcKNLvGeFI76GK
         I/kQk7JoXKPDUbAkMDFPD9fL+Qsvd9BefL7ujzFBY6Y86hi86P2KGjhG2vpSZEaBQ0
         bkFekS1n91I02mCEb5zdSVGyhzKEoVY74K1GiCPACLTncYGSYHqAc2SVyhLSAHLw+0
         cxDIVaBZLqSdakirAK0y0aph2yJ5EsuBFh+7QMl7U6gcryxx9TotyAgtwoF92lyUW0
         zRED379fUJ58jIVTNm0zBxH+YNli/ady77dx9auTVUKOGc2VSIZGroFt9RnXK7Yrf3
         SS4U9r0v17vJA==
Date:   Thu, 19 May 2022 16:13:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 05/12] README: document _begin_fstests better
Message-ID: <YobPNOJvSyUYEZpm@magnolia>
References: <20220517070111.1381936-1-david@fromorbit.com>
 <20220517070111.1381936-6-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517070111.1381936-6-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 17, 2022 at 05:01:04PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Because how it actually gets used by the fstests infrastructure
> has been undocumented and that has impact on how it should be set
> up.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  README | 41 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 9 deletions(-)
> 
> diff --git a/README b/README
> index 7da66cb6..eacf1acd 100644
> --- a/README
> +++ b/README
> @@ -368,19 +368,42 @@ Test script environment:
>  
>       6. Test group membership: Each test can be associated with any number
>  	of groups for convenient selection of subsets of tests.  Group names
> -	can be any sequence of non-whitespace characters.  Test authors
> -	associate a test with groups by passing the names of those groups as
> -	arguments to the _begin_fstest function.  For example, the code:
> +	can be any sequence of non-whitespace characters, though human-readable
> +	names that match the set [A-Za-z0-9\-] are highly prefered.
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

I don't see where this is implemented in mkgroupfile?  Was that in the
part of the patchset that got eaten by vger?  Or is this patch a
proposal for how we want to define _begin_fstest usage and will be
followed by changes to mkgroupfile to make it do what we now say it
does?

Also, under the old behavior, a '#' not preceded by whitespace or
otherwise escaped on the command line is considered to be part of an
argument:

$ echo moo#cow
moo#cow

Not that we /had/ any groups like that.

Also, I think we ought to add:

	(d) Group names may not contain whitespace or punctuation.

	(e) Quotation marks are considered a part of the group name.

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

Otherwise, I'm happy with this.

--D

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
