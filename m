Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9335FC61DA4
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Feb 2023 00:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjBCAeg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 2 Feb 2023 19:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBCAeg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Feb 2023 19:34:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B343E2312B
        for <fstests@vger.kernel.org>; Thu,  2 Feb 2023 16:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675384405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+SToU2R/yoPCN2ZoFi+iD0TCH5/I9Qz8RJhRrBbHgqE=;
        b=U32LWQvf7fsCvLwi+OU2lU4s5SEXjb5HFmUeCeMsZ3cBvBfckbZhziwPkjfV2PBLjgnsdU
        XUzUCBu0Wsrq19/WWJx90v9WDqsZuTCcUbre6s+cJS7AA7PmdezuUngKweLTbi5K771UBQ
        IwebaU4x09cnG7kPaye7wPo7bt7sbOA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-zLbpbwy6N7mRQx9UZ4OCFA-1; Thu, 02 Feb 2023 19:33:22 -0500
X-MC-Unique: zLbpbwy6N7mRQx9UZ4OCFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4928285A5B1;
        Fri,  3 Feb 2023 00:33:22 +0000 (UTC)
Received: from redhat.com (unknown [10.22.16.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 212CF404CD80;
        Fri,  3 Feb 2023 00:33:22 +0000 (UTC)
Date:   Thu, 2 Feb 2023 18:33:20 -0600
From:   Bill O'Donnell <billodo@redhat.com>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/191: fix xattr leaf block emptying on 64k blocksized
 fses
Message-ID: <Y9xWUG7G5eDsLlL/@redhat.com>
References: <20230202210940.95791-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202210940.95791-1-ailiop@suse.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

On my ppc64le box, this patch fixes the problem nicely. Thanks!

Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

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
> +	if [ $dbsize -eq 65536 ]; then
> +		firstused=0;
> +	else
> +		firstused=$dbsize;
> +	fi
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

