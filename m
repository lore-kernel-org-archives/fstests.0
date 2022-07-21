Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D20EC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 04:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiGUEkn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 00:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiGUEkm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 00:40:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BCD6FA2C
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 21:40:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2CB5617D7
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 04:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59214C3411E;
        Thu, 21 Jul 2022 04:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658378440;
        bh=AAmYwItamOFuPJBBDFYEmzfRkd2WhqU5uZ8ZiFKbEYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JywzL2+2k1n4NUnG31C17JiCxQe3c8DknSnIKnVLxqU36ELyWRmJ3/8f5+b2fb0QY
         75E90vvKGX7UqBIAPLz/NomZm+hRTwFNf4/Kqwg3ux5USBY91GQJ7nZbXpV4/Azzx6
         7YmfoX6KDgWFreC1ZMQks96/SEh+RQv3YQlGkreRBq7orp/9WpoBMBcuvyxbLkQsi8
         G2ZPyFWK2Vj0EIcSDC4RJAbPkP6BLMm6E/yuA1WdBZuToSwG5ejcnHFGG5Ase5CILy
         XsaypEBXKOg7qwFSJ87/Sq0j2JxOT6hh37eJ7QEBK1NfRszLxiXyN+ZUSv67fBJDvU
         dwYR/ZA9RQI0w==
Date:   Wed, 20 Jul 2022 21:40:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     bxue@redhat.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
Message-ID: <YtjYxyhVmSPzzFoH@magnolia>
References: <20220721022959.4189726-1-bxue@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721022959.4189726-1-bxue@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 21, 2022 at 10:29:59AM +0800, bxue@redhat.com wrote:
> From: Boyang Xue <bxue@redhat.com>
> 
> The test requires larger scratch dev size when running on top of NFS other
> than ext4 and xfs. It requires at least 27GB in my test. Without this
> requirement, the test run never finishes on NFS, leaving 100% scratch disk
> space use.

> Signed-off-by: Boyang Xue <bxue@redhat.com>
> ---
> Hi,
> 
> I find generic/476 easily goes into an infinite run on top of NFS. When it

Infinite?  It's only supposed to start 25000*nr_cpus*TIME_FACTOR
operations, so it /should/ conclude eventually.  That includes driving
the filesystem completel out of space, but there ought to be enough
unlink/rmdir/truncate calls to free up space every now and then...

> happens, the common pattern is 100% disk space use of SCRATCH_MNT, and
> `nfsiostat` shows 50% write error on SCRATCH_MNT. When I run it with a large
> enough SCRATCH_MNT, the problem disappears. So I post this patch to add the size
> requirement.
> 
> Please help review this patch. Thanks!
> 
> -Boyang
> 
>  tests/generic/476 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/476 b/tests/generic/476
> index 212373d1..dcc7c3da 100755
> --- a/tests/generic/476
> +++ b/tests/generic/476
> @@ -24,6 +24,7 @@ _cleanup()
>  _supported_fs generic
>  
>  _require_scratch
> +_require_scratch_size $((27 * 1024 * 1024)) # 27GB

...so IDGI, this test works as intended.  Are you saying that NFS
command overhead is so high that this test takes too long?

--D

>  _require_command "$KILLALL_PROG" "killall"
>  
>  echo "Silence is golden."
> -- 
> 2.27.0
> 
