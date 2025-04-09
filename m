Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E3025B691
	for <fstests@vger.kernel.org>; Wed,  9 Apr 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194228; cv=none; b=c6EY7K6lZcLl/P/4WwhmSjjT+byBMLdvUtCZqkLlgKDgTDusaOzLjS/REii7u/CgzBWyTdJHfXWXiivTpW6kNZYdDb1LUC+u5ygfrZ/kbnNewdi48x0vsDo+NMUickU01HUD3yJxSp78mIFZT42wOv2mDcUFfXdYbKuX0Peo6vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194228; c=relaxed/simple;
	bh=pyeFoEm78Vu7hsKXBNymqLj471vUb8RdNTwN5jdedmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TS+/9piLK0koleg7EiZwZAsi++FRMVY4TtlQy+GaQGDZO3KyI6L/DZPASTCsWWnXO2eCRIJhlhKw5+ezZ8fiWkwtRtQxV8L2aMWIVlefVcOMeSjhkBMiu0Ng6AIm0OlcL6kMKlstgjlEG4gbJZ5N6V2V6gFuD4lnaqwZLAOrKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XuvS/P24; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuvS/P24"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744194226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0k7F4odglZY3WVlCzU+CBDzfgce9j8xtA/EUvRCkJc=;
	b=XuvS/P24YaiVYJE/Hr4bZaOA3rgJh+hCl3cuvCAzSXvDhaOr7tUa6xC9iU5xtjNDBkRU/k
	FkFfrxChh3M+hwUYSutngO9OZWPptjRnwnZyFqk+cbeh50ONlxpz4BXp/7fTLPNCru3FtD
	HSJM9EaOrz0TG9EUiXweE3TdrREIo/c=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-XGaOtiAbMSK88Tsti7NIyw-1; Wed, 09 Apr 2025 06:23:45 -0400
X-MC-Unique: XGaOtiAbMSK88Tsti7NIyw-1
X-Mimecast-MFC-AGG-ID: XGaOtiAbMSK88Tsti7NIyw_1744194224
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-73720b253fcso5239312b3a.2
        for <fstests@vger.kernel.org>; Wed, 09 Apr 2025 03:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744194224; x=1744799024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0k7F4odglZY3WVlCzU+CBDzfgce9j8xtA/EUvRCkJc=;
        b=JgrRIpwqtec0cmV6YyVN/dtk49skSagW0BuMzpFLJdWGC3iSYx2SiiRqkTP6b4s2I4
         7slXX75XBkCOZ2dBaNVspWNJJ5z3h2GKweaWXJnAoORXmjec9CDxg95LFF/SjSCVAaSb
         qcq3LE/ajufBW30GG0csgAvlfyHfoLiC3QTuLBue9HR/y0I+hoNPtsg5bDTJvZkE78Wg
         1d6cwOqn9nj/LGt7loXohSWXQrwlrRfJfSrZNE02/ERmpmqpTnyiSI9gCvVecr/VEJtp
         AfvpCoLDCY9+KMjtmnCkeRCidXAXVMxzs1cUgt3T8WO057BdkpEbRfQsBYrascqc+ADg
         vHMQ==
X-Gm-Message-State: AOJu0YxC6Ob/BNksqaPLLPZ39rck0ycEsp3iO0bRp/sixY4Ve98/JT+Q
	jqntio9jJ6+cO54CRbwT7/wP8fWvfT6Wc3bi23CRc+7ZkBfeDTzJAOtNWoAm6UWnyJiyry0ztN2
	7Tl9y9uumL/iYwDbiu3x1lZbFmV4bfJLryT8Q1XxQtLWQuVpObcsNBjFlel9YLITj+A==
X-Gm-Gg: ASbGncuywQrcO7qjo79lb4GiWn3FU6pkDA06LzHHnxc90ebjlYXa8kUqF+KipNuQFnL
	I2Z8B7YbpQfh+RFkoKw491Ao7BagBTjb/rzSNas2PkXOnLu9kgHouk6ETM0Mq3/bEi0dQX6YMcq
	ekrCGhbUS9PQ0QOfAXzwKOOJGmd9Go+fJi71oN1XuWMcdtwTH325ZtuT9HajWXMNcEQGdybt6Hk
	J2M51IJO+2pS90Z6/3+ZB9DCA/Vc6AkG+99r/PAwkEEML6af6xdUiiX6TRyZYWhPpJrHRNZsYmd
	VOr0Vf3wRtOrMuPEgP1igXxVLOa78v4/KDIKNJbgst2sC/hKWduN
X-Received: by 2002:a05:6a00:2292:b0:730:95a6:375f with SMTP id d2e1a72fcca58-73bae490ff7mr2917718b3a.3.1744194223662;
        Wed, 09 Apr 2025 03:23:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnGrfx8aEqkXH+Rsu2T9l6BMFNcFL/SeTDqH3+NG+bKZxq+tjV1K9cz8WsTBYSRErlRIx4ug==
X-Received: by 2002:a05:6a00:2292:b0:730:95a6:375f with SMTP id d2e1a72fcca58-73bae490ff7mr2917692b3a.3.1744194223278;
        Wed, 09 Apr 2025 03:23:43 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d6af12sm930692b3a.80.2025.04.09.03.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:23:43 -0700 (PDT)
Date: Wed, 9 Apr 2025 18:23:39 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v6 6/6] fstests: btrfs: testcase for sysfs chunk_size
 attribute validation
Message-ID: <20250409102339.s2akqjndh25hqkjr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1744183008.git.anand.jain@oracle.com>
 <a53aa65a639bd7906c28418bee14ee4d006700e4.1744183008.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a53aa65a639bd7906c28418bee14ee4d006700e4.1744183008.git.anand.jain@oracle.com>

On Wed, Apr 09, 2025 at 03:43:18PM +0800, Anand Jain wrote:
> Checks if the sysfs attribute sanitizes arguments and verifies
> input syntax allocation/data/chunk_size.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

This version is good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/334     | 21 +++++++++++++++++++++
>  tests/btrfs/334.out | 14 ++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100755 tests/btrfs/334
>  create mode 100644 tests/btrfs/334.out
> 
> diff --git a/tests/btrfs/334 b/tests/btrfs/334
> new file mode 100755
> index 000000000000..d81ec921f1f2
> --- /dev/null
> +++ b/tests/btrfs/334
> @@ -0,0 +1,21 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 334
> +#
> +# Verify sysfs knob input syntax for allocation/data/chunk_size
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +. ./common/sysfs
> +. ./common/filter
> +
> +_require_test
> +_require_fs_sysfs_attr $TEST_DEV allocation/data/chunk_size
> +
> +_verify_sysfs_syntax $TEST_DEV allocation/data/chunk_size 256m
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/334.out b/tests/btrfs/334.out
> new file mode 100644
> index 000000000000..f64f9ac09499
> --- /dev/null
> +++ b/tests/btrfs/334.out
> @@ -0,0 +1,14 @@
> +QA output created by 334
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> -- 
> 2.47.0
> 

