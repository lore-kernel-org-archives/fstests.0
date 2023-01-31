Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80087C38142
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Jan 2023 14:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjAaOL6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Jan 2023 09:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjAaOL6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Jan 2023 09:11:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D1351439
        for <fstests@vger.kernel.org>; Tue, 31 Jan 2023 06:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675174273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nt8Rayd1JmbOhP27TrepiiJ8oyJEnbWMbzfSlJKda4k=;
        b=iPw71IzsCQeskf7w62m1qiy7vKlifulMIKQTVb+tcPxPDUhP8bXKaQ8j93Ae3owZ6H972R
        JoLTJ/FdA162rHkeiujD1VCJC8AWoC5dU+FCNU/EmzR3vajaRdw8mf74jjo1aGP7VibM0r
        mencOaicut5pv0IY9NEcn7etvDX8HFE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-548-lnQodcXOOH6V8V-vQVfKIQ-1; Tue, 31 Jan 2023 09:11:09 -0500
X-MC-Unique: lnQodcXOOH6V8V-vQVfKIQ-1
Received: by mail-pf1-f199.google.com with SMTP id v23-20020aa78097000000b005748c087db1so7188289pff.2
        for <fstests@vger.kernel.org>; Tue, 31 Jan 2023 06:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nt8Rayd1JmbOhP27TrepiiJ8oyJEnbWMbzfSlJKda4k=;
        b=rVpJMcOC/tV6CfxTFF1tGX0y+IQ0I26B6EwRYZb4rtl42xHIO0qyTrBtXJkCdorwq9
         sSPo6vTYMZ/6+gEBY3cAnO4pXcwUeCVoDxqmZH36rf9gmUWlJyeWP2hdJ/nJrNWW4ekJ
         0UawSezHeLVUxEwMmk4NbhJ5Xq8LpxPBlvsrcXGYLnJcTRjafbPOWwGQAPLYOEleSTXy
         h3I4FZEWsl5EmGDCsaErWjP2PV1vsREOotRqLJ/VxIpVN80j79Q8GKhGM2mP0nsjORZU
         r0/RSgPyDQE9NGAofFkJERTkL6jwHzs9iDrbAwGd8AcRuTOhmTtrImQnV3Qtz7PKSYsI
         sIlw==
X-Gm-Message-State: AO0yUKXZfmJwLMimV+z7lnPJap6KbDAAY92bwEENsDSwspdzPrpwKpne
        i/e6jDA7Ls4ycR9q5R5q02/xplYvZADy3ePPPqZXijgw3u2bKjhdLLUM7kws34u2xqSs9bchsmP
        jF3bXtdQdoK4rNWXxcg==
X-Received: by 2002:a17:90b:17c2:b0:22b:fd64:c48e with SMTP id me2-20020a17090b17c200b0022bfd64c48emr27027893pjb.14.1675174268125;
        Tue, 31 Jan 2023 06:11:08 -0800 (PST)
X-Google-Smtp-Source: AK7set8xgWcQVawtlNdMwOFO3/vuhWxxdDesYHdS0yf+a2omPTztpcTstRAWXG1D2+oC1/rsDcRBBA==
X-Received: by 2002:a17:90b:17c2:b0:22b:fd64:c48e with SMTP id me2-20020a17090b17c200b0022bfd64c48emr27027868pjb.14.1675174267623;
        Tue, 31 Jan 2023 06:11:07 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ep22-20020a17090ae65600b0022c08445e97sm8575864pjb.38.2023.01.31.06.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:11:07 -0800 (PST)
Date:   Tue, 31 Jan 2023 22:11:03 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Hironori Shiina <shiina.hironori@gmail.com>
Cc:     fstests@vger.kernel.org,
        Hironori Shiina <shiina.hironori@fujitsu.com>
Subject: Re: [PATCH v3 1/2] xfs: add helper to create fake root inode
Message-ID: <20230131141103.heidozijnw3tzash@zlang-mailbox>
References: <20230130225643.148935-1-shiina.hironori@fujitsu.com>
 <20230130225643.148935-2-shiina.hironori@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130225643.148935-2-shiina.hironori@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jan 30, 2023 at 05:56:42PM -0500, Hironori Shiina wrote:
> xfsdump used to cause a problem when there is an inode whose number is
> lower than the root inode number. This patch adds a helper function to
> reproduce such a situation for regression tests.
> 
> Signed-off-by: Hironori Shiina <shiina.hironori@fujitsu.com>
> ---

This version looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/xfs    | 40 ++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/545 | 31 ++++---------------------------
>  tests/xfs/554 | 35 ++++++-----------------------------
>  tests/xfs/557 | 31 ++++---------------------------
>  4 files changed, 54 insertions(+), 83 deletions(-)
> 
> diff --git a/common/xfs b/common/xfs
> index a00d90a4..ba59889c 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -1556,3 +1556,43 @@ _xfs_get_inode_core_bytes()
>  		echo 96
>  	fi
>  }
> +
> +# Create a file with a lower inode number than the root inode number. For this
> +# creation, this function runs mkfs and mount on the scratch device with
> +# options. This function prints the root inode number and the created inode
> +# number.
> +_scratch_xfs_create_fake_root()
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
> +	[[ $inum -lt $root_inum ]] || _notrun "Could not set up test"
> +
> +	echo "$root_inum $inum"
> +}
> diff --git a/tests/xfs/545 b/tests/xfs/545
> index ccb0dd6c..57a650ac 100755
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
> +inums=($(_scratch_xfs_create_fake_root))
> +root_inum=${inums[0]}
> +fake_inum=${inums[1]}
>  
>  # Now try a dump and restore. Cribbed from xfs/068
>  _create_dumpdir_stress
> diff --git a/tests/xfs/554 b/tests/xfs/554
> index 65084cb3..16fc052c 100755
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
> +inums=($(_scratch_xfs_create_fake_root))
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
> index 425695db..522c4f06 100644
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
> +inums=($(_scratch_xfs_create_fake_root))
> +root_inum=${inums[0]}
> +fake_inum=${inums[1]}
>  
>  # Get root ino with XFS_BULK_IREQ_SPECIAL_ROOT
>  bulkstat_root_inum=$($XFS_IO_PROG -c 'bulkstat_single root' $SCRATCH_MNT | grep bs_ino | awk '{print $3;}')
> -- 
> 2.39.1
> 

