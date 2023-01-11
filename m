Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF31C46467
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Jan 2023 05:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjAKFr3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 Jan 2023 00:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjAKFr3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Jan 2023 00:47:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5C66343
        for <fstests@vger.kernel.org>; Tue, 10 Jan 2023 21:47:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9918614D4
        for <fstests@vger.kernel.org>; Wed, 11 Jan 2023 05:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF6FC433EF;
        Wed, 11 Jan 2023 05:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673416047;
        bh=qMvxR5Ldp67EGWmi26WGNakMHbZjciNxSy/C5DT1m8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5CXb3KJtcMo3GeIooUobkCdcR4L2AsX6BeoKx/uineVL+8w5UW8HMxm36VFETrN8
         4a5/WhP7dY3x+H+J+O7StfBjPFTJ0LIgKMtCkwKOvidPttonVZJrL9uPc9ayVbdMXh
         VYVMQ89ZI+HtMgJ8NqOm+lKuZU5UG6PqUcVI3N2IHZr+tBZVOPTjT1KJxFh7clNqyb
         /1QGjZL9ceEyiLPqvXbCeMiZbmRxnlOUSYvcR4KFG7/l1Aj0cjfV00BN/3YzW9w4P+
         86F+t4fhclUA03LN5p3eEYiD5CuKLuPOzp6M6+MBjDpdYeERk7vRjIdP6iwMDu6GJl
         oxZzK9w5NgJNQ==
Date:   Tue, 10 Jan 2023 21:47:26 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/3] populate: ensure btree directories are created
 reliably
Message-ID: <Y75NbhbmZJMnVBFK@magnolia>
References: <20230110224906.1171483-1-david@fromorbit.com>
 <20230110224906.1171483-3-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110224906.1171483-3-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 11, 2023 at 09:49:05AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> The population function creates an XFS btree format directory by
> polling the extent count of the inode and creating new dirents until
> the extent count goes over the limit that pushes it into btree
> format.
> 
> It then removes every second dirent to create empty space in the
> directory data to ensure that operations like metadump with
> obfuscation can check that they don't leak stale data from deleted
> dirents.
> 
> Whilst this does not result in directory data blocks being freed, it
> does not take into account the fact that the dabtree index has half
> the entries removed from it and that can result in btree nodes
> merging and extents being freed. This causes the extent count to go
> down, and the inode is converted back into extent form. The
> population checks then fail because it should be in btree form.
> 
> Fix this by counting the number of directory data extents rather than
> the total number of extents in the data fork. We can do this simply
> by using xfs_bmap and counting the number of extents returned as it
> does not report extents beyond EOF (which is where the dabtree is
> located). As the number of data blocks does not change with the
> dirent removal algorithm used, this will ensure that the inode data
> fork remains in btree format.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  common/populate | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/common/populate b/common/populate
> index 9b60fa5c1..7b5b16fb8 100644
> --- a/common/populate
> +++ b/common/populate
> @@ -80,8 +80,11 @@ __populate_create_nfiles() {
>  			continue
>  		fi
>  
> -		local nextents="$(_xfs_get_fsxattr nextents $name)"
> -		if [ "${nextents}" -gt "${max_nextents}" ]; then
> +		# Extent count checks use data blocks only to avoid the removal
> +		# step from removing dabtree index blocks and reducing the
> +		# number of extents below the required threshold.
> +		local nextents="$(xfs_bmap ${name} |grep -v hole | wc -l)"
> +		if [ "$((nextents - 1))" -gt "${max_nextents}" ]; then

Pretty much the same patch I had in my tree...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  			echo ${d}
>  			break
>  		fi
> -- 
> 2.38.1
> 
