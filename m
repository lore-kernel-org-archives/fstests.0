Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754A372AA9
	for <fstests@vger.kernel.org>; Thu, 20 Nov 2025 01:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763601319; cv=none; b=p8M9p2AZYbEpdYJSiNc80nvF6Y/4xflui6nPX8nSvK3MwbCrepY+uMGOYDFnQv91u2MQXWM/s3e0FWtkPJmt7k6CEU/MK1J39NX8zQ0ZG4iP3D3jycGO8V1JDYqoDznhiv6zABA4zjsEhxUIbt8dkBQMCKmvdhQiHAgKyWkJJWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763601319; c=relaxed/simple;
	bh=enrbeARSJgv/CaMiA7uXqQrBJp4Pb05gpkgC+U48+tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJ7qTM+dgn8K3eKhTvPm/pwxYfmBYfsYhDKoxRZLo33ul6YuCDwJgNWAar7fJDol6eBsk1lNqJ/t4D2MD7CVLB5/e881WaMFCQcMwAHhoJQrgTNHoKWhKUlnF+44NyEiZRTp+ypK5ypwIYFrNdgWR4ZASSE87n8uzLIZvXh8yLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eV8GGLL2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UimV0/pA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eV8GGLL2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UimV0/pA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763601315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NqgqOwd5jqp5oDAf2y+M8e0ASYazdS1wJvsZ356bYZE=;
	b=eV8GGLL2+SF4O3xHhdJfrrEdMME1EitZwomoB15U0W2A/dwNsJ/uRngmfWh1cyyT7uWpqO
	WmPo/rfykDbqNJ8dTP7Vp8bntsiF+Ic7RvQs5uBp/PIHKRgF2u9sPfsLnb+1ArlMftJCMK
	6Hp6o/ZCVO5wTuWqw65koCNVy6eVdrE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-kYMEGRqMOeittCSNsN1ApA-1; Wed, 19 Nov 2025 20:15:13 -0500
X-MC-Unique: kYMEGRqMOeittCSNsN1ApA-1
X-Mimecast-MFC-AGG-ID: kYMEGRqMOeittCSNsN1ApA_1763601313
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee25cd2da3so7016281cf.2
        for <fstests@vger.kernel.org>; Wed, 19 Nov 2025 17:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763601313; x=1764206113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqgqOwd5jqp5oDAf2y+M8e0ASYazdS1wJvsZ356bYZE=;
        b=UimV0/pAhAkrWqUKzNi8M6+qMkv9E/Cn1e0XKThlK2DNb68UmtIEluXZ/3u4jKf6ZH
         jhY8OnHBqs3cbwz1QhO+l8eGMEvH+YHI67CFDEsCqDMbUIqeC7FCtUNqx0yrdixu2gK3
         gxLoeF2I4p6kRof2kOZAYU3QID/JeVQvO/uQ/c5wY2ZmVBmG1BD3eShmlT+DvE2/jFEn
         Xwj38ifEDvHPicVrBICNi6gOG7YNbiLHXKE9mCJneRDpmare+KBCDBUk5Ro8m5MUFYnI
         ssXVSAZ/daJgeYTt4xG6PG+7NIAMKJPBS63rdOdI/FVtTc1Y0Cx5U0nGug1904k10mJ7
         1KkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763601313; x=1764206113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqgqOwd5jqp5oDAf2y+M8e0ASYazdS1wJvsZ356bYZE=;
        b=pYWHVKbt1CfOvnPOAsqWwh4ZFOuAHM4n2qRtli4xBc6mqEfhtQFjC0KLnv8enBzLFh
         4877+tlHy3RvcsxIs3Kja9npFLooxnLz4oFLkTO62eOldk71BjfJW3E9HayamDcm2Nmh
         cPc0pWVA68N/LN6WjBv597NM3D95GL421TgSa+Xhl+VqDxjGzAd2hltNlX6esyKKScWk
         jbPo0d0Hg2edVJALq/7BoUVmhaLnGeF0NRE3oEZc4fTYjTV3Y2TaP6lUafjnzsP7EylC
         NNokigM0GZ8dWWxQ0U1vGO5ms3RoDAe9rZqnJlKY3u8wJVJROtjB683jClCy4SXRMQWA
         HmjA==
X-Forwarded-Encrypted: i=1; AJvYcCXHcHMfT7fET/IZj95lvhRy+65yR3Pi6L/dFYMTubF6v3754nfw1drA7Dgm4/yPiGTCwaJm9A84@vger.kernel.org
X-Gm-Message-State: AOJu0YyYAO9eP3Nn85SW7+/G3sUsUCT24TwhuMaI5cDLmF83zkFBSV6K
	8eqDLynrqAQ47kC2ciu2vva64B0lfO5lOLgG7fzvAqoCgM7tnV5letqr70g3LbK/1Svmc7q6RKc
	kOQa/+oq9nB0RGh5puyhEtGaqgH2a2krWAZmBTVGMMJPOXecQ+H4QvWBTr0vsQXQFi1s=
X-Gm-Gg: ASbGncuG1flxDqnXqWPCeVHA8cXAmc9Xn+RxMUvAKwnSpXYjEaq/JmpLiR8exF7ISbl
	ueG3Ovcpm6GxCjJWVNGoSitDkMbXzOP7wVg1jdhhE85KqoTMyh8cJvq/Ge/DWeQR13rPkjLqkXW
	07rcQeT52QqJS+xCr3VXNdva5W0izyGN7eRo42kD2Ya9/4ZztA1GNHxCdcwzZW6/QIKTq98SgJM
	JV/dtVbOZVL42CYJtW6UJ9pOFStT9zlsQIXEdBQXykYV+njdhHepzZexsIUx2/4U1u1PBp5h6kK
	lCrDDN2JdKXIrVKZsY5SozYZL32jOJCCTEFmwuWkUYCJo5bKtpdmtfzEPyrqSa2dq0sqahqqx3V
	I1qUGzTR+La8M3mv++yUTMcglxI5Ge9zsyAkdGfYB+Ta3j3NBi/4gQIWS
X-Received: by 2002:ac8:7e85:0:b0:4ec:f1cc:37c0 with SMTP id d75a77b69052e-4ee4971e94bmr19540031cf.81.1763601312588;
        Wed, 19 Nov 2025 17:15:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFo80YT4ij2I/FfCnf4li9DX7WFNQtjycZ4PKqwbBCDEA0dksjzzKSCwFXp54r7zQ2EpoKMDQ==
X-Received: by 2002:ac8:7e85:0:b0:4ec:f1cc:37c0 with SMTP id d75a77b69052e-4ee4971e94bmr19539621cf.81.1763601312121;
        Wed, 19 Nov 2025 17:15:12 -0800 (PST)
Received: from ?IPV6:2001:8003:4a36:e700:8cd:5151:364a:2095? ([2001:8003:4a36:e700:8cd:5151:364a:2095])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee4cbc3c81sm1215061cf.16.2025.11.19.17.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 17:15:11 -0800 (PST)
Message-ID: <193ae927-9a53-4fa0-9cbe-4e677af2525c@redhat.com>
Date: Thu, 20 Nov 2025 12:15:06 +1100
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] xfs: test case for handling io errors when reading
 extended attributes
To: Zorro Lang <zlang@redhat.com>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org,
 Zorro Lang <zlang@kernel.org>
References: <20251119041210.2385106-1-ddouwsma@redhat.com>
 <20251119100709.zbkenjwztblkjobd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US, en-AU
From: Donald Douwsma <ddouwsma@redhat.com>
In-Reply-To: <20251119100709.zbkenjwztblkjobd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/11/25 21:07, Zorro Lang wrote:
> On Wed, Nov 19, 2025 at 03:12:10PM +1100, Donald Douwsma wrote:
>> We've seen reports from the field panicking in xfs_trans_brelse after an
>> IO error when reading an attribute block.
>>
>> sd 0:0:23:0: [sdx] tag#271 CDB: Read(16) 88 00 00 00 00 00 9b df 5e 78 00 00 00 08 00 00
>> critical medium error, dev sdx, sector 2615107192 op 0x0:(READ) flags 0x1000 phys_seg 1 prio class 2
>> XFS (sdx1): metadata I/O error in "xfs_da_read_buf+0xe1/0x140 [xfs]" at daddr 0x9bdf5678 len 8 error 61
>> BUG: kernel NULL pointer dereference, address: 00000000000000e0
>> ...
>> RIP: 0010:xfs_trans_brelse+0xb/0xe0 [xfs]
>>
>> Signed-off-by: Donald Douwsma <ddouwsma@redhat.com>
>>
>> ---
>> V3
>> - Zorro's suggestions (_require_scsi_debug, _require_scratch, ..., use _get_file_block_size
>>   drop dry_run, fix local variables and parameters, common/attr, ...)
>> - Override SELINUX_MOUNT_OPTIONS to avoid _scratch_mount breaking the test
>> - Add test to quick attr
>> - Change test_attr() to work with blocks instead of bytes
>> - Name the scsi_debug options to make it clearer where the error is active
>> - Determine size of the attr value required based on filesystem block size
>> V2
>> - As this is specific to ENODATA test using scsi_debug instead of dmerror
>> which returns EIO.
>> ---
>>  common/scsi_debug |   8 ++-
>>  tests/xfs/999     | 139 ++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/xfs/999.out |   2 +
>>  3 files changed, 148 insertions(+), 1 deletion(-)
>>  create mode 100755 tests/xfs/999
>>  create mode 100644 tests/xfs/999.out
>>
>> diff --git a/common/scsi_debug b/common/scsi_debug
>> index 1e0ca255..c3fe7be6 100644
>> --- a/common/scsi_debug
>> +++ b/common/scsi_debug
>> @@ -6,6 +6,7 @@
>>  
>>  . common/module
>>  
>> +# _require_scsi_debug [mod_param]
>>  _require_scsi_debug()
>>  {
>>  	local mod_present=0
>> @@ -30,9 +31,14 @@ _require_scsi_debug()
>>  			_patient_rmmod scsi_debug || _notrun "scsi_debug module in use"
>>  		fi
>>  	fi
>> +
>>  	# make sure it has the features we need
>>  	# logical/physical sectors plus unmap support all went in together
>> -	modinfo scsi_debug | grep -wq sector_size || _notrun "scsi_debug too old"
>> +	grep -wq sector_size <(modinfo scsi_debug) || _notrun "scsi_debug too old"
>> +	# make sure it supports this module parameter
>> +	if [ -n "$1" ];then
>> +		grep -Ewq "$1" <(modinfo scsi_debug) || _notrun "scsi_debug not support $1"
>> +	fi
>>  }
>>  
>>  # Args: [physical sector size, [logical sector size, [unaligned(0|1), [size in megs]]]]
>> diff --git a/tests/xfs/999 b/tests/xfs/999
>> new file mode 100755
>> index 00000000..2a571195
>> --- /dev/null
>> +++ b/tests/xfs/999
>> @@ -0,0 +1,139 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2025 Red Hat Inc.  All Rights Reserved.
>> +#
>> +# FS QA Test 999
>> +#
>> +# Regression test for panic following IO error when reading extended attribute blocks
>> +#
>> +#   XFS (sda): metadata I/O error in "xfs_da_read_buf+0xe1/0x140 [xfs]" at daddr 0x78 len 8 error 61
>> +#   BUG: kernel NULL pointer dereference, address: 00000000000000e0
>> +#   ...
>> +#   RIP: 0010:xfs_trans_brelse+0xb/0xe0 [xfs]
>> +#
>> +# For SELinux enabled filesystems the attribute security.selinux will be
>> +# created before any additional attributes are added. In this case the
>> +# regression will trigger via security_d_instantiate() during a stat(2),
>> +# without SELinux this should trigger from fgetxattr(2).
>> +#
>> +# Kernels prior to v4.16 don't have medium_error_start, and only return errors
>> +# for a specific location, making scsi_debug unsuitable for checking old
>> +# kernels. See d9da891a892a scsi: scsi_debug: Add two new parameters to
>> +# scsi_debug driver
>> +#
>> +
>> +. ./common/preamble
>> +_begin_fstest auto quick attr
>> +
>> +_fixed_by_kernel_commit ae668cd567a6 \
>> +	"xfs: do not propagate ENODATA disk errors into xattr code"
>> +
>> +# Override the default cleanup function.
>> +_cleanup()
>> +{
>> +	_unmount $SCRATCH_MNT 2>/dev/null
>> +	_put_scsi_debug_dev
>> +	cd /
>> +	rm -f $tmp.*
>> +}
>> +
>> +# Import common functions.
>> +. ./common/attr
>> +. ./common/scsi_debug
>> +
>> +_require_scratch_nocheck
>> +_require_scsi_debug "medium_error_start"
>> +_require_attrs user
>> +
>> +# If SELinux is enabled common/config sets a default context, which which breaks this test.
>                                                                        ^^^^^
> 
>> +export SELINUX_MOUNT_OPTIONS=""
>> +
>> +scsi_debug_dev=$(_get_scsi_debug_dev)
>> +scsi_debug_opt_noerror=0
>> +scsi_debug_opt_error=${scsi_debug_opt_error:=2}
>> +test -b $scsi_debug_dev || _notrun "Failed to initialize scsi debug device"
>> +echo "SCSI debug device $scsi_debug_dev" >>$seqres.full
>> +
>> +SCRATCH_DEV=$scsi_debug_dev
>> +_scratch_mkfs >> $seqres.full
>> +_scratch_mount
>> +
>> +block_size=$(_get_file_block_size $SCRATCH_MNT)
>> +inode_size=$(_xfs_get_inode_size $SCRATCH_MNT)
>> +error_length=$((block_size/512)) # Error all sectors in the block
>> +
>> +echo Block size $block_size >> $seqres.full
>> +echo Inode size $inode_size >> $seqres.full
>> +
>> +test_attr()
>> +{
>> +	local test=$1
>> +	local testfile=$SCRATCH_MNT/$test
>> +	local attr_blocks=$2
>> +	local error_at_block=${3:-0}
>> +
>> +	local attr_size_bytes=$((block_size/2*attr_blocks))
>> +
>> +	# The maximum size for a single value is ATTR_MAX_VALUELEN (64*1024)
>> +	# If we wanted to test a larger range of extent combinations the test
>> +	# would need to use multiple values.
>> +	[[ $attr_size_bytes -ge 65536 ]] && echo "Test would need to be modified to support > 64k values for $attr_blocks blocks".
>> +
>> +	echo $scsi_debug_opt_noerror > /sys/module/scsi_debug/parameters/opts
>> +
>> +	echo -e "\nTesting : $test" >> $seqres.full
>> +	echo -e "attr size: $attr_blocks" >> $seqres.full
>> +	echo -e "error at block: $error_at_block\n" >> $seqres.full
>> +
>> +	touch $testfile
>> +	local inode=$(stat -c '%i' $testfile)
>> +	$SETFATTR_PROG -n user.test_attr -v $(printf "%0*d" $attr_size_bytes $attr_size_bytes) $testfile
>> +
>> +	$XFS_IO_PROG -c "bmap -al" $testfile >> $seqres.full
>> +	start_blocks=($($XFS_IO_PROG -c "bmap -al" $testfile | awk 'match($3, /[0-9]+/, a) {print a[0]}'))
>         ^^^^^^^^^^^^
>         local start_blocks
> 
> 
> OK, so you still don't want to use:
> 
>   local start_blocks=$(_scratch_xfs_get_metadata_field "a.bmx[0].startblock" "inode $inode")

I'm used to looking at extent information on mounted filesystems with xfs_bmap,
so it felt more natural.

I also wanted to make it easy to extend this to btree format attr if required.
It may be possible to do that with _scratch_xfs_get_metadata_field if it works
with btdump, but would add complexity.

> Anyway, both ways are good to get the start_blocks for this case. So ... (don't need to send v4)
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 

Thanks for your help and feedback with this,
Don


>> +	echo "Attribute fork extent(s) start at ${start_blocks[*]}" >> $seqres.full
>> +
>> +	_scratch_unmount
>> +
>> +	echo "Dump inode $inode details with xfs_db" >> $seqres.full
>> +	_scratch_xfs_db -c "inode $inode" -c "print core.aformat core.naextents a" >> $seqres.full
>> +
>> +	if [[ start_blocks[0] -ne 0 ]]; then
>> +		# Choose the block to error, currently only works with a single extent.
>> +		error_daddr=$((start_blocks[0] + error_at_block*block_size/512))
>> +	else
>> +		# Default to the inode daddr when no extents were found.
>> +		# Errors when getfattr(1) stats the inode and doesnt get to getfattr(2)
>> +		error_daddr=$(_scratch_xfs_db -c "inode $inode" -c "daddr" | awk '{print $4}')
>> +	fi
>> +
>> +	_scratch_mount
>> +
>> +	echo "Setup scsi_debug to error when reading attributes from block" \
>> +	     "$error_at_block at daddr $error_daddr" >> $seqres.full
>> +	echo $error_daddr > /sys/module/scsi_debug/parameters/medium_error_start
>> +	echo $error_length > /sys/module/scsi_debug/parameters/medium_error_count
>> +	echo $scsi_debug_opt_error > /sys/module/scsi_debug/parameters/opts
>> +	grep ^ /sys/module/scsi_debug/parameters/{medium_error_start,medium_error_count,opts} >> $seqres.full
>> +
>> +	echo "Read the extended attribute on $testfile" >> $seqres.full
>> +	sync # the fstests logs to disk.
>> +
>> +	_getfattr -d -m - $testfile >> $seqres.full 2>&1 # Panic here on failure
>> +}
>> +
>> +# aformat shortform
>> +test_attr "attr_local" 0 0
>> +
>> +# aformat extents
>> +# Single leaf block, known to panic
>> +test_attr "attr_extent_one_block" 1 0
>> +
>> +# Other tests to exercise multi block extents
>> +test_attr "attr_extent_two_blocks_1" 2 1
>> +test_attr "attr_extent_two_blocks_2" 2 2
>> +
>> +# success, all done
>> +echo Silence is golden
>> +status=0
>> +exit
>> diff --git a/tests/xfs/999.out b/tests/xfs/999.out
>> new file mode 100644
>> index 00000000..3b276ca8
>> --- /dev/null
>> +++ b/tests/xfs/999.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 999
>> +Silence is golden
>> -- 
>> 2.47.3
>>
>>
> 

