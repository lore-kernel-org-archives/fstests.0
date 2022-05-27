Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3861C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 27 May 2022 14:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353279AbiE0Oy7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 27 May 2022 10:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353337AbiE0Oy6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 May 2022 10:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B7CA140412
        for <fstests@vger.kernel.org>; Fri, 27 May 2022 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653663296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a3KQTNTent3DuSGsndELTjpAZfYQxl6ufSTMKVi760A=;
        b=e5hMtROA3vg27tlEwiURGyhnBU9Kn7+c5pt1KhHO5HEHx8jfR/NzVftF3xg+INTKx90RUh
        TztZj5OMInTCNZcIrWXQI3qII7nMewq6wsquXw2PKRQK44hu/XTyVlDDeSrI/wkAiIt+U5
        2TzK1JXUuXflkVnFcOUFYu3kD4utfuI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-Dnqnb4bTPu-z0WZy-vMebQ-1; Fri, 27 May 2022 10:54:54 -0400
X-MC-Unique: Dnqnb4bTPu-z0WZy-vMebQ-1
Received: by mail-ot1-f69.google.com with SMTP id 104-20020a9d0bf1000000b0060aee3fc1a9so1647007oth.19
        for <fstests@vger.kernel.org>; Fri, 27 May 2022 07:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a3KQTNTent3DuSGsndELTjpAZfYQxl6ufSTMKVi760A=;
        b=AJ6gU2Bb86fHNjQuhVDGoXsssRVfgdH96y/puTWWTQQs5bdDQbTuGS7feheJkz2MRA
         xGPlNDZo3quqbPW4ZHfn4anRRF9mvEZaN52MvKFU2Cs2sQY1Dub6HU57rsUhVezx3aUa
         C65BGLk3Hf1Px4eGXIKX5SfWZEKFvIa39T8qpK3DJi69RG3pqNNIH18ZOXgi+3iu+kX7
         KxBJV2AsJoEH61LqYDgKoEhvYf385bTMPuOAOJudJPbiwHwz1ulPIaOgfzbRAHv5L8lY
         DfrRI2XRulS8xXicqLS8DOnI5DYcoMb4RmoNBkXD36A5HKUp2E1gKxge/iJFqRK5w73C
         X9PQ==
X-Gm-Message-State: AOAM5323j7iKkTFbULadKHUDvlWFq0XU0evRw7fAkPRbEUH8WW1EOn5q
        cYbc60bqTnNFMfBiEq8EbtOBc4TTF4cEpNoBjgayQ7LBIVzPuqeIJWK5n7i1YJpVfjvsA7K9ghA
        Gk5q88slxeQcnJK8MJQ==
X-Received: by 2002:a05:6808:13d0:b0:32b:d458:4979 with SMTP id d16-20020a05680813d000b0032bd4584979mr1631132oiw.72.1653663292112;
        Fri, 27 May 2022 07:54:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwj1Of9TE63QeyJoCpqDqE/Gilr8xSEAED6JHKHY08lNcHQK8BJwDF1EmQWiRbQLWiTfmNERA==
X-Received: by 2002:a05:6808:13d0:b0:32b:d458:4979 with SMTP id d16-20020a05680813d000b0032bd4584979mr1631125oiw.72.1653663291850;
        Fri, 27 May 2022 07:54:51 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bk40-20020a0568081a2800b0032b7a0c5da1sm1933519oib.27.2022.05.27.07.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 07:54:51 -0700 (PDT)
Date:   Fri, 27 May 2022 22:54:45 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH 01/10] btrfs: add a helpers for read repair testing
Message-ID: <20220527145445.fyrp3anncqdxb7sl@zlang-mailbox>
References: <20220527081915.2024853-1-hch@lst.de>
 <20220527081915.2024853-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527081915.2024853-2-hch@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 27, 2022 at 10:19:06AM +0200, Christoph Hellwig wrote:
> Add a few helpers to consolidate code for btrfs read repair testing:
> 
>  - _btrfs_get_first_logical() gets the btrfs logical address for the
>    first extent in a file
>  - _btrfs_get_device_path and _btrfs_get_physical use the
>    btrfs-map-logical tool to find the device path and physical address
>    for btrfs logical address for a specific mirror
>  - _btrfs_direct_read_on_mirror and _btrfs_buffered_read_on_mirror
>    read the data from a specific mirror
> 
> These will be used to consolidate the read repair tests and avoid
> duplication for new tests.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/btrfs  | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  common/config |  1 +
>  2 files changed, 76 insertions(+)
> 
> diff --git a/common/btrfs b/common/btrfs
> index ac597ca4..b69feeee 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -505,3 +505,78 @@ _btrfs_metadump()
>  	$BTRFS_IMAGE_PROG "$device" "$dumpfile"
>  	[ -n "$DUMP_COMPRESSOR" ] && $DUMP_COMPRESSOR -f "$dumpfile" &> /dev/null
>  }
> +
> +# Return the btrfs logical address for the first block in a file
> +_btrfs_get_first_logical()
> +{
> +	local file=$1
> +	_require_command "$FILEFRAG_PROG" filefrag
> +
> +	${FILEFRAG_PROG} -v $SCRATCH_MNT/foobar >> $seqres.full
                              ^^
                            $file

You can send a single fixed patch for this one

Thanks,
Zorro

> +	${FILEFRAG_PROG} -v $file | _filter_filefrag | cut -d '#' -f 1
> +}
> +
> +# Find the device path for a btrfs logical offset
> +_btrfs_get_device_path()
> +{
> +	local logical=$1
> +	local stripe=$2
> +
> +	_require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
> +
> +	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
> +		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$8 }"
> +}
> +
> +
> +# Find the device physical sector for a btrfs logical offset
> +_btrfs_get_physical()
> +{
> +	local logical=$1
> +	local stripe=$2
> +
> +	_require_command "$BTRFS_MAP_LOGICAL_PROG" btrfs-map-logical
> +
> +	$BTRFS_MAP_LOGICAL_PROG -b -l $logical $SCRATCH_DEV >> $seqres.full 2>&1
> +	$BTRFS_MAP_LOGICAL_PROG -l $logical $SCRATCH_DEV | \
> +		$AWK_PROG "(\$1 ~ /mirror/ && \$2 ~ /$stripe/) { print \$6 }"
> +}
> +
> +# Read from a specific stripe to test read recovery that corrupted a specific
> +# stripe.  Btrfs uses the PID to select the mirror, so keep reading until the
> +# xfs_io process that performed the read was executed with a PID that ends up
> +# on the intended mirror.
> +_btrfs_direct_read_on_mirror()
> +{
> +	local mirror=$1
> +	local nr_mirrors=$2
> +	local file=$3
> +	local offset=$4
> +	local size=$5
> +
> +	while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
> +		exec $XFS_IO_PROG -d \
> +			-c "pread -b $size $offset $size" $file) ]]; do
> +		:
> +	done
> +}
> +
> +# Read from a specific stripe to test read recovery that corrupted a specific
> +# stripe.  Btrfs uses the PID to select the mirror, so keep reading until the
> +# xfs_io process that performed the read was executed with a PID that ends up
> +# on the intended mirror.
> +_btrfs_buffered_read_on_mirror()
> +{
> +	local mirror=$1
> +	local nr_mirrors=$2
> +	local file=$3
> +	local offset=$4
> +	local size=$5
> +
> +	echo 3 > /proc/sys/vm/drop_caches
> +	while [[ -z $( (( BASHPID % nr_mirrors == mirror )) &&
> +		exec $XFS_IO_PROG \
> +			-c "pread -b $size $offset $size" $file) ]]; do
> +		:
> +	done
> +}
> diff --git a/common/config b/common/config
> index c6428f90..df20afc1 100644
> --- a/common/config
> +++ b/common/config
> @@ -228,6 +228,7 @@ export E2IMAGE_PROG="$(type -P e2image)"
>  export BLKZONE_PROG="$(type -P blkzone)"
>  export GZIP_PROG="$(type -P gzip)"
>  export BTRFS_IMAGE_PROG="$(type -P btrfs-image)"
> +export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
>  
>  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
>  # newer systems have udevadm command but older systems like RHEL5 don't.
> -- 
> 2.30.2
> 

