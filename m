Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6779C433FE
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Apr 2022 08:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359486AbiD0InN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Apr 2022 04:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359487AbiD0InM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Apr 2022 04:43:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1F66EC42
        for <fstests@vger.kernel.org>; Wed, 27 Apr 2022 01:40:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 728E1B82535
        for <fstests@vger.kernel.org>; Wed, 27 Apr 2022 08:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B1CBC385A9;
        Wed, 27 Apr 2022 08:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651048798;
        bh=huGgbIC1Um/TXpnRmp03N+JgFFdo5T9OJ7aWe+vAARw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u1ENqKkZGLD5SIpY1W4J6wc3EcEyhVSSTUDUXZj4WDvQXwRN23W6iljVAWJXXvvrk
         uw8eCXcdxZbKUhZDD2enEwT6VgjwroUsADMP1qPvBNpQkJjjcrrjxtxL62vSkTZQdA
         qAUMTQbrqntoQ+AICcx//R8qDgAseiLKnKHq3OKZen/nXK60X3MF0az4uEouecsPA0
         QfPTTQEWooaTLoY3Wd/JWuh/A6+Raxc7iL6DlpJQttxNwIk8I3tK3ViWVCL7D670x3
         Q4iqlDLgO0ewCNJrwHoUqe7AOXu5cGTVnYTkrAor4Tsl4ta59g5KLG8lu49BduvR99
         An6QRnZa2j/bQ==
Date:   Wed, 27 Apr 2022 16:39:43 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Rishabh Dave <ridave@redhat.com>
Cc:     fstests@vger.kernel.org, jlayton@redhat.com, rishabhddave@gmail.com
Subject: Re: [PATCH] cephfs: add ceph-fuse suport for ceph-fuse
Message-ID: <20220427083943.rc4alejvbl2wbw2z@zlang-mailbox>
Mail-Followup-To: Rishabh Dave <ridave@redhat.com>, fstests@vger.kernel.org,
        jlayton@redhat.com, rishabhddave@gmail.com
References: <20220419175811.602126-1-ridave@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419175811.602126-1-ridave@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 19, 2022 at 11:28:11PM +0530, Rishabh Dave wrote:
> Currently tests in xfstests-dev can be executed against CephFS only by
> mounting CephFS using kernel driver. Attempting to run tests against
> CephFS using FUSE doesn't work because xfstests-dev would remount CephFS
> using kernel. This patch adds the ability for xfstest-dev code to mount
> CephFS using FUSE.
> 
> Fixes: https://tracker.ceph.com/issues/55354
> Signed-off-by: Rishabh Dave <ridave@redhat.com>
> ---
>  common/config |  2 ++
>  common/rc     | 46 ++++++++++++++++++++++++++++++++++------------
>  2 files changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/common/config b/common/config
> index 1033b890..efcf12e9 100644
> --- a/common/config
> +++ b/common/config
> @@ -556,6 +556,8 @@ _check_device()
>  			_fatal "common/config: $name ($dev) is not a character device"
>  		fi
>  		;;
> +	ceph-fuse)
> +		;;
>  	*)
>  		_fatal "common/config: $name ($dev) is not a block device or a network filesystem"
>  	esac
> diff --git a/common/rc b/common/rc
> index 553ae350..868b3ddd 100644
> --- a/common/rc
> +++ b/common/rc

[snip]

>  
>  	if [ -n "$type" -a "`_fs_type $dev`" != "$type" ]; then
> @@ -1869,6 +1890,7 @@ _require_test()
>  		if [ ! -d "$TEST_DIR" ]; then
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi

This place missed a ";;", it'll cause all cases fail directly when they try to
". common/rc". As this patch has been RVB, I'll fix it when I merge it. But better
to give a patch a mimimum test before sending (except it's simple enough:), to make
sure it won't break the most fundamental things at least, it's hard for me to test
all fs that fstests supports before merging, Thanks for understanding :)

Thanks,
Zorro


> +	ceph-fuse)
>  		;;
>  	cifs)
>  		echo $TEST_DEV | grep -q "//" > /dev/null 2>&1
> @@ -3204,7 +3226,7 @@ _check_test_fs()
>      virtiofs)
>  	# no way to check consistency for virtiofs
>  	;;
> -    ceph)
> +    ceph|ceph-fuse)
>  	# no way to check consistency for CephFS
>  	;;
>      glusterfs)
> -- 
> 2.34.1
> 
