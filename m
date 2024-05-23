Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E989933985
	for <fstests@vger.kernel.org>; Thu, 23 May 2024 04:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716437381; cv=none; b=r0cggyin5Rv6+GMspVQdaACiQfMMsuVnUvwy/CszoonZESDcCTQRpJKl8uBeOjjckmnXkQWRN94F/HeadhL39W6esT7PlHPvQGGG2IuAHmmAdZP1mDLUm9gxYzc0gRXfY7acq8Gqok1oQYz6lli9LaDnlfQ/sO7CN+bMaraNccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716437381; c=relaxed/simple;
	bh=fEU9Pz5+e3oGZc0m4HJin9+LOxIsGRVlKsosANpABro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Upb99mIi4VTafVz4Hho9FIaRQkbyZwy+9UGK8l1uySjcGlNnZ8fedp0FYXbBenGJRx/F2L8fNVsyYDVar8T/cj0DLaL4aQS5L6E0Ep+jSZ5fUv4mCoZOINIOrds2ef/OqrSbx09pJ93PsX5zrCwZDl71opc46NJUl+vLvA4aTR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzGFSSDA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzGFSSDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716437376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BtPgFGc8eiIl/Ozbg97gV0Zo6otA94034erqlMz8hq0=;
	b=fzGFSSDAvFJ0qM2mPBHEl8W1u9ApdNVwZS9plXEvZq+0kLicury7AsXdyn+9bxzJ9myzmq
	r0W0BSFYZddglbrGqlOwOfRO1RuqtBYxTb4PioDpxGkus1OXSuIpTwjAmcB0gH98FMtnNg
	m4uKYIrLXIr1pzsC3KLBIozUiFgiIT4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-gfkE3xl9NXmKbapWcVGTrg-1; Thu, 23 May 2024 00:09:30 -0400
X-MC-Unique: gfkE3xl9NXmKbapWcVGTrg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2bddb8bf80eso411867a91.0
        for <fstests@vger.kernel.org>; Wed, 22 May 2024 21:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716437369; x=1717042169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtPgFGc8eiIl/Ozbg97gV0Zo6otA94034erqlMz8hq0=;
        b=jm20Nl6pfebSFB90q2S+XL8Qc9wUPbJGAOLkAQo1/uVi5QJGlGg5UxJuQ38Hwx33+s
         mJRBl3gViRzMSEM6misWmW8EwX/uukE7C2scWm0t7HAfDptc/xgupoiJT/RChnR/53Ei
         /lNkZF3ptheNh82zDh7SS5tKV2rQd+jnHTQSJC6LAxvNTMF8VJWP8llM9oZiteHJyIrj
         jD6ZgoXeegrj0Dh94dOzu0dg+YUWOY5eSziGvDA7pK6VGcCCv0PTU45Y7/JFYTr+ubQH
         5NCPsLVe7wZrijrAlNHMqfQyTdAcBr8uhZ+LvpL4fZ6qnYnI/usobbzQkuRYUG0VfILH
         q+Ww==
X-Gm-Message-State: AOJu0YxTsVVOnzr2fiaA3SogG2cKjTTBlCDbEtaCIpKez51Wz9gE3Srg
	rmvmwahp6xsHPNW8vPyaQKyr2y1PMHjSwi3jaJmMr4GXEBl4BFTo8b2ns8pFL/t9Xf4DKi7TRwo
	DMHXCyq8C74glWfSWAQGjebsprMUkbsf7nY4VFgGJA3O9hIfsXvh5KSQ=
X-Received: by 2002:a17:90a:4315:b0:2bd:4759:46dd with SMTP id 98e67ed59e1d1-2bd9f59ec18mr4124183a91.37.1716437368513;
        Wed, 22 May 2024 21:09:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+mbKwYUxr5zhrXPiy02K0smKpDIhgU8gyAHtlECtg2abvQj5hWfhW7g1vHl9hE1//nEla8A==
X-Received: by 2002:a17:90a:4315:b0:2bd:4759:46dd with SMTP id 98e67ed59e1d1-2bd9f59ec18mr4124150a91.37.1716437367522;
        Wed, 22 May 2024 21:09:27 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9f2bb87sm588862a91.45.2024.05.22.21.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 21:09:26 -0700 (PDT)
Date: Thu, 23 May 2024 12:09:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] Remove richacl support
Message-ID: <20240523040922.ozy5drxg7w4svrj5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240522173048.30558-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522173048.30558-1-dsterba@suse.com>

On Wed, May 22, 2024 at 07:30:48PM +0200, David Sterba wrote:
> There's no support for richacl in Linux and based on information in the
> links will never be. Remove all related files and support code.
> 
> References:
> - https://wiki.samba.org/index.php/NFS4_ACL_overview#Linux
> - https://lwn.net/Articles/661357/ (article, 2015)
> - https://lwn.net/Articles/661078/ (patches, 2015)
> - https://github.com/andreas-gruenbacher/richacl/
> - http://www.bestbits.at/richacl/ (n/a anymore)
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---

Thanks! The richacl testing was brought in by:

  commit 73f9e47abdc58f39b7e39b3729bc88db624c9771
  Author: Andreas Gruenbacher <agruenba@redhat.com>
  Date:   Tue Jun 28 14:47:26 2016 +0200

      generic: Add richacl tests

Looks like we were too hurry to merge the test things before the kernel
patchset get merged.

Sorry I didn't learn about the details. From above links, I can see how
we tried to implement the richacl, but I didn't see how we denied it and
never have it in the future. Is there any record (e.g. an email reply) to
learn about the "history"?

Thanks,
Zorro

>  common/config         |   2 -
>  common/ext4           |   9 ---
>  common/rc             |  52 ----------------
>  doc/group-names.txt   |   1 -
>  tests/generic/362     |  93 ----------------------------
>  tests/generic/362.out |  94 ----------------------------
>  tests/generic/363     |  86 --------------------------
>  tests/generic/363.out | 139 ------------------------------------------
>  tests/generic/364     |  67 --------------------
>  tests/generic/364.out |  39 ------------
>  tests/generic/365     |  61 ------------------
>  tests/generic/365.out |   9 ---
>  tests/generic/366     |  54 ----------------
>  tests/generic/366.out |  11 ----
>  tests/generic/367     |  53 ----------------
>  tests/generic/367.out |  11 ----
>  tests/generic/368     |  53 ----------------
>  tests/generic/368.out |   7 ---
>  tests/generic/369     |  94 ----------------------------
>  tests/generic/369.out |  24 --------
>  tests/generic/370     |  58 ------------------
>  tests/generic/370.out |  19 ------
>  22 files changed, 1036 deletions(-)
>  delete mode 100755 tests/generic/362
>  delete mode 100644 tests/generic/362.out
>  delete mode 100755 tests/generic/363
>  delete mode 100644 tests/generic/363.out
>  delete mode 100755 tests/generic/364
>  delete mode 100644 tests/generic/364.out
>  delete mode 100755 tests/generic/365
>  delete mode 100644 tests/generic/365.out
>  delete mode 100755 tests/generic/366
>  delete mode 100644 tests/generic/366.out
>  delete mode 100755 tests/generic/367
>  delete mode 100644 tests/generic/367.out
>  delete mode 100755 tests/generic/368
>  delete mode 100644 tests/generic/368.out
>  delete mode 100755 tests/generic/369
>  delete mode 100644 tests/generic/369.out
>  delete mode 100755 tests/generic/370
>  delete mode 100644 tests/generic/370.out
> 
> diff --git a/common/config b/common/config
> index 2114d9360790e7..a1cd14de618349 100644
> --- a/common/config
> +++ b/common/config
> @@ -204,8 +204,6 @@ export LSATTR_PROG="$(type -P lsattr)"
>  export CHATTR_PROG="$(type -P chattr)"
>  export DEBUGFS_PROG="$(type -P debugfs)"
>  export UUIDGEN_PROG="$(type -P uuidgen)"
> -export GETRICHACL_PROG="$(type -P getrichacl)"
> -export SETRICHACL_PROG="$(type -P setrichacl)"
>  export KEYCTL_PROG="$(type -P keyctl)"
>  export XZ_PROG="$(type -P xz)"
>  export LZ4_PROG="$(type -P lz4)"
> diff --git a/common/ext4 b/common/ext4
> index 3dcbfe17c994a6..13921bb8165a4d 100644
> --- a/common/ext4
> +++ b/common/ext4
> @@ -187,15 +187,6 @@ _ext4_disable_extent_zeroout()
>  		echo 0 >/sys/fs/ext4/$sdev/extent_max_zeroout_kb
>  }
>  
> -_require_scratch_richacl_ext4()
> -{
> -	_scratch_mkfs -O richacl >/dev/null 2>&1 \
> -		|| _notrun "can't mkfs $FSTYP with option -O richacl"
> -	_try_scratch_mount >/dev/null 2>&1 \
> -		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
> -	_scratch_unmount
> -}
> -
>  _scratch_ext4_options()
>  {
>  	local type=$1
> diff --git a/common/rc b/common/rc
> index 0fe56382a6a497..c906fc0c817216 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3095,58 +3095,6 @@ _runas()
>  	"$here/src/runas" "$@"
>  }
>  
> -_require_richacl_prog()
> -{
> -	_require_command "$GETRICHACL_PROG" getrichacl
> -	_require_command "$SETRICHACL_PROG" setrichacl
> -}
> -
> -_require_scratch_richacl_xfs()
> -{
> -	_scratch_mkfs_xfs_supported -m richacl=1 >/dev/null 2>&1 \
> -		|| _notrun "mkfs.xfs doesn't have richacl feature"
> -	_scratch_mkfs_xfs -m richacl=1 >/dev/null 2>&1
> -	_try_scratch_mount >/dev/null 2>&1 \
> -		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
> -	_scratch_unmount
> -}
> -
> -_require_scratch_richacl_support()
> -{
> -	_scratch_mount
> -	$GETFATTR_PROG -n system.richacl >/dev/null 2>&1 \
> -		|| _notrun "this test requires richacl support on \$SCRATCH_DEV"
> -	_scratch_unmount
> -}
> -
> -_require_scratch_richacl()
> -{
> -	case "$FSTYP" in
> -	xfs)    _require_scratch_richacl_xfs
> -		;;
> -	ext4)   _require_scratch_richacl_ext4
> -		;;
> -	nfs*|cifs|overlay)
> -		_require_scratch_richacl_support
> -		;;
> -	*)      _notrun "this test requires richacl support on \$SCRATCH_DEV"
> -		;;
> -	esac
> -}
> -
> -_scratch_mkfs_richacl()
> -{
> -	case "$FSTYP" in
> -	xfs)    _scratch_mkfs_xfs -m richacl=1
> -		;;
> -	ext4)   _scratch_mkfs -O richacl
> -		;;
> -	nfs*|afs|cifs|overlay)
> -		_scratch_mkfs
> -		;;
> -	esac
> -}
> -
>  # check if the given device is mounted, if so, return mount point
>  _is_dev_mounted()
>  {
> diff --git a/doc/group-names.txt b/doc/group-names.txt
> index 50262e02f6810d..2c4c31270075d7 100644
> --- a/doc/group-names.txt
> +++ b/doc/group-names.txt
> @@ -106,7 +106,6 @@ repair			xfs_repair functional tests
>  replace			btrfs device replace
>  replay			dm-logwrites replays
>  resize			resize2fs functionality tests
> -richacl			rich ACL feature
>  rmap			XFS reverse mapping exercisers
>  rotate			overlayfs upper layer rotate tests from the unionmount
>  			test suite
> diff --git a/tests/generic/362 b/tests/generic/362
> deleted file mode 100755
> index 6e0e81edfd25af..00000000000000
> --- a/tests/generic/362
> +++ /dev/null
> @@ -1,93 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
> -#
> -# FS QA Test 362
> -#
> -# RichACL apply-masks test
> -#
> -. ./common/preamble
> -_begin_fstest auto quick richacl perms
> -
> -# Import common functions.
> -
> -# real QA test starts here
> -
> -_supported_fs generic
> -
> -_require_scratch
> -_require_scratch_richacl
> -_require_richacl_prog
> -
> -_scratch_mkfs_richacl >> $seqres.full
> -_scratch_mount
> -
> -cd $SCRATCH_MNT
> -
> -touch x
> -$SETRICHACL_PROG --set 'owner@:rwp::allow group@:rwp::allow everyone@:r::allow' x
> -$GETRICHACL_PROG x
> -
> -$SETRICHACL_PROG --set 'everyone@:wp::allow owner@:r::allow group@:r::allow' x
> -chmod 664 x
> -$GETRICHACL_PROG x
> -
> -$SETRICHACL_PROG --set 'everyone@:wp::deny owner@:rwp::allow group@:rwp::allow' x
> -chmod 664 x
> -$GETRICHACL_PROG x
> -
> -$SETRICHACL_PROG --set 'owner@:rwCo::allow' x
> -$GETRICHACL_PROG x
> -
> -$SETRICHACL_PROG --set 'owner@:rwpCo::allow' x
> -$GETRICHACL_PROG x
> -
> -chmod 644 x
> -$GETRICHACL_PROG x
> -
> -$SETRICHACL_PROG --set 'u:77:rwp::allow' x
> -chmod 664 x
> -$GETRICHACL_PROG x
> -
> -chmod 644 x
> -$GETRICHACL_PROG --numeric-ids x
> -
> -chmod 664 x
> -$GETRICHACL_PROG x
> -
> -$SETRICHACL_PROG --set 'u:77:rwp::allow everyone@:r::allow' x
> -chmod 664 x
> -$GETRICHACL_PROG x
> -
> -$SETRICHACL_PROG --set 'u:77:r::allow everyone@:rwp::allow' x
> -chmod 664 x
> -$GETRICHACL_PROG x
> -
> -$SETRICHACL_PROG --set 'u:77:wp::deny everyone@:rwp::allow' x
> -chmod 664 x
> -$GETRICHACL_PROG x
> -
> -$SETRICHACL_PROG --set 'u:77:rwp::allow u:77:wp::deny everyone@:rwp::allow' x
> -chmod 664 x
> -$GETRICHACL_PROG x
> -
> -$SETRICHACL_PROG --set 'everyone@:rwp::allow' x
> -chmod 066 x
> -$GETRICHACL_PROG x
> -
> -chmod 006 x
> -$GETRICHACL_PROG x
> -
> -chmod 606 x
> -$GETRICHACL_PROG x
> -
> -$SETRICHACL_PROG --set 'u:77:rwp::allow everyone@:rwp::allow' x
> -chmod 606 x
> -$GETRICHACL_PROG x
> -
> -chmod 646 x
> -$GETRICHACL_PROG x
> -
> -# success, all done
> -status=0
> -exit
> diff --git a/tests/generic/362.out b/tests/generic/362.out
> deleted file mode 100644
> index 65d52ccc3258c0..00000000000000
> --- a/tests/generic/362.out
> +++ /dev/null
> @@ -1,94 +0,0 @@
> -QA output created by 362
> -x:
> -    owner@:rwp----------::allow
> -    group@:rwp----------::allow
> - everyone@:r------------::allow
> -
> -x:
> -    owner@:rwp----------::allow
> -    group@:rwp----------::allow
> - everyone@:r------------::allow
> -
> -x:
> -    owner@:rwp----------::allow
> -    group@:rwp----------::allow
> - everyone@:r------------::allow
> -
> -x:
> - owner@:rw-------Co--::allow
> -
> -x:
> - owner@:rwp----------::allow
> -
> -x:
> -    owner@:rwp----------::allow
> - everyone@:r------------::allow
> -
> -x:
> -    owner@:rwp----------::allow
> -   user:77:rwp----------::allow
> -    group@:r------------::deny
> - everyone@:r------------::allow
> -
> -x:
> -    owner@:rwp----------::allow
> -   user:77:r------------::allow
> -    group@:r------------::deny
> - everyone@:r------------::allow
> -
> -x:
> -    owner@:rwp----------::allow
> -   user:77:rwp----------::allow
> -    group@:r------------::deny
> - everyone@:r------------::allow
> -
> -x:
> -    owner@:rwp----------::allow
> -   user:77:rwp----------::allow
> - everyone@:r------------::allow
> -
> -x:
> -   user:77:rwp----------::allow
> -    owner@:rwp----------::allow
> -    group@:rwp----------::allow
> - everyone@:r------------::allow
> -
> -x:
> -    owner@:rwp----------::allow
> -   user:77:-wp----------::deny
> -    group@:rwp----------::allow
> - everyone@:r------------::allow
> -
> -x:
> -    owner@:rwp----------::allow
> -   user:77:rwp----------::allow
> -   user:77:-wp----------::deny
> -    group@:rwp----------::allow
> - everyone@:r------------::allow
> -
> -x:
> -    owner@:rwp----------::deny
> - everyone@:rwp----------::allow
> -
> -x:
> -    owner@:rwp----------::deny
> -    group@:rwp----------::deny
> - everyone@:rwp----------::allow
> -
> -x:
> -    owner@:rwp----------::allow
> -    group@:rwp----------::deny
> - everyone@:rwp----------::allow
> -
> -x:
> -    owner@:rwp----------::allow
> -    group@:rwp----------::deny
> - everyone@:rwp----------::allow
> -
> -x:
> -   user:77:r------------::allow
> -    owner@:rwp----------::allow
> -    group@:-wp----------::deny
> -   user:77:-wp----------::deny
> - everyone@:rwp----------::allow
> -
> diff --git a/tests/generic/363 b/tests/generic/363
> deleted file mode 100755
> index d3d888dbefb5c2..00000000000000
> --- a/tests/generic/363
> +++ /dev/null
> @@ -1,86 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
> -#
> -# FS QA Test 363
> -#
> -# RichACL auto-inheritance test
> -#
> -. ./common/preamble
> -_begin_fstest auto quick richacl perms
> -
> -# Import common functions.
> -
> -# real QA test starts here
> -
> -_supported_fs generic
> -
> -_require_scratch
> -_require_scratch_richacl
> -_require_richacl_prog
> -
> -_scratch_mkfs_richacl >> $seqres.full
> -_scratch_mount
> -
> -cd $SCRATCH_MNT
> -
> -umask 022
> -
> -mkdir d1
> -$SETRICHACL_PROG --modify owner@:rwpxd:fd:allow,u:101:rw:fd:deny d1
> -$SETRICHACL_PROG --modify u:102:rw:f:deny d1
> -$SETRICHACL_PROG --modify u:103:rw:d:deny d1
> -$SETRICHACL_PROG --modify g:101:rw:fdi:deny d1
> -
> -$SETRICHACL_PROG --modify flags:a d1
> -
> -$GETRICHACL_PROG --numeric --raw d1
> -
> -mkdir d1/d2
> -touch d1/d3
> -
> -# Mode bits derived from inherited ACEs
> -$GETRICHACL_PROG --numeric --raw d1/d2
> -
> -$GETRICHACL_PROG --numeric --raw d1/d3
> -
> -mkdir d1/d2/d4
> -touch d1/d2/d4/d5
> -
> -# Protected files
> -mkdir d1/d6
> -touch d1/d7
> -
> -$GETRICHACL_PROG --numeric --raw d1/d2/d4
> -
> -$GETRICHACL_PROG --numeric --raw d1/d2/d4/d5
> -
> -# Clear protected flag from all the ACLs
> -$SETRICHACL_PROG --modify flags:a d1/d2
> -$SETRICHACL_PROG --modify flags:a d1/d3
> -$SETRICHACL_PROG --modify flags:a d1/d2/d4
> -$SETRICHACL_PROG --modify flags:a d1/d2/d4/d5
> -
> -$GETRICHACL_PROG --numeric d1 | sed -e 's/:fd:deny/:fd:allow/' > acl.txt
> -cat acl.txt
> -
> -$SETRICHACL_PROG --set-file acl.txt d1
> -
> -$GETRICHACL_PROG --numeric --raw d1
> -
> -$GETRICHACL_PROG --numeric --raw d1/d2
> -
> -$GETRICHACL_PROG --numeric --raw d1/d3
> -
> -$GETRICHACL_PROG --numeric --raw d1/d2/d4
> -
> -$GETRICHACL_PROG --numeric --raw d1/d2/d4/d5
> -
> -# No automatic inheritance for protected files
> -$GETRICHACL_PROG --numeric --raw d1/d6
> -
> -$GETRICHACL_PROG --numeric --raw d1/d7
> -
> -# success, all done
> -status=0
> -exit
> diff --git a/tests/generic/363.out b/tests/generic/363.out
> deleted file mode 100644
> index 62f3a496ff437a..00000000000000
> --- a/tests/generic/363.out
> +++ /dev/null
> @@ -1,139 +0,0 @@
> -QA output created by 363
> -d1:
> -     flags:a
> -     owner:rwpxd-----------::mask
> -     group:r--x------------::mask
> -     other:r--x------------::mask
> -  user:101:rw--------------:fd:deny
> -  user:102:rw--------------:f:deny
> -  user:103:rw--------------:d:deny
> - group:101:rw--------------:fdi:deny
> -    owner@:rwpxd-----------:fd:allow
> - everyone@:r--x------------::allow
> -
> -d1/d2:
> -     flags:map
> -     owner:rwpxd-----------::mask
> -     group:----------------::mask
> -     other:----------------::mask
> -  user:101:rw--------------:fda:deny
> -  user:102:rw--------------:fia:deny
> -  user:103:rw--------------:da:deny
> - group:101:rw--------------:fda:deny
> -    owner@:rwpxd-----------:fda:allow
> -
> -d1/d3:
> -     flags:map
> -     owner:rwp-------------::mask
> -     group:----------------::mask
> -     other:----------------::mask
> -  user:101:rw--------------:a:deny
> -  user:102:rw--------------:a:deny
> - group:101:rw--------------:a:deny
> -    owner@:rwpx------------:a:allow
> -
> -d1/d2/d4:
> -     flags:map
> -     owner:rwpxd-----------::mask
> -     group:----------------::mask
> -     other:----------------::mask
> -  user:101:rw--------------:fda:deny
> -  user:102:rw--------------:fia:deny
> -  user:103:rw--------------:da:deny
> - group:101:rw--------------:fda:deny
> -    owner@:rwpxd-----------:fda:allow
> -
> -d1/d2/d4/d5:
> -     flags:map
> -     owner:rwp-------------::mask
> -     group:----------------::mask
> -     other:----------------::mask
> -  user:101:rw--------------:a:deny
> -  user:102:rw--------------:a:deny
> - group:101:rw--------------:a:deny
> -    owner@:rwpx------------:a:allow
> -
> -d1:
> -     flags:a
> -  user:101:rw-----------:fd:allow
> -  user:102:rw-----------:f:deny
> -  user:103:rw-----------:d:deny
> - group:101:rw-----------:fdi:deny
> -    owner@:rwpxd--------:fd:allow
> - everyone@:r--x---------::allow
> -
> -d1:
> -     flags:a
> -     owner:rwpxd-----------::mask
> -     group:rw-x------------::mask
> -     other:r--x------------::mask
> -  user:101:rw--------------:fd:allow
> -  user:102:rw--------------:f:deny
> -  user:103:rw--------------:d:deny
> - group:101:rw--------------:fdi:deny
> -    owner@:rwpxd-----------:fd:allow
> - everyone@:r--x------------::allow
> -
> -d1/d2:
> -     flags:a
> -     owner:rwpxd-----------::mask
> -     group:rw--------------::mask
> -     other:----------------::mask
> -  user:101:rw--------------:fda:allow
> -  user:102:rw--------------:fia:deny
> -  user:103:rw--------------:da:deny
> - group:101:rw--------------:fda:deny
> -    owner@:rwpxd-----------:fda:allow
> -
> -d1/d3:
> -     flags:a
> -     owner:rwpx------------::mask
> -     group:rw--------------::mask
> -     other:----------------::mask
> -  user:101:rw--------------:a:allow
> -  user:102:rw--------------:a:deny
> - group:101:rw--------------:a:deny
> -    owner@:rwpx------------:a:allow
> -
> -d1/d2/d4:
> -     flags:a
> -     owner:rwpxd-----------::mask
> -     group:rw--------------::mask
> -     other:----------------::mask
> -  user:101:rw--------------:fda:allow
> -  user:102:rw--------------:fia:deny
> -  user:103:rw--------------:da:deny
> - group:101:rw--------------:fda:deny
> -    owner@:rwpxd-----------:fda:allow
> -
> -d1/d2/d4/d5:
> -     flags:a
> -     owner:rwpx------------::mask
> -     group:rw--------------::mask
> -     other:----------------::mask
> -  user:101:rw--------------:a:allow
> -  user:102:rw--------------:a:deny
> - group:101:rw--------------:a:deny
> -    owner@:rwpx------------:a:allow
> -
> -d1/d6:
> -     flags:map
> -     owner:rwpxd-----------::mask
> -     group:----------------::mask
> -     other:----------------::mask
> -  user:101:rw--------------:fda:deny
> -  user:102:rw--------------:fia:deny
> -  user:103:rw--------------:da:deny
> - group:101:rw--------------:fda:deny
> -    owner@:rwpxd-----------:fda:allow
> -
> -d1/d7:
> -     flags:map
> -     owner:rwp-------------::mask
> -     group:----------------::mask
> -     other:----------------::mask
> -  user:101:rw--------------:a:deny
> -  user:102:rw--------------:a:deny
> - group:101:rw--------------:a:deny
> -    owner@:rwpx------------:a:allow
> -
> diff --git a/tests/generic/364 b/tests/generic/364
> deleted file mode 100755
> index 2c721fea202c99..00000000000000
> --- a/tests/generic/364
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
> -#
> -# FS QA Test 364
> -#
> -# RichACL basic test
> -#
> -. ./common/preamble
> -_begin_fstest auto quick richacl perms
> -
> -# Import common functions.
> -. ./common/attr
> -
> -# real QA test starts here
> -
> -_supported_fs generic
> -
> -_require_scratch
> -_require_scratch_richacl
> -_require_richacl_prog
> -
> -_scratch_mkfs_richacl >> $seqres.full
> -_scratch_mount
> -
> -cd $SCRATCH_MNT
> -
> -umask 022
> -
> -touch x
> -
> -$SETRICHACL_PROG --set 'everyone@:rwp::allow' x
> -stat -c %A x
> -$GETRICHACL_PROG x
> -
> -chmod 664 x
> -stat -c %A x
> -$GETRICHACL_PROG x
> -
> -# Note that unlike how the test cases look at first sight, we do *not* require
> -# a richacl-enabled version of ls here ...
> -
> -mkdir sub
> -$SETRICHACL_PROG --set 'everyone@:rwpxd:fd:allow' sub
> -stat -c %A+ sub
> -_getfattr -m system\.richacl sub
> -
> -chmod 775 sub
> -stat -c %A+ sub
> -_getfattr -m system\.richacl sub
> -$GETRICHACL_PROG sub
> -
> -touch sub/f
> -stat -c %A sub/f
> -$GETRICHACL_PROG sub/f
> -
> -mkdir sub/sub2
> -stat -c %A+ sub/sub2
> -$GETRICHACL_PROG sub/sub2
> -
> -mkdir -m 750 sub/sub3
> -stat -c %A+ sub/sub3
> -$GETRICHACL_PROG sub/sub3
> -
> -# success, all done
> -status=0
> -exit
> diff --git a/tests/generic/364.out b/tests/generic/364.out
> deleted file mode 100644
> index 696cf6c78ba3d7..00000000000000
> --- a/tests/generic/364.out
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -QA output created by 364
> --rw-rw-rw-
> -x:
> - everyone@:rwp----------::allow
> -
> --rw-rw-r--
> -x:
> -    owner@:rwp----------::allow
> -    group@:rwp----------::allow
> - everyone@:r------------::allow
> -
> -drwxrwxrwx+
> -# file: sub
> -system.richacl
> -
> -drwxrwxr-x+
> -# file: sub
> -system.richacl
> -
> -sub:
> -    owner@:rwpxd--------::allow
> -    group@:rwpxd--------::allow
> - everyone@:rwpxd--------:fdi:allow
> - everyone@:r--x---------::allow
> -
> --rw-rw-rw-
> -sub/f:
> - everyone@:rwp----------::allow
> -
> -drwxrwxrwx+
> -sub/sub2:
> - everyone@:rwpxd--------:fd:allow
> -
> -drwxr-x---+
> -sub/sub3:
> -    owner@:rwpxd--------::allow
> -    group@:r--x---------::allow
> - everyone@:rwpxd--------:fdi:allow
> -
> diff --git a/tests/generic/365 b/tests/generic/365
> deleted file mode 100755
> index d22f233a61a824..00000000000000
> --- a/tests/generic/365
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
> -#
> -# FS QA Test 365
> -#
> -# RichACL chmod test
> -#
> -. ./common/preamble
> -_begin_fstest auto quick richacl perms
> -
> -# Import common functions.
> -
> -# real QA test starts here
> -
> -_supported_fs generic
> -
> -_require_scratch
> -_require_scratch_richacl
> -_require_richacl_prog
> -_require_runas
> -
> -_scratch_mkfs_richacl >> $seqres.full
> -_scratch_mount
> -
> -cd $SCRATCH_MNT
> -
> -r()
> -{
> -	echo "--- runas -u 99 -g 99 $*"
> -	_runas -u 99 -g 99 -- "$@"
> -}
> -
> -s()
> -{
> -	echo "--- runas -u 99 -g 99 setrichacl $*"
> -	_runas -u 99 -g 99 -- $SETRICHACL_PROG "$@"
> -}
> -
> -# Create file as root
> -touch a
> -
> -# We cannot set the acl as another user
> -s --set 'u:99:rwc::allow' a
> -
> -# We cannot chmod as another user
> -r chmod 666 a
> -
> -# Give user 99 the write_acl permission
> -$SETRICHACL_PROG --set 'u:99:rwpC::allow' a
> -
> -# Now user 99 can setrichacl and chmod ...
> -s --set 'u:99:rwpC::allow' a
> -r chmod 666 a
> -
> -# ... but chmod disables the write_acl permission
> -s --set 'u:99:rwpC::allow' a
> -
> -# success, all done
> -status=0
> -exit
> diff --git a/tests/generic/365.out b/tests/generic/365.out
> deleted file mode 100644
> index f7c9242b3bf966..00000000000000
> --- a/tests/generic/365.out
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -QA output created by 365
> ---- runas -u 99 -g 99 setrichacl --set u:99:rwc::allow a
> -a: Operation not permitted
> ---- runas -u 99 -g 99 chmod 666 a
> -chmod: changing permissions of 'a': Operation not permitted
> ---- runas -u 99 -g 99 setrichacl --set u:99:rwpC::allow a
> ---- runas -u 99 -g 99 chmod 666 a
> ---- runas -u 99 -g 99 setrichacl --set u:99:rwpC::allow a
> -a: Operation not permitted
> diff --git a/tests/generic/366 b/tests/generic/366
> deleted file mode 100755
> index c005f8097474e2..00000000000000
> --- a/tests/generic/366
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
> -#
> -# FS QA Test 366
> -#
> -# RichACL chown test
> -#
> -. ./common/preamble
> -_begin_fstest auto quick richacl perms
> -
> -# Import common functions.
> -
> -# real QA test starts here
> -
> -_supported_fs generic
> -
> -_require_scratch
> -_require_scratch_richacl
> -_require_richacl_prog
> -_require_runas
> -
> -_scratch_mkfs_richacl >> $seqres.full
> -_scratch_mount
> -
> -cd $SCRATCH_MNT
> -
> -r()
> -{
> -	echo "--- runas -u 99 -g 99 $*"
> -	_runas -u 99 -g 99 -- "$@"
> -}
> -
> -# Create file as root
> -touch a
> -
> -# Chown and chgrp with no take ownership permission fails
> -r chown 99 a
> -r chgrp 99 a
> -
> -# Add the take_ownership permission
> -$SETRICHACL_PROG --set 'u:99:rwpo::allow' a
> -
> -# Chown and chgrp to a user or group the process is not in fails
> -r chown 100 a
> -r chgrp 100 a
> -
> -# Chown and chgrp to a user and group the process is in succeeds
> -r chown 99 a
> -r chgrp 99 a
> -
> -# success, all done
> -status=0
> -exit
> diff --git a/tests/generic/366.out b/tests/generic/366.out
> deleted file mode 100644
> index d950cc2d05ee5c..00000000000000
> --- a/tests/generic/366.out
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -QA output created by 366
> ---- runas -u 99 -g 99 chown 99 a
> -chown: changing ownership of 'a': Operation not permitted
> ---- runas -u 99 -g 99 chgrp 99 a
> -chgrp: changing group of 'a': Operation not permitted
> ---- runas -u 99 -g 99 chown 100 a
> -chown: changing ownership of 'a': Operation not permitted
> ---- runas -u 99 -g 99 chgrp 100 a
> -chgrp: changing group of 'a': Operation not permitted
> ---- runas -u 99 -g 99 chown 99 a
> ---- runas -u 99 -g 99 chgrp 99 a
> diff --git a/tests/generic/367 b/tests/generic/367
> deleted file mode 100755
> index db7b2956f67382..00000000000000
> --- a/tests/generic/367
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
> -#
> -# FS QA Test 367
> -#
> -# RichACL create test
> -#
> -. ./common/preamble
> -_begin_fstest auto quick richacl perms
> -
> -# Import common functions.
> -
> -# real QA test starts here
> -
> -_supported_fs generic
> -
> -_require_scratch
> -_require_scratch_richacl
> -_require_richacl_prog
> -_require_runas
> -
> -_scratch_mkfs_richacl >> $seqres.full
> -_scratch_mount
> -
> -cd $SCRATCH_MNT
> -
> -r()
> -{
> -	echo "--- runas -u 99 -g 99 $*"
> -	_runas -u 99 -g 99 -- "$@"
> -}
> -
> -# Create directories as root with different permissions
> -mkdir d1 d2 d3
> -$SETRICHACL_PROG --set 'u:99:wx::allow' d2
> -$SETRICHACL_PROG --set 'u:99:px::allow' d3
> -
> -# Cannot create files or directories without permissions
> -r touch d1/f
> -r mkdir d1/d
> -
> -# Can create files with add_file (w) permission
> -r touch d2/f
> -r mkdir d2/d
> -
> -# Can create directories with add_subdirectory (p) permission
> -r touch d3/f
> -r mkdir d3/d
> -
> -# success, all done
> -status=0
> -exit
> diff --git a/tests/generic/367.out b/tests/generic/367.out
> deleted file mode 100644
> index ec25b5c7fcb521..00000000000000
> --- a/tests/generic/367.out
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -QA output created by 367
> ---- runas -u 99 -g 99 touch d1/f
> -touch: cannot touch 'd1/f': Permission denied
> ---- runas -u 99 -g 99 mkdir d1/d
> -mkdir: cannot create directory 'd1/d': Permission denied
> ---- runas -u 99 -g 99 touch d2/f
> ---- runas -u 99 -g 99 mkdir d2/d
> -mkdir: cannot create directory 'd2/d': Permission denied
> ---- runas -u 99 -g 99 touch d3/f
> -touch: cannot touch 'd3/f': Permission denied
> ---- runas -u 99 -g 99 mkdir d3/d
> diff --git a/tests/generic/368 b/tests/generic/368
> deleted file mode 100755
> index d2259b348f45d7..00000000000000
> --- a/tests/generic/368
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
> -#
> -# FS QA Test 368
> -#
> -# RichACL ctime test
> -#
> -. ./common/preamble
> -_begin_fstest auto quick richacl perms
> -
> -# Import common functions.
> -
> -# real QA test starts here
> -
> -_supported_fs generic
> -
> -_require_scratch
> -_require_scratch_richacl
> -_require_richacl_prog
> -_require_runas
> -
> -_scratch_mkfs_richacl >> $seqres.full
> -_scratch_mount
> -
> -cd $SCRATCH_MNT
> -
> -r()
> -{
> -	echo "--- runas -u 99 -g 99 $*"
> -	_runas -u 99 -g 99 -- "$@"
> -}
> -
> -touch a
> -
> -# Without write access, the ctime cannot be changed
> -r touch a
> -
> -$SETRICHACL_PROG --set 'u:99:rw::allow' a
> -
> -# With write access, the ctime can be set to the current time, but not to
> -# any other time
> -r touch a
> -r touch -d '1 hour ago' a
> -
> -$SETRICHACL_PROG --set 'u:99:rwA::allow' a
> -
> -# With set_attributes access, the ctime can be set to an arbitrary time
> -r touch -d '1 hour ago' a
> -
> -# success, all done
> -status=0
> -exit
> diff --git a/tests/generic/368.out b/tests/generic/368.out
> deleted file mode 100644
> index 2cdf5e585cb4c2..00000000000000
> --- a/tests/generic/368.out
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -QA output created by 368
> ---- runas -u 99 -g 99 touch a
> -touch: cannot touch 'a': Permission denied
> ---- runas -u 99 -g 99 touch a
> ---- runas -u 99 -g 99 touch -d 1 hour ago a
> -touch: setting times of 'a': Operation not permitted
> ---- runas -u 99 -g 99 touch -d 1 hour ago a
> diff --git a/tests/generic/369 b/tests/generic/369
> deleted file mode 100755
> index 526de2443a401a..00000000000000
> --- a/tests/generic/369
> +++ /dev/null
> @@ -1,94 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
> -#
> -# FS QA Test 369
> -#
> -# RichACL delete test
> -#
> -. ./common/preamble
> -_begin_fstest auto quick richacl perms
> -
> -# Import common functions.
> -
> -# real QA test starts here
> -
> -_supported_fs generic
> -
> -_require_scratch
> -_require_scratch_richacl
> -_require_richacl_prog
> -_require_runas
> -
> -_scratch_mkfs_richacl >> $seqres.full
> -_scratch_mount
> -
> -cd $SCRATCH_MNT
> -
> -r()
> -{
> -	echo "--- runas -u 99 -g 99 $*"
> -	_runas -u 99 -g 99 -- "$@"
> -}
> -
> -umask 022
> -
> -chmod go+w .
> -mkdir d1 d2 d3 d4 d5 d6 d7
> -touch d1/f d1/g d2/f d3/f d4/f d5/f d6/f d7/f d7/g d7/h
> -chmod o+w d1/g
> -chown 99 d2
> -chgrp 99 d3
> -chmod g+w d3
> -$SETRICHACL_PROG --set 'u:99:wx::allow' d4
> -$SETRICHACL_PROG --set 'u:99:d::allow' d5
> -$SETRICHACL_PROG --set 'u:99:xd::allow' d6
> -$SETRICHACL_PROG --set 'u:99:D::allow' d7/f d7/g d7/h
> -chmod 664 d7/g
> -
> -mkdir s2 s3 s4 s5 s6 s7
> -chmod +t s2 s3 s4 s5 s6 s7
> -touch s2/f s3/f s4/f s5/f s6/f s7/f s7/g s7/h
> -chown 99 s2
> -chgrp 99 s3
> -chmod g+w s3
> -$SETRICHACL_PROG --set 'u:99:wx::allow' s4
> -$SETRICHACL_PROG --set 'u:99:d::allow' s5
> -$SETRICHACL_PROG --set 'u:99:xd::allow' s6
> -$SETRICHACL_PROG --set 'u:99:D::allow' s7/f s7/g s7/h
> -chmod 664 s7/g
> -
> -# Cannot delete files with no or only with write permissions on the directory
> -r rm -f d1/f d1/g
> -
> -# Can delete files in directories we own
> -r rm -f d2/f s2/f
> -
> -# Can delete files in non-sticky directories we have write access to
> -r rm -f d3/f s3/f
> -
> -# "Write_data/execute" access does not include delete_child access, so deleting
> -# is not allowed:
> -r rm -f d4/f s4/f
> -
> -# "Delete_child" access alone also is not sufficient
> -r rm -f d5/f s5/f
> -
> -# "Execute/delete_child" access is sufficient for non-sticky directories
> -r rm -f d6/f s6/f
> -
> -# "Delete" access on the child is sufficient, even in sticky directories.
> -r rm -f d7/f s7/f
> -
> -# Regression: Delete access must not override add_file / add_subdirectory
> -# access.
> -r touch h
> -r mv -f h d7/
> -r mv -f h s7/
> -
> -# A chmod turns off the "delete" permission
> -r rm -f d7/g s7/g
> -
> -# success, all done
> -status=0
> -exit
> diff --git a/tests/generic/369.out b/tests/generic/369.out
> deleted file mode 100644
> index acdab46642f2d0..00000000000000
> --- a/tests/generic/369.out
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -QA output created by 369
> ---- runas -u 99 -g 99 rm -f d1/f d1/g
> -rm: cannot remove 'd1/f': Permission denied
> -rm: cannot remove 'd1/g': Permission denied
> ---- runas -u 99 -g 99 rm -f d2/f s2/f
> ---- runas -u 99 -g 99 rm -f d3/f s3/f
> -rm: cannot remove 's3/f': Operation not permitted
> ---- runas -u 99 -g 99 rm -f d4/f s4/f
> -rm: cannot remove 'd4/f': Permission denied
> -rm: cannot remove 's4/f': Permission denied
> ---- runas -u 99 -g 99 rm -f d5/f s5/f
> -rm: cannot remove 'd5/f': Permission denied
> -rm: cannot remove 's5/f': Permission denied
> ---- runas -u 99 -g 99 rm -f d6/f s6/f
> -rm: cannot remove 's6/f': Operation not permitted
> ---- runas -u 99 -g 99 rm -f d7/f s7/f
> ---- runas -u 99 -g 99 touch h
> ---- runas -u 99 -g 99 mv -f h d7/
> -mv: cannot move 'h' to 'd7/h': Permission denied
> ---- runas -u 99 -g 99 mv -f h s7/
> -mv: cannot move 'h' to 's7/h': Permission denied
> ---- runas -u 99 -g 99 rm -f d7/g s7/g
> -rm: cannot remove 'd7/g': Permission denied
> -rm: cannot remove 's7/g': Permission denied
> diff --git a/tests/generic/370 b/tests/generic/370
> deleted file mode 100755
> index 8c17af0ce723ac..00000000000000
> --- a/tests/generic/370
> +++ /dev/null
> @@ -1,58 +0,0 @@
> -#! /bin/bash
> -# SPDX-License-Identifier: GPL-2.0
> -# Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
> -#
> -# FS QA Test 370
> -#
> -# RichACL write-vs-append test
> -#
> -. ./common/preamble
> -_begin_fstest auto quick richacl perms
> -
> -# Import common functions.
> -
> -# real QA test starts here
> -
> -_supported_fs generic
> -
> -_require_scratch
> -_require_scratch_richacl
> -_require_richacl_prog
> -_require_runas
> -
> -_scratch_mkfs_richacl >> $seqres.full
> -_scratch_mount
> -
> -cd $SCRATCH_MNT
> -
> -r()
> -{
> -	echo "--- runas -u 99 -g 99 $*"
> -	_runas -u 99 -g 99 -- "$@"
> -}
> -
> -touch a b c d e f
> -$SETRICHACL_PROG --set 'owner@:rwp::allow' a
> -$SETRICHACL_PROG --set 'owner@:rwp::allow u:99:w::allow' b
> -$SETRICHACL_PROG --set 'owner@:rwp::allow u:99:p::allow' c
> -$SETRICHACL_PROG --set 'owner@:rwp::allow u:99:wp::allow' d
> -$SETRICHACL_PROG --set 'u:99:a::deny owner@:rwp::allow u:99:w::allow' e
> -$SETRICHACL_PROG --set 'u:99:w::deny owner@:rwp::allow u:99:p::allow' f
> -
> -r sh -c 'echo a > a'
> -r sh -c 'echo b > b'
> -r sh -c 'echo c > c'
> -r sh -c 'echo d > d'
> -r sh -c 'echo e > e'
> -r sh -c 'echo f > f'
> -
> -r sh -c 'echo A >> a'
> -r sh -c 'echo B >> b'
> -r sh -c 'echo C >> c'
> -r sh -c 'echo D >> d'
> -r sh -c 'echo E >> e'
> -r sh -c 'echo F >> f'
> -
> -# success, all done
> -status=0
> -exit
> diff --git a/tests/generic/370.out b/tests/generic/370.out
> deleted file mode 100644
> index 97a21a156c6a76..00000000000000
> --- a/tests/generic/370.out
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -QA output created by 370
> ---- runas -u 99 -g 99 sh -c echo a > a
> -sh: a: Permission denied
> ---- runas -u 99 -g 99 sh -c echo b > b
> ---- runas -u 99 -g 99 sh -c echo c > c
> -sh: c: Permission denied
> ---- runas -u 99 -g 99 sh -c echo d > d
> ---- runas -u 99 -g 99 sh -c echo e > e
> ---- runas -u 99 -g 99 sh -c echo f > f
> -sh: f: Permission denied
> ---- runas -u 99 -g 99 sh -c echo A >> a
> -sh: a: Permission denied
> ---- runas -u 99 -g 99 sh -c echo B >> b
> -sh: b: Permission denied
> ---- runas -u 99 -g 99 sh -c echo C >> c
> ---- runas -u 99 -g 99 sh -c echo D >> d
> ---- runas -u 99 -g 99 sh -c echo E >> e
> -sh: e: Permission denied
> ---- runas -u 99 -g 99 sh -c echo F >> f
> -- 
> 2.45.0
> 
> 

