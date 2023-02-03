Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31292C636D3
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Feb 2023 00:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbjBCAEg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 2 Feb 2023 19:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbjBCAEd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Feb 2023 19:04:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384D328D2B
        for <fstests@vger.kernel.org>; Thu,  2 Feb 2023 16:04:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECB8DB810EE
        for <fstests@vger.kernel.org>; Fri,  3 Feb 2023 00:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9307BC433D2;
        Fri,  3 Feb 2023 00:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675382665;
        bh=WF75xBD3hCqtKCM5Rjj44CY2U0j8El4s25JaBDjuQww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lHcudj7V20oWNVUuldLwl4h6WBRNBknuFU4YRii6/hJqjjV5Fw1lTQgiIQNoLDYJC
         h2/b//c3eLQ6TZxM78kx+fEIYnvj1pz/ZVApVwpQhJDsLaoRnQUzbDGeeq0xdNma8i
         1owhGC8C2dPhJ+on4ssS5nwQ0By39/cGY+15SrutdDzc72qne59FHJIcChhTXJUper
         z8R3fAWoKXZr5W5BOPcf0Eq0jjaZeoRB0xrZIs22UnisnwLufpkzKBIjVMLq0daWDB
         /O4HK3gWi3UfZTn3dgklBmbh6QEgD8bxWYxbKx+CSCrirdbF5bQoiD+CTvNFuno/IJ
         F1stHpf6kkkVw==
Date:   Thu, 2 Feb 2023 16:04:25 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/191: fix xattr leaf block emptying on 64k blocksized
 fses
Message-ID: <Y9xPiT6wtGKQm7s3@magnolia>
References: <20230202210940.95791-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202210940.95791-1-ailiop@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Feb 02, 2023 at 10:09:40PM +0100, Anthony Iliopoulos wrote:
> This test is failing on filesystems with 64k blocksize since the leaf
> hdr.firstused field is 16 bit and as such trying to reset it to $dbsize
> overflows and is rejected by xfs_db. The leaf is never properly resetted
> and the discrepancy is picked up by xfs_repair, thus failing the test.
> 
> Fix it by setting it to XFS_ATTR3_LEAF_NULLOFF (0) as this is the proper
> on-disk value to indicate an empty leaf on 64k blocksized fses.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  tests/xfs/191 | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/191 b/tests/xfs/191
> index 4f0a9b9eeef5..8dd875fcd28b 100755
> --- a/tests/xfs/191
> +++ b/tests/xfs/191
> @@ -78,10 +78,20 @@ make_empty_leaf() {
>  
>  	base=$(_scratch_xfs_get_metadata_field "hdr.freemap[0].base" "inode $inum" "ablock 0")
>  
> +	# 64k dbsize is a special case since it overflows the 16 bit firstused
> +	# field and it needs to be set to the special XFS_ATTR3_LEAF_NULLOFF (0)
> +	# value to indicate a null leaf. For more details see kernel commit:
> +	# e87021a2bc10 ("xfs: use larger in-core attr firstused field and detect overflow").

Do we need a second _fixed_by_kernel_commit here?

> +	if [ $dbsize -eq 65536 ]; then
> +		firstused=0;
> +	else
> +		firstused=$dbsize;

Trailing semicolon not necessary here.

> +	fi

Otherwise, looks correct to me, so
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> +
>  	_scratch_xfs_db -x -c "inode $inum" -c "ablock 0" \
>  		-c "write -d hdr.count 0" \
>  		-c "write -d hdr.usedbytes 0" \
> -		-c "write -d hdr.firstused $dbsize" \
> +		-c "write -d hdr.firstused $firstused" \
>  		-c "write -d hdr.freemap[0].size $((dbsize - base))" \
>  		-c print >> $seqres.full
>  }
> -- 
> 2.35.3
> 
