Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F082C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 16 May 2022 16:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiEPQUa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 16 May 2022 12:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiEPQU3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 May 2022 12:20:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB5339145
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 09:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E4D261011
        for <fstests@vger.kernel.org>; Mon, 16 May 2022 16:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A112BC385AA;
        Mon, 16 May 2022 16:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652718026;
        bh=Uh6bbzZWIvw7emlxt0ZL1dcuhFBusflD1hjNhgajrfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e95vk8auS2W9cofflomtA1Qhb0WyD15Kc/nwoEBvwlxKEL2rj2StwxIIQNBltKZKX
         SfCuaVM1ZQyYPRT0wiKwN0z6WvSfTEDL7JHtapMMzKUErKdmP75t1I3dpsz6cZttNB
         hG32kfz0xNLLxAo4n3s6KRHtiNZaA6gWlDNl0o98Jc2H8FT9Q8f41msFGumr6t0wzO
         HJX+7DINRlxt9mqje3lTAkNbvPMxMko5lM1SlhSmGD69m9xXxjJ9YrBfEzWi9jTGqS
         PeC3sNJSO9M3rhrmd3UHj7yNnknR2vhPVe6rCgC2d/gd+zl/G2Lwdp9zKAHsSb4WUx
         TxisnhVEQcsow==
Date:   Mon, 16 May 2022 09:20:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/4] fstests: fix group list generation for whacky test
 names
Message-ID: <YoJ5yvYD9ZmNoNVi@magnolia>
References: <20220516085922.1306879-1-david@fromorbit.com>
 <20220516085922.1306879-2-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516085922.1306879-2-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 16, 2022 at 06:59:19PM +1000, Dave Chinner wrote:
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
> Long term, we should rename that test to '191' and rip out all that
> unused and unnecessary complexity for matching ascii test names
> because we just don't use it. Numbers for tests are still working
> just fine.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  tools/mkgroupfile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/mkgroupfile b/tools/mkgroupfile
> index 24435898..958d4e2f 100755
> --- a/tools/mkgroupfile
> +++ b/tools/mkgroupfile
> @@ -60,7 +60,7 @@ ENDL
>  
>  	# Aggregate the groups each test belongs to for the group file
>  	grep -I -R "^_begin_fstest" $test_dir/ | \
> -		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' >> $new_groups
> +		sed -e 's/^.*\/\([0-9]*\).*:_begin_fstest/\1/' >> $new_groups

Sorry I didn't get a chance to review this patch before it went in, but
this string parsing gets tripped up by things that the old code handled
just fine.  Back when we'd run _begin_fstest as a real bash subroutine
to print the group name arguments, a line like this:

_begin_fstest deprecated # log logprint quota

would put this test in *only* the group "deprecated".  Everything
starting with the '#' is a comment.  bash would also ignore extra spaces
between arguments, and if someone happened to use a tab, that would also
be fine because bash ignores all the unquoted whitespace between
arguments.  Yes, it's slow, but I chose that method because (a) make
-jXX, and (b) I hate string parsing with grep and sed gunk.

Instead, that above output (which I harvested from xfs/081) now becomes:

081 deprecated # log logprint quota

The first grepsed blobule should do more if it's going to
performance-optimize bash:

grep -I -R "^_begin_fstest" -Z $test_dir/ | \
	sed -e 's/#.*$//g' \
	    -e 's/[[:space:]]$//g' \
	    -e 's/[[:space:]]+/ /g' | \
	    -e 's/^.*\/\(.*\)\x0.*_begin_fstest[[:space:]]*/\1 /g' \
	sort -g

The -Z option separates the filename from the found content, which
enables sed to isolate the filename portion.  The first sed statement
removes all comments, the second removes all trailing whitespace so that
it won't end up in the output, and the third collapses whitespace runs
into a single space.  The fourth reformats the input to match group file
format.  The command ends with a sort -g so that the lines end up in
numeric order instead of readdir() order.

Even then, this still isn't sufficient, since a null in the test file
will confuse this.  I half wonder if this will even work universally,
since -Z is probably a GNUism, and I bet there are sed out there that
won't recognize '\x0' to detect the NULL in the output.  But hey, -I and
-R aren't in the posix definition either...

>  	# Create the list of unique groups for existence checking
>  	grep -I -R "^_begin_fstest" $test_dir/ | \

This second blobule isn't so bad; it becomes:

	grep -I -R "^_begin_fstest" -h $test_dir/ | \
		sed -e 's/#.*$//g' \
		    -e 's/[[:space:]]$//g' \
		    -e 's/[[:space:]]+/ /g' \
		    -e 's/^.*_begin_fstest[[:space:]]*//g' \
		    -e 's/ /\n/g' | \
		sort -u > $new_groups.check

Where -h turns off the filename printing since we don't need that for
the unique group list.  But still, UGH STRING PARSING.

--D

> -- 
> 2.35.1
> 
