Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B1920D4F8
	for <fstests@vger.kernel.org>; Tue,  6 May 2025 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746561290; cv=none; b=o03eBMLmiffPax41RvlE/UB7T0u6Je1TEsYZax/Mm3WvC+9Vf/gz4cuKfdDHxeUf+BRYSDK37+7kqE9ssbXUDT4imK4lw6A19zIepyzth3mMvwutWIfgYd8rLyzyPiBZY5whcDjeApWpOQxWvbwvL1ChB8zAkQ7Nrd1CFnJLtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746561290; c=relaxed/simple;
	bh=qOBf+I6QQQZBDMXtPERFZllywn1N2P9yWCe0qH5Njtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+IGDKiFEbOs9x1q7h/vaTCTy/1+3IzJ4z3pu5DYSwUliXkqq1oX+3ETx6bZ147dYaocPMH0rf/+IyvD/yAFCNYfFLFnvccIniypa7CflmH0F+nTJ9VeR77R9T9okyRlvgtpNdILpn7CByeGhf59TXnkbIPLrcGiICQDdp+ZU6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H385buyW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H385buyW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746561288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nTtBEGhm/lysd8OPY+qVgqqfEFpE8kDf1zO3CBYOOdw=;
	b=H385buyWnInEHBTSAzLqls4pKP/mJeh5gDENRwPQ/eeqTH1aumP2kYOjsjIVJewRFvUsNc
	Yxas3UoGzxwRMS7KBTSKiAaY6ZadjjlylxuHF+CMXA8UcOfU2Vj2tMDdb9CiiF3WFbMmDJ
	nzCyu8lBeoJAyD+2tddZ2lK0gXLUM6E=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-DnXRx7EfN4yHUMWHaxxBVA-1; Tue, 06 May 2025 15:54:46 -0400
X-MC-Unique: DnXRx7EfN4yHUMWHaxxBVA-1
X-Mimecast-MFC-AGG-ID: DnXRx7EfN4yHUMWHaxxBVA_1746561286
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff58318acaso8455556a91.0
        for <fstests@vger.kernel.org>; Tue, 06 May 2025 12:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746561286; x=1747166086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTtBEGhm/lysd8OPY+qVgqqfEFpE8kDf1zO3CBYOOdw=;
        b=wY68CceHCX1CbgliudIkbJJz5HLlheh6/xtSoFQPZbnOP7xfUbbjF98f48Ew3KH7yP
         tlDffAF7A4U8gWgpA2ZYG+rlcQh4GSLp/oXfjd24MnF6zdBwK2mwt7wrol7AH9RCJ4p9
         FqIa1atMABfNc7WvUdyH8q5ZLtMsrMla/DH8/XSdabrEP0HYO0i31CPK6hgHEoVs6CfU
         Sgz1VakFl67V48/EfTxcrb6gKmkYiXPSsRxEI3PxODIclSnD/OSzAEhpfQK0yULt123l
         yDGqsZ0zoUdWaONFm1LHqFk54r3LZmJLOgdzCHdytS/RysjiAEigXcSVKlYDJoUdr2yX
         MJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCXntfB2LxsoKNBaYX8wcG8DNtNfvzSO1UTgtt78fk/UGp2lH4aGgB4PxHk4P9SIcD7ajSEjIBlC@vger.kernel.org
X-Gm-Message-State: AOJu0YwwuAqT+WoQ0IAo9ayM5D9FNqkBEhTxg2lB+0/jVpRr1yT3X18a
	E4hU9v2Osiyjdv4+4nQqAOHIYMvbbOIFKAboUvRvc8wo8yRVjp8s9fJnCsBlhkIgqJipcz/m9dt
	NZdSCcch5oo62Nt/wxxj7df8oC6hfovE9gWU45Aap+OLibJCiRM3l1U8=
X-Gm-Gg: ASbGncteu32TOBti9gJIxO1DPxI59QP71M7lELvz8Qror1lMXr7jlLzRPGnKQzJnfPo
	tSN/nxEVmra3db+Xw48bMoPZlW8G4DYoDpMZzO/NcENzVez8iPt6ZGgkgmgFLQvhC28jmkQTcUY
	P+blTIcsL5k/jq0B5kAOyxzTvObw2YHTUj3wYiUVaToUjJ5NhEpy9V0Ni53BxgX4QxfkTOkuQVd
	1K/FI80Fo+DRs6HmkPOCcB3E1+rD2fyXjwgg0hAcqLcUJTmH/RZakATEsq6HOOdhX5bJ8Bcn70P
	lenqNmkDm566gXLEvYntLo6RjKq4dlLSsGO1qAEjxiMuzODbB7OK
X-Received: by 2002:a17:90b:3d8c:b0:2f2:a664:df1a with SMTP id 98e67ed59e1d1-30aac156361mr1187899a91.2.1746561285676;
        Tue, 06 May 2025 12:54:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd/Bp/SJj/dFUii4g0ztMXnsqi74UFt0LA7wClWlUC30ZzHQTbvZ2ib92cDiv1RTLZbZvj5w==
X-Received: by 2002:a17:90b:3d8c:b0:2f2:a664:df1a with SMTP id 98e67ed59e1d1-30aac156361mr1187872a91.2.1746561285318;
        Tue, 06 May 2025 12:54:45 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30aaead24bdsm209096a91.32.2025.05.06.12.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 12:54:45 -0700 (PDT)
Date: Wed, 7 May 2025 03:54:40 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 09/15] xfs: test zone stream separation for two buffered
 writers
Message-ID: <20250506195440.ylqb6rgxi455zcpw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250501134302.2881773-1-hch@lst.de>
 <20250501134302.2881773-10-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501134302.2881773-10-hch@lst.de>

On Thu, May 01, 2025 at 08:42:46AM -0500, Christoph Hellwig wrote:
> Check that two parallel buffered sequential writers are separated into
> different zones when writeback happens before closing the files.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/4208     | 79 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/4208.out |  3 ++
>  2 files changed, 82 insertions(+)
>  create mode 100755 tests/xfs/4208
>  create mode 100644 tests/xfs/4208.out
> 
> diff --git a/tests/xfs/4208 b/tests/xfs/4208
> new file mode 100755
> index 000000000000..b85105704b65
> --- /dev/null
> +++ b/tests/xfs/4208
> @@ -0,0 +1,79 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Christoph Hellwig.
> +#
> +# FS QA Test No. 4208
> +#
> +# Test that multiple buffered I/O write streams are directed to separate zones
> +# when written back with the file still open.
> +#
> +. ./common/preamble
> +_begin_fstest quick auto rw zone
> +
> +_cleanup()
> +{
> +	cd /
> +	_scratch_unmount >/dev/null 2>&1

Same review points with patch 8/15.

> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +_require_scratch
> +
> +_filter_rgno()

Same review points with patch 8/15.

> +{
> +	# the rg number is in column 4 of xfs_bmap output
> +	perl -ne '
> +		$rg = (split /\s+/)[4] ;
> +		if ($rg =~ /\d+/) {print "$rg "} ;
> +	'
> +}
> +
> +_scratch_mkfs_xfs >>$seqres.full 2>&1
> +_scratch_mount
> +_require_xfs_scratch_zoned 3
> +
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +fio_err=$tmp.fio.err
> +
> +cat >$fio_config <<EOF
> +[global]
> +bs=64k
> +iodepth=16
> +iodepth_batch=8
> +size=1m
> +directory=$SCRATCH_MNT
> +rw=write
> +fsync_on_close=1
> +
> +[file1]
> +filename=file1
> +size=128m
> +
> +[file2]
> +filename=file2
> +size=128m
> +EOF
> +
> +_require_fio $fio_config
> +
> +$FIO_PROG $fio_config --output=$fio_out
> +cat $fio_out >> $seqres.full
> +
> +# Check the files only have a single extent each and are in separate zones
> +extents1=$(_count_extents $SCRATCH_MNT/file1)
> +extents2=$(_count_extents $SCRATCH_MNT/file2)
> +
> +echo "number of file 1 extents: $extents1"
> +echo "number of file 2 extents: $extents2"
> +
> +rg1=`xfs_bmap -v $SCRATCH_MNT/file1 | _filter_rgno`
> +rg2=`xfs_bmap -v $SCRATCH_MNT/file2 | _filter_rgno`
> +if [ "${rg1}" == "${rg2}" ]; then
> +	echo "same RG used for both files"
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/xfs/4208.out b/tests/xfs/4208.out
> new file mode 100644
> index 000000000000..1aaea308fe6a
> --- /dev/null
> +++ b/tests/xfs/4208.out
> @@ -0,0 +1,3 @@
> +QA output created by 4208
> +number of file 1 extents: 1
> +number of file 2 extents: 1
> -- 
> 2.47.2
> 

