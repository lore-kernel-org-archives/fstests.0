Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42585C54EBD
	for <linux-fstests@archiver.kernel.org>; Thu, 12 Jan 2023 05:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbjALFmm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 Jan 2023 00:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbjALFml (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Jan 2023 00:42:41 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3582C120A5
        for <fstests@vger.kernel.org>; Wed, 11 Jan 2023 21:42:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VZPoBhp_1673502154;
Received: from 30.97.48.238(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZPoBhp_1673502154)
          by smtp.aliyun-inc.com;
          Thu, 12 Jan 2023 13:42:35 +0800
Message-ID: <04f8e7bf-5279-7b63-d543-4e7ff8215bac@linux.alibaba.com>
Date:   Thu, 12 Jan 2023 13:42:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] populate: ensure btree directories are created
 reliably
To:     Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
References: <20230110224906.1171483-1-david@fromorbit.com>
 <20230110224906.1171483-3-david@fromorbit.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230110224906.1171483-3-david@fromorbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org



On 2023/1/11 06:49, Dave Chinner wrote:
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

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   common/populate | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/common/populate b/common/populate
> index 9b60fa5c1..7b5b16fb8 100644
> --- a/common/populate
> +++ b/common/populate
> @@ -80,8 +80,11 @@ __populate_create_nfiles() {
>   			continue
>   		fi
>   
> -		local nextents="$(_xfs_get_fsxattr nextents $name)"
> -		if [ "${nextents}" -gt "${max_nextents}" ]; then
> +		# Extent count checks use data blocks only to avoid the removal
> +		# step from removing dabtree index blocks and reducing the
> +		# number of extents below the required threshold.
> +		local nextents="$(xfs_bmap ${name} |grep -v hole | wc -l)"
> +		if [ "$((nextents - 1))" -gt "${max_nextents}" ]; then
>   			echo ${d}
>   			break
>   		fi
