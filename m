Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBTETyRN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B550810E6
	for <fstests@vger.kernel.org>; Fri,  8 Dec 2023 21:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702098562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c1dglHsXHch+sNbPf4lh7SiEjxLw7RXEQLZMwESVvc8=;
	b=VBTETyRN45ikFHMyKr2Qb6TUxi6Z3b4AJD0xQuLccd5F+J0+224ms1mgMWr5hbGw7Mt8cQ
	hQxPnpZ102agRrwQAsbEbVxxmMRfWjlNgGcThVSFrslMmxyDx5bXXXBzmT4CJ9JrLylYU4
	gVrEkh3OVcyT/BUQuhkuqnGh2eDNZvc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-eS2UH3gLM5mmYdlG3aAbvg-1; Sat, 09 Dec 2023 00:09:18 -0500
X-MC-Unique: eS2UH3gLM5mmYdlG3aAbvg-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ce751b8297so3092540b3a.0
        for <fstests@vger.kernel.org>; Fri, 08 Dec 2023 21:09:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702098557; x=1702703357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1dglHsXHch+sNbPf4lh7SiEjxLw7RXEQLZMwESVvc8=;
        b=DjCS3a9cbOUP3fjhli4S6f5Ucqcau5S//Kvpx0kS6b9geZlpZN6DuDqMpl6xaW7AQm
         HyXBszkd/M35aBqVTvFWytE/X/AdsKyTjP4SWawtN9QFJAYR3IO/rtrp6OUhOpfZ6q7L
         PW7I37a7oGKrYOgm7CYu5HPBkXuwh0VSgQx9jpj21xHyTSNXn6qYYTXEtX6XDpKRor46
         d3rZlxcqyGbfI1sFo+Ve8KTLNs6TYml6r5E4cFfr0O0e5V2stLGfnMm0fyVi9J5Y3p7/
         m0+RAwMR5yk+LImh2uIDKw7tb0EpdPpCOPL+vya4wngQiVoZXCjKOt4RhrM/5CY6N1Wl
         RP/g==
X-Gm-Message-State: AOJu0YwLLqXJnVMt9HMOGjwiD53QLfX1kFmO3TW7DSLrR6w2YQP/MT4I
	8jzWK2b4dGplxS2BeXgJ89e2x8o3xtMiX9RGXWTIDK/F13h9VZ9TgX0X2bRtcKJTkvcMAyOLBH0
	wnSRkFvar4YoWJGUNXQ==
X-Received: by 2002:a05:6a20:7d97:b0:18b:e5f7:25c5 with SMTP id v23-20020a056a207d9700b0018be5f725c5mr1651073pzj.11.1702098557273;
        Fri, 08 Dec 2023 21:09:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmkWzDhUGE41VSpPpvt2T79s4Knv+0nrQ+KK18g8CZEhvRjUfgjLsws69EBA5nKA/u+aCvkw==
X-Received: by 2002:a05:6a20:7d97:b0:18b:e5f7:25c5 with SMTP id v23-20020a056a207d9700b0018be5f725c5mr1651059pzj.11.1702098556910;
        Fri, 08 Dec 2023 21:09:16 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id gw17-20020a17090b0a5100b00285be64e529sm4259574pjb.39.2023.12.08.21.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 21:09:16 -0800 (PST)
Date: Sat, 9 Dec 2023 13:09:13 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Gao Xiang <hsiangkao@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [PATCHv3 2/2] generic: Add integrity tests with synchronous
 directio
Message-ID: <20231209050913.2l42zctsh44bfhit@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <8379b5df9f70a1d75692e029a565199e98a535e8.1700478575.git.ritesh.list@gmail.com>
 <e255d8494511a705bacc5103e15dd532d2f433d0.1700478575.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e255d8494511a705bacc5103e15dd532d2f433d0.1700478575.git.ritesh.list@gmail.com>

On Mon, Nov 20, 2023 at 04:49:34PM +0530, Ritesh Harjani (IBM) wrote:
> This test covers data & metadata integrity check with directio with
> o_sync flag and checks the file contents & size after sudden fileystem
> shutdown once the directio write is completed. ext4 directio after iomap
> conversion was broken in the sense that if the FS crashes after
> synchronous directio write, it's file size is not properly updated.
> This test adds a testcase to cover such scenario.
> 
> Man page of open says that -
> O_SYNC provides synchronized I/O file integrity completion, meaning write
> operations will flush data and all associated metadata to the underlying
> hardware
> 
> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  tests/generic/733     | 54 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/733.out | 22 ++++++++++++++++++
>  2 files changed, 76 insertions(+)
>  create mode 100755 tests/generic/733
>  create mode 100644 tests/generic/733.out
> 
> diff --git a/tests/generic/733 b/tests/generic/733
> new file mode 100755
> index 00000000..18021e8a
> --- /dev/null
> +++ b/tests/generic/733
> @@ -0,0 +1,54 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 IBM Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 471
> +#
> +# Integrity test for O_SYNC with buff-io, dio, aio-dio with sudden shutdown.
> +# Based on a testcase reported by Gao Xiang <hsiangkao@linux.alibaba.com>
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick shutdown aio
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_scratch
> +_require_scratch_shutdown
> +_require_aiodio aio-dio-write-verify
> +
> +_fixed_by_kernel_commit 91562895f803 \
> +	"ext4: properly sync file size update after O_SYNC direct IO"

As this a generic test case, so:

[[ "$FSTYP" =~ ext* ]] && ...

Anyway, I'll change that when I merge it. Other looks good to me

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount
> +
> +echo "T-1: Create a 1M file using buff-io & O_SYNC"
> +$XFS_IO_PROG -fs -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
> +echo "T-1: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-1: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-1: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t1
> +
> +echo "T-2: Create a 1M file using O_DIRECT & O_SYNC"
> +$XFS_IO_PROG -fsd -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t2 > /dev/null 2>&1
> +echo "T-2: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-2: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-2: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t2
> +
> +echo "T-3: Create a 1M file using AIO-DIO & O_SYNC"
> +$AIO_TEST -a size=1048576 -S -N $SCRATCH_MNT/testfile.t3 > /dev/null 2>&1
> +echo "T-3: Shutdown the fs suddenly"
> +_scratch_shutdown
> +echo "T-3: Cycle mount"
> +_scratch_cycle_mount
> +echo "T-3: File contents after cycle mount"
> +_hexdump $SCRATCH_MNT/testfile.t3
> +
> +status=0
> +exit
> diff --git a/tests/generic/733.out b/tests/generic/733.out
> new file mode 100644
> index 00000000..e0536a4e
> --- /dev/null
> +++ b/tests/generic/733.out
> @@ -0,0 +1,22 @@
> +QA output created by 733
> +T-1: Create a 1M file using buff-io & O_SYNC
> +T-1: Shutdown the fs suddenly
> +T-1: Cycle mount
> +T-1: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
> +T-2: Create a 1M file using O_DIRECT & O_SYNC
> +T-2: Shutdown the fs suddenly
> +T-2: Cycle mount
> +T-2: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
> +T-3: Create a 1M file using AIO-DIO & O_SYNC
> +T-3: Shutdown the fs suddenly
> +T-3: Cycle mount
> +T-3: File contents after cycle mount
> +000000 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  >ZZZZZZZZZZZZZZZZ<
> +*
> +100000
> -- 
> 2.41.0
> 
> 

