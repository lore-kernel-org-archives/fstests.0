Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E78EC433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 16:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D966260F35
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 16:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbhJKQi2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Oct 2021 12:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232752AbhJKQiT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 11 Oct 2021 12:38:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BAFA60F35;
        Mon, 11 Oct 2021 16:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633970179;
        bh=IowoujM1u1a+rgjhf1c+jtd3N1yuDxJ57IOIuGjug3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwlXrATzMm5GvP/s8xLTRt4N6tyQ+flLY+RoRIst/jbsBevmqBqisb0Kzt5BVZmZM
         DGa99j6ymRJBSTruNuYebgfJEhD4gOSqbL0uAkJt5FHNxSiQQNXn00qTDz7dWBvDgM
         yyeB1GMtfZ/QPf0ByVZ3uHrWzwP/GGuOVTIYBET5pr4JmRJEuy1Vy8QoTgYbYLw/FI
         UBI487RIriYnMSKSdswTR8YPrgm4Tv342ORNzBJhP191WLnyPx+ez0z6A7f0nChG4A
         1oBle7OadvPmRBQbagV8KEFKb13b2FezQKeIaoTaM5iwcDI5xqZqGGzx0QfzLOZnaP
         BxYkYhjaILPdg==
Date:   Mon, 11 Oct 2021 09:36:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] fstests: groupfile generation needs force overwrite
Message-ID: <20211011163618.GE24282@magnolia>
References: <20211010230659.216166-1-david@fromorbit.com>
 <20211010230659.216166-3-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010230659.216166-3-david@fromorbit.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 11, 2021 at 10:06:59AM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> Having built fstests as root as part of a run script, I get failures
> then trying to run it as a user because of the group list
> generation. The issue occurs because the group list files are owned
> by root, and so I get an interactive prompt to overwrite them such
> as:
> 
> Building btrfs
>  [GROUP] /home/dave/src/xfstests-dev/tests/btrfs/group.list
> mv: replace 'group.list', overriding mode 0644 (rw-r--r--)? y
> Building ceph
>  [GROUP] /home/dave/src/xfstests-dev/tests/ceph/group.list
> mv: replace 'group.list', overriding mode 0644 (rw-r--r--)? y
> Building cifs
>  [GROUP] /home/dave/src/xfstests-dev/tests/cifs/group.list
> mv: replace 'group.list', overriding mode 0644 (rw-r--r--)? y
> Building ext4
>  [GROUP] /home/dave/src/xfstests-dev/tests/ext4/group.list
> ...
> 
> Use 'mv -f' to ignore such trivial issues so that the new group
> lists are written correctly.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Oops, sorry I didn't catch this.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tools/mkgroupfile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/mkgroupfile b/tools/mkgroupfile
> index 634ec92c..3844e57d 100755
> --- a/tools/mkgroupfile
> +++ b/tools/mkgroupfile
> @@ -24,7 +24,7 @@ cleanup() {
>  	test -z "$ngroupfile" && return
>  
>  	if [ $ret -eq 0 ]; then
> -		mv "$ngroupfile" "$groupfile"
> +		mv -f "$ngroupfile" "$groupfile"
>  	else
>  		rm -f "$ngroupfile"
>  	fi
> -- 
> 2.33.0
> 
