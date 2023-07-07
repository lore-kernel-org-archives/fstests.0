Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5CAEB64DA
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Jul 2023 13:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbjGGNrj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jul 2023 09:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjGGNri (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jul 2023 09:47:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69918210C
        for <fstests@vger.kernel.org>; Fri,  7 Jul 2023 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688737610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nPGVUIcC1qJJ1XaHj0mfy4Zxe9fOQlDgv6/wUBzenA8=;
        b=Yardust9uBDJpsx82M/zfpdnTln46JxPgI/FlIha8iT0K3zvosMy11PX5ywdcArDdLOr1I
        XNuqVFt4yi+vdET4JyAAQIYhxvfdgDL+2fSL8ypUv71s5j/Ik14vWlhbyZQXb7g0+Zw0yx
        2MLH6tm1mnBZBfV6/Vid0ibqtxFywKs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-95cDkAvFPt2NLsp101sLew-1; Fri, 07 Jul 2023 09:46:49 -0400
X-MC-Unique: 95cDkAvFPt2NLsp101sLew-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1b890ca6718so21532435ad.0
        for <fstests@vger.kernel.org>; Fri, 07 Jul 2023 06:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688737608; x=1691329608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPGVUIcC1qJJ1XaHj0mfy4Zxe9fOQlDgv6/wUBzenA8=;
        b=A2d+kfDm5+hHdXj19hksPS3skTh4qbGnroq8i8UvRVx2lIkg9kKxvp072dAKnuYQ0N
         5H95nqsNX9uNm1F0yfhYzUZdx7kbtOLWVWcXkL2NHQAdKW8PYFkfDCQGEzwQ3uxTlNrw
         KrRu6bvOJwJTxA/7XuLqIRAe12an1Go/y+qhCPREs0pAZEeBJwoTi5scdVMeqTTpk+pG
         G12fvPKBdRXmehXWXyZLg8inp2+fLsYXUeN4IpA35JHBvNLLGDlo8sc+vmUNMwpNOjYH
         3x6N6ZHKiBIHrXjm+mDb2UuyMbrBqKESCjWcFtS3Yg0hJLZNulcNqX7Hyz/frWnGD6wC
         V+Tw==
X-Gm-Message-State: ABy/qLaKfed/etoJ+BhaSluS/6Akq93I3fsI8VXYxw9w3sDcGl1OE4WF
        mK1mryOvHIBh8XyNRzcdFwU3TSM/6zLA3p+BT8lTH9N1538zyDmNOmrywuGb3Khx91NHfku4zND
        llRcokYsY5U1SPr6RZgyYmR5lX5iPaPs=
X-Received: by 2002:a17:903:22cc:b0:1b8:9b1b:ae8e with SMTP id y12-20020a17090322cc00b001b89b1bae8emr4846555plg.59.1688737608029;
        Fri, 07 Jul 2023 06:46:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHy7O2+rHT5JyTOtm5gRhpi9OL5d7AU9Ejz4a03noCaSdwRPQrr1k+WX0bwu5fvNDgiDQQ1/Q==
X-Received: by 2002:a17:903:22cc:b0:1b8:9b1b:ae8e with SMTP id y12-20020a17090322cc00b001b89b1bae8emr4846541plg.59.1688737607684;
        Fri, 07 Jul 2023 06:46:47 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709027c1800b001b9be79729csm1665030pll.165.2023.07.07.06.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:46:47 -0700 (PDT)
Date:   Fri, 7 Jul 2023 21:46:43 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] common/btrfs: handle dmdust as mounted device in
 _btrfs_buffered_read_on_mirror()
Message-ID: <20230707134643.vysagmfx4gxk6jrj@zlang-mailbox>
References: <20230629001010.36235-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629001010.36235-1-wqu@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jun 29, 2023 at 08:10:10AM +0800, Qu Wenruo wrote:
> [BUG]
> After commit ab41f0bddb73 ("common/btrfs: use _scratch_cycle_mount to
> ensure all page caches are dropped"), the test case btrfs/143 can fail
> like below:
> 
>  btrfs/143 6s ... [failed, exit status 1]- output mismatch (see ~/xfstests/results//btrfs/143.out.bad)
>     --- tests/btrfs/143.out 2020-06-10 19:29:03.818519162 +0100
>     +++ ~/xfstests/results//btrfs/143.out.bad 2023-06-19 17:04:00.575033899 +0100
>     @@ -1,37 +1,6 @@
>      QA output created by 143
>      wrote 131072/131072 bytes
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
>     -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
> ................
> 
> [CAUSE]
> Test case btrfs/143 uses dm-dust device to emulate read errors, this
> means we can not use _scratch_cycle_mount to cycle mount $SCRATCH_MNT.
> 
> As it would go mount $SCRATCH_DEV, not the dm-dust device to
> $SCRATCH_MNT.
> This prevents us to trigger read-repair (since no error would be hit)
> thus fail the test.
> 
> [FIX]
> Since we can mount whatever device at $SCRATCH_MNT, we can not use
> _scratch_cycle_mount in this case.
> 
> Instead implement a small helper to grab the mounted device and its
> mount options, and use the same device and mount options to cycle
> $SCRATCH_MNT mount.
> 
> This would fix btrfs/143 and hopefully future test cases which use dm
> devices.
> 
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Use findmnt command to grab mount options and source device
> ---

This version looks good to me. Although the "_mount $dev -o $opts $SCRATCH_MNT"
is a little odd, but as this's a btrfs only helper, so I think it's fine for
btrfs at least.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/btrfs | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 175b33ae..0fec093d 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -601,8 +601,17 @@ _btrfs_buffered_read_on_mirror()
>  	# The drop_caches doesn't seem to drop every pages on aarch64 with
>  	# 64K page size.
>  	# So here as another workaround, cycle mount the SCRATCH_MNT to ensure
> -	# the cache are dropped.
> -	_scratch_cycle_mount
> +	# the cache are dropped, but we can not use _scratch_cycle_mount, as
> +	# we may mount whatever dm device at SCRATCH_MNT.
> +	# So here we grab the mounted block device and its mount options, then
> +	# unmount and re-mount with the same device and options.
> +	local dev=$(findmnt -n -T $SCRATCH_MNT -o SOURCE)
> +	local opts=$(findmnt -n -T $SCRATCH_MNT -o OPTIONS)
> +	if [ -z "$dev" -o -z "$opts" ]; then
> +		_fail "failed to grab mount info of $SCRATCH_MNT"
> +	fi
> +	_scratch_unmount
> +	_mount $dev -o $opts $SCRATCH_MNT
>  	while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
>  		exec $XFS_IO_PROG \
>  			-c "pread -b $size $offset $size" $file) ]]; do
> -- 
> 2.39.0
> 

