Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D0B1DDC1E
	for <fstests@vger.kernel.org>; Wed,  7 May 2025 05:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746594526; cv=none; b=gaZXBrUiDVoe1n/Yln8tx6VKik0NrltPf6tmvV8UtJmPJOrlabEGnt8bQkQnNTFzomxVOIrqwGroha2EcF8PwQtBj5bWFK3XDbFkqxQiJfD6uMT0kKrP5UhDXd+BeU5SQD5jCVKNS2uvacqQfXedPHeL8OUixD/mrQakW73kAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746594526; c=relaxed/simple;
	bh=8ZX9JlhUjFIMIzsAlQzPtJCknKOWJ/53LZg6WccAO1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQfIVuFZB0unw8t8tSngkNhaFCWeKZSX0D3LSLaAhhypTlx3SNsV5VIEOuhgdJ9qOigf3jjvm9AYKHK7X/9ui9ASkyZzubfWRuyzQhQFK1+ueZQKHHcjBE2JZsjP8fqUWBasUlRK6Z6+R9+sQCi70TCavGam9N9XG69Bw/9fpbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBoz0J5j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBoz0J5j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746594522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmIuv+NVMknYCAE6TCTFvWQhIXOSC9EkxcL92TtRf2k=;
	b=cBoz0J5jPwfpz4/MpQD6TzaJ7HPE82jpbMaUj6UN+s9AhycjDS86eyZdCor9YQjYnYPvuA
	Ov/g4PW1CHERVRljsM2PkkToTPyK8j72tt0MHppYPzuiUX/CL0+YYS0BQDIPwOnFEmIjUe
	W9oqLisMMXYZPIpE9wlU/ZySmYBZqmI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-p9MJEQATNaa7fpr-Bj4ZWA-1; Wed, 07 May 2025 01:08:39 -0400
X-MC-Unique: p9MJEQATNaa7fpr-Bj4ZWA-1
X-Mimecast-MFC-AGG-ID: p9MJEQATNaa7fpr-Bj4ZWA_1746594518
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22e50d4f49bso15576985ad.1
        for <fstests@vger.kernel.org>; Tue, 06 May 2025 22:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746594518; x=1747199318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmIuv+NVMknYCAE6TCTFvWQhIXOSC9EkxcL92TtRf2k=;
        b=M5QRHrLPWVEZ8DDSPokQ01HjxIC23SrVFGxvT3HDhn6dpZIJYQ8cjC0uvgyU/4CIh4
         uELprycr723pu8zxqzoXuZkBsgm00UOka0no9A6q+5MN29iZmWSuygwN8VoUICUALXN6
         q+lasQmwGvmhCR1cqKQiOH4NrbwR8XywAyd5vugpXWiCJLzE2m25Omj7+nA6gJ4Pb2K9
         8P7nyTMK71q8oE6SCIO6F6Pe1uLHBg/lYVIUWP9eU1nORHyyxeQzrAGGIW//LIAi2k2s
         y/w3mY888HzKPlEhyXm1LyPVBqENnhicv4OVUyQ4Y5lgQu7yJox7oL7P/NHIii11zdw5
         /MvA==
X-Forwarded-Encrypted: i=1; AJvYcCU7AMtJs6L3vJpfsZeUWc4713po4dRGZu/dk2GzlK+/uMbisBabZETWg+YrUq+zHJOaTsdnL2/Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo2kTYwS17/7vASoR0j+WLZaOzhtFBDmjY73zGCKWvToDkeE9H
	MT8YDJLOe2KLeNg3CwFGO+UpBaF88NlEH3Lkly2JhLpb1xK4SLvfcPINpZT6AMmENbIWrPKAV9q
	ayj5XljUTNJSF+UyrfKHE1pVV3w1veeuc4j7Qffj5YjkZ9yPcUOso87A=
X-Gm-Gg: ASbGnctxP6ULvpwq0vypYx0BvRs9IKN4dKXZxX7eW8/jL1V12X7ZyI7Vo5hZyW701JK
	oK7agP+x3RjWWcfbJxhTmeFD2V+3NE7BYmwmeWUV0KzfDS2jIi3+/n4+zmSHY6hO2ef0K9x3kcR
	+1PtfMrQE+PbWGYc7DSj0F8pQhFrYB9W+w419FzNzW4uxB5gSvE+TxBX0wc84PBnAvTnMgHRFJJ
	fE0bonvtE9Un9tb+XNjhQOep6pevtMjp3Go3ngWEPUlxBjc7/OFXUre3qhl+oRrFxGYdf1tjOdo
	8kQR7eMUDMGlanEH+CE8ad33rQNCkoRaoQ+KW1PdaKyS8Fp1CpOQ
X-Received: by 2002:a17:902:d4ce:b0:21f:35fd:1b6c with SMTP id d9443c01a7336-22e5ede6912mr26160935ad.45.1746594518252;
        Tue, 06 May 2025 22:08:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsouU9Velf8EBfVx/RQ+IkBNoIeu46dxROrVEsTyz4Z53WH9ttelpZhq0ou7ZszouACsVrRw==
X-Received: by 2002:a17:902:d4ce:b0:21f:35fd:1b6c with SMTP id d9443c01a7336-22e5ede6912mr26160765ad.45.1746594517881;
        Tue, 06 May 2025 22:08:37 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e70b96c1bsm19985ad.83.2025.05.06.22.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 22:08:37 -0700 (PDT)
Date: Wed, 7 May 2025 13:08:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Daniel Lee <chullee@google.com>
Subject: Re: [PATCH v2] f2fs/012: test red heart lookup
Message-ID: <20250507050833.f72gsjv4xc4fdhuf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250415093822.1100476-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250415093822.1100476-1-chao@kernel.org>

On Tue, Apr 15, 2025 at 05:38:22PM +0800, Chao Yu wrote:
> As Han Qi reported in bugzilla [1], commit 5c26d2f1d3f5 ("unicode: Don't
> special case ignorable code points") changes logic to handle ignorable
> code points, when we handle filename which has special unicode charactor
> like red heart ❤️, utf8_casefold() may return different length than in the
> past, result in that f2fs cacluates hash code incorreclty, eventually,
> filename w/ special unicode charactor will not be found w/ the wrong hash
> code.
> 
> f2fs has introduces a linear lookup fallback w/ commit 91b587ba79e1
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

Sorry for this late review, this verssion looks good to me, just one review point
as below ..

> v2:
> - tune linear_lookup feature before fault injection
> - check status after tuning linear_lookup feature
> - clean up codes
>  tests/f2fs/012     | 73 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/012.out |  2 ++
>  2 files changed, 75 insertions(+)
>  create mode 100755 tests/f2fs/012
>  create mode 100644 tests/f2fs/012.out
> 
> diff --git a/tests/f2fs/012 b/tests/f2fs/012
> new file mode 100755
> index 00000000..38a63f2e
> --- /dev/null
> +++ b/tests/f2fs/012
> @@ -0,0 +1,73 @@
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
> +_require_scratch
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
> +
> +	# to avoid _check_filesystems failure in the end of test
> +	_repair_scratch_fs >> $seqres.full

If you want to make sure "fsck.f2fs can repair above corruption", then this comment isn't right.
If you just want to avoid _check_filesystems failure, you can replace _require_scratch with
_require_scratch_nocheck, then remove this line.

Thanks,
Zorro

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

