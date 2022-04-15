Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D0AC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 15 Apr 2022 01:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348487AbiDOBmO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 14 Apr 2022 21:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347526AbiDOBmN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Apr 2022 21:42:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A489286F6
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 18:39:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 180C3B82BEF
        for <fstests@vger.kernel.org>; Fri, 15 Apr 2022 01:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93E5C385A5;
        Fri, 15 Apr 2022 01:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649986784;
        bh=I9wSOZr68G6YvQWW7ZUc+kRaQD7q1sbcHwCWj0DN2is=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a9wmDEMMmlZ1qJwkpL8QyM9IdY5KwaTRv7tZyztlPjQXzNQO7Fu7M3GNJFKnW4nv/
         ISv6T7eyyM42qhjBgJILBFZUTLZJ9/s4l6idDZJvaU3R6NfkkVCR+I2sNwYgUOFFoE
         tuHE0u2+SReVj7vz0taWnl1cLJrVNK22SD8RNugP2L+O1t1QOLKdqzplgfaizabR3o
         RHzrQR3oxFhH5MiIDFLeBOi8WiRfX1DNeGkvok2WPdpduq6dC8mprqpg81ZZL7X0OV
         YNuaA6NMqkMhUgwcFD1CSZDh+Nwk3FlJDo2wpjU0qbIAR7s+llxycJ6AfN4Ndz0xV8
         13gKiR5qeAMhg==
Date:   Thu, 14 Apr 2022 18:39:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
Subject: Re: [xfstests-bld PATCH 1/2] test-appliance: Add exclude file for
 ntfs3
Message-ID: <20220415013944.GD17014@magnolia>
References: <20220414234220.627320-1-kari.argillander@fidelix.com>
 <20220414234220.627320-2-kari.argillander@fidelix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414234220.627320-2-kari.argillander@fidelix.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 15, 2022 at 02:42:19AM +0300, Kari Argillander wrote:
> From: Kari Argillander <kari.argillander@gmail.com>
> 
> There is some hangs which will affect full run. Exclude these for now so
> that ntfs3 is easier to run.
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
>  kvm-xfstests/test-appliance/files/root/fs/ntfs3/exclude | 8 ++++++++
>  1 file changed, 8 insertions(+)
>  create mode 100644 kvm-xfstests/test-appliance/files/root/fs/ntfs3/exclude
> 
> diff --git a/kvm-xfstests/test-appliance/files/root/fs/ntfs3/exclude b/kvm-xfstests/test-appliance/files/root/fs/ntfs3/exclude
> new file mode 100644
> index 0000000..27160d3
> --- /dev/null
> +++ b/kvm-xfstests/test-appliance/files/root/fs/ntfs3/exclude
> @@ -0,0 +1,8 @@
> +# These ones hang so badly at the moment that we just ignore them for
> +# now.
> +generic/014
> +generic/129
> +
> +# This hangs sometimes so for now let's ignore it so that it will not
> +# affect full run.
> +generic/476

Yikes.  fsstress is enough to knock over ntfs3??!

--D

> -- 
> 2.35.1
> 
