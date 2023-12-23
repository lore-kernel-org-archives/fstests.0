Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3915E96
	for <fstests@vger.kernel.org>; Sat, 23 Dec 2023 19:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ce6pmM2z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703358594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O00j2AIAqRuugHAvC+JIFU1mD3El9Iw99E2KnThZl5Q=;
	b=Ce6pmM2zFQBRo22fJfvdjkSsMAAzLkUiptWAlRzDwJowK6xkAWzHtNOTyNaytdaQr/TE5R
	l0OC0kMs5SYU89DsfO+s42vCQweXFGlrzOKs/f1gSuCXjDEES/wjDNvoFphLYFu+PvqTSb
	PAxMUdjm23bleibpyJsPnH2eQNlmW5w=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-d02k9JxTNRmvk2Ykb3TeBQ-1; Sat, 23 Dec 2023 14:09:52 -0500
X-MC-Unique: d02k9JxTNRmvk2Ykb3TeBQ-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7ba8315d1cbso339080739f.2
        for <fstests@vger.kernel.org>; Sat, 23 Dec 2023 11:09:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703358591; x=1703963391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O00j2AIAqRuugHAvC+JIFU1mD3El9Iw99E2KnThZl5Q=;
        b=s8MYpCwsqXkSY51JhZ7rCCGOsOltIUUN7S1qN+6RPit5DfUDrulDU+ZeJGFkTt9OfV
         oCWZT3a/6+x1on6b+NxEedgBLEgfLGGWYCJCI3cYLnpc8CtQgjHlDHk8n4AHzE1k1Jmy
         blPaXfpqcknBKqYB3vuRby46p6ieawkT8C5ZqbqI1VbJd5ulfnJ/M1OSksT0g5k3WyPk
         IEojB1YJubNpgC6NwUrCIuZu77qEP/l9jyYy/D/P+MqgK5A4OLTqYEJ0ln5MVgmDyINS
         Onn33zFi62PwpySVqkhNNa1nUuFL6QNV5Dr6SJMOEY4PgJi+WqzVAey9nGL2X7Nzxhf9
         Q8Zw==
X-Gm-Message-State: AOJu0Yy+ENDpFdEC2vMzy0ryKJv5zFArdRkwJJtdOiQiIM6PPLsDDvxD
	yR6TWFn1n+Iyd5zyRJzCpHW4pNII/sci/UUYC4fpEsj8LVnM8N0FwRXGAXqICA0orMsf+5rEyfG
	8Bhj2Vbu7zrxYH5z59J+wIs0FCg==
X-Received: by 2002:a05:6e02:3b85:b0:35f:b4ef:ff2d with SMTP id cv5-20020a056e023b8500b0035fb4efff2dmr4841503ilb.18.1703358591574;
        Sat, 23 Dec 2023 11:09:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrU401Ba0/LxUJ5BhpKaXFFxVWVwomwa2YtFMl7VSoyq6t6dstC7nTTq4QTfRL6H8lxpj17A==
X-Received: by 2002:a05:6e02:3b85:b0:35f:b4ef:ff2d with SMTP id cv5-20020a056e023b8500b0035fb4efff2dmr4841489ilb.18.1703358591335;
        Sat, 23 Dec 2023 11:09:51 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ju22-20020a170903429600b001d1cd7e4acesm5453225plb.68.2023.12.23.11.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 11:09:51 -0800 (PST)
Date: Sun, 24 Dec 2023 03:09:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/650: add kernel commit id
Message-ID: <20231223190948.4w4hqzmjz2qebu2t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231222024800.138907-1-xuyang2018.jy@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222024800.138907-1-xuyang2018.jy@fujitsu.com>

On Thu, Dec 21, 2023 at 09:48:00PM -0500, Yang Xu wrote:
> This week, this case crashed when I test xfstests on xfs. Then, I found
> this kernel patch to slove this problem, so add it.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/650 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/generic/650 b/tests/generic/650
> index 773f93c7..e152c398 100755
> --- a/tests/generic/650
> +++ b/tests/generic/650
> @@ -10,6 +10,9 @@
>  . ./common/preamble
>  _begin_fstest auto rw stress soak
>  
> +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit ecd49f7a36fb \
> +        "xfs: fix per-cpu CIL structure aggregation racing with dying cpus"
> +
>  # Override the default cleanup function.
>  _cleanup()
>  {
> -- 
> 2.27.0
> 
> 

