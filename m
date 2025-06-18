Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332ED3085A0
	for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275287; cv=none; b=bMiXW649+YsV+ueF7xxLt+l2OXsesHdcMn+P7cAz26H5Ser+SQZcF3sGlzaVplBt4tBiBGW50lqQ36fNat9uHi7xJQwUkUmVHmK6Cfm7Qo6heVPsR3y94rVm2RNA/bJU8xmatO1+m/3PWw7u0E+Pb7SS4s3PbySwH3ugOdBvOoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275287; c=relaxed/simple;
	bh=1Yn0U+d7UWVFLWHsCeqtBZPrhV1WRIXCbgqX+NVfG2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWpnFmFWN8DLEit+gveTXhbo4/+7wQ11NL3v2ftNy+Gjf8n6OHgw8C/jJREcg49ufwJ+Du/ZC/FA6Hd4UGkgLLYKTCmWZr0q77Q/FFR1iNEQXhtgj3wlEHzlHgF87S3NxYn9GaDE0rBAuRVC9ESYLxJCXUVIpPDlitJvdIUMBtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rw3VdeoM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rw3VdeoM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750275282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SCXW/AbdOgm2CjUzl6KnAoAo8/BpYXxpoS5MIWgbgps=;
	b=Rw3VdeoMdG9R/5z1e+rc2itiQud3R3xmptZ01fgBCNY5bn+jdbo/7JTi1LJZLGxHkwaClW
	xnS+7YXnhPMCxAQML075dogvdT7N9Zz1OfO0hpGlEeQJ5zNJV0mm6rXTh3YABiArC0MsMI
	6hz0jwIvWy4XE3hDmfRfAgoze36ZjxQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-wJIJkyhtOnK16m50iga-SQ-1; Wed, 18 Jun 2025 15:34:40 -0400
X-MC-Unique: wJIJkyhtOnK16m50iga-SQ-1
X-Mimecast-MFC-AGG-ID: wJIJkyhtOnK16m50iga-SQ_1750275280
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2349498f00eso80865ad.0
        for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 12:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750275279; x=1750880079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCXW/AbdOgm2CjUzl6KnAoAo8/BpYXxpoS5MIWgbgps=;
        b=eblNCdW7LpgPXAPoUskPCOw9plh8bHYY5yQAgSvGfJzf+TchSFO17ck7PQyGPHhATB
         zxlUDTwwgSeOBM115EHoGTQF/apeW+y7n0h78BPHcdsVKQfjb4GsHi96k1Tso2LhbuAK
         4IC66JcGA1KoMc7u3UF4kzsmqn7uMN/NHRVWkDxK67HShNC8ksQjv9EOkEMj6diWWYuv
         NrXJ+15I5CUWUhKiF2Tak1/the+6Qck7O7fbD4l1svrPsKhe25T7Xta9YSXLlClJ3E+1
         1I7D+VNKaQPbh7yYOKn7iyyvfjcuvfqitpipb15lISOJv7f4ko8huVny71LIoeamY2mP
         BRwQ==
X-Gm-Message-State: AOJu0YyjjMd9uUTd/PnWJb+/g0MHz5NVzag3LXCwGjG6qn+S9MxbJy/4
	KbhVqBOHG3QZLULY/JztACFTm50SStj6+U1hH817wEOJPI66HHh4GUz+u/WMbznXBLlMQnqJWYY
	SfSQ5IEVqOBBE/HSr4Y939xYFxjOptekwKwbV7DJF067lOegAdO+dBVYNsjA=
X-Gm-Gg: ASbGnctWYdrgAi8jb7ap+rvpGWBi+66rT8wUrZzzWal+Gm71xhVhc8YReZoiUykeVr4
	qVfP6cv1SAEJ8pyhEh4THJdLT0hjuxce5tsDGRgG5D3muehQaQja2NOKOMCyzvOwMic7tUlp0Zi
	I1AMIINtz0CHke99B9t7vqn7zit9IEGgF38RItGEqIEK1l4IbfBOsbvvKsPAKLAMObdLfmGQeB9
	MksrOC/H7+RCtEul5nlzUnm9rNrcLd4FRLBGuZ2Omw4ufD2hA8+1BOZ/6qWwvqMMUHl04Na9qVT
	c8JMfBLlbI+wIaAHP6iTmAyDt6rgE0mTeTrPEbaw+QO//g8uWGHWO9BIAbizpnU=
X-Received: by 2002:a17:902:f542:b0:234:8a4a:ad89 with SMTP id d9443c01a7336-237cbe9b579mr12188035ad.1.1750275279541;
        Wed, 18 Jun 2025 12:34:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdv0dFn3PaKK7Jad7HLLx+K/Qn9HHPyRH2wc447D9YdA7xKUX61kFelOjAah63DFAsHMdewg==
X-Received: by 2002:a17:902:f542:b0:234:8a4a:ad89 with SMTP id d9443c01a7336-237cbe9b579mr12187755ad.1.1750275279149;
        Wed, 18 Jun 2025 12:34:39 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de783b3sm104248415ad.119.2025.06.18.12.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 12:34:38 -0700 (PDT)
Date: Thu, 19 Jun 2025 03:34:34 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 04/12] generic/767: Add atomic write test using fio crc
 check verifier
Message-ID: <20250618193434.yhi2gjgusgula5bj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <9cb914eacd9d7825f2903410948d2a1d4a1a8800.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cb914eacd9d7825f2903410948d2a1d4a1a8800.1749629233.git.ojaswin@linux.ibm.com>

On Wed, Jun 11, 2025 at 03:04:47PM +0530, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> This adds atomic write test using fio based on it's crc check verifier.
> fio adds a crc for each data block. If the underlying device supports atomic
> write then it is guaranteed that we will never have a mix data from two
> threads writing on the same physical block.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/generic/767     | 84 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/767.out |  2 ++

I'd like to recommend using a bigger case number for this RFC test case (and others
in this patchset), to help you to rebase on later fstests easily :)

>  2 files changed, 86 insertions(+)
>  create mode 100755 tests/generic/767
>  create mode 100644 tests/generic/767.out
> 
> diff --git a/tests/generic/767 b/tests/generic/767
> new file mode 100755
> index 00000000..4f80e7b6
> --- /dev/null
> +++ b/tests/generic/767
> @@ -0,0 +1,84 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 767
> +#
> +# Validate FS atomic write using fio crc check verifier.
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +
> +_begin_fstest auto aio rw atomicwrites
> +
> +_require_scratch_write_atomic
> +_require_odirect
> +_require_aio
> +
> +function max()
> +{
> +	if (( $1 > $2 )); then
> +		echo "$1"
> +	else
> +		echo "$2"
> +	fi
> +}
> +
> +function min()
> +{
> +	if (( $1 > $2 )); then
> +		echo "$2"
> +	else
> +		echo "$1"
> +	fi
> +}
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +touch "$SCRATCH_MNT/f1"
> +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> +blocksize=$(max "$awu_min_write" "$((awu_max_write/2))")
> +
> +# XFS can have high awu_max_write due to software fallback. Cap it at 64k
> +blocksize=$(min "$blocksize" "65536")
> +
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +
> +FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))

This's the first time I learn about this command :-D

[root@dell-per750-41 xfstests]# nproc 
112
[root@dell-per750-41 xfstests]# type -P nproc
/usr/bin/nproc
[root@dell-per750-41 xfstests]# rpm -qf `type -P nproc`
coreutils-9.7-3.fc43.x86_64

Thanks,
Zorro

> +SIZE=$((100 * 1024 * 1024))
> +
> +cat >$fio_config <<EOF
> +[aio-dio-aw-verify]
> +direct=1
> +ioengine=libaio
> +rw=randwrite
> +bs=$blocksize
> +fallocate=native
> +filename=$SCRATCH_MNT/test-file
> +size=$SIZE
> +iodepth=$FIO_LOAD
> +numjobs=$FIO_LOAD
> +group_reporting=1
> +verify_state_save=0
> +verify=crc32c
> +verify_fatal=1
> +verify_dump=0
> +verify_backlog=1024
> +verify_async=4
> +verify_write_sequence=0
> +atomic=1
> +EOF
> +
> +_require_fio $fio_config
> +
> +cat $fio_config >> $seqres.full
> +$FIO_PROG $fio_config --output=$fio_out
> +cat $fio_out >> $seqres.full
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/generic/767.out b/tests/generic/767.out
> new file mode 100644
> index 00000000..2bf7f989
> --- /dev/null
> +++ b/tests/generic/767.out
> @@ -0,0 +1,2 @@
> +QA output created by 767
> +Silence is golden
> -- 
> 2.49.0
> 
> 

