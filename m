Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044A5C54EED
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Jan 2023 17:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbjA3RTJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Jan 2023 12:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbjA3RSy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Jan 2023 12:18:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661F22F7BE
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2023 09:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675099088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CdFNcsfDEYS5tTq8lCJfmIeeOHHsyKjGcXyukBwUxe4=;
        b=Xv7vSwGbxV3FIAIXxLwQRPlfhYCToYVrPWgIpHXVT8ml7bJ/1jMQLyV2AjFUmOTmDufhyC
        Cz6/BiGoqYiUg0nrblemmHNvq12+nldYt8B/pz/1Bn5Z4HjaWs0zvlhV3BuN38fvQ+tWWL
        UwCgwL9od5EIioQx3Wvx6JTYTmoNPG8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-561-a3Ui_DmpNBGbu-CHsIY2gQ-1; Mon, 30 Jan 2023 12:18:07 -0500
X-MC-Unique: a3Ui_DmpNBGbu-CHsIY2gQ-1
Received: by mail-pl1-f197.google.com with SMTP id m7-20020a170902db0700b00194bd3c810aso6942684plx.23
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2023 09:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdFNcsfDEYS5tTq8lCJfmIeeOHHsyKjGcXyukBwUxe4=;
        b=M9PMa3qMGtv0du/3qjvn9EZ1XRU+hWPMvfZojiJXzpDeDqoly4UA97PxuHgWBB+yRz
         kLqMb65a6GEKjR+woSM4sxxJn/AsFrJfnrw3dJX4Qg7IxED/dTqQPYe1ix698smXdtsb
         R42Ba8BkRhZDWRuYr4tO1LmXbC6JE4G2Ccy2hqLDUrnvDZHBFNFz4pX+qENkx5Ufp1d2
         C+L16dCALEVbIR4T0B+sFyYdbXZnc3BiKwRyxG/sM4OQRXbg0kFBlWD7/AOSthDBGyhy
         C/vWTvoOpq9yKKkxJcUWT9f18gpFCF3FW934h+eWpvZMjjE1wE+h3lO7ZvQeGZlu8+rk
         sC3Q==
X-Gm-Message-State: AO0yUKUfKLsYV52DJAgX45kZ7MtyQ9Xt1YQt1Sv5EZnfIYCo48LbKQ8E
        /Y4iUP2xKPyuVWevTXj2keh2sSmFoi7oc3ldSdHeoszF5zTPLZLUsWGS/wIhr2+iGieB4un9aV0
        2qLhvHmTTxNRW2d2exw==
X-Received: by 2002:a05:6a20:3c9f:b0:bd:f7a:ef06 with SMTP id b31-20020a056a203c9f00b000bd0f7aef06mr5339580pzj.47.1675099085595;
        Mon, 30 Jan 2023 09:18:05 -0800 (PST)
X-Google-Smtp-Source: AK7set95SZ+VjJLB/l/hP5yjixqjezd3trOuuOcnbhCocQp2kI4BHGBXdYTV28+4YWdtmms+ihnB/Q==
X-Received: by 2002:a05:6a20:3c9f:b0:bd:f7a:ef06 with SMTP id b31-20020a056a203c9f00b000bd0f7aef06mr5339553pzj.47.1675099085203;
        Mon, 30 Jan 2023 09:18:05 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id v15-20020a63bf0f000000b0047917991e83sm7038045pgf.48.2023.01.30.09.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 09:18:04 -0800 (PST)
Date:   Tue, 31 Jan 2023 01:18:00 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Hironori Shiina <shiina.hironori@gmail.com>
Cc:     fstests@vger.kernel.org,
        Hironori Shiina <shiina.hironori@fujitsu.com>
Subject: Re: [PATCH v2 1/2] xfs: add helper to create fake root inode
Message-ID: <20230130171800.dohjcyghqycvbppm@zlang-mailbox>
References: <20230112222242.153502-1-shiina.hironori@fujitsu.com>
 <20230112222242.153502-2-shiina.hironori@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112222242.153502-2-shiina.hironori@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 12, 2023 at 05:22:41PM -0500, Hironori Shiina wrote:
> xfsdump used to cause a problem when there is an inode whose number is
> lower than the root inode number. This patch adds a helper function to
> reproduce such a situation for regression tests.
> 
> Signed-off-by: Hironori Shiina <shiina.hironori@fujitsu.com>
> ---
>  common/xfs    | 38 ++++++++++++++++++++++++++++++++++++++
>  tests/xfs/545 | 31 ++++---------------------------
>  tests/xfs/554 | 35 ++++++-----------------------------
>  tests/xfs/557 | 31 ++++---------------------------
>  4 files changed, 52 insertions(+), 83 deletions(-)
> 
> diff --git a/common/xfs b/common/xfs
> index 7eee76c0..745d48d1 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -1547,3 +1547,41 @@ _xfs_get_inode_core_bytes()
>  		echo 96
>  	fi
>  }
> +
> +# Create a file with a lower inode number than the root inode number. For this
> +# creation, this function runs mkfs and mount on the scratch device with
> +# options. This function prints the root inode number and the created inode
> +# number.
> +_xfs_create_fake_root()

If this function only work for SCRATCH_DEV, better to use "_scratch_" prefix,
e.g. _scratch_xfs_create_fake_root()

> +{
> +	local root_inum
> +	local inum
> +
> +	# A large stripe unit will put the root inode out quite far
> +	# due to alignment, leaving free blocks ahead of it.
> +	_scratch_mkfs_xfs -d sunit=1024,swidth=1024 > $seqres.full 2>&1 || _fail "mkfs failed"
> +
> +	# Mounting /without/ a stripe should allow inodes to be allocated
> +	# in lower free blocks, without the stripe alignment.
> +	_scratch_mount -o sunit=0,swidth=0
> +
> +	local root_inum=$(stat -c %i $SCRATCH_MNT)
> +
> +	# Consume space after the root inode so that the blocks before
> +	# root look "close" for the next inode chunk allocation
> +	$XFS_IO_PROG -f -c "falloc 0 16m" $SCRATCH_MNT/fillfile
> +
> +	# And make a bunch of inodes until we (hopefully) get one lower
> +	# than root, in a new inode chunk.
> +	echo "root_inum: $root_inum" >> $seqres.full
> +	for i in $(seq 0 4096) ; do
> +		fname=$SCRATCH_MNT/$(printf "FILE_%03d" $i)
> +		touch $fname
> +		inum=$(stat -c "%i" $fname)
> +		[[ $inum -lt $root_inum ]] && break
> +	done
> +
> +	echo "created: $inum" >> $seqres.full
> +
> +	echo "$root_inum $inum"

This function might fail to get fake root, right? If it fails, as a common
helper, I think it should _fail or _notrun(?) or return something to tell
the caller.

> +}
> diff --git a/tests/xfs/545 b/tests/xfs/545
> index ccb0dd6c..83785155 100755
> --- a/tests/xfs/545
> +++ b/tests/xfs/545
> @@ -17,33 +17,10 @@ _supported_fs xfs
>  _require_xfs_io_command "falloc"
>  _require_scratch
>  
> -# A large stripe unit will put the root inode out quite far
> -# due to alignment, leaving free blocks ahead of it.
> -_scratch_mkfs_xfs -d sunit=1024,swidth=1024 > $seqres.full 2>&1
> -
> -# Mounting /without/ a stripe should allow inodes to be allocated
> -# in lower free blocks, without the stripe alignment.
> -_scratch_mount -o sunit=0,swidth=0
> -
> -root_inum=$(stat -c %i $SCRATCH_MNT)
> -
> -# Consume space after the root inode so that the blocks before
> -# root look "close" for the next inode chunk allocation
> -$XFS_IO_PROG -f -c "falloc 0 16m" $SCRATCH_MNT/fillfile
> -
> -# And make a bunch of inodes until we (hopefully) get one lower
> -# than root, in a new inode chunk.
> -echo "root_inum: $root_inum" >> $seqres.full
> -for i in $(seq 0 4096) ; do
> -	fname=$SCRATCH_MNT/$(printf "FILE_%03d" $i)
> -	touch $fname
> -	inum=$(stat -c "%i" $fname)
> -	[[ $inum -lt $root_inum ]] && break
> -done
> -
> -echo "created: $inum" >> $seqres.full
> -
> -[[ $inum -lt $root_inum ]] || _notrun "Could not set up test"
> +# Create a filesystem which contains a fake root inode
> +inums=($(_xfs_create_fake_root))
> +root_inum=${inums[0]}
> +fake_inum=${inums[1]}
>  
>  # Now try a dump and restore. Cribbed from xfs/068
>  _create_dumpdir_stress
> diff --git a/tests/xfs/554 b/tests/xfs/554
> index 65084cb3..22ce7e28 100755
> --- a/tests/xfs/554
> +++ b/tests/xfs/554
> @@ -21,33 +21,10 @@ _require_xfs_io_command "falloc"
>  _require_scratch
>  _require_xfsrestore_xflag
>  
> -# A large stripe unit will put the root inode out quite far
> -# due to alignment, leaving free blocks ahead of it.
> -_scratch_mkfs_xfs -d sunit=1024,swidth=1024 > $seqres.full 2>&1 || _fail "mkfs failed"
> -
> -# Mounting /without/ a stripe should allow inodes to be allocated
> -# in lower free blocks, without the stripe alignment.
> -_scratch_mount -o sunit=0,swidth=0
> -
> -root_inum=$(stat -c %i $SCRATCH_MNT)
> -
> -# Consume space after the root inode so that the blocks before
> -# root look "close" for the next inode chunk allocation
> -$XFS_IO_PROG -f -c "falloc 0 16m" $SCRATCH_MNT/fillfile
> -
> -# And make a bunch of inodes until we (hopefully) get one lower
> -# than root, in a new inode chunk.
> -echo "root_inum: $root_inum" >> $seqres.full
> -for i in $(seq 0 4096) ; do
> -	fname=$SCRATCH_MNT/$(printf "FILE_%03d" $i)
> -	touch $fname
> -	inum=$(stat -c "%i" $fname)
> -	[[ $inum -lt $root_inum ]] && break
> -done
> -
> -echo "created: $inum" >> $seqres.full
> -
> -[[ $inum -lt $root_inum ]] || _notrun "Could not set up test"
> +# Create a filesystem which contains a fake root inode
> +inums=($(_xfs_create_fake_root))
> +root_inum=${inums[0]}
> +fake_inum=${inums[1]}
>  
>  # Now try a dump and restore. Cribbed from xfs/068
>  _create_dumpdir_stress
> @@ -59,10 +36,10 @@ _do_dump_file
>  
>  # Set the wrong root inode number to the dump file
>  # as problematic xfsdump used to do.
> -$here/src/fake-dump-rootino $dump_file $inum
> +$here/src/fake-dump-rootino $dump_file $fake_inum
>  
>  _do_restore_file -x | \
> -sed -e "s/rootino #${inum}/rootino #FAKENO/g" \
> +sed -e "s/rootino #${fake_inum}/rootino #FAKENO/g" \
>  	-e "s/# to ${root_inum}/# to ROOTNO/g" \
>  	-e "/entries processed$/s/[0-9][0-9]*/NUM/g"
>  
> diff --git a/tests/xfs/557 b/tests/xfs/557
> index 425695db..e1de919b 100644
> --- a/tests/xfs/557
> +++ b/tests/xfs/557
> @@ -21,33 +21,10 @@ _require_scratch
>  _fixed_by_kernel_commit XXXXXXXXXXXX \
>  	"xfs: get root inode correctly at bulkstat"
>  
> -# A large stripe unit will put the root inode out quite far
> -# due to alignment, leaving free blocks ahead of it.
> -_scratch_mkfs_xfs -d sunit=1024,swidth=1024 > $seqres.full 2>&1 || _fail "mkfs failed"
> -
> -# Mounting /without/ a stripe should allow inodes to be allocated
> -# in lower free blocks, without the stripe alignment.
> -_scratch_mount -o sunit=0,swidth=0
> -
> -root_inum=$(stat -c %i $SCRATCH_MNT)
> -
> -# Consume space after the root inode so that the blocks before
> -# root look "close" for the next inode chunk allocation
> -$XFS_IO_PROG -f -c "falloc 0 16m" $SCRATCH_MNT/fillfile
> -
> -# And make a bunch of inodes until we (hopefully) get one lower
> -# than root, in a new inode chunk.
> -echo "root_inum: $root_inum" >> $seqres.full
> -for i in $(seq 0 4096) ; do
> -	fname=$SCRATCH_MNT/$(printf "FILE_%03d" $i)
> -	touch $fname
> -	inum=$(stat -c "%i" $fname)
> -	[[ $inum -lt $root_inum ]] && break
> -done
> -
> -echo "created: $inum" >> $seqres.full
> -
> -[[ $inum -lt $root_inum ]] || _notrun "Could not set up test"
> +# Create a filesystem which contains a fake root inode
> +inums=($(_xfs_create_fake_root))
> +root_inum=${inums[0]}
> +fake_inum=${inums[1]}
>  
>  # Get root ino with XFS_BULK_IREQ_SPECIAL_ROOT
>  bulkstat_root_inum=$($XFS_IO_PROG -c 'bulkstat_single root' $SCRATCH_MNT | grep bs_ino | awk '{print $3;}')
> -- 
> 2.39.0
> 

