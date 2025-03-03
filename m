Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20C81F0E44
	for <fstests@vger.kernel.org>; Mon,  3 Mar 2025 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996657; cv=none; b=TQkFvqzaTYoiHBCe7/1e4v9/KMgolJjxdl6IlaqpD6TCodAiD3Vk5+X7kH61Rmfia8Ea9lWudLky9e8HxEOsC5pRfyk+xDugPEpgAC5Djh/JbR9gu355I65qh9kjTy7KY1t9mBfJCyZuHEyZXNDS3Lr6eG3FMkqrsuhYlEtf1Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996657; c=relaxed/simple;
	bh=B6pWxJmT7/ohptYq2vq9bRokT8bcVyt5hNDZzm5udLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFDsdrLKceuVdDvpLaMCV88U+Pvyc7Vf5l8Ka3ACBkjbl1xjIwJteWOWT1VZdluN3Di91X8XzwNIIXMkLPZT944GKgL85MlvqrKOxao7m3DcRiKBBQ2KyjcTLMhOxVwndca/F5ediEIL+Hs0PBUn7WVQf10clk8q1GjojXp8DmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZwbxCM9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZwbxCM9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740996654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FGT+xNmG8FBIo7SyGASI8CI5uNZvycSJXAx3uPZvDZ8=;
	b=eZwbxCM9umtwqLCszln1bOjwUlVmcf7hExODvzZEZuYP4JMoYpi8aSNNEeI47DugCs849e
	EWrfw20a30HyCdp3oor5/ixq2RqmSS4rmWxTgHZHct0+RVsUQsGd9EIvxNUqaoThYcuVW7
	03K4iy33UXFJyFLgfgmaGzPaEQ94ZLQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-mQSs-rukN1mFLUee0fnWmg-1; Mon, 03 Mar 2025 05:10:52 -0500
X-MC-Unique: mQSs-rukN1mFLUee0fnWmg-1
X-Mimecast-MFC-AGG-ID: mQSs-rukN1mFLUee0fnWmg_1740996651
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22380b74cfcso32324995ad.2
        for <fstests@vger.kernel.org>; Mon, 03 Mar 2025 02:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996651; x=1741601451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGT+xNmG8FBIo7SyGASI8CI5uNZvycSJXAx3uPZvDZ8=;
        b=VtOlBBsgP6ooJRTQZbdsp2vjOK8HFYwcLABVGtUNUdnl+mmqj+h0L43LPm6YkONoFQ
         aTXA/+cqgVR1e662uy9RpTa5LMgYkRYe9wrikzrMTuNJ2gGKPFBMEHm8DPEAaute3EvH
         QIAQr569sQTQZ17U3+Lzu+QubQLq4SviZI2WCCuoHtnTiKQpSBzLJk5wyVHtrnrpNJtG
         Jw8loSoii1L7v4FsCfwJ1sVHC4rCnJqos/skgxYpqyniw+qOzmVlIbQt07UZKc1yDUi8
         YGD0Fi/ErkQ/O7qOjKSuXTUQmwU86mJOUGuE0OkxXTxLtEHY4YSFmXUzrmPWg8xHhUow
         ChnQ==
X-Gm-Message-State: AOJu0YwbXByhFbrhzAGYQyuiYGNDliJzDno8FWDFh+GaKzyMDEh/YTkq
	TRgJVQLH7Z6huvAYIs0PdYZ3tVcZupT723Dh7SDFVTamk1n5rPFi8ngdOHfjD+QkuykHi0UDpgm
	zsv5nMbe/12e197TzB2g2ILYkmuw2GYnZEiBTYxMEAl+7jB55aJ77x8U=
X-Gm-Gg: ASbGncuLMys8E9O3RhOrIB5+0BCAbcNASKZRT/Zelk/G6d65D0/xDbuJomBCtdOsz66
	s6t8hILKFpGQfcVPuE4xSi+OoNU6FIys1mXNJXx1F3WPIfbmwufzULPajVdQ7GZPwxFufHrs6tE
	878NobjPYf/lan0y9upwiHBjNg9I2Gz/rONaNgLaEK6cgvB8gqPf/MjmUfZT9g5aC310/n/7nZb
	O4Gusc9arG/olsGCA1/qXqWa4D45Zxdtpnpiniq1lAXKklTfPqqhzHCwrYUuYDBW4zkDbr5WURC
	mnoM2uq0Ep14SOwm7vTscHcfaobLsv0afWkkL9fRr8KFC0+Gas87SGW/
X-Received: by 2002:a17:902:d510:b0:220:f140:f7be with SMTP id d9443c01a7336-2236924e3f6mr189878705ad.41.1740996651468;
        Mon, 03 Mar 2025 02:10:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJVDKJd77DQj5B0Mr6LZp6rmTi++vQ2P+x2twy8VmRHinhPmbL+p1ly0SjtdI0kIj3oNczwg==
X-Received: by 2002:a17:902:d510:b0:220:f140:f7be with SMTP id d9443c01a7336-2236924e3f6mr189878245ad.41.1740996650894;
        Mon, 03 Mar 2025 02:10:50 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7365b66255asm1168087b3a.165.2025.03.03.02.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:10:50 -0800 (PST)
Date: Mon, 3 Mar 2025 18:10:47 +0800
From: Zorro Lang <zlang@redhat.com>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH] tools/run_privatens: check if it is mount point for
 --make-private
Message-ID: <20250303101047.qjugaez6c7ythpd6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250303064209.602577-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303064209.602577-1-naohiro.aota@wdc.com>

On Mon, Mar 03, 2025 at 03:42:09PM +0900, Naohiro Aota wrote:
> While /tmp is mounted with tmpfs in the most setup, it still can be a non-mount
> point. For example, I'm running the fstests in a container, which does not
> mount /tmp inside the container.
> 
> Running any test case on such system results in having the following error
> printed, which leads to all the test cases fail due to the output difference.
> 
>   mount: /tmp: not mount point or bad option.
>          dmesg(1) may have more information after failed mount system call.
> 
> These lines are printed by the "mount --make-private" command. So, fix that by
> using mountpoint command to check if the directory is a mount point or not.
> 
> Fixes: 247ab01fa227 ("check: run tests in a private pid/mount namespace")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  tools/run_privatens | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/run_privatens b/tools/run_privatens
> index df94974ab30c..c52e0128b8f9 100755
> --- a/tools/run_privatens
> +++ b/tools/run_privatens
> @@ -8,7 +8,7 @@
>  
>  if [ -n "${FSTESTS_ISOL}" ]; then
>  	for path in /proc /tmp; do
> -		mount --make-private "$path"
> +		mountpoint "$path" >/dev/null && mount --make-private "$path"

Oh, if /tmp isn't a mountpoint on your system, don't you need to think about ...

>  	done
>  	mount -t proc proc /proc
>  	mount -t tmpfs tmpfs /tmp
        ^^^^^^^^^^^^^^^^^^^^^^^^^

... this step? I think the first run_privatens process will remain a "mounted"
/tmp on your system.

And then later tests will use this tmpfs. That's nearly equal to "We always
make sure there's a tmpfs mount on /tmp at the beginning of fstests running".

But if we don't run that "mount tmpfs" step, I think it's not what this script
wants (to isolate the data in /tmp). Right?

Thanks,
Zorro



> -- 
> 2.48.1
> 
> 

