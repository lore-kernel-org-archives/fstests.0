Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E38A42050
	for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760729426; cv=none; b=rHh788IyrplXbf5xlanbJpcakXh7dwqOH3K0vUEib2/DxxqTqIbtt0/g/iD1ugGrUxzTtalAfPey8eji8A9fuOdfSN8HxCVl4nsNCUHvgGMZmEP6AxuywN47hlm3OrF9j62PKWwzatFJWpL+l0fnDVEN3eIkq88uyf7B1tH8Uh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760729426; c=relaxed/simple;
	bh=ac30U7GQQORXzpcrqqMcSfoRuu1DKEHwjaDFpbJKsQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEpUag2ELWKVg6rCU0UcmTKph1b1yVO8l/OntFORz1W8+iG3vdl4iPws0cso65gsgyendk+RXU1JSHvO8Kuunp9tGZbB5AWDMQc/wGav7GDZEm5lAp6VGvvqh1NN2H1/cUicGXzwL6mavehrWRquyDLfPZPsYwIC9al+J7O+L7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VO+ANYsN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VO+ANYsN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760729423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7VL9F1Q6eRmzq2H+mSS9Xs3FgFDlVtC38/QZmDEt33w=;
	b=VO+ANYsNjJQ7le3A2KRlNBCeb4KTg2z/2/cOaCANq0d1ofvRq+YDfapta1qmgMvlZs1eIt
	mxNWFXQUdCZ1kfHEkVPtDJv1sQ1+m6GTZFFzZeWonWE3yJb4TviiXFkpsreVQHsqXfpbIe
	86/467VV0bqOn+PTpfP8shVkSYKIo8I=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-5IoIgDSeM7SgEGWcSkb9YQ-1; Fri, 17 Oct 2025 15:30:21 -0400
X-MC-Unique: 5IoIgDSeM7SgEGWcSkb9YQ-1
X-Mimecast-MFC-AGG-ID: 5IoIgDSeM7SgEGWcSkb9YQ_1760729420
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27356178876so16688265ad.1
        for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 12:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760729420; x=1761334220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VL9F1Q6eRmzq2H+mSS9Xs3FgFDlVtC38/QZmDEt33w=;
        b=KVrIjGZZn2yVO8DKU5bviX2aKvA/4WJ0G/Sb9g/sq3zAf15TspGhw+qaEVDqUYe+1F
         zaGGbvyqDfofQr6RxQLP9Jd3OpkKRf4WZonpnh/8/mMFu/0WrYOoSBpu9SdnYiF/dza1
         oj9aLmn2bwauFdIvq5CanY6tY+GkZ1LHBrDVaJArosisz46BAWixzIoHs1N3JihfHGzA
         sWiCgrt7MXslurCjDp9SxlIC0BcBRtyLw2Q7rc7xZnTYjq7/nMUBIVwkRdThQZewOKZw
         7HvJu7vZHSUFA3drebvsPAUU4zxVX7x3lqQLdR9XFU+RsgBxDMDXq1mXR5YOxyS+rNro
         pMkg==
X-Forwarded-Encrypted: i=1; AJvYcCXaylpaRhR01rgp593mj1rYfGTnRs6WuFuRcr3AAGsGW1bjQBNsHNwfMKXuoBSA6tJRnqaKmw7t@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxm9YQZq8goinS0BNRdCzxLtXPHTNj5QfSddpe2S7VaIa8u9K
	w018lC9uvpwG4frHZGk9Oauh2Y4jhNcPFTF9LE03DxwXtFbCRTaK7NIxGupp5P9r7FyJ/BNV0X5
	SnEPN8/0RIBjHUDEiM4T0Nq8KtPXgWpW8yrhmHdvbskRVOqSfvzqxA3jm3OH2/QipiRg=
X-Gm-Gg: ASbGncuKEXRfyutKcPItsZQoP7vIIb0FbgDD1J7alFimGsf+/H3FmLgq4ibq5DWjUt7
	25mNiE9vl0J8o/LIRmVdWW+57QB6yctGudxGvNAmVZerTBt4uVQ3fzPmqP/YTKUzvects+5NNPL
	K6XIhXdTV/ewaIJWVLKL1R8ECtFgwz2JwZ7XAymTvAJ4Gi/i2TH2TePpO5aDh9aQE3KorjcugGM
	1vZUn2MqGg107TjDh35Yx+5iaLeG56J6HFTsCGrtdx32rjMrb/SB8L6Y/bC4EvZ6I4OhMdKZ3yw
	B9xg9xGArekMq6q35UVd0WVOc2D817uocREM0Kri87iImHm62lYNfjb1x6AAfU9k4xHO+7tyPM/
	qLpShjo1EXuBlAaIWC5CMzpgeYh1xHEPOCg+90Tg=
X-Received: by 2002:a17:902:e80c:b0:265:57dc:977b with SMTP id d9443c01a7336-290cccc781amr59659345ad.61.1760729419839;
        Fri, 17 Oct 2025 12:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG86OYrKZBz0jqOvlvMY1DrD8J9pWCiiZpCc3+lBMHwZDjWzThPUv6LILa7L0/tIPfw/2/thw==
X-Received: by 2002:a17:902:e80c:b0:265:57dc:977b with SMTP id d9443c01a7336-290cccc781amr59659045ad.61.1760729419400;
        Fri, 17 Oct 2025 12:30:19 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5959sm2910105ad.68.2025.10.17.12.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 12:30:18 -0700 (PDT)
Date: Sat, 18 Oct 2025 03:30:13 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 1/2] f2fs/021: test quota mount option
Message-ID: <20251017193013.ykrwjftkvhaug76z@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251011084715.608562-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011084715.608562-1-chao@kernel.org>

On Sat, Oct 11, 2025 at 04:47:14PM +0800, Chao Yu wrote:
> This testcase tries to check whether f2fs can handle "usrjquota="
> during remount correctly, it expects kernel will encounter NULL
> pointer dereference bug w/o the fix ("f2fs: fix to avoid NULL pointer
> dereference in f2fs_check_quota_consistency()").
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

Hi Chao,

This patchset has been merged, you can send a seperated patch to update the
commit id of _fixed_by_kernel_commit :)

Thanks,
Zorro

> v3:
> - update commit id in _fixed_by_kernel_commit line
>  tests/f2fs/021     | 30 ++++++++++++++++++++++++++++++
>  tests/f2fs/021.out |  2 ++
>  2 files changed, 32 insertions(+)
>  create mode 100755 tests/f2fs/021
>  create mode 100644 tests/f2fs/021.out
> 
> diff --git a/tests/f2fs/021 b/tests/f2fs/021
> new file mode 100755
> index 00000000..0cacb138
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
> +_begin_fstest auto quick mount quota remount
> +
> +_fixed_by_kernel_commit 930a9a6ee8e7 \
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

