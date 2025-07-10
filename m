Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038061E8333
	for <fstests@vger.kernel.org>; Thu, 10 Jul 2025 18:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752171891; cv=none; b=elQKVu9G318AG+2MwQ4KHOTt22BWNI0ZYW4g9JLx5bIhYfMviNvZyGL4XxmP6SBRbc4cadyRBNFWKpmMc2hjj+gbG3JqO98MEFjPX7Xsv/nNmjLs3MnRet6mCJ5ONRNXsZEibS6wrMiiIH768MioGZ4djtKcD+1zROmKbJNByKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752171891; c=relaxed/simple;
	bh=DsLFrnVRMMGITPWlfPZ7uoPR3BKg+NFVQGD0v7R7470=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AP53BaFlLtpUfFHzou6bqjFfu+BciIxO7IK7m3+J1W9M/zRSELyKC/WsOtckymhMDWO2VTSUxdz7QYGTQu7n1khdZdfIFAs5/2Hd8VZwO0agVWaMLD1GnWBw7mqkch0mehyr4DSxhhygEQdP/WX6p3j1QTiakFYA74gGeBA8naE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UL7naPfd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UL7naPfd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752171888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QwiVPBdUJC6rkc4PHGcJB16mH+q+WGUbV8g0rByGz94=;
	b=UL7naPfdgP96A6OsJkAQA1NtWiBo0a/7SjiGA4iH2tdISIqES28v5uKP8nAkt/LePNPZbP
	SUihN2ZIPTxBxbHf55x8RSTU1UmxV+HvoBMVqiLt2TjqzW+gZrSS/MQ3My5eeNqK/vHoGl
	Cn3Kvxdfz2AE+tIxAGyx7ftEtCEzU3k=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-ViTZbTb-P1uAZl4RfsaZ6A-1; Thu, 10 Jul 2025 14:24:46 -0400
X-MC-Unique: ViTZbTb-P1uAZl4RfsaZ6A-1
X-Mimecast-MFC-AGG-ID: ViTZbTb-P1uAZl4RfsaZ6A_1752171885
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235e3f93687so18934495ad.2
        for <fstests@vger.kernel.org>; Thu, 10 Jul 2025 11:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752171885; x=1752776685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwiVPBdUJC6rkc4PHGcJB16mH+q+WGUbV8g0rByGz94=;
        b=RM/WY9EMA5jZDV/Xs4F9DBf2qIk0QSzO06MufMtg2KsTGVCc9ZeI79CXDk6y8FbXkC
         5SA7RD4Ab9ofmCo0TdSTJp/0S0CBsBTuBMCoNHGu/dkcmalejOxwp5Wrn6ESxx4GGHdW
         y152CWw7RRS8ezf/6UYXvRT8uKlWC5ms5WNggkDDbEbZCbafY5y4Iwv1C6vQa0xCUsWI
         JCVnL7UgMDrj3HY5H7srWRBIJ/nvlgj1t7V/bnwY1Lo+Y0zKU+/3ZGaQryj3i+1psxtE
         Fgj2mZRLsAw6AroiR3edmumqMDi5zqlFRk/HflzY/QT1xPr4FQ12zcrclkUo7ncgkFC8
         OqwA==
X-Gm-Message-State: AOJu0YzfsTWymQR123a+2zTO28BXnZ7qmZGkuAyteadXbK01r+/YEJYp
	eLS6aZzXnkPFxHmieYzrFzFiVn+YAVHxeaEezzTRSMYEskLRID2g5QEfLbmOFuHwVx2ROJRLb8g
	9AGCZWTyOM2GB4cXUVa1xZis9TK2Rkk4JUUpe8fSc9llAwBrtbQc0BPswG/k=
X-Gm-Gg: ASbGncuGYI16MfiVsLq7cCvB2ZIyKCZeelU5gqwGD9rUQ1ynF1D6G3YSirPya+sY+Cv
	ex5j5zVfTQOKFmIDfgnwUgIB0tp+5q5+uhLC8B+K2TQ/zaFzU7rBwP1msSHmIAD9tT+yDTMf7tz
	ZCV5JWlYvq5maOyTjdeqk4D14dgfq0kOpp9mrAbcsTf6+UKb/1K+W409HkptLrmy2eLwKX2zY4U
	V5S0EWEgIiTTAuxIr/4bSqEdYaiS58qy1UBCX/fxFO3ZouE6PSYHVc/g0WyUFXIlW24xK7bu3bl
	aGxWfcrJqqzmS3h4heb0fQ/X2O43k2GUW9ff70o62JOP/lp8uDBvyq1sqxAWRXU=
X-Received: by 2002:a17:902:cf07:b0:235:15f3:ef16 with SMTP id d9443c01a7336-23dede3a35emr2879485ad.13.1752171885442;
        Thu, 10 Jul 2025 11:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaRwJekOrZ+hET/XMGZtYgxaB4ddoI3su+l3xYpS2kd1XXWZ0iTNVDqIn8mL7YMiHwMAQbqg==
X-Received: by 2002:a17:902:cf07:b0:235:15f3:ef16 with SMTP id d9443c01a7336-23dede3a35emr2879275ad.13.1752171885006;
        Thu, 10 Jul 2025 11:24:45 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe581a16sm2852217a12.28.2025.07.10.11.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 11:24:44 -0700 (PDT)
Date: Fri, 11 Jul 2025 02:24:40 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] generic: test overwriting file with mmap on a full
 filesystem
Message-ID: <20250710182440.jnqs36ukx4j4okxr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
 <681c9dcaca0bf16a694d8f56449618001cf20df6.1752166696.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <681c9dcaca0bf16a694d8f56449618001cf20df6.1752166696.git.fdmanana@suse.com>

On Thu, Jul 10, 2025 at 06:03:43PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that overwriting a file with mmap when the filesystem has no more
> space available for data allocation works. The motivation here is to check
> that NOCOW mode of a COW filesystem (such as btrfs) works as expected.
> 
> This currently fails with btrfs but it's fixed by a kernel patch that has
> the subject:
> 
>    btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Use _try_scratch_mkfs_sized;
>     Use _get_file_block_size instead of _get_block_size;
>     Add a more detailed comment about why dd is used to fill the fs.

Thanks Filipe, it's going to be merged into patches-in-queue branch, and
will be push in next fstests release (this weekend hopefully)

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  tests/generic/211     | 63 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/211.out |  6 +++++
>  2 files changed, 69 insertions(+)
>  create mode 100755 tests/generic/211
>  create mode 100644 tests/generic/211.out
> 
> diff --git a/tests/generic/211 b/tests/generic/211
> new file mode 100755
> index 00000000..e87d1e01
> --- /dev/null
> +++ b/tests/generic/211
> @@ -0,0 +1,63 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 211
> +#
> +# Test that overwriting a file with mmap when the filesystem has no more space
> +# available for data allocation works. The motivation here is to check that
> +# NOCOW mode of a COW filesystem (such as btrfs) works as expected.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw mmap
> +
> +. ./common/filter
> +
> +_require_scratch
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents"
> +
> +# Use a 512M fs so that it's fast to fill it with data but not too small such
> +# that on btrfs it results in a fs with mixed block groups - we want to have
> +# dedicated block groups for data and metadata, so that after filling all the
> +# data block groups we can do a NOCOW write with mmap (if we have enough free
> +# metadata space available).
> +fs_size=$(_small_fs_size_mb 512)
> +_try_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
> +	_fail "mkfs failed"
> +_scratch_mount
> +
> +touch $SCRATCH_MNT/foobar
> +
> +# Set the file to NOCOW mode on btrfs, which must be done while the file is
> +# empty, otherwise it fails.
> +if [ $FSTYP == "btrfs" ]; then
> +	_require_chattr C
> +	$CHATTR_PROG +C $SCRATCH_MNT/foobar
> +fi
> +
> +# Add initial data to the file we will later overwrite with mmap.
> +$XFS_IO_PROG -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foobar | _filter_xfs_io
> +
> +# Now fill all the remaining space with data. We use dd because we want to fill
> +# only data space in btrfs - creating files with __populate_fill_fs() would also
> +# fill metadata space. We want to exhaust data space on btrfs but still have
> +# metadata space available, as metadata is always COWed on btrfs, so that the
> +# mmap writes below succeed (metadata space available but no more data space
> +# available).
> +blksz=$(_get_file_block_size $SCRATCH_MNT)
> +dd if=/dev/zero of=$SCRATCH_MNT/filler bs=$blksz >>$seqres.full 2>&1
> +
> +# Overwrite the file with a mmap write. Should succeed.
> +$XFS_IO_PROG -c "mmap -w 0 1M"        \
> +	     -c "mwrite -S 0xcd 0 1M" \
> +	     -c "munmap"              \
> +	     $SCRATCH_MNT/foobar
> +
> +# Cycle mount and dump the file's content. We expect to see the new data.
> +_scratch_cycle_mount
> +_hexdump $SCRATCH_MNT/foobar
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/211.out b/tests/generic/211.out
> new file mode 100644
> index 00000000..71cdf0f8
> --- /dev/null
> +++ b/tests/generic/211.out
> @@ -0,0 +1,6 @@
> +QA output created by 211
> +wrote 1048576/1048576 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
> +*
> +100000
> -- 
> 2.47.2
> 
> 

