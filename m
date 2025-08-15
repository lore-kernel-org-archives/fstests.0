Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CB01E7C34
	for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273655; cv=none; b=OoREfhq9t/3Utueo3rZAI9KgROP7JhReVm4xICCHaPfejjXTdLGZjcu5zjc2kSgUVEF6WUqhFExw2X/ENYAzEirNvbNpeCrxiYlBMqTguja2idIwTlOCH526XieCjybAVwGRYIMtUi7TqXR+QpfeR1dDAKAhohOxSVKf/w/3p3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273655; c=relaxed/simple;
	bh=4fL6TF+OEpbSUcdc3EVCVkJGlrx5Rd+TY+MsUYASZcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvYKAgZB1h46993Mz68z9Pc7gWafx2PJYEJ9SlOVTxSz/dQtJayKmCMmquxMPnftr/L3N3XXESN+Pv9xJF33UNAP+TJvHWliqYkRGDYADAeD/V1uFVvBRK7O3FmDbPSsrQ2gPpsZJSoB9LyEVTpc9l436Ee0WQHPhMfC3IqSO18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=djbmKzFu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djbmKzFu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755273652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jp1PX+AOUQIhnbS4CXc7w8KsHa1VC6udXIXvYmjjWjc=;
	b=djbmKzFuyyvZ6vNGV79oQ6ARuiDtxgHvcAJcGr8Uc5kSV7/+edivorSbWvBkoyHOLH1SOf
	qiZtqdy+Crar49vFO4cLzwzzV+25PiZbkcl/7HmGA1DvHsQmvyQAiFCoPLIYbQfcQtVCzd
	Z66hNgNIsOxXuP/mMdQ5ANiWZQOEfp4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-xq4SAosjMZGNmMX1RnU1_Q-1; Fri, 15 Aug 2025 12:00:50 -0400
X-MC-Unique: xq4SAosjMZGNmMX1RnU1_Q-1
X-Mimecast-MFC-AGG-ID: xq4SAosjMZGNmMX1RnU1_Q_1755273650
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2ead3b51so3438842b3a.2
        for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 09:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755273649; x=1755878449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jp1PX+AOUQIhnbS4CXc7w8KsHa1VC6udXIXvYmjjWjc=;
        b=qeLG6piWje1L5striPf4LzAVlABbH9aunr+N6zY2YiRsTf+KZxLlRQWeXYPylNXp99
         QA87eh6cxF9Vkcy7qHGVMOyEkqnfOQvGXiCW4B1BXEq+lcSMGNksCffwvsSX5hnyHd/Y
         iO8l9Y1qOZiMt89WJokWkWCzQFEAnGUwy5bdxTNBSfTRoaZcKV+917s+X6nKhVi5vetp
         WVOLEbz147xLuFw521lfQ+UURTXhWoNMxyQsEAHSnFzuZwk9L6a7mrftYL/0MkYapJ5i
         tYQH3P2TK8ooESZrDybZOwlCDkrqBhEB+0QXdZpi8B0+UhNWjBWgOcxd2eh2U70KF+gZ
         tgEg==
X-Forwarded-Encrypted: i=1; AJvYcCWidODj3JeI65M0oEbkpZE9ZNT970hcSK1Jl2fIfuAHHeJCSqZh6HQ9Zx/djC7kg7yhZ6zJvHXb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3QCHzMxUcAIgHIHH/f1iOvaLmAwumsswwvKhgCyafSJyAg9Lv
	EDOJYk/FsYTkCDHi08k420iDdlGv7RR68cQoTPoNQUtFciKvVIX02pFPqlg3a3Qi/kGEJoUKp5W
	eI4boLQBFhGBq3W4giqK1WmCRkz4oK06kykh6zwUVFWIix2Eb8y1OKlng0ftabKPNJqg=
X-Gm-Gg: ASbGncuDYpzQvfOcR7aWd8wdtQT3vfebvgkrd1aaYCK8B+NAQc4s9ZAWPiQHbBf8xf0
	luryQ/sdDTe/xn/PQfvECmxRJyGbXiLElob22kSJthgGvozdCWJlmnQbpBWF+fbHr+EgMtvc9aS
	6oNrnOLL/YbJQ4mcOcRITLEHcbUdUMxeVfgCAzidtPqOvTCHCaPq/UOkU5+qTEjnsSKka+8DLx5
	4eUKGUwvqaA/iwReEUW0z6YvuyY7oVQ5Db2pgD6aDOpNcOMIOUqQcB4CJA/VBUNiQYALS6EskhS
	xZ+jhzxFtuuIskbEvlc3ZPNnXWbFC6+pSt8XjmhUqxD93VeSx+BQrsFhrW5LNS4XUsafS8WrlOt
	QfZ6+
X-Received: by 2002:a05:6a20:734f:b0:240:1de:8bdb with SMTP id adf61e73a8af0-240d2fed245mr4293924637.30.1755273649174;
        Fri, 15 Aug 2025 09:00:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHjcIiOd/VMu8eOTrV6+IjbR0JkdHjIT+JVLUji8iUqnv4iWhGh9afTHWDhQfU7AFS71FEQQ==
X-Received: by 2002:a05:6a20:734f:b0:240:1de:8bdb with SMTP id adf61e73a8af0-240d2fed245mr4293686637.30.1755273647200;
        Fri, 15 Aug 2025 09:00:47 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45593da9sm1399452b3a.105.2025.08.15.09.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:00:46 -0700 (PDT)
Date: Sat, 16 Aug 2025 00:00:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 1/3] f2fs/015: test common mount options
Message-ID: <20250815160042.pavsszqk5n3izmdm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250804114016.2734919-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804114016.2734919-1-chao@kernel.org>

On Mon, Aug 04, 2025 at 07:40:14PM +0800, Chao Yu wrote:
> As f2fs changes to use new mount APIs, let's add a new testcase
> to check mount result for all f2fs supported common mount options
> and their combinations, in order to detect any inconsistency during
> mount.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

I forgot this patchset. This version is good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc          |   3 +
>  tests/f2fs/015     | 121 +++++++++++++++++++++++++++++++
>  tests/f2fs/015.out | 173 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 297 insertions(+)
>  create mode 100755 tests/f2fs/015
>  create mode 100644 tests/f2fs/015.out
> 
> diff --git a/common/rc b/common/rc
> index ff5df203..81587dad 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -876,6 +876,9 @@ _test_mkfs()
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
> index 00000000..73ac3d82
> --- /dev/null
> +++ b/tests/f2fs/015
> @@ -0,0 +1,121 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/015
> +#
> +# This testcase tries to check stability of mount result
> +# w/ common mount option and their combination.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick mount
> +_require_kernel_config CONFIG_F2FS_FS_XATTR
> +_require_kernel_config CONFIG_F2FS_FS_POSIX_ACL
> +_require_kernel_config CONFIG_F2FS_FAULT_INJECTION
> +
> +options=(
> +#	mount_option			mkfs_option
> +	"background_gc=on"		""			\
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
> +
> +	if [ "${options[$((i+1))]}" ]; then
> +		_scratch_mkfs "-O ${options[$((i+1))]}" >> $seqres.full || _fail "mkfs failed"
> +	else
> +		_scratch_mkfs >> $seqres.full || _fail "mkfs failed"
> +	fi
> +	_try_scratch_mount "-o ${options[$i]}" >> $seqres.full 2>&1
> +	echo $?
> +	_scratch_unmount >> $seqres.full 2>&1
> +done
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/015.out b/tests/f2fs/015.out
> new file mode 100644
> index 00000000..8d6712f0
> --- /dev/null
> +++ b/tests/f2fs/015.out
> @@ -0,0 +1,173 @@
> +QA output created by 015
> +Option#0: background_gc=on : 
> +0
> +Option#2: background_gc=off : 
> +0
> +Option#4: background_gc=sync : 
> +0
> +Option#6: disable_roll_forward : 
> +0
> +Option#8: norecovery : 
> +32
> +Option#10: discard : 
> +0
> +Option#12: nodiscard : 
> +0
> +Option#14: no_heap : 
> +0
> +Option#16: heap : 
> +0
> +Option#18: user_xattr : 
> +0
> +Option#20: nouser_xattr : 
> +0
> +Option#22: acl : 
> +0
> +Option#24: noacl : 
> +0
> +Option#26: active_logs=2 : 
> +0
> +Option#28: active_logs=4 : 
> +0
> +Option#30: active_logs=6 : 
> +0
> +Option#32: disable_ext_identify : 
> +0
> +Option#34: inline_xattr : 
> +0
> +Option#36: noinline_xattr : 
> +0
> +Option#38: inline_xattr_size=400 : 
> +0
> +Option#40: inline_data : 
> +0
> +Option#42: noinline_dentry : 
> +0
> +Option#44: inline_dentry : 
> +0
> +Option#46: noinline_dentry : 
> +0
> +Option#48: flush_merge : 
> +0
> +Option#50: noflush_merge : 
> +0
> +Option#52: barrier : 
> +0
> +Option#54: nobarrier : 
> +0
> +Option#56: fastboot : 
> +0
> +Option#58: extent_cache : 
> +0
> +Option#60: noextent_cache : 
> +0
> +Option#62: data_flush : 
> +0
> +Option#64: reserve_root=32768 : 
> +0
> +Option#66: resuid=1000 : 
> +0
> +Option#68: resgid=1000 : 
> +0
> +Option#70: fault_injection=100 : 
> +0
> +Option#72: fault_type=4095 : 
> +0
> +Option#74: mode=adaptive : 
> +0
> +Option#76: mode=lfs : 
> +0
> +Option#78: mode=fragment:segment : 
> +0
> +Option#80: mode=fragment:block : 
> +0
> +Option#82: usrquota : 
> +0
> +Option#84: grpquota : 
> +0
> +Option#86: prjquota : 
> +32
> +Option#88: usrjquota=ausrquota : 
> +32
> +Option#90: grpjquota=agrpquota : 
> +32
> +Option#92: prjjquota=aprjquota : 
> +32
> +Option#94: jqfmt=vfsold : 
> +0
> +Option#96: jqfmt=vfsv0 : 
> +0
> +Option#98: jqfmt=vfsv1 : 
> +0
> +Option#100: usrjquota= : 
> +0
> +Option#102: grpjquota= : 
> +0
> +Option#104: prjjquota= : 
> +0
> +Option#106: quota : 
> +0
> +Option#108: noquota : 
> +0
> +Option#110: alloc_mode=reuse : 
> +0
> +Option#112: alloc_mode=default : 
> +0
> +Option#114: fsync_mode=posix : 
> +0
> +Option#116: fsync_mode=strict : 
> +0
> +Option#118: fsync_mode=nobarrier : 
> +0
> +Option#120: test_dummy_encryption : 
> +0
> +Option#122: test_dummy_encryption=v1 : 
> +0
> +Option#124: test_dummy_encryption=v2 : 
> +0
> +Option#126: checkpoint=enable : 
> +0
> +Option#128: checkpoint=disable : 
> +0
> +Option#130: checkpoint=disable:32768 : 
> +0
> +Option#132: checkpoint=disable:50% : 
> +0
> +Option#134: checkpoint_merge : 
> +0
> +Option#136: nocheckpoint_merge : 
> +0
> +Option#138: compress_algorithm=lzo : 
> +0
> +Option#140: inlinecrypt : 
> +0
> +Option#142: atgc : 
> +0
> +Option#144: discard_unit=block : 
> +0
> +Option#146: discard_unit=segment : 
> +0
> +Option#148: discard_unit=section : 
> +0
> +Option#150: memory=normal : 
> +0
> +Option#152: memory=low : 
> +0
> +Option#154: age_extent_cache : 
> +0
> +Option#156: errors=panic : 
> +0
> +Option#158: errors=continue : 
> +0
> +Option#160: errors=remount-ro : 
> +0
> +Option#162: nat_bits : 
> +0
> +Option#164: atgc,mode=lfs : 
> +32
> +Option#166: ro,flush_merge : 
> +32
> +Option#168: rw : ro
> +0
> +Option#170: norecovery,ro : 
> +0
> -- 
> 2.49.0
> 

