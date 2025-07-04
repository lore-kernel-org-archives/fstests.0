Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2D520FAA4
	for <fstests@vger.kernel.org>; Fri,  4 Jul 2025 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751652897; cv=none; b=sHfR9fh2W0TNKKbuSwxkqMYLhNA7vd0tRX16SUAtbJ7OuVvcHnjrUbtoVaoyBQhHeNZvWqmhzx9zgWIjXnDT5nUhxtwe8N2zJXSvZ3q8MCvBrrfu/QXlXeajUMs50UNgSk+GA/TPmlNWeekTpo9XzzrWYo5cLFJlK6eZKTix2Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751652897; c=relaxed/simple;
	bh=9GCtSquDs/LFaK/Ekfqx0qfS5eI+1goMW7/SnvbOQ4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6zV6MKfyaoE2QolO0bqaSu4Ney7+i1VXLyjOVtchhDBUQKDnwTxl9dxb+DF6DSiY9aBDhISBZSb99QXzsMAo7Lixj1oiaswNgRi1bIv2eVY+jKQW6DsAnQnPcKbJF3LBabUG58m8liPNTNuciLHVDWTtHBFxNlHyP+1CV5HLI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ePxEcwv3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePxEcwv3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751652894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4IhIibfVl8cYibtd3QJLrHiPv/dYGxvh8urj8/Xtww=;
	b=ePxEcwv3p+Cp4iCU7xtDjuFZqINdwVy3Mm3MWs91yuOhgt6tFqNd9URNkm85YGtq/3uHEf
	p8cioL4imSMCYtYFZXT85Qo7wDsKmTCkvrkrt5LvUhasNubxlHXcAzL5SXTrba7QB9mPwF
	pF8XStGjUa3df6C1MGpCn24CuMbcUao=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-53XYryq4O4ucChBv84Tc3w-1; Fri, 04 Jul 2025 14:14:53 -0400
X-MC-Unique: 53XYryq4O4ucChBv84Tc3w-1
X-Mimecast-MFC-AGG-ID: 53XYryq4O4ucChBv84Tc3w_1751652892
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-747ddba7c90so915371b3a.0
        for <fstests@vger.kernel.org>; Fri, 04 Jul 2025 11:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751652892; x=1752257692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4IhIibfVl8cYibtd3QJLrHiPv/dYGxvh8urj8/Xtww=;
        b=JC3DuLIUZRwYpdZCcKqXVbSsFIsZ+vs0zSkyVpGDF9IfAtVSjM1jT1UVxt/HqVUzhv
         AvSd33FdhigaQh2yumnD+uykP923EWZlYmGisr3KADCFNcCb60qFUaZzyHZrkmGdJkvO
         OveiOMOnFkjg7bxDNF8DjAVib6Z4IBRlIN2k04EItD8kUBUR6gQQuWh8fbuY/ln+jEiA
         Ce2RmFYXDciBFN36YJWgWBBi0I9cK85JOpfBBWtkNAFn7K9XYDsdzMPWoIesivK914R3
         Zb7IxcfVixHVXPGu29WLMEu8HFvIK8aoU6/9VLP3r95Z6UFe2sVhiCKgP+AkDHU+UyzN
         LFxw==
X-Forwarded-Encrypted: i=1; AJvYcCV8LnR1eq8F6I3+5nvHFEF6IQzpYPaLkEEd51uPGEsbPKDsP7aNey71YGKjA/tdsigsRg7CIQU9@vger.kernel.org
X-Gm-Message-State: AOJu0YzfrDiJ5/QU1CHchJ0d2oLP7sfT9takJaj7aoXh/OTWHv/JDy85
	hBUavJsAcihZu36N31ZS5cw8hOjBIsCGwmxqMbdQKEE4Vq+ksmxpvYtoIl9KNX6jxdA5+nZco6P
	P4IzCQCx3Ib+J1YcdWUSn8rk35uCIc1P1gsE0j4MJJPyunTt4p1wBFovfplhYerOGXoQ=
X-Gm-Gg: ASbGncutc5KSLoS6wx4OUKhfvB75YQeIn2EhnZp2+QO4um4EOugipeUHBsR5wu/lZmE
	JFVP6JEAaMDOPEfMukygkAev94vqsmohGMqaWjD6aQfy8pUUww3xosVQP43ELTlHx9a7229JeqO
	GguIKkY/KpAvL2dwHVhxfpFJSgWaDixyfS3HZDkq6VIy6GXVubeVSoSwJk7XQ6KZW3e9x3xM5yO
	DtghwIhDOKu/wXBEAJI8q43Z0WAuUQkrWsEZdAsuyvx3VQQsEX0RhCao7eYJcfIkczZh+EmXW5T
	8I2Q02gMxJuEvM5q2uHt7bsCwgX7JUxBXcDvUBRNJ76PWNO5Sa0OWXed20Y8CPo=
X-Received: by 2002:a05:6a21:7a43:b0:223:76d2:5a7 with SMTP id adf61e73a8af0-225b948850fmr6021557637.24.1751652891583;
        Fri, 04 Jul 2025 11:14:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNTZqLPQNz8aLt8ul7CEKJY1M51gJoMd5BNbfWFKG4F0lU180wOZ+AA4BoTUps/DOjDS3bsw==
X-Received: by 2002:a05:6a21:7a43:b0:223:76d2:5a7 with SMTP id adf61e73a8af0-225b948850fmr6021532637.24.1751652891171;
        Fri, 04 Jul 2025 11:14:51 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee450a61sm2553502a12.8.2025.07.04.11.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 11:14:50 -0700 (PDT)
Date: Sat, 5 Jul 2025 02:14:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs/015: test mount options
Message-ID: <20250704181446.pum4b7zp2xqvotzx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250704114818.1878294-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704114818.1878294-1-chao@kernel.org>

On Fri, Jul 04, 2025 at 07:48:18PM +0800, Chao Yu wrote:
> As f2fs changes to use new mount APIs, let's add a new testcase
> to check mount result for all f2fs supported mount options and
> their combinations, in order to detect any inconsistency during
> mount.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - allow to check mount options w/ zoned device
>  common/rc          |   3 +
>  tests/f2fs/015     | 159 ++++++++++++++++++++++++++++++++
>  tests/f2fs/015.out | 225 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 387 insertions(+)
>  create mode 100755 tests/f2fs/015
>  create mode 100644 tests/f2fs/015.out
> 
> diff --git a/common/rc b/common/rc
> index f71cc8f0..94fdce7e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -844,6 +844,9 @@ _test_mkfs()
>      ext2|ext3|ext4)
>  	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
>  	;;
> +    f2fs)
> +	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* $TEST_DEV
> +	;;
>      xfs)
>  	_test_options mkfs
>  	$MKFS_PROG -t $FSTYP -- -f $TEST_OPTIONS $MKFS_OPTIONS $* $TEST_DEV
> diff --git a/tests/f2fs/015 b/tests/f2fs/015
> new file mode 100755
> index 00000000..746e79de
> --- /dev/null
> +++ b/tests/f2fs/015
> @@ -0,0 +1,159 @@
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
> +_require_kernel_config CONFIG_F2FS_FS_XATTR
> +_require_kernel_config CONFIG_F2FS_FS_POSIX_ACL
> +_require_kernel_config CONFIG_F2FS_FAULT_INJECTION
> +_require_kernel_config CONFIG_F2FS_FS_COMPRESSION
> +_require_kernel_config CONFIG_F2FS_FS_LZO
> +_require_kernel_config CONFIG_F2FS_FS_LZORLE
> +_require_kernel_config CONFIG_F2FS_FS_LZ4
> +_require_kernel_config CONFIG_F2FS_FS_LZ4HC
> +_require_kernel_config CONFIG_F2FS_FS_ZSTD
> +
> +_require_zoned_device "$TEST_DEV"

This requirement limit this test case only on zoned device...
Maybe you can slip this test case to 2~3 cases, let some common
mount options can be tested at first, some unimportant mount
options can be tested in another case, then zoned device related
mount options be tested in a seperated case ?

Thanks,
Zorro

> +_test_unmount >> $seqres.full 2>&1
> +
> +options=(
> +#	mount_option			mkfs_option
> +	"background_gc=on"		""			\
> +	"background_gc=off"		""			\
> +	"background_gc=sync"		""			\
> +	"background_gc=on"		"blkzone"		\
> +	"background_gc=off"		"blkzone"		\
> +	"background_gc=sync"		"blkzone"		\
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
> +	"mode=adaptive"			"blkzone"		\
> +	"mode=lfs"			"blkzone"		\
> +	"mode=fragment:segment"		"blkzone"		\
> +	"mode=fragment:block"		"blkzone"		\
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
> +	"compress_algorithm=zstd:1"	"extra,compression"	\
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
> +	"discard_unit=block"		"blkzone"		\
> +	"discard_unit=segment"		"blkzone"		\
> +	"discard_unit=section"		"blkzone"		\
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
> +	if [ "${options[$((i+1))]}" == "blkzone" ]; then
> +		_test_mkfs "-m" >> $seqres.full
> +		_test_mount "-o ${options[$i]}" >> $seqres.full 2>&1
> +		echo $?
> +		_test_unmount >> $seqres.full 2>&1
> +	else
> +		_scratch_mkfs "-O ${options[$((i+1))]}" >> $seqres.full
> +		_try_scratch_mount "-o ${options[$i]}" >> $seqres.full 2>&1
> +		echo $?
> +		_scratch_unmount >> $seqres.full 2>&1
> +	fi
> +done
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/015.out b/tests/f2fs/015.out
> new file mode 100644
> index 00000000..d7f4e62a
> --- /dev/null
> +++ b/tests/f2fs/015.out
> @@ -0,0 +1,225 @@
> +QA output created by 015
> +Option#0: background_gc=on : 
> +0
> +Option#2: background_gc=off : 
> +0
> +Option#4: background_gc=sync : 
> +0
> +Option#6: background_gc=on : blkzone
> +0
> +Option#8: background_gc=off : blkzone
> +32
> +Option#10: background_gc=sync : blkzone
> +0
> +Option#12: disable_roll_forward : 
> +0
> +Option#14: norecovery : 
> +32
> +Option#16: discard : 
> +0
> +Option#18: nodiscard : 
> +0
> +Option#20: no_heap : 
> +0
> +Option#22: heap : 
> +0
> +Option#24: user_xattr : 
> +0
> +Option#26: nouser_xattr : 
> +0
> +Option#28: acl : 
> +0
> +Option#30: noacl : 
> +0
> +Option#32: active_logs=2 : 
> +0
> +Option#34: active_logs=4 : 
> +0
> +Option#36: active_logs=6 : 
> +0
> +Option#38: disable_ext_identify : 
> +0
> +Option#40: inline_xattr : 
> +0
> +Option#42: noinline_xattr : 
> +0
> +Option#44: inline_xattr_size=400 : extra,flexible_inline_xattr
> +32
> +Option#46: inline_xattr_size=400 : 
> +32
> +Option#48: inline_data : 
> +0
> +Option#50: noinline_dentry : 
> +0
> +Option#52: inline_dentry : 
> +0
> +Option#54: noinline_dentry : 
> +0
> +Option#56: flush_merge : 
> +0
> +Option#58: noflush_merge : 
> +0
> +Option#60: barrier : 
> +0
> +Option#62: nobarrier : 
> +0
> +Option#64: fastboot : 
> +0
> +Option#66: extent_cache : 
> +0
> +Option#68: noextent_cache : 
> +0
> +Option#70: data_flush : 
> +0
> +Option#72: reserve_root=32768 : 
> +0
> +Option#74: resuid=1000 : 
> +0
> +Option#76: resgid=1000 : 
> +0
> +Option#78: fault_injection=100 : 
> +0
> +Option#80: fault_type=4095 : 
> +0
> +Option#82: mode=adaptive : 
> +0
> +Option#84: mode=lfs : 
> +0
> +Option#86: mode=fragment:segment : 
> +0
> +Option#88: mode=fragment:block : 
> +0
> +Option#90: mode=adaptive : blkzone
> +32
> +Option#92: mode=lfs : blkzone
> +0
> +Option#94: mode=fragment:segment : blkzone
> +32
> +Option#96: mode=fragment:block : blkzone
> +32
> +Option#98: usrquota : 
> +0
> +Option#100: grpquota : 
> +0
> +Option#102: prjquota : 
> +32
> +Option#104: usrjquota=ausrquota : 
> +32
> +Option#106: grpjquota=agrpquota : 
> +32
> +Option#108: prjjquota=aprjquota : 
> +32
> +Option#110: jqfmt=vfsold : 
> +0
> +Option#112: jqfmt=vfsv0 : 
> +0
> +Option#114: jqfmt=vfsv1 : 
> +0
> +Option#116: usrjquota= : 
> +0
> +Option#118: grpjquota= : 
> +0
> +Option#120: prjjquota= : 
> +0
> +Option#122: quota : 
> +0
> +Option#124: noquota : 
> +0
> +Option#126: alloc_mode=reuse : 
> +0
> +Option#128: alloc_mode=default : 
> +0
> +Option#130: fsync_mode=posix : 
> +0
> +Option#132: fsync_mode=strict : 
> +0
> +Option#134: fsync_mode=nobarrier : 
> +0
> +Option#136: test_dummy_encryption : 
> +32
> +Option#138: test_dummy_encryption=v1 : 
> +32
> +Option#140: test_dummy_encryption=v2 : 
> +32
> +Option#142: checkpoint=enable : 
> +0
> +Option#144: checkpoint=disable : 
> +0
> +Option#146: checkpoint=disable:32768 : 
> +0
> +Option#148: checkpoint=disable:50% : 
> +0
> +Option#150: checkpoint_merge : 
> +0
> +Option#152: nocheckpoint_merge : 
> +0
> +Option#154: compress_algorithm=lzo : 
> +0
> +Option#156: compress_algorithm=lzo : extra,compression
> +0
> +Option#158: compress_algorithm=lz4 : extra,compression
> +0
> +Option#160: compress_algorithm=zstd : extra,compression
> +0
> +Option#162: compress_algorithm=lzo-rle : extra,compression
> +0
> +Option#164: compress_algorithm=lz4:3 : extra,compression
> +0
> +Option#166: compress_algorithm=zstd:1 : extra,compression
> +0
> +Option#168: compress_log_size=8 : extra,compression
> +0
> +Option#170: compress_extension=so : extra,compression
> +0
> +Option#172: nocompress_extension=so : extra,compression
> +0
> +Option#174: nocompress_extension=* : extra,compression
> +0
> +Option#176: compress_extension=so,nocompress_extension=so : extra,compression
> +0
> +Option#178: compress_chksum : extra,compression
> +0
> +Option#180: compress_mode=fs : extra,compression
> +0
> +Option#182: compress_mode=user : extra,compression
> +0
> +Option#184: compress_cache : extra,compression
> +0
> +Option#186: inlinecrypt : 
> +0
> +Option#188: atgc : 
> +0
> +Option#190: discard_unit=block : 
> +0
> +Option#192: discard_unit=segment : 
> +0
> +Option#194: discard_unit=section : 
> +0
> +Option#196: discard_unit=block : blkzone
> +0
> +Option#198: discard_unit=segment : blkzone
> +0
> +Option#200: discard_unit=section : blkzone
> +0
> +Option#202: memory=normal : 
> +0
> +Option#204: memory=low : 
> +0
> +Option#206: age_extent_cache : 
> +0
> +Option#208: errors=panic : 
> +0
> +Option#210: errors=continue : 
> +0
> +Option#212: errors=remount-ro : 
> +0
> +Option#214: nat_bits : 
> +0
> +Option#216: atgc,mode=lfs : 
> +32
> +Option#218: ro,flush_merge : 
> +32
> +Option#220: rw : ro
> +0
> +Option#222: norecovery,ro : 
> +0
> -- 
> 2.49.0
> 

