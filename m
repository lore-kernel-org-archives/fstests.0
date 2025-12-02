Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB712F60D5
	for <fstests@vger.kernel.org>; Tue,  2 Dec 2025 05:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764652336; cv=none; b=Nc5AOt6CH+GcSzH0JUfx37wQ7WD935hF5q5piDiKjxphGulcPCTL/RHnErt5B44cdcpqm7qiUnkjQB0pFL8o+39Vh4zxWmWfxFT9Obcu5BQCUCq7X+NMT76lhlX6xu+M7ruvwtpjgR4DihT2TCZ5N7RX62Dv9f0QKlwQw7VJNS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764652336; c=relaxed/simple;
	bh=ihMRFFibkx4iZAo+T769NF0X6xtfec6KCzeaiEyNtFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsTEEgu4D5FwfVk0O6YJM5NYpzCdZzR7Pl6IqR6wqvvbv2zFliXLO2XzKginXq+zlXrvSQ+R7UZuJ5fAgu4P/GFg4tEHPZgwZiQsQM6DL0p3nMrBhHZE20l5zqyaANcinZBXjN1IffhE9LptCu2EgPHgKxwpsrnHmEq9PWrC0KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0zNoxUm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CSOOA/u2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0zNoxUm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSOOA/u2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764652332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vk+CkeVt6vIORHD5FrSK0jxLpo6cDXbgc2E73tBRSUI=;
	b=O0zNoxUmKkSIhFEzrThAfFgrb3ll6BpKe+MtoORZfoyDvPuRphnUx3pxWSY4v+T5Ske1Dy
	jXKCi0y8CAa48isCSK89lYYvgSQBl7F3v1BBO07vniE3PIayRWyKl+itLnEDeK+rK565iZ
	Fjt7ZcO31p+iQmZC1ifQzmwHl+NRwLg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-Lo0NpzdlPYWlTH-Wv09YyA-1; Tue, 02 Dec 2025 00:12:10 -0500
X-MC-Unique: Lo0NpzdlPYWlTH-Wv09YyA-1
X-Mimecast-MFC-AGG-ID: Lo0NpzdlPYWlTH-Wv09YyA_1764652329
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34374bfbcccso4454707a91.0
        for <fstests@vger.kernel.org>; Mon, 01 Dec 2025 21:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764652329; x=1765257129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vk+CkeVt6vIORHD5FrSK0jxLpo6cDXbgc2E73tBRSUI=;
        b=CSOOA/u2DlQ+D7YPrFrnNkfvzey/AK/swv1xixLaivSGNde71xStTioyMgyfsPuipE
         B7tkIsVMkgEQ9c0HX6gMfL0Nv7YadmjuXqP6CWUdUGEcsoHA8ScJARzoWcfQJnqRsu4p
         hp3ALUOkP5ulPrXVAucuWFZeX+edrR0sKwACnUf0m6Rh1XsGNZvS8oetGjYQjrNU2e55
         2rOnIva1939iUMcZOSe1qO6TifUzCf0erLV4Tzq/ZbIlffUQ3bXr2AOCLdijWD2o8mc5
         +bqHBdjkwaXUxgm9UDvV+aNAhb3o0PtE4HBQDQKdqShX5KOtLq2etvcwKDkU46KxB7gQ
         Fz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764652329; x=1765257129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vk+CkeVt6vIORHD5FrSK0jxLpo6cDXbgc2E73tBRSUI=;
        b=gjhzU71jB5rC0NlOp6+LZVDgMwp2EvYT4M+JHu8nBNfqMiQzQpOltaCl1osYzN+YUi
         Q6IHRCZy1LXT1sN/aYCXR+xtiXb12gNcfLswJMGd+Mmmnn4H6wzA7j3XZmKgcPjGKv55
         nGCM353iDA8jAvmtCEfl8npfPUgJYIMQXrlw+7/uf5kNlMZ67uPL447pjIWsIITNLw0Y
         VqSlmD050Nh1LWsE6qNBbAZA38aL6BMgwPn13KiBV6OlQ4cGVnC98YAjkCuVRgGPVBum
         6YILZOFq0d4VtAczskUFkiRK8fs1/yBoe2I+N44nUd0E/ilnLpfYIlfsQp+020/e3vCg
         uOHg==
X-Gm-Message-State: AOJu0YxHuh+XhV9n2KmlmUlpRI6aOxXJ3pOJWxc0mEQKJ+lTBRJynOny
	MBEYJvmXfNZdeMQIkaoEwTeS1wY1IKEx8K/zYFZQAVP371jzJAYVfh/eiwyDLXYYm+FW8F+m1Zn
	FZxpA7clX37OtkaQ60HaH+5Oe3rBI3SKeuAKNy2tizkx3rVAUmCzQgtQJxEQ=
X-Gm-Gg: ASbGncu5d1QpiO1cj92mQnCo9MzkPTSRtQPsjuJeI1EhDrwNwxwiRFSsTDCsg+JuqNM
	UQQzi9hVSTfwQjdhjCGMrvlROabzH9F5HzT+YK+3Tc0h5thohA6ftvuspwQtdNILnlXlO3WaJ6l
	SI06ykSR1XFL/4pi4AAXEsK0/+xf3aHocaLxOwJ13mHCT7azSh3h88SZGt39eQUO0QclYESJ9sA
	jqiDHeBWXHwPz9bZjvG33mIa9wbN2Yl1aNq9ftJNWUDNpd48oU5CscTXN5H9/EARhfA2s+NF3HE
	QKCAgjYPu21GEM4Yn/LytTuEIFRTtbrqJzz28P4rEOO3O1jDI2teCFPPuaKE1M+Fxw2bnwnYpsU
	9BUPBCjT9I6FpDv4pmveyI0vMq+I64qTGA2vREmem7KjCek9d6w==
X-Received: by 2002:a17:90b:4a4e:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-3475ed515cfmr26384112a91.23.1764652329090;
        Mon, 01 Dec 2025 21:12:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHux/qd0DXAzACnKqI92pLYuMfCCxCYJaKOo2Zi7xT1CdUkxKWNgLE3HB77yVmOBRmOe+dtew==
X-Received: by 2002:a17:90b:4a4e:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-3475ed515cfmr26384080a91.23.1764652328684;
        Mon, 01 Dec 2025 21:12:08 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a7e8b65sm18598669a91.17.2025.12.01.21.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 21:12:08 -0800 (PST)
Date: Tue, 2 Dec 2025 13:12:04 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH fstests v2 3/3] generic: add tests for file delegations
Message-ID: <20251202051204.nm2oplwits7lfq6z@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251119-dir-deleg-v2-0-f952ba272384@kernel.org>
 <20251119-dir-deleg-v2-3-f952ba272384@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-dir-deleg-v2-3-f952ba272384@kernel.org>

On Wed, Nov 19, 2025 at 10:43:05AM -0500, Jeff Layton wrote:
> Mostly the same ones as leases, but some additional tests to validate
> that they are broken on metadata changes.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/locktest       |   5 ++
>  src/locktest.c        | 202 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  tests/generic/998     |  22 ++++++
>  tests/generic/998.out |   2 +
>  4 files changed, 229 insertions(+), 2 deletions(-)
> 

[snip]

> diff --git a/tests/generic/998 b/tests/generic/998
> new file mode 100755
> index 0000000000000000000000000000000000000000..5e7e62137ba3a52c62718f9f674094a107e3edca
> --- /dev/null
> +++ b/tests/generic/998
> @@ -0,0 +1,22 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Intel, Corp.  All Rights Reserved.
> +#
> +# FSQA Test No. XXX
> +#
> +# file delegation test
> +#
> +. ./common/preamble
> +_begin_fstest auto quick

Same review points with patch 2/3. And I'm wondering if we these common/locktest
related test cases should be in "locks" (refer to doc/group-names.txt) group.

Thanks,
Zorro

> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/locktest
> +
> +_require_test
> +_require_test_fcntl_advisory_locks
> +_require_test_fcntl_setdeleg
> +
> +_run_filedelegtest
> +
> +exit
> diff --git a/tests/generic/998.out b/tests/generic/998.out
> new file mode 100644
> index 0000000000000000000000000000000000000000..b65a7660fea895dc4d60cec8fabe7be1695beabe
> --- /dev/null
> +++ b/tests/generic/998.out
> @@ -0,0 +1,2 @@
> +QA output created by 998
> +success!
> 
> -- 
> 2.51.1
> 
> 

