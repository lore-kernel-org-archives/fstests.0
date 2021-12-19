Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74058C433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Dec 2021 02:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhLSC7L (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 18 Dec 2021 21:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhLSC7K (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 18 Dec 2021 21:59:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7F9C061574
        for <fstests@vger.kernel.org>; Sat, 18 Dec 2021 18:59:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40D35B80B6E
        for <fstests@vger.kernel.org>; Sun, 19 Dec 2021 02:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B51C36AE2;
        Sun, 19 Dec 2021 02:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639882748;
        bh=nFjL8nWN07WrwuonhnKO2ijLyr/p7TKZQq/zHfXyN7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YeM05h+TTD84rHw9cb/6AK6JvFCZLtdjwyTDyJHiBOf2ad8o2cb9+yadmoJZ1oxjr
         yqGrTUC2nVdiihDy3OlCnzgqDBDk4FiV0ebeJG3CcXYgr9wllhXbNjtW4Ai/p0aFcp
         PPZP+DO2dTKx0+8CDS6I4E1v0tjkR+c/VbN5ghmlAw6sUcoKycG7B46kVC4CZoFeuP
         ERJcV92/87Oaz5CKsFADdOhJAuiQ7yFNeC2NTTSpA0Am22sntfpIBDflqWXNs+RKBa
         PeafwPMQgynAvNgq1eUPRnhdtWijDDlEilJ3EzmRJi6dT/M8UBZtUSb3S51UYNlKGX
         BUwoPs+9bl4aA==
Date:   Sat, 18 Dec 2021 20:59:05 -0600
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, guan@eryu.me,
        Luis Henriques <lhenriques@suse.de>
Subject: Re: [PATCH] common/rc, ceph: skip ceph/001-ceph/003 if
 test_dummy_encryption is enabled
Message-ID: <Yb6f+Qn0gQQoQDfX@quark.localdomain>
References: <20211216124752.13768-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216124752.13768-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Dec 16, 2021 at 07:47:52AM -0500, Jeff Layton wrote:
> Some tests on ceph require changing the layout of new files, which is
> forbidden when the files are encrypted. Skip these tests if the
> test_dummy_encryption mount option is being used.
> 
> Generalize the _exclude_scratch_mount_option code and add a new
> _exclude_test_mount_option call as well. Call the new function from the
> ceph tests that should exclude test_dummy_encryption.
> 
> Cc: Luis Henriques <lhenriques@suse.de>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/rc      | 18 ++++++++++++++----
>  tests/ceph/001 |  1 +
>  tests/ceph/002 |  1 +
>  tests/ceph/003 |  1 +
>  4 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 7973ceb5fdf8..312ebea8fb57 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3844,14 +3844,14 @@ _require_cloner()
>  # "opt1 opt2 opt3"
>  _normalize_mount_options()
>  {
> -	echo $MOUNT_OPTIONS | sed -n 's/-o\s*\(\S*\)/\1/gp'| sed 's/,/ /g'
> +	echo "$1" | sed -n 's/-o\s*\(\S*\)/\1/gp'| sed 's/,/ /g'
>  }

Doesn't this break the call to _normalize_mount_options() in common/btrfs?

>  
> -# skip test if MOUNT_OPTIONS contains the given strings
> +# skip test if $2 contains the given strings in $1
>  # Both dax and dax=always are excluded if dax or dax=always is passed
> -_exclude_scratch_mount_option()
> +_exclude_mount_option()
>  {
> -	local mnt_opts=$(_normalize_mount_options)
> +	local mnt_opts=$(_normalize_mount_options "$2")
>  
>  	while [ $# -gt 0 ]; do
>  		local pattern=$1
> @@ -3864,6 +3864,16 @@ _exclude_scratch_mount_option()
>  	done
>  }

This function already uses all positional arguments, so using $2 isn't valid.

- Eric
