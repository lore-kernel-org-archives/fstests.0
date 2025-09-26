Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B44273D9A
	for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910738; cv=none; b=D0qFto9oyz/BitjYgO1JGOZsNP/c0j0gJRaziTiOOG3i0+vfdDsSXrrHpPoU5r1M0Jgkw788TAKtNPJw1S5DA/JKuWGhS1IMo9Nvo5OrdktCFPbS7xc53FtOZRTWOMi4jIcp/UuBjEq3a2g86aW1dMiJDKEoTIXEFfOlZTOq3Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910738; c=relaxed/simple;
	bh=S5E85luiva6ZMg0jLPUaJReSCTKGXTYKo9iC9ozGSKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGuVDTRRxiY8I97OelcG8GZSmAvhV02iGvHe9/vdpweyV7hSLJ9B2FP6m+wdZKhpwhUMLmO2s9+m9lagr3MiX+nmjwcxOFpnh6XhgQuNVxg/QH1HyOlVSBq+NtTIi1SpjB0c7kdWFtfYjxJQh3WI3O2wetspM8+fFZJYG1a/mkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=do2eqjWi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="do2eqjWi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758910735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cX2wH+EbGFZUEI4y4724LZ3Nec5RAN0sk3YwKB4Gqi0=;
	b=do2eqjWiAR9nEs35mfjJIOp+gN39TMJgALFlluxs1XBSaF38uNrg3pXJmh2jTDAMS7pqAQ
	ZKvwLvaVQYhvDRDP4OT+PNvu2bTzWErHv8Amf1DD11Q1y2ISfGI78l/6KV/o9E2YM5noST
	1xpdKjgbOTwijAVOxHbBMkh2646qdcw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-XBRT3ytkNDqDG0TkbnUdNQ-1; Fri, 26 Sep 2025 14:18:54 -0400
X-MC-Unique: XBRT3ytkNDqDG0TkbnUdNQ-1
X-Mimecast-MFC-AGG-ID: XBRT3ytkNDqDG0TkbnUdNQ_1758910733
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-330a4d5c4efso2443292a91.0
        for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 11:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758910733; x=1759515533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cX2wH+EbGFZUEI4y4724LZ3Nec5RAN0sk3YwKB4Gqi0=;
        b=jOtU+Triby0OLLfnuJH5NC6oKRPyE5gWfDDCtoY94EHFKr20qTAUxhO9CA1Nesnber
         WTC5IxZyOz0hYeLgE+BajyEKJ4mcDfZHT6UC4gdk5n6WdiQp5gUk2PJbm2MmRs1LpS9D
         8vNbWizmAKGqsFNyvsgg3Kra731vCPFoxRpirpTZY6DU0uA30XpdTt1B/DzkIJ8jyfkw
         4ukyZfELwghQ62a+nDLQijKu2GNdRiq53USq73lJ5ACTR+9s1dhe9RK5tx9PKqUh12M8
         l8v02NnGLq09+3wHFsn8m5XACVp/lGrzjFIYZRugGrNZN+uapqMMFwpx5GYh2P2TfPoK
         euzA==
X-Forwarded-Encrypted: i=1; AJvYcCXGfO1x08sQ4smPVJ/AuoP1olcfMevAEc7WjfTLERS7pYrt194g+QYOAL6pCnY3bNbfOKx4hWWg@vger.kernel.org
X-Gm-Message-State: AOJu0YzY8aqE8zZ73W5yblH5qC2wUBVH01m/TrWC6qyT87WCSkQlpbNz
	Sx/2buEM80PU+VdbutH0nHuHj5Inl9Jw7bVYpX6uOecAoy01qWA0BdcTOAa5awvOjbYWiVchB2+
	y1MwgEAEOWE5UJbLjF9f+aMNIq+KChHn+e8ozfPP2SXfpPzIbGFCSVslZdAw=
X-Gm-Gg: ASbGncsHvB81/kwzeDhI+GtD8f/zrxdfs2kfCxJ2D6YZ4XmW8/qowxoH2ij7NQqzARk
	2MmOZCDP4Fcjy7dG6MSpiYLaEKgeABk8Z0i2rnXBKOyH6r+/N9hN2fbHie0f/qtCW3ZJ8ryiZ6J
	Mm3A/DkPtbC+FMJVLGu4k45B/Kv1wrj3ZcY5SNBYX6ieaaWS2sDgkbl7F8sc+rHyaoIrhjetSPr
	sJc8RS69mK5SujB+fY0+1R5LCqBB18jI6SsUBAl2dbDdPbhZVQ5dvLwcSKMKW6PqQgWL7euPvKO
	JWNx5hLkN0QG2g998CC7b460k4sJXEC9xQuiXWQK3yUYsWeKTGLStM5YS8YN72Z1wNKgtqJm5+8
	KBhHM
X-Received: by 2002:a17:90b:1c8d:b0:32e:936f:ad7 with SMTP id 98e67ed59e1d1-3342a2d9becmr9613042a91.27.1758910733044;
        Fri, 26 Sep 2025 11:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGAB85DNc1y13kOKPOXXUiKKWLpm5a6b8DXLkkhg8vG9CugFJu9Hub8qmZJMRL++wJuNGUfA==
X-Received: by 2002:a17:90b:1c8d:b0:32e:936f:ad7 with SMTP id 98e67ed59e1d1-3342a2d9becmr9613023a91.27.1758910732612;
        Fri, 26 Sep 2025 11:18:52 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33473f7beacsm5990132a91.15.2025.09.26.11.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 11:18:52 -0700 (PDT)
Date: Sat, 27 Sep 2025 02:18:47 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/2] f2fs/021: test quota mount option
Message-ID: <20250926181847.rebyuxqba7hy225r@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250901020331.2171502-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901020331.2171502-1-chao@kernel.org>

On Mon, Sep 01, 2025 at 10:03:30AM +0800, Chao Yu wrote:
> This testcase tries to check whether f2fs can handle "usrjquota="
> during remount correctly, it expects kernel will encounter NULL
> pointer dereference bug w/o the fix ("f2fs: fix to avoid NULL pointer
> dereference in f2fs_check_quota_consistency()").
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/021     | 30 ++++++++++++++++++++++++++++++
>  tests/f2fs/021.out |  2 ++
>  2 files changed, 32 insertions(+)
>  create mode 100755 tests/f2fs/021
>  create mode 100644 tests/f2fs/021.out
> 
> diff --git a/tests/f2fs/021 b/tests/f2fs/021
> new file mode 100755
> index 00000000..c41760fc
> --- /dev/null
> +++ b/tests/f2fs/021
> @@ -0,0 +1,30 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/021
> +#
> +# This testcase tries to check whether f2fs can handle "usrjquota="
> +# during remount correctly
> +#
> +. ./common/preamble
> +_begin_fstest auto quick mount
                                  ^^^^^^^^^^^^^
                                  quota remount

I'll help to add these two tags when I merge it. Others look good to me,
if you've maken sure it can trigger the bug you want to uncover.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"f2fs: fix to avoid NULL pointer dereference in f2fs_check_quota_consistency()"
> +
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount "-o usrquota"
> +quotacheck -uc $SCRATCH_MNT
> +_scratch_unmount
> +
> +_scratch_mount "-o usrjquota=aquota.user,jqfmt=vfsold"
> +_scratch_mount "-o remount,usrjquota=,jqfmt=vfsold"
> +_scratch_unmount
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/021.out b/tests/f2fs/021.out
> new file mode 100644
> index 00000000..09f4062d
> --- /dev/null
> +++ b/tests/f2fs/021.out
> @@ -0,0 +1,2 @@
> +QA output created by 021
> +Silence is golden
> -- 
> 2.49.0
> 

