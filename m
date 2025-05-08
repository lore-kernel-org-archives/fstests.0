Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC65328A1C6
	for <fstests@vger.kernel.org>; Thu,  8 May 2025 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732365; cv=none; b=np30hAXzJ3c/HpMqQHovbRhwKOSGNpyovl+9u3gJcyVr5hn7h7NNSKjRQY2n4L4tMmqGF27KL5nlAsMI3fYJqnV9o1+HMXX6+Ca5awW35YOhGYBv1JKHohJ+ZvZQcHZjV2xh2kMdp8luunSQkr8a6XMuSFKuQh+Oyi66yGoTaBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732365; c=relaxed/simple;
	bh=u5ZRTyuJRwF50m41vhX9H3hfeEHSNxiRot7wrGIFeWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2uBtkasbHjYI4YAz28OILLk7d93FuEi4Y1F19dPTTYuws+0rlFOBoC0fHk1rMjybuh/uH68WSV0ZH0ivEkV7Ej6R/AqXlk29hHVPbtTa9AMPnchCj6wVhNcnUfE7LP5ycBjKqcoIaWUdyGVQ2PPFq2Bsu/CEkIki+Ab4Gr8Gfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ad/JqStq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ad/JqStq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746732362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nOEZ3Z4gprgV0eoVphm2mn4dPOAQZ82KJIfJEGplbHA=;
	b=Ad/JqStqmvk8k4UmWbODSnv7V+bTUeX/uhYo7nGoHhchZYE8n4IYuHN5ySjUVcfvodhXin
	u1smShCEI1S/MrsqtuR/Ol4DjF/zrrxFH8TTIlOXc9iVykQZV9kRjGk75uXJTONfd3iI//
	cDh+FsG43Zmb++6q/wo9VFftdXts8FQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-FA7oBpWbN0ukrFnsDMFRKQ-1; Thu, 08 May 2025 15:26:01 -0400
X-MC-Unique: FA7oBpWbN0ukrFnsDMFRKQ-1
X-Mimecast-MFC-AGG-ID: FA7oBpWbN0ukrFnsDMFRKQ_1746732361
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-739764217ecso1367530b3a.0
        for <fstests@vger.kernel.org>; Thu, 08 May 2025 12:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746732360; x=1747337160;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nOEZ3Z4gprgV0eoVphm2mn4dPOAQZ82KJIfJEGplbHA=;
        b=rvRqi/GEIXyuTyEiUicDHcA9NJKBxrMfljryQwVzZ2Au+cIxrOr1EQx/Tmjk6S0KPv
         2ka2WyEwsGGKMDgbXRUJ1Ove0eaILEgO7wpEAIjKM+e282l2PXzPv5Sp8PywFW2VYenS
         6S5bZQwRWCBiImJk9VbcClw7gd2TNNi5+p7IadpcTBJs3SnLm5l8n9ClivcNr9gNua0l
         PUagPeY4p/mxyozDt4WMGFlsajmmABQdUxND73/NwVI5Di6Y+AaAajpDigEm/s70Q2mU
         o0wjeg5e9dGIcHeiNMvMEeyPD5ntXWcPuNXAumGC2I1e9DHqyuJia5tLKfiquNZyrQag
         wiog==
X-Forwarded-Encrypted: i=1; AJvYcCWAMrcmHLfAx3W/IwzlH6rK78X6HetUm+3gdPfCTJPTHIOfzXHAFQem0lJa43I5pvGc9vGk4uKW@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZv+96RRISfCZHeG/OVVUwkTn4mLkXsl3blyYdC2D3Dyp3yzs
	KhjxrBamq9rS3mT0n+Cxmunoe7gH1GIf9YbewSWnKgjj3qAEP6VO2N12ES7MvNtMdUQo1glszzv
	qLDTT4hND75t1+UZrOY8fIsBLQSkuqob4ITIbNzfPB26gPF6N02GPyQe4cTDlJYQ=
X-Gm-Gg: ASbGncsKZdcZPzTwPdNQPrORXTEIXDeAHAicYSOrJ/ZS7mZrtbz4IxjyL/Nxn5REudq
	feDENVjMRIjZM/nnis7EZ/UYen77UUhosQFj0ucRhih5m2Ho+5nPlorSn94fSg/JnAg+4CXoBoY
	a4a3QJkne06Ff57vE0IbKnUCDKrEgGbvlvajVUwGq6aEiN944xpRWhn2HGDIuhuSzg8wGjpGVLk
	Eou1ajv3aW5bmPWPAEoPjxBn3IBODdIWFABbZfJ8Y2EKBB31KwaaSTUTC6bvItTNtsNJMJP3Y44
	flP8yGtFnQzIg/jFhCTFUCrfHpkP+21z6cAQlkm0uyOT/D8HIyM7
X-Received: by 2002:a05:6a00:2f52:b0:73e:356:98b0 with SMTP id d2e1a72fcca58-740a94e63e7mr6126719b3a.8.1746732360414;
        Thu, 08 May 2025 12:26:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKFDM/p//EPxZrqhAehjFHlzGYiSfOQUOhYxPVzQh79kxCgOQXC3mtOrwwcQjENORwLmcM+g==
X-Received: by 2002:a05:6a00:2f52:b0:73e:356:98b0 with SMTP id d2e1a72fcca58-740a94e63e7mr6126691b3a.8.1746732360024;
        Thu, 08 May 2025 12:26:00 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237734c4asm407201b3a.57.2025.05.08.12.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 12:25:59 -0700 (PDT)
Date: Fri, 9 May 2025 03:25:55 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Daniel Lee <chullee@google.com>
Subject: Re: [PATCH v3] f2fs/012: test red heart lookup
Message-ID: <20250508192555.7sw42hmrye2jqznb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250507053642.842805-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250507053642.842805-1-chao@kernel.org>

On Wed, May 07, 2025 at 01:36:42PM +0800, Chao Yu wrote:
> As Han Qi reported in bugzilla [1], commit 5c26d2f1d3f5 ("unicode: Don't
> special case ignorable code points") changes logic to handle ignorable
> code points, when we handle filename which has special unicode charactor
> like red heart ❤️, utf8_casefold() may return different length than in the
> past, result in that f2fs cacluates hash code incorreclty, eventually,
> filename w/ special unicode charactor will not be found w/ the wrong hash
> code.
> 
> f2fs has introduced a linear lookup fallback w/ commit 91b587ba79e1
> ("f2fs: Introduce linear search for dentries"), once hash-based lookup
> fails, it tries linear lookup as a fallback.
> 
> This patch can help to check whether linear lookup fallback works well
> or not.
> 
> Firstly, we use below testcase to check how hash code changes:
> 
> mkfs.f2fs -f -O casefold -C utf8 /dev/vda
> mount /dev/vda /mnt/f2fs
> mkdir /mnt/f2fs/dir/
> f2fs_io setflags casefold /mnt/f2fs/dir
> touch /mnt/f2fs/dir/$'\u2764\ufe0f'
> umount /mnt/f2fs
> dump.f2fs -i 4 -d 3 /dev/vda
> dump.f2fs -b $blkaddr_of_dir -d 3 /dev/vda
> 
> w/o ("unicode: Don't special case ignorable code points")
> [dump_dirent: 991] bitmap pos[0x2] name[❤️] len[0x6] hash[0x19dd7132] ino[0x5] type[0x1]
> [dump_dirent: 998] name(hex)[0xe2 0x9d 0xa4 0xef 0xb8 0x8f 0x0]
> 
> w/ ("unicode: Don't special case ignorable code points")
> [dump_dirent: 991] bitmap pos[0x2] name[❤️] len[0x6] hash[0x9a2ea068] ino[0x5] type[0x1]
> [dump_dirent: 998] name(hex)[0xe2 0x9d 0xa4 0xef 0xb8 0x8f 0x0]
> 
> Correct hash code:	0x19dd7132
> Wrong hash code:	0x9a2ea068
> 
> So, we can test as below:
> 
> 1. create file w/ red heart as its filename
> 2. inject wrong hash code to the file
> 3. disable linear lookup, expect lookup failure
> 4. enable linear lookup, expect lookup succeed
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219586
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Daniel Lee <chullee@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v3:
> - use _require_scratch_nocheck instead of _require_scratch to avoid
> _check_filesystems failure on corrupted image
> - fix typo: s/introduces/introduced

This version is good to me, thanks!

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/f2fs/012     | 70 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/012.out |  2 ++
>  2 files changed, 72 insertions(+)
>  create mode 100755 tests/f2fs/012
>  create mode 100644 tests/f2fs/012.out
> 
> diff --git a/tests/f2fs/012 b/tests/f2fs/012
> new file mode 100755
> index 00000000..b3df9a8f
> --- /dev/null
> +++ b/tests/f2fs/012
> @@ -0,0 +1,70 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/012
> +#
> +# This testcase checks whether linear lookup fallback works well
> +# or not as below:
> +# 1.create file w/ red heart as its filename
> +# 2.inject wrong hash code to the file
> +# 3.disable linear lookup, expect lookup failure
> +# 4.enable linear lookup, expect lookup succeed
> +#
> +. ./common/preamble
> +_begin_fstest auto quick casefold
> +
> +_fixed_by_kernel_commit 91b587ba79e1 \
> +	"f2fs: Introduce linear search for dentries"
> +
> +export LC_ALL=C.UTF-8
> +_require_scratch_nocheck
> +_require_command "$F2FS_IO_PROG" f2fs_io
> +_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +
> +check_lookup()
> +{
> +	local nolinear_lookup=$1
> +	local dir=$SCRATCH_MNT/dir
> +	# red heart charactor in unicode format
> +	local redheart=$dir/$'\u2764\ufe0f'
> +
> +	_scratch_mkfs -O casefold -C utf8 >> $seqres.full
> +	_scratch_mount
> +
> +	mkdir $dir
> +	$F2FS_IO_PROG setflags casefold $dir >> $seqres.full
> +	touch $redheart
> +	ino=`stat -c '%i' $redheart`
> +	_scratch_unmount
> +
> +	# should tune nolinear_lookup feature before fault injection
> +	$F2FS_FSCK_PROG --nolinear-lookup=$nolinear_lookup $SCRATCH_DEV >> $seqres.full
> +
> +	# check whether linear_lookup is changed as expected
> +	if [ $nolinear_lookup == "1" ]; then
> +		$F2FS_FSCK_PROG $SCRATCH_DEV | grep -q "linear_lookup \[disable\]" ||	\
> +					_fail "linear_lookup is not disabled"
> +	else
> +		$F2FS_FSCK_PROG $SCRATCH_DEV | grep -q "linear_lookup \[enable\]" ||	\
> +					_fail "linear_lookup is not enabled"
> +	fi
> +
> +	$F2FS_INJECT_PROG --dent --mb d_hash --nid $ino --val 0x9a2ea068 $SCRATCH_DEV >> $seqres.full
> +
> +	_scratch_mount
> +	if [ $nolinear_lookup == "1" ]; then
> +		[ -f $redheart ] && _fail "red heart file should not exist"
> +	else
> +		[ -f $redheart ] || _fail "red heart file should exist"
> +	fi
> +	_scratch_unmount
> +}
> +
> +check_lookup 1
> +check_lookup 0
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/012.out b/tests/f2fs/012.out
> new file mode 100644
> index 00000000..3afeca2f
> --- /dev/null
> +++ b/tests/f2fs/012.out
> @@ -0,0 +1,2 @@
> +QA output created by 012
> +Silence is golden
> -- 
> 2.49.0
> 

