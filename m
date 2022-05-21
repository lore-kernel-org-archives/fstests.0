Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5F7C433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 21 May 2022 05:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbiEUFvE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 21 May 2022 01:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbiEUFvC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 21 May 2022 01:51:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C29F2250F
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 22:50:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 14AB3CE27A4
        for <fstests@vger.kernel.org>; Sat, 21 May 2022 05:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C62C385A5;
        Sat, 21 May 2022 05:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653112255;
        bh=OOVXqlkjrT1tCCoSQyJwlQWChHNEfmClUr6zw33bDQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ktlZ5D7uudrefAEYIAUb3YAu1m73w2BWQw0+ln+Pzicd4Yj2f0K+q/LNESWLHr79y
         Wp/Jmph/F13sgJG4j3VjFemiOcRTiLJvmhf6n6ilFzQUkcqx0XP0dBI8NBY2eXMYeB
         pz/fQeXPa+n4WNZmuzOot5jw9CmhVaZWh9q8VXiwnSbAkpvHaTOy3MKiOjecvMDn25
         olUeYjchSB3RolsPbFfwKfAVqLLySNeggKh4CQPCxKWXBX/jF1vt7QwpNlDg4LZ+3y
         oVO4Bux4gOjhE/wT//P54iwiftVzA53pZWQfj/OK3stZmznFUi+iRPbQL7T+Bi/IfE
         yUqPMmktDDNwA==
Date:   Fri, 20 May 2022 22:50:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org, david@fromorbit.com
Subject: Re: [PATCH] tools/mkgroupfile: help the cases of group.list in
 number order
Message-ID: <Yoh9vqqF6De6XCJq@magnolia>
References: <20220521054349.1691473-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521054349.1691473-1-zlang@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, May 21, 2022 at 01:43:49PM +0800, Zorro Lang wrote:
> The mkgroupfile doesn't sort cases in number order, that cause
> fstests' ./new script can't find a proper number which isn't taken.
> The unsorted case number might cause more problems, so fix it.
> 
> Fixes: 441606d28681 ("fstests: faster group file creation")
> Signed-off-by: Zorro Lang <zlang@kernel.org>

Makes sense to me.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

> ---
> 
> Hi,
> 
> If you'd like to fix this issue seperately, I can merge this patch with Dave's
> "[PATCH 04/12] fstests: fix group list generation for whacky test names"
> together.

Yeah, that'd be nice...

--D

> 
> Thanks,
> Zorro
> 
>  tools/mkgroupfile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/mkgroupfile b/tools/mkgroupfile
> index 24435898..bab85046 100755
> --- a/tools/mkgroupfile
> +++ b/tools/mkgroupfile
> @@ -60,7 +60,8 @@ ENDL
>  
>  	# Aggregate the groups each test belongs to for the group file
>  	grep -I -R "^_begin_fstest" $test_dir/ | \
> -		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' >> $new_groups
> +		sed -e 's/^.*\/\([0-9]*\):_begin_fstest/\1/' | \
> +		sort -ug >> $new_groups
>  
>  	# Create the list of unique groups for existence checking
>  	grep -I -R "^_begin_fstest" $test_dir/ | \
> -- 
> 2.31.1
> 
