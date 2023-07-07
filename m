Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAECEB64D9
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Jul 2023 14:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjGGO4G (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jul 2023 10:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjGGO4F (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jul 2023 10:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D0B2115
        for <fstests@vger.kernel.org>; Fri,  7 Jul 2023 07:55:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E7D1618E5
        for <fstests@vger.kernel.org>; Fri,  7 Jul 2023 14:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83609C433C8;
        Fri,  7 Jul 2023 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688741755;
        bh=+2lPvZOX4uiVu2d4EJUOMwkg/5jjlP29w5YI5jCVjgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntukMPnoiftF5dXWtzu+rvt79RgDx16VIeP7UaMf4PMn+BoEgPnCmU5eOdmHoolZC
         C7CwshxucCYDncfP+mIAFIWJS92JfeKk9FKnwy2qyCgDFPt2iAKErghXLyWcwcTdfE
         zds5B8fn3E0Rl1t+pYW6cIa4tZ4nMLTOqB2DvruJ57VgCywtusAhvCmJb0FObbBanu
         xbJKSI67WZwtewPznU8YnFbEFh9j7gG7KfwGvgjgYuOJ6cFA4f6o5YKiJgZjagVytG
         7xTYnhon70tF21C3AB+RbadhhkZc0/vZC8pFDg2wm3pYkIEQTY0xNokbxMvm3mFlTj
         zQ8dfn7NtqsJA==
Date:   Fri, 7 Jul 2023 07:55:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] report: remove xmlns specifier
Message-ID: <20230707145554.GC11476@frogsfrogsfrogs>
References: <20230706204232.1577765-1-tytso@mit.edu>
 <20230706204232.1577765-2-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706204232.1577765-2-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 06, 2023 at 04:42:32PM -0400, Theodore Ts'o wrote:
> By specifying "xmlns=https://git.kernel.org/.../xfstests-dev.git",
> this causes XML complaint parsers, such as used by the python
> junitparser library, to put all of the XML elements into a namespace,
> which then causes junitparser to toss its cookies.
> 
> This can be worked-around in a test runner script via:
> 
>     sed -i.orig -e 's/xmlns=\".*\"//' "$RESULT_BASE/result.xml"
> 
> but it's better not to include the xmlns line at all in the first
> place, since this may cause other users of fstests who are using
> the Python junitparser library a lot of headaches.
> 
> Cc: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Yeah, I guess.  Note to self: xmlns needs to be in the file format from
the start, or adding it will break parsers. :(

Sooo much engineering and yet it's easy to stop up the drain.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/report | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/common/report b/common/report
> index 3ad14f94e..081df988f 100644
> --- a/common/report
> +++ b/common/report
> @@ -127,7 +127,6 @@ _xunit_make_section_report()
>  	local fstests_ns="https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git"
>  	cat >> "$tmp_fn" << ENDL
>  <testsuite
> - xmlns="$fstests_ns"
>   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
>   xsi:schemaLocation="$fstests_ns $fstests_ns/tree/doc/xunit.xsd"
>  
> -- 
> 2.31.0
> 
