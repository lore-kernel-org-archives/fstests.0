Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1801DA23
	for <fstests@vger.kernel.org>; Fri, 13 Mar 2026 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773429570; cv=none; b=ec3Zn+zw1LyAIEQdiryLMtBs9WdYrnvdNeG6N9dYLpdCdqVtvH7pvJmafOtVOuU/zCLw3BDJIaeRdCqkOchbCFGzHL/jpzC9FiZpFtwkxxCFen8nzTLrAKHZjuLBAlJDechdFqOBw2R2sQcSb4sf24j9uLKUDPvGxaSeEIgxiuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773429570; c=relaxed/simple;
	bh=DgLDJwjfN9POXB2fAoyI8G2QRiauMXnd+TBYRBSCsBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTDMbybleF72Qe1YSq17PajdA69Raooz/QTAkB3SA3B9iy3tMIqKbzx+nSTyOWMCecvmDQYJoArVQo8YNST6+zODT7oEgtY7yomRLbI4X5JsOFiD+UL7zA0fwZcn1/6qVmamzZ5Rh4JfIK3i8T28UEvkOyLuH1XmOVfnQXvO0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iPrVlBLi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sECpfZgm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPrVlBLi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sECpfZgm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773429568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbAhGVPsBTRCoKAt+2dGuvMTR2ct/lDm5/NumNxug0c=;
	b=iPrVlBLi+8yEl2Srxc0ZTbZNUxSNOyMcB3IZ6OAHV3cta4IM4HLeZfGqkR7m55iu/ky2HK
	LV6MQMWD0XgSimL1zq5ivZGFaIT+H9ifwfgXU+jSfIKTnztZaLe+8nUJZjcFRBTo8aoBLD
	f9zuAl1R5ovJ9GWBghDHIw9gaZ8EsHc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-7-HEEUJcObGXZ_cv82-MXg-1; Fri, 13 Mar 2026 15:19:26 -0400
X-MC-Unique: 7-HEEUJcObGXZ_cv82-MXg-1
X-Mimecast-MFC-AGG-ID: 7-HEEUJcObGXZ_cv82-MXg_1773429566
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35a032cdd78so10883590a91.1
        for <fstests@vger.kernel.org>; Fri, 13 Mar 2026 12:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773429565; x=1774034365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KbAhGVPsBTRCoKAt+2dGuvMTR2ct/lDm5/NumNxug0c=;
        b=sECpfZgm8qonCimGdNXoWFDl3G5PVQMXYic7XcjWge8+f7nwBlqUajbqhaS0Fa93qe
         cegelbM0OiYf2H91fsXAAyQF8L+eIRQW4Do6X7ExNXlf9pXlsyy85404VTdsa2k6o16+
         FaO+f+QJLeeOZnsAmAKuul1KfPzfi7VVgtxuP+qH4KCRRvx+OB2hExVah2+WhZGnRyjQ
         naftW/MV/OYYqhbtErZW7hl28jjA/+QykuI66gvolvw0vD24mW0bhz4mB9OB5gbBBVbu
         3utFgOer1RMM0/7mhCD4V0Hh6nERU6Ejm7nX/zEmBZmyvk1W0sz+NF+LJogiGcpXNyxq
         toVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773429565; x=1774034365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbAhGVPsBTRCoKAt+2dGuvMTR2ct/lDm5/NumNxug0c=;
        b=JNBwe+jwrRQRpPf2dCJnkhfu3/M35HkfTd0DEZ1GSQpL1RjQxr1Q0e75hEtaRfwFhb
         6vXrnCvKVvfB7v7TrbweskxlD+Lwjyk23voqjZZOSAFJKfLJwKVEsBwnEj/tC2w5zPJz
         1oEvg9b7ym59wFE1/spdkVS2d35cmnOGOypju+LNZ34HeUAYh+HVHizAt5egnhlFzCyY
         wEQh+qDZ/e3M7a/ntCuVbKadYBVMYtGOU3E2AFqVxwHLfGQ9eEMoQOKuCXhxveuethOe
         PVMjFmurJoDZV8SP5KWwLPS8o779cD/mDD633MiyjiTlTI1OGshRDsypLyn3eqFCqu1Z
         Liww==
X-Gm-Message-State: AOJu0YywPLaViz5npwpvCf6wYb2nP2FUTvtGqVkU/6HDp5mU20ylYH8O
	OsJ+e3kkdYogECMoxhpFupfxFuwdlIh+LAco6BpTY9uwMaTO/cXeTRmXAYa4oj9BhLjt3NdFDMa
	HOZ9VCaw76aCki+9+b54puE6z0OOkigKpMdthI/BFMvXEXY9ARgFSLSjsEVc=
X-Gm-Gg: ATEYQzyoubgDgqmfpWsErRFfhE9z4KpIXnU9O9GcycvVYy5NGovB5nf97qsekEypt1j
	Ah1n76jHi42m8GpCpmy3v19wjxz7a8eNZiglcMpYajWiAQ55oz7k9fZNA0lRkHpBy0kyYVq1/nq
	9k/SMJQRy+ZeWXBTBNbBJJzhzbaDs63urZVLdwlYdRF1N+1HcoWE7Vtv2/Nfdu/rJQeenBSmvGA
	fsRoY0tk5WP30I8tYuGaaNmvVuKHHMw+AG2f6xscCXrWEcEn0ypYGqEbl7+boLeJdA4CRmql9Cr
	slKD5EKzel7jAgN7bPwzPRz8WIt/O7CDUCtj2xjLdxQjkaQXvlqwg5HvY6qIxKtFgn/v/5UbyZ/
	1TZLETLCPWD/9dQ0l3YkXf1lz6SvjbtDWviPERR8GRVhQVH7QSFRayjQta53lAA==
X-Received: by 2002:a17:90b:574f:b0:359:fe72:3559 with SMTP id 98e67ed59e1d1-35a21fdd3b7mr3916128a91.21.1773429565362;
        Fri, 13 Mar 2026 12:19:25 -0700 (PDT)
X-Received: by 2002:a17:90b:574f:b0:359:fe72:3559 with SMTP id 98e67ed59e1d1-35a21fdd3b7mr3916116a91.21.1773429564998;
        Fri, 13 Mar 2026 12:19:24 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02ffe078sm9596873a91.13.2026.03.13.12.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 12:19:24 -0700 (PDT)
Date: Sat, 14 Mar 2026 03:19:20 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 05/14] xfs: test xfs_healer's event handling
Message-ID: <20260313191920.nuec3vcexb44yt3c@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <177311403712.1186408.7032564474004561606.stgit@frogsfrogsfrogs>
 <177311403867.1186408.18154501598966372334.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177311403867.1186408.18154501598966372334.stgit@frogsfrogsfrogs>

On Mon, Mar 09, 2026 at 08:51:26PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Make sure that xfs_healer can handle every type of event that the kernel
> can throw at it by initiating a full scrub of a test filesystem.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Tests and looks good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/1882     |   44 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/1882.out |    2 ++
>  2 files changed, 46 insertions(+)
>  create mode 100755 tests/xfs/1882
>  create mode 100644 tests/xfs/1882.out
> 
> 
> diff --git a/tests/xfs/1882 b/tests/xfs/1882
> new file mode 100755
> index 00000000000000..2fb4589418401e
> --- /dev/null
> +++ b/tests/xfs/1882
> @@ -0,0 +1,44 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024-2026 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 1882
> +#
> +# Make sure that xfs_healer correctly handles all the reports that it gets
> +# from the kernel.  We simulate this by using the --everything mode so we get
> +# all the events, not just the sickness reports.
> +#
> +. ./common/preamble
> +_begin_fstest auto selfhealing
> +
> +. ./common/filter
> +. ./common/fuzzy
> +. ./common/systemd
> +. ./common/populate
> +
> +_require_scrub
> +_require_xfs_io_command "scrub"		# online check support
> +_require_command "$XFS_HEALER_PROG" "xfs_healer"
> +_require_scratch
> +
> +# Does this fs support health monitoring?
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +_require_xfs_healer $SCRATCH_MNT
> +_scratch_unmount
> +
> +# Create a sample fs with all the goodies
> +_scratch_populate_cached nofill &>> $seqres.full
> +_scratch_mount
> +
> +_scratch_invoke_xfs_healer "$tmp.healer" --everything
> +
> +# Run scrub to make some noise
> +_scratch_scrub -b -n >> $seqres.full
> +
> +_scratch_kill_xfs_healer
> +cat $tmp.healer >> $seqres.full
> +
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/xfs/1882.out b/tests/xfs/1882.out
> new file mode 100644
> index 00000000000000..9b31ccb735cabd
> --- /dev/null
> +++ b/tests/xfs/1882.out
> @@ -0,0 +1,2 @@
> +QA output created by 1882
> +Silence is golden
> 

