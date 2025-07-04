Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8A820E01F
	for <fstests@vger.kernel.org>; Fri,  4 Jul 2025 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751652656; cv=none; b=pqhLjh8K1SEPUrHzq/izF9qKRdMkFPTWGpQV846An+SCm4IbN0UYF1NFnz6VedhRoxHHPZQ0Y3QOs4Ek4NzhxDVGHpCbRUjVlRr/p93KTLZYK9ncw37XLKhEVzjJw+soxVy6PBRFsRVmBUeXKMXCV6sARBETauld6GvvYHeDm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751652656; c=relaxed/simple;
	bh=Pf0fYtKh4u2yawjympH+vEWVAb6g5PNoBvn9/Rm1paw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKWmDxrfHSHxqQc4aaU9RankLh9YhJLE+fyKHId25m7CvkHqEiZOxUjJXouZsD7koka+tTQjI1Fyi4P31qPdqJl294XNzVak+fF9slyYac8JOa8ghi/hTCXXkeNYh3ZlkC0Omo4TV0Hx5pj3UkmyMuuxQUXIAE3kzAp7PixbePA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJnsaKTE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJnsaKTE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751652652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MdUieAd1lJmb1QYM4PuzRy4XXeLxoRFZCYmwy8/kupk=;
	b=ZJnsaKTEiDwqPh36ZBuPxUwkj/jWTE9QN0UOR0ZmtskwdQxWQkWW0zUAq1WuusKXNOkx64
	dfE0Bq+QN/8CZZJVf8enK14lf9FKHIjYQZ+MHdmbj8AkZp/8P2v9pLaEylS5J/Xev01Fi3
	6z5dkyOtcNM/PFYTliQvIw3nug0IVIk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-qZ0LX9VIMuGKVSeeWo3REA-1; Fri, 04 Jul 2025 14:10:51 -0400
X-MC-Unique: qZ0LX9VIMuGKVSeeWo3REA-1
X-Mimecast-MFC-AGG-ID: qZ0LX9VIMuGKVSeeWo3REA_1751652650
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23536f7c2d7so18456515ad.2
        for <fstests@vger.kernel.org>; Fri, 04 Jul 2025 11:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751652650; x=1752257450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdUieAd1lJmb1QYM4PuzRy4XXeLxoRFZCYmwy8/kupk=;
        b=AH6bi75Xycp1pWPXZ8armsJoeePoac44/a+cmMhuEbpN8+CUwT2jxKQ8DJyB3QHp9r
         bsCo1YjcBPiKJRNFPf+VUaPMNqh7GiBOKyI4mlMnUH0UVMkY2segCKSWthREJXSCv3sr
         2ZPkkK45q+Jpxhyt8MzkxTmnplFDDfrb4RiVC1K4ES5vx05Q5TGxcoW7OgR92OUPjy0W
         3yFPddLbPK5sEwnGOi7l7oN7NSc+WJDKYS8P6YpB4kMpKbFkf0qZxEcycGtEDm9e1VE8
         8MjTNNOpOXFLYUkHlfsBkhiqjTvcfeCw65ZIF8q1ZInemY7yHFJmLuULpYk4sgcJwUym
         xEeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCaEktpnoY+J+fdxmrkSsJ9+EtkOUPoKiv+Q9Dv4FMxJgmnIjAkRG0ZiGBlZmpVW2R7FMZdtJk@vger.kernel.org
X-Gm-Message-State: AOJu0YwkncWIqdayhDhNlIjYfZoey0PF4dvreSe74D8qP13SsrKO1YJo
	zfayZpY8z0/DrG2sKxeCg8kt194qB6889/Vqh7/cWXTndf8qaxdgRZcmtKVHw+iQaz1vh9qPHkb
	f8Yvk5XryNYrMyJ/Ag3oQ2tsDmASZoMpr3Ur1EOrWQRWVWHebLFTcdUZ1PiI=
X-Gm-Gg: ASbGncus4KoT6Imo83G3vibsqHo+QhUtMcsdFOYB3o/QGAjbQW8sQmh3DFAvWDYrDIZ
	2VAeceKzmAHcV60iPbDV9wTXcQbdfjPRxOTd9fSw9prYAkA8Q6zj0XQC0zyNu4rT7tus4m65gOb
	S8H+doNESxBAxyUkQNVnQ1eGVm1TtSkDRk90XzQB2Psx6a1A3zaIux0jpDC89Qs/qpRg8pC6Nvd
	HtPAmjV1Dip4y090BA8FASc2h2sgNedmlkLD793ksfFIA/eqca/P8AfUVkryGFjwiyCFAIHQTvx
	E1nnJ2Wrnf1X99KrXI7Fb48+1o4FpPaMBzli72cgqiHA5YPljj2gI5RN6n7K6ro=
X-Received: by 2002:a17:902:c40f:b0:234:c7e6:8459 with SMTP id d9443c01a7336-23c8748444emr44878495ad.20.1751652650088;
        Fri, 04 Jul 2025 11:10:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBzi8I6IYD4Jam1MnA8U5c6bVwDAqiWg9FKXKEQo6MIng475KXF0yvVZw9sgImahp1Q+1K8Q==
X-Received: by 2002:a17:902:c40f:b0:234:c7e6:8459 with SMTP id d9443c01a7336-23c8748444emr44878265ad.20.1751652649644;
        Fri, 04 Jul 2025 11:10:49 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845998b4sm26242445ad.215.2025.07.04.11.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 11:10:49 -0700 (PDT)
Date: Sat, 5 Jul 2025 02:10:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] f2fs/015: test mount options
Message-ID: <20250704181044.5v5a3xxv5dixd43a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250702110204.1063796-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702110204.1063796-1-chao@kernel.org>

On Wed, Jul 02, 2025 at 07:02:04PM +0800, Chao Yu wrote:
> As f2fs changes to use new mount APIs, let's add a new testcase
> to check mount result for all f2fs supported mount options and
> their combinations, in order to detect any inconsistency during
> mount.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/015     | 141 ++++++++++++++++++++++++++++++
>  tests/f2fs/015.out | 207 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 348 insertions(+)
>  create mode 100755 tests/f2fs/015
>  create mode 100644 tests/f2fs/015.out
> 
> diff --git a/tests/f2fs/015 b/tests/f2fs/015
> new file mode 100755
> index 00000000..86f0ef9e
> --- /dev/null
> +++ b/tests/f2fs/015
> @@ -0,0 +1,141 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/015
> +#
> +# This testcase tries to check stability of mount result
> +# w/ all f2fs supported mount option and their combination.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
                            ^^^^^
			    mount

> +_require_kernel_config CONFIG_F2FS_FS_XATTR
> +_require_kernel_config CONFIG_F2FS_FS_POSIX_ACL
> +_require_kernel_config CONFIG_F2FS_FAULT_INJECTION
> +_require_kernel_config CONFIG_F2FS_FS_COMPRESSION
> +_require_kernel_config CONFIG_F2FS_FS_LZO
> +_require_kernel_config CONFIG_F2FS_FS_LZORLE
> +_require_kernel_config CONFIG_F2FS_FS_LZ4
> +_require_kernel_config CONFIG_F2FS_FS_LZ4HC
> +_require_kernel_config CONFIG_F2FS_FS_ZSTD

Hmm... I think these requirements might cause this test case be _notrun
from lots of Linux distributions, except the kernel is built for testing
manually :)

> +_require_scratch
> +
> +options=(
> +#	mount_option			mkfs_option
> +	"background_gc=on"		""			\
> +	"background_gc=off"		""			\
> +	"background_gc=off"		""			\
> +	"background_gc=sync"		""			\
> +	"disable_roll_forward"		""			\
> +	"norecovery"			""			\
> +	"discard"			""			\
> +	"nodiscard"			""			\
> +	"no_heap"			""			\
> +	"heap"				""			\
> +	"user_xattr"			""			\
> +	"nouser_xattr"			""			\
> +	"acl"				""			\
> +	"noacl"				""			\
> +	"active_logs=2"			""			\
> +	"active_logs=4"			""			\
> +	"active_logs=6"			""			\
> +	"disable_ext_identify"		""			\
> +	"inline_xattr"			""			\
> +	"noinline_xattr"		""			\
> +	"inline_xattr_size=400"		"extra,flexible_inline_xattr"\
> +	"inline_xattr_size=400"		""			\
> +	"inline_data"			""			\
> +	"noinline_dentry"		""			\
> +	"inline_dentry"			""			\
> +	"noinline_dentry"		""			\
> +	"flush_merge"			""			\
> +	"noflush_merge"			""			\
> +	"barrier"			""			\
> +	"nobarrier"			""			\
> +	"fastboot"			""			\
> +	"extent_cache"			""			\
> +	"noextent_cache"		""			\
> +	"data_flush"			""			\
> +	"reserve_root=32768"		""			\
> +	"resuid=1000"			""			\
> +	"resgid=1000"			""			\
> +	"fault_injection=100"		""			\
> +	"fault_type=4095"		""			\
> +	"mode=adaptive"			""			\
> +	"mode=lfs"			""			\
> +	"mode=fragment:segment"		""			\
> +	"mode=fragment:block"		""			\
> +	"usrquota"			""			\
> +	"grpquota"			""			\
> +	"prjquota"			""			\
> +	"usrjquota=ausrquota"		""			\
> +	"grpjquota=agrpquota"		""			\
> +	"prjjquota=aprjquota"		""			\
> +	"jqfmt=vfsold"			""			\
> +	"jqfmt=vfsv0"			""			\
> +	"jqfmt=vfsv1"			""			\
> +	"usrjquota="			""			\
> +	"grpjquota="			""			\
> +	"prjjquota="			""			\
> +	"quota"				""			\
> +	"noquota"			""			\
> +	"alloc_mode=reuse"		""			\
> +	"alloc_mode=default"		""			\
> +	"fsync_mode=posix"		""			\
> +	"fsync_mode=strict"		""			\
> +	"fsync_mode=nobarrier"		""			\
> +	"test_dummy_encryption"		""			\
> +	"test_dummy_encryption=v1"	""			\
> +	"test_dummy_encryption=v2"	""			\
> +	"checkpoint=enable"		""			\
> +	"checkpoint=disable"		""			\
> +	"checkpoint=disable:32768"	""			\
> +	"checkpoint=disable:50%"	""			\
> +	"checkpoint_merge"		""			\
> +	"nocheckpoint_merge"		""			\
> +	"compress_algorithm=lzo"	""			\
> +	"compress_algorithm=lzo"	"extra,compression"	\
> +	"compress_algorithm=lz4"	"extra,compression"	\
> +	"compress_algorithm=zstd"	"extra,compression"	\
> +	"compress_algorithm=lzo-rle"	"extra,compression"	\
> +	"compress_algorithm=lz4:3"	"extra,compression"	\
> +	"compress_algorithm=ztsd:1"	"extra,compression"	\
> +	"compress_log_size=8"		"extra,compression"	\
> +	"compress_extension=so"		"extra,compression"	\
> +	"nocompress_extension=so"	"extra,compression"	\
> +	"nocompress_extension=*"	"extra,compression"	\
> +	"compress_extension=so,nocompress_extension=so"		\
> +					"extra,compression"	\
> +	"compress_chksum"		"extra,compression"	\
> +	"compress_mode=fs"		"extra,compression"	\
> +	"compress_mode=user"		"extra,compression"	\
> +	"compress_cache"		"extra,compression"	\
> +	"inlinecrypt"			""			\
> +	"atgc"				""			\
> +	"discard_unit=block"		""			\
> +	"discard_unit=segment"		""			\
> +	"discard_unit=section"		""			\
> +	"memory=normal"			""			\
> +	"memory=low"			""			\
> +	"age_extent_cache"		""			\
> +	"errors=panic"			""			\
> +	"errors=continue"		""			\
> +	"errors=remount-ro"		""			\
> +	"nat_bits"			""			\
> +	"atgc,mode=lfs"			""			\
> +	"ro,flush_merge"		""			\
> +	"rw"				"ro"			\
> +	"norecovery,ro"			""			\
> +)
> +
> +for ((i=0;i<${#options[@]};i=i+2))
> +do
> +	echo "Option#$i: ${options[$i]} : ${options[$((i+1))]}"
> +	_scratch_mkfs "-O ${options[$((i+1))]}" >> $seqres.full

_scratch_mkfs just return non-zero if it fails, so...

> +	_try_scratch_mount "-o ${options[$i]}" >> $seqres.full 2>&1

...do you still hope to try mount if mkfs fails?

Thanks,
Zorro

> +	echo $?
> +	_scratch_unmount
> +done
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/015.out b/tests/f2fs/015.out
> new file mode 100644
> index 00000000..83e6ad51
> --- /dev/null
> +++ b/tests/f2fs/015.out
> @@ -0,0 +1,207 @@
> +QA output created by 015
> +Option#0: background_gc=on : 
> +0
> +Option#2: background_gc=off : 
> +0
> +Option#4: background_gc=off : 
> +0
> +Option#6: background_gc=sync : 
> +0
> +Option#8: disable_roll_forward : 
> +0
> +Option#10: norecovery : 
> +32
> +Option#12: discard : 
> +0
> +Option#14: nodiscard : 
> +0
> +Option#16: no_heap : 
> +0
> +Option#18: heap : 
> +0
> +Option#20: user_xattr : 
> +0
> +Option#22: nouser_xattr : 
> +0
> +Option#24: acl : 
> +0
> +Option#26: noacl : 
> +0
> +Option#28: active_logs=2 : 
> +0
> +Option#30: active_logs=4 : 
> +0
> +Option#32: active_logs=6 : 
> +0
> +Option#34: disable_ext_identify : 
> +0
> +Option#36: inline_xattr : 
> +0
> +Option#38: noinline_xattr : 
> +0
> +Option#40: inline_xattr_size=400 : extra,flexible_inline_xattr
> +0
> +Option#42: inline_xattr_size=400 : 
> +0
> +Option#44: inline_data : 
> +0
> +Option#46: noinline_dentry : 
> +0
> +Option#48: inline_dentry : 
> +0
> +Option#50: noinline_dentry : 
> +0
> +Option#52: flush_merge : 
> +0
> +Option#54: noflush_merge : 
> +0
> +Option#56: barrier : 
> +0
> +Option#58: nobarrier : 
> +0
> +Option#60: fastboot : 
> +0
> +Option#62: extent_cache : 
> +0
> +Option#64: noextent_cache : 
> +0
> +Option#66: data_flush : 
> +0
> +Option#68: reserve_root=32768 : 
> +0
> +Option#70: resuid=1000 : 
> +0
> +Option#72: resgid=1000 : 
> +0
> +Option#74: fault_injection=100 : 
> +0
> +Option#76: fault_type=4095 : 
> +0
> +Option#78: mode=adaptive : 
> +0
> +Option#80: mode=lfs : 
> +0
> +Option#82: mode=fragment:segment : 
> +0
> +Option#84: mode=fragment:block : 
> +0
> +Option#86: usrquota : 
> +0
> +Option#88: grpquota : 
> +0
> +Option#90: prjquota : 
> +32
> +Option#92: usrjquota=ausrquota : 
> +32
> +Option#94: grpjquota=agrpquota : 
> +32
> +Option#96: prjjquota=aprjquota : 
> +32
> +Option#98: jqfmt=vfsold : 
> +0
> +Option#100: jqfmt=vfsv0 : 
> +0
> +Option#102: jqfmt=vfsv1 : 
> +0
> +Option#104: usrjquota= : 
> +0
> +Option#106: grpjquota= : 
> +0
> +Option#108: prjjquota= : 
> +0
> +Option#110: quota : 
> +0
> +Option#112: noquota : 
> +0
> +Option#114: alloc_mode=reuse : 
> +0
> +Option#116: alloc_mode=default : 
> +0
> +Option#118: fsync_mode=posix : 
> +0
> +Option#120: fsync_mode=strict : 
> +0
> +Option#122: fsync_mode=nobarrier : 
> +0
> +Option#124: test_dummy_encryption : 
> +0
> +Option#126: test_dummy_encryption=v1 : 
> +0
> +Option#128: test_dummy_encryption=v2 : 
> +0
> +Option#130: checkpoint=enable : 
> +0
> +Option#132: checkpoint=disable : 
> +0
> +Option#134: checkpoint=disable:32768 : 
> +0
> +Option#136: checkpoint=disable:50% : 
> +0
> +Option#138: checkpoint_merge : 
> +0
> +Option#140: nocheckpoint_merge : 
> +0
> +Option#142: compress_algorithm=lzo : 
> +0
> +Option#144: compress_algorithm=lzo : extra,compression
> +0
> +Option#146: compress_algorithm=lz4 : extra,compression
> +0
> +Option#148: compress_algorithm=zstd : extra,compression
> +0
> +Option#150: compress_algorithm=lzo-rle : extra,compression
> +0
> +Option#152: compress_algorithm=lz4:3 : extra,compression
> +0
> +Option#154: compress_algorithm=ztsd:1 : extra,compression
> +32
> +Option#156: compress_log_size=8 : extra,compression
> +0
> +Option#158: compress_extension=so : extra,compression
> +0
> +Option#160: nocompress_extension=so : extra,compression
> +0
> +Option#162: nocompress_extension=* : extra,compression
> +32
> +Option#164: compress_extension=so,nocompress_extension=so : extra,compression
> +32
> +Option#166: compress_chksum : extra,compression
> +0
> +Option#168: compress_mode=fs : extra,compression
> +0
> +Option#170: compress_mode=user : extra,compression
> +0
> +Option#172: compress_cache : extra,compression
> +0
> +Option#174: inlinecrypt : 
> +0
> +Option#176: atgc : 
> +0
> +Option#178: discard_unit=block : 
> +0
> +Option#180: discard_unit=segment : 
> +0
> +Option#182: discard_unit=section : 
> +0
> +Option#184: memory=normal : 
> +0
> +Option#186: memory=low : 
> +0
> +Option#188: age_extent_cache : 
> +0
> +Option#190: errors=panic : 
> +0
> +Option#192: errors=continue : 
> +0
> +Option#194: errors=remount-ro : 
> +0
> +Option#196: nat_bits : 
> +0
> +Option#198: atgc,mode=lfs : 
> +32
> +Option#200: ro,flush_merge : 
> +32
> +Option#202: rw : ro
> +0
> +Option#204: norecovery,ro : 
> +0
> -- 
> 2.49.0
> 

