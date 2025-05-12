Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B81B393C
	for <fstests@vger.kernel.org>; Mon, 12 May 2025 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058552; cv=none; b=lMoKHkVD14+qArKf+9kVjd+ef9rSI1l4vNWyQj9ihIDI/RYzLTdWa5AXjOxowcCxkfvnolrE622lEW9Rc6usiF8p19A6WtFGJ9ntstQSxCDw4naKVvXU3yFvy5wcDiuK8SuGDhTQmsd37FPQHQdNEBGeiv8WXOu16az8sHTGJ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058552; c=relaxed/simple;
	bh=qULqdWo7pxBlk7H+IlhSG4gaCjWWnR8QKtrtufBn4ps=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=Pcb5m8hK3lQGmvP9IacyCeRPQD8MkE+Vgfi4H3nOJBQxtEuAeTOSNqh021ed6El5chb1mTZ9pC/yjajogJO5cJUZrlU0IL8I+RCL18Dfge3nEKMF+KPEAC1zudZRzrAbi5iQkcmCuDo+82vxoR4Y/ZXG3ytzfg/XQ+eoP5oS0ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR2o+Bkt; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR2o+Bkt"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4c34dcdaf88so1641562137.2
        for <fstests@vger.kernel.org>; Mon, 12 May 2025 07:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747058549; x=1747663349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHsKJMdtVpvcETBzhfbUmlhulB89NGM2mwTc6CkdgQI=;
        b=BR2o+BktViz0CFG+lRET5oT70w4QQC0b8F0XT1VEFWqIq0G7bgsRLmtmKIS7ivUtX5
         lRptn5C7tGeN682N6oMupormnqHCModZkkG4u5CmdwHsP8m/yynEBlWjnuE6U15hGHAW
         jcgzkPA/nf0NedM+zT5Q/cTbNttU4nLVgh4Pzh4Z4mBMZsFUvbxSkuE4Bl/bYECCBFSZ
         5LYt1NhSetLewhrrCeN0jU+04q9rE7jSDCK2ZcgYD9KJLArCRy9DVgo2NiTvVy7Z48+U
         DoqTUFJzuzehLHtYu3YyYKHIHkiL9da7ByTpJqvl3kZv6Ebv4lCPMK7rV4XoceEGANjS
         2C7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747058549; x=1747663349;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oHsKJMdtVpvcETBzhfbUmlhulB89NGM2mwTc6CkdgQI=;
        b=OHYMLzSY64rqR2NwAjW6mE1GChBWqVyJtIKMQDSUk+BVzy8NQm/GKaIFmvmfmfO7R9
         jwXETvh97P3LscOWJB/cDSJRlZBkt6qqsEIPlizWXZWNloP9ruoR7pyMB9+B2QVpgBea
         ZoLmmVSHW2p6LFQLL4I1+Sm1E/74KCYYEWmyIAAhZJFUPQ4eDtIhWFtsKezgEZxNdt4g
         cq3zCTA5SlIZmQRthcZ4NlSUpwdc1XGx3H7j5w9vNd8br0PNVuFzgoL4Y5to0ysJH5hi
         sQ4PhKoMNPQrV3Px2zCiTBHYut4AJBr8OT1GZMSaRAM4CrOCX7VSwCRFtqIXC1spmffA
         I8/w==
X-Forwarded-Encrypted: i=1; AJvYcCV7r8Is/sfpOLGHN5TxJiYVFVQ3hNO/4EjISG+N/N5ygB+9JqgfwRbJTVlppRQ0b7QcMoETk/iK@vger.kernel.org
X-Gm-Message-State: AOJu0YwDGWfto9Isl7Qipo84uypY91VXWSKkngsqVdspOdzTiJF6hnlK
	c39JJ+tJVImrOlL1iB1u07kS1B2x/z7hsAQpVGEDpT1KG3tgfosKjMtxWg==
X-Gm-Gg: ASbGncvcwqQhRLRXQRQJvP6Uo1yAT+lkEQOOlAs0TTEs5rqdH8fnEEKenD/NmmjyCON
	O3P7mfhtHed0cPpW7WQFN2+fO+eNQz+vWAuQd/1ZikEG7RZi83m9IzvrD48JcFKzLWA0bWybCEn
	oLbEjl/YXv1flnxLvr+7oRJrNDqfJdhzdhjojVYvo6kvIU+owvWdWx9Jl9fpb776Oa+uHnj8Wlj
	/PWTAJLhNvI1E9CuEC8K8urBHbGx5Fmobiq/d6VBZEpUKJnmKGveMAWRRyG9ho2lCjrFymFybue
	GM22Oi/IqzDSnklmH7fjvwVlTqdXhzrdex4+e0ZLCTSDZpGsVUFdxpdSK9WucmvaqXwbNPJB5mg
	M/9vj3RrNGGqiZenMT/mVd8wHa5mB
X-Google-Smtp-Source: AGHT+IHc1FwjPAT6YlAReu5gRrmoHq3ExW5KyALvh9/TP96qgEPiw1QUroPGSC/KYqEeEfvHQ4zhng==
X-Received: by 2002:a05:6a00:a0f:b0:730:9502:d564 with SMTP id d2e1a72fcca58-7423bfe5164mr16371207b3a.14.1747058538535;
        Mon, 12 May 2025 07:02:18 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a405c4sm6071114b3a.154.2025.05.12.07.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 07:02:18 -0700 (PDT)
Message-ID: <434c560c632558cdc32b45f2aef54c68ca6c0baa.camel@gmail.com>
Subject: Re: [PATCH] selftest: add a test that flakes
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Leah Rumancik <leah.rumancik@gmail.com>, fstests@vger.kernel.org
Date: Mon, 12 May 2025 19:32:15 +0530
In-Reply-To: <20250510004256.451058-1-leah.rumancik@gmail.com>
References: <20250510004256.451058-1-leah.rumancik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2025-05-09 at 17:42 -0700, Leah Rumancik wrote:
> Add selftest/007 which should fail about half of the time.

I have already posted something similar[1] a couple of months back. It got an approval didn't get
picked up. 
[1] https://lore.kernel.org/all/20250113164639.GG1251194@frogsfrogsfrogs/
--NR
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  tests/selftest/007     | 14 ++++++++++++++
>  tests/selftest/007.out |  3 +++
>  2 files changed, 17 insertions(+)
>  create mode 100755 tests/selftest/007
>  create mode 100644 tests/selftest/007.out
> 
> diff --git a/tests/selftest/007 b/tests/selftest/007
> new file mode 100755
> index 00000000..0e983b37
> --- /dev/null
> +++ b/tests/selftest/007
> @@ -0,0 +1,14 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 007
> +#
> +# A test that flakes due to occasional output mismatch
> +#
> +. ./common/preamble
> +_begin_fstest selftest
> +
> +echo "I am intentionally flaky"
> +echo $((RANDOM % 2))
> +status=0
> +exit
> diff --git a/tests/selftest/007.out b/tests/selftest/007.out
> new file mode 100644
> index 00000000..0b5e439a
> --- /dev/null
> +++ b/tests/selftest/007.out
> @@ -0,0 +1,3 @@
> +QA output created by 007
> +I am intentionally flaky
> +0

