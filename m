Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B3A251796
	for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381650; cv=none; b=PPvApmjyHrLrvXGbhxcdmLxQtO9inkJKUnsHTjBM0z8ywSf9LmzdGDRRiEB5WoVwFfBTEGry2uoCcZ+O0o4wv1SUhpcHeGFJJya+Yb5Q/2rhf/815DvIUlb/QPiki3jQJ/9SmdcXlm+mt6HNZMDymyAJNJscr4HRHv6vluLPi/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381650; c=relaxed/simple;
	bh=WAabwxnTGOL8Ujttl5LoUsaZkJtnRlMXFXxCus1adcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FArOLegiG3qhNF+AFY/rbyRaCw+tHPMiYmiBs6y51bJekTkgP75Z35UTbNdTrynwQlTwBOwUSxeyEIEY4dP45jgsZocCbyiwo1KLB0+Tr12k7MJCGIOepNnPpgQ3v73O6TP4DlV87KK+CfTHo7NFlQ/um8aCtXpC9OTI6XT/RLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOKNkfdK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOKNkfdK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742381647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hmmBQM6+gzkEBaTUsXzJYVbA/vn3n8h18EIwPhYpF+c=;
	b=NOKNkfdKE1rDTD4lee4VGRbzHq4msEcC41Fwp9qZZYLpzL8kwtwXmvdtwmKwu5Muc0CsH5
	D2C4itMIMZWu0ISR6QdPq/O81IdxOkwVlsIOcNSanNPAgX0grvWDFF8x26xBY7YoNEistN
	0FDFAo9JL/YIa81G7CwNUa6Gm7hbYag=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-wu2_KSPCP0iSxnvdygNucQ-1; Wed, 19 Mar 2025 06:54:06 -0400
X-MC-Unique: wu2_KSPCP0iSxnvdygNucQ-1
X-Mimecast-MFC-AGG-ID: wu2_KSPCP0iSxnvdygNucQ_1742381645
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac2db121f95so139310766b.1
        for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 03:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742381645; x=1742986445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmmBQM6+gzkEBaTUsXzJYVbA/vn3n8h18EIwPhYpF+c=;
        b=aPb839JHkJK9OGq0yrm5mPIT3T2Fs1TBjo/Rts1npKHpYUEP0igF9N7jW0yyep4xHs
         6XrJcem3aXN0kyP9NlLMgBb30SwfjEcptvgXzbfW27Lo1i1HHPE7b42UmZlrsd3t5wFW
         d7ADBKVsGA/7X19M3NRyr7H3PPpP1oIF+kF7bFNIKj0UWJpmmiL1u1T75VAW+SlhxELu
         Ot15wfgD2Qc5uK/vxNZhFI4KUI11Zme4q7TOotKFxLBscRXljBTTUUSH0Kd5ZWaW513l
         LO1VLJL5C3/jjwhQ83+TPZNN40hzGtt0aJAaitO2pj1hLERVgMTWmjhFknnfRF3I+4ZH
         B3Ow==
X-Gm-Message-State: AOJu0Yz0iXOdYbZXnrgXos1ofCq7lFz/v/TE9f1AB/NQiau/5WaLy5O4
	e8OP+Qr57ThBxwW8GyZtCvihHH0ZudF1B0ZFyJsj6aiGrNxKkUIQpKANL1uCcBxytDMj96U3stk
	6s/ISDSl76hPxDzA4rvU9DgAj2N9Mhy3yD5zyHCSb4q6ai/J0ZRDfvNf4K/g1C9HnqhRu6GuHcl
	P1BI8oylgi4aujGKFLTfDa5n12GWzsRtbE1K0N0w==
X-Gm-Gg: ASbGncu0Gul2WdWMyrTxbxxFFJVepzsD+0J+NyuE+1WWakQLbLfDnZHLARYFNIjh+kW
	3+8LWgpj84+SI+2AeV21JU8l6Oha/VYF7Wvz5/jzso7xg7rBdxrN21nExU3HZ1VSpjueBBv0qcd
	FS2Hm/xWjmQpgIqii6xTNXISUPAYJ7yxQYQHo06LUFXE5tiKyUQiXzWHRgBiKr+zNcT5qHLgVbU
	FVPY7lZIqGTPHRrghIhU6roeY40N23ObNNzq9+E+0JoXu3qCvxTTqaQmXNCMV8rvmDYCrFNMnsX
	Ig1A+/+eQbLZasmcc/Pu26eQy1HKhkwetUQ=
X-Received: by 2002:a17:907:ec8c:b0:abf:6f87:c732 with SMTP id a640c23a62f3a-ac3b7c01cb1mr225590766b.20.1742381644706;
        Wed, 19 Mar 2025 03:54:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo3dyk5XjonUp03HZM2nbGgssJQNwtKrmCPIDmxnhu8baJ81sqXnqqzplqvXIFtTQkUAwkeg==
X-Received: by 2002:a17:907:ec8c:b0:abf:6f87:c732 with SMTP id a640c23a62f3a-ac3b7c01cb1mr225588266b.20.1742381644176;
        Wed, 19 Mar 2025 03:54:04 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aef90sm998247366b.6.2025.03.19.03.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:54:03 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:54:03 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fstests@vger.kernel.org
Cc: Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH] fstests: update missing gitignore entries
Message-ID: <onefsbwensjkrkjav3tycjklhns3j3f67wemhxduvucmznhzwn@x67jswejm6sd>
References: <20250319-update-gitignore-v1-1-6664aab9df35@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-update-gitignore-v1-1-6664aab9df35@kernel.org>

On 2025-03-19 10:55:56, Andrey Albershteyn wrote:
> Some build artifacts seems to be missing from gitignore (list them
> with ls -l src/*.c). Also, add autoconf backup files (tilda).
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
> Minor patch to update gitignore with build artifacts.
> ---
> Compare .gitignore to src/*.c
> 
> diff \
>         <(grep -F '/src/' .gitignore |sed -E 's~/src/(.*)~\1~' | sort) \
>         <(ls -l src/*.c | awk '{ print $9 }' | sed -E 's~src/(.*).c~\1~' | sort)
> ---
>  .gitignore | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 4fd817243dca37715d9a6ca52afa0f7fecfabc64..9b44071f8de3d43536e0a59c1a4a7416d6525f85 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -7,6 +7,7 @@
>  .*
>  *.state
>  tags
> +/*~
>  
>  /local.config
>  /results
> @@ -37,6 +38,7 @@ tags
>  /include/builddefs
>  /include/config.h
>  /include/config.h.in
> +/include/*~
>  
>  # quilt
>  /patches
> @@ -210,6 +212,13 @@ tags
>  /src/fiemap-fault
>  /src/min_dio_alignment
>  /src/dio-writeback-race
> +/src/enospc_unlink
> +/src/iopat
> +/src/md5
> +/src/scaleread
> +/src/btrfs_encoded_read
> +/src/btrfs_encoded_write
> +/src/fsxattrat

ops, some of them aren't compiled into separate executables and some
got from an older branch

ignore

>  
>  # Symlinked files
>  /tests/generic/035.out
> 
> ---
> base-commit: d71157da4ef4cfdbf39e2c4a07f8013633e6bcbe
> change-id: 20250319-update-gitignore-60420f206207
> 
> Best regards,
> -- 
> Andrey Albershteyn <aalbersh@kernel.org>
> 

-- 
- Andrey

