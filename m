Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90CDC77B7F
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Apr 2023 14:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241402AbjDZObP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbjDZObN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2023 10:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283686E8F
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682519422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rCnoY4aWqZ4VhtkdJptemm7GP2eAZjpgtlDsGlJCvGw=;
        b=Ey1oysgm7sMxxaQUjQllEbV0eWsGVjOc8I1MSFPsQPRQlR5/1ujbUkAc4LCHLHLg9G+/UB
        hSEr9whLm3hn9zPDgKFJetwnOCff6euR1A/aQruzBBqJ/ocjp9COwofaruo3VRxmPoQFB9
        yOZHjDN3i+BgBhHrz+z/ZdbyB+sObFI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-VSKXmVw8Mz-YvZJ2lhUMiQ-1; Wed, 26 Apr 2023 10:30:18 -0400
X-MC-Unique: VSKXmVw8Mz-YvZJ2lhUMiQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1a697b1a71aso78531655ad.1
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 07:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682519417; x=1685111417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCnoY4aWqZ4VhtkdJptemm7GP2eAZjpgtlDsGlJCvGw=;
        b=eU+/aPqT/pYnKph1r5XzsIgPREmZHjCghBauyTIpNMdFlOIc74r2HATTJyIcrcGxkK
         9PQX0LaHE/KcqpO3kHwsa+xCZZBYa9A24BAKt0nDjLhNvAjzrsdiiqXjDAh4R9HpSd/A
         BKPzGKA1jlkfOZBaxxabvnLjCEPg0qyOwIb4hI08O2DHwBInSzxxmxMwgstiGq4nF5vu
         o+/o46cNQ69l3QZZC5yhKgKm9jodWl3OgjnwzP6L9TxWouKd5yqjJbO7OhZFVQzqA3Xv
         vHWWOFiFgFVjdn1pf1clMsCP6bX8hcENJcdLKx+ZMw04ne/PDNVq/NHL6tvgZd7pCTOp
         Ge6Q==
X-Gm-Message-State: AAQBX9fnZyeUyzrhcxD5pyu1UwT+HN1Jy7Jr8o/5OQ4ONv2hhIddebAa
        Z9jynJOyiHgWzj2O3rU/ucY5kVyabeCbla9NpgO+4gEHLatO7n1LtXhi2beDPEN9A1wbwzhhWFF
        CFDO1ZGN/ySdFo8BJjw==
X-Received: by 2002:a17:902:d484:b0:1a9:712d:18b5 with SMTP id c4-20020a170902d48400b001a9712d18b5mr13156398plg.67.1682519417039;
        Wed, 26 Apr 2023 07:30:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350agpgKXRbmSXoGTH341smZ4pK76DfcDAa3DV/3VAvl2eKjI+p3Pn+0LVXN3A12CuNx8PMGVJg==
X-Received: by 2002:a17:902:d484:b0:1a9:712d:18b5 with SMTP id c4-20020a170902d48400b001a9712d18b5mr13156351plg.67.1682519416474;
        Wed, 26 Apr 2023 07:30:16 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902778400b001a2135e7eabsm10044035pll.16.2023.04.26.07.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 07:30:15 -0700 (PDT)
Date:   Wed, 26 Apr 2023 22:30:11 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
        Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v2 1/6] Add AFS support
Message-ID: <20230426143011.lktpz46bytvub6kh@zlang-mailbox>
References: <20230424141042.450535-1-dhowells@redhat.com>
 <20230424141042.450535-2-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424141042.450535-2-dhowells@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 24, 2023 at 03:10:37PM +0100, David Howells wrote:
> Add support for the AFS filesystem.  AFS is a network filesystem and there
> are a number of features it doesn't support.
> 
>  - No mkfs.  (Kind of.  An AFS volume server can be asked to create a new
>    volume, but that's probably best left to AFS-specific test suites.
>    Further, a volume would need to be destroyed before another of the same
>    name could be created; it's not simply a matter of overwriting the old
>    one as it is on a blockdev with a block-based filesystem.)
> 
>  - No fsck.  (Kind of - the server can be asked to salvage a volume, but it
>    may involve taking the server offline).
> 
>  - No richacls.  AFS has its own ACL system.
> 
>  - No atimes.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> ---

Thanks David, to help fstests to support one more fs testing!

>  build/rpm/xfstests.spec.in |  2 +-
>  check                      |  3 ++-
>  common/config              | 15 +++++++++++---
>  common/rc                  | 42 ++++++++++++++++++++++++++++++++------
>  4 files changed, 51 insertions(+), 11 deletions(-)
> 
> diff --git a/build/rpm/xfstests.spec.in b/build/rpm/xfstests.spec.in
> index e0f7c5f9..3dce41ef 100644
> --- a/build/rpm/xfstests.spec.in
> +++ b/build/rpm/xfstests.spec.in

I nearly forget we have this file :-D

If you'd like to update some docs about AFS testing, you can check
README and README.config-sections.

> @@ -17,7 +17,7 @@ Group: System Environment/Base
>  
>  %description
>  The XFS regression test suite.  Also includes some support for
> -acl, attr, udf, and nfs testing.  Contains around 200 specific tests
> +acl, attr, udf, nfs and afs testing.  Contains around 200 specific tests
>  for userspace & kernelspace.
>  
>  %prep
> diff --git a/check b/check
> index 1a58a2b2..d4bb4126 100755
> --- a/check
> +++ b/check
> @@ -57,6 +57,7 @@ usage()
>  
>  check options
>      -nfs		test NFS
> +    -afs		test AFS
>      -glusterfs		test GlusterFS
>      -cifs		test CIFS
>      -9p			test 9p
> @@ -280,7 +281,7 @@ while [ $# -gt 0 ]; do
>  	case "$1" in
>  	-\? | -h | --help) usage ;;
>  
> -	-nfs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
> +	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
>  		FSTYP="${1:1}"
>  		;;
>  	-overlay)
> diff --git a/common/config b/common/config
> index 6c8cb3a5..25fbec14 100644
> --- a/common/config
> +++ b/common/config
> @@ -301,6 +301,7 @@ export BTRFS_TUNE_PROG=$(type -P btrfstune)
>  export BTRFS_CORRUPT_BLOCK_PROG=$(type -P btrfs-corrupt-block)
>  export XFS_FSR_PROG=$(type -P xfs_fsr)
>  export MKFS_NFS_PROG="false"
> +export MKFS_AFS_PROG="false"
>  export MKFS_CIFS_PROG="false"
>  export MKFS_OVERLAY_PROG="false"
>  export MKFS_REISER4_PROG=$(type -P mkfs.reiser4)
> @@ -353,6 +354,9 @@ _common_mount_opts()
>  	nfs)
>  		echo $NFS_MOUNT_OPTIONS
>  		;;
> +	afs)
> +		echo $AFS_MOUNT_OPTIONS
> +		;;
>  	cifs)
>  		echo $CIFS_MOUNT_OPTIONS
>  		;;
> @@ -420,6 +424,9 @@ _mkfs_opts()
>  	nfs)
>  		export MKFS_OPTIONS=$NFS_MKFS_OPTIONS
>  		;;
> +	afs)
> +		export MKFS_OPTIONS=$AFS_MKFS_OPTIONS
> +		;;
>  	cifs)
>  		export MKFS_OPTIONS=$CIFS_MKFS_OPTIONS
>  		;;
> @@ -510,6 +517,8 @@ _source_specific_fs()
>  	nfs)
>  		. ./common/nfs
>  		;;
> +	afs)
> +		;;
>  	cifs)
>  		;;
>  	9p)
> @@ -588,9 +597,9 @@ _check_device()
>  	fi
>  
>  	case "$FSTYP" in
> -	9p|fuse|tmpfs|virtiofs)
> -		# 9p, fuse and virtiofs mount tags are just plain strings, so anything is allowed
> -		# tmpfs doesn't use mount source, ignore
> +	9p|fuse|tmpfs|virtiofs|afs)
> +		# 9p, fuse, virtiofs and afs mount tags are just plain strings,
> +		# so anything is allowed tmpfs doesn't use mount source, ignore
>  		;;
>  	ceph)
>  		# ceph has two different possible syntaxes for mount devices. The
> diff --git a/common/rc b/common/rc
> index 90749343..8b8cb714 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -569,6 +569,9 @@ _test_mkfs()
>      nfs*)
>  	# do nothing for nfs
>  	;;
> +    afs*)
> +	# do nothing for afs
> +	;;
>      cifs)
>  	# do nothing for cifs
>  	;;
> @@ -614,6 +617,9 @@ _try_mkfs_dev()
>      nfs*)
>  	# do nothing for nfs
>  	;;
> +    afs*)
> +	# do nothing for afs
> +	;;
>      9p)
>  	# do nothing for 9p
>  	;;
> @@ -660,7 +666,7 @@ _mkfs_dev()
>      rm -f $tmp.mkfserr $tmp.mkfsstd
>  }
>  
> -# remove all files in $SCRATCH_MNT, useful when testing on NFS/CIFS
> +# remove all files in $SCRATCH_MNT, useful when testing on NFS/AFS/CIFS
>  _scratch_cleanup_files()
>  {
>  	case $FSTYP in
> @@ -688,7 +694,7 @@ _scratch_mkfs()
>  	local mkfs_status
>  
>  	case $FSTYP in
> -	nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|fuse|virtiofs)
> +	nfs*|afs|cifs|ceph|overlay|glusterfs|pvfs2|9p|fuse|virtiofs)
>  		# unable to re-create this fstyp, just remove all files in
>  		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
>  		# created in previous runs
> @@ -1571,7 +1577,7 @@ _check_mounted_on()
>  
>  	if [ -n "$type" -a "`_fs_type $dev`" != "$type" ]; then
>  		echo "$devname=$dev is mounted but not a type $type filesystem"
> -		# raw $DF_PROG cannot handle NFS/CIFS/overlay correctly
> +		# raw $DF_PROG cannot handle NFS/AFS/CIFS/overlay correctly
>  		_df_device $dev
>  		return 3 # 3 = mounted as wrong type
>  	fi
> @@ -1610,6 +1616,15 @@ _require_scratch_nocheck()
>  			_notrun "this test requires a valid \$SCRATCH_MNT"
>  		fi
>  		;;
> +	afs)
> +		echo $SCRATCH_DEV | grep -q "^%" > /dev/null 2>&1

You're the expert of AFS, I'm not familiar with it. Just according to the
documantation of linux (https://docs.kernel.org/filesystems/afs.html), it
says:

  Filesystems can be mounted anywhere by commands similar to the following:

  mount -t afs "%cambridge.redhat.com:root.afs." /afs
  mount -t afs "#cambridge.redhat.com:root.cell." /afs/cambridge
  mount -t afs "#root.afs." /afs
  mount -t afs "#root.cell." /afs/cambridge

So I hope to double check with you if the mount source must be started with
"%" ?

Others looks good to me.

> +		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
> +			_notrun "this test requires a valid \$SCRATCH_DEV"
> +		fi
> +		if [ ! -d "$SCRATCH_MNT" ]; then
> +			_notrun "this test requires a valid \$SCRATCH_MNT"
> +		fi
> +		;;
>  	ceph)
>  		echo $SCRATCH_DEV | grep -qE "=/|:/" > /dev/null 2>&1
>  		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
> @@ -1810,6 +1825,15 @@ _require_test()
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi
>  		;;
> +	afs)
> +		echo $TEST_DEV | grep -q "^%" > /dev/null 2>&1
> +		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
> +			_notrun "this test requires a valid \$TEST_DEV"
> +		fi
> +		if [ ! -d "$TEST_DIR" ]; then
> +			_notrun "this test requires a valid \$TEST_DIR"
> +		fi
> +		;;
>  	ceph)
>  		echo $TEST_DEV | grep -qE "=/|:/" > /dev/null 2>&1
>  		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
> @@ -2923,7 +2947,7 @@ _scratch_mkfs_richacl()
>  		;;
>  	ext4)   _scratch_mkfs -O richacl
>  		;;
> -	nfs*|cifs|overlay)
> +	nfs*|afs|cifs|overlay)
>  		_scratch_mkfs
>  		;;
>  	esac
> @@ -3163,6 +3187,9 @@ _check_test_fs()
>      nfs)
>  	# no way to check consistency for nfs
>  	;;
> +    afs)
> +	# no way to check consistency for afs
> +	;;
>      cifs)
>  	# no way to check consistency for cifs
>  	;;
> @@ -3227,6 +3254,9 @@ _check_scratch_fs()
>      nfs*)
>  	# Don't know how to check an NFS filesystem, yet.
>  	;;
> +    afs*)
> +	# Don't know how to check an AFS filesystem, yet.
> +	;;
>      cifs)
>  	# Don't know how to check a CIFS filesystem, yet.
>  	;;
> @@ -3996,7 +4026,7 @@ _require_atime()
>  {
>  	_exclude_scratch_mount_option "noatime"
>  	case $FSTYP in
> -	nfs|cifs|virtiofs)
> +	nfs|afs|cifs|virtiofs)
>  		_notrun "atime related mount options have no effect on $FSTYP"
>  		;;
>  	esac
> @@ -4532,7 +4562,7 @@ _require_congruent_file_oplen()
>  	local oplen="$2"
>  
>  	case $FSTYP in
> -	nfs*|cifs|9p|virtiofs|ceph|glusterfs|overlay|pvfs2)
> +	nfs*|afs|cifs|9p|virtiofs|ceph|glusterfs|overlay|pvfs2)
>  		# Network filesystems don't know about (or tell the client
>  		# about) the underlying file allocation unit and they generally
>  		# pass the file IO request to the underlying filesystem, so we
> 

