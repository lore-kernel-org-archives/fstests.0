Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72467DDC1
	for <fstests@vger.kernel.org>; Tue, 21 Jan 2025 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737426949; cv=none; b=pD1M+YfxFJi+t6z2gkJmcqeLEaYSws4FVXsglVOoGtjeFfLMU3+9CK/W22hqdsqlwVcMRYW9CX0e3/Y7PLMIZROYS8BWfdWtBPwlrAGLNBd7j5jlvpZgByEpaybVuua8AfvsPPFxsYvyb+QDpzTnIV/caD/UcXQmK1qrcJwTmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737426949; c=relaxed/simple;
	bh=pwsVM9EDpphoOOULtPX8CCUe4CA5OiSEGlS3F8V0Yzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krR/Sjj5fwa+OOvUSw6cgrwlwy7sSxvGQnskO1l+O4++ivfNZ13noSi9ubSiy2QSHdY6ClWmKWvsP6T7cotXwnVZhCEZnYQZtNfs1GJGSG2X7LQLzMt46ZCkWj1wSSUccdrd9yA/Z/2f0R0X8XdZyGHVx+c7mkppMtAbjTBnhUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3aNY09P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3aNY09P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737426945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iVHIPMirTmmbBZ8UwQ+Tw8lCHN38M140E0B+daOa/5M=;
	b=B3aNY09P9Kdfi4Km80XfcwfKCI9Z3TOeAaHxiTrFMpd79JDo86m92EnY0Yeh0hXLgv+ivG
	5hEcjxA035FsUwFx5VsqDGJGWT3psW05fEilmFCPo0HDR3IxNcpURE2XXnKaAQIEmtsmVf
	zjioopHwzHeOinOSiZN0P9mKxNERceM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-Qdn5Th0zO3C5NR-8GV-l5g-1; Mon, 20 Jan 2025 21:35:43 -0500
X-MC-Unique: Qdn5Th0zO3C5NR-8GV-l5g-1
X-Mimecast-MFC-AGG-ID: Qdn5Th0zO3C5NR-8GV-l5g
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2178115051dso94502075ad.1
        for <fstests@vger.kernel.org>; Mon, 20 Jan 2025 18:35:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737426941; x=1738031741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVHIPMirTmmbBZ8UwQ+Tw8lCHN38M140E0B+daOa/5M=;
        b=MQBGpZmsFua8qWgGNNp90Kaq0Om3eCxD4nlwquzN8+G+fjs7OlvGtZZO1tO67tSMPC
         l/TxMqaz93blBwhFvFvC3A7t+qUZbkLlx43igGw+5T4aeTF4LmQDYE7RWfuMTi5JzqYT
         elaqaoaOZ1f36zKZtcVEyuML0yy3ArlUjYiaMG6WIhG0Mbg2MXeXX1R+bPaSgQZpTZ+z
         ykq2tEkJ4qItMiyYLTwo/Wcr5NjcFkiky4esNkdcGO7e0lKmscWtL0zSU6aDdh5qchTM
         Py4RPJZV4ga0x4IkN8P6+5q0gvApOecw9fRuC5pQOjmHDBpXCKObQSLvkeOelO0fTW34
         hGJg==
X-Gm-Message-State: AOJu0YxdfZ5QCccBnvzW45ZbJ6APfqQZY9JTOy6I9D4v0K4ypxQ43uTy
	JEvxj4htciwoK59bOT4AkVEmNdUoydFPVgOCi9DJ8REH7R8mIy+ahgflsXgd3Q3rpQNOfv4XPQh
	ocUp3JzfTtzhtXwhZwzy4ZozVhPUHIK5z5JQjtrK7aa1p97krmUJiDTArJVaGkIMOmg==
X-Gm-Gg: ASbGncvU0EqHehco29A+UEOyGzAvM8cx/+62DHqEjMfzyl2O/iYkbkNgo8kGFKVDLxn
	TGFfuNVB4i0LGsQcX8FM7lQ/PWzlzMM6WsgWQNk918knuYORnWWrNTuzvkGGorGCZDFArYR2THo
	fRZfFaxTEgbI7wjHJYhegGWqKrIcKIG+e+x88SD32uzF/fVyIqzbkzBpGe3LD7bC0WL0Sy0xqk5
	bJ/fVc+rioVBFgJobZnW06T29/VdNY5sQJtKiXNFtAEKr0mYZQ5rNH1fr2LxYdch0nMj84PWOn/
	z5LIWoZcH4miO4X6dg45xLKxg3R8N568GZw=
X-Received: by 2002:a17:902:f78e:b0:215:a05d:fb05 with SMTP id d9443c01a7336-21c355dcf9emr247083695ad.32.1737426940949;
        Mon, 20 Jan 2025 18:35:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH31YMyUP8lCa4myec7eJa9EBPL6xI8ZnWgCGSkgUmyF5wYtw3tpIS4iHC0dNU5Be5xjXDmgA==
X-Received: by 2002:a17:902:f78e:b0:215:a05d:fb05 with SMTP id d9443c01a7336-21c355dcf9emr247083435ad.32.1737426940641;
        Mon, 20 Jan 2025 18:35:40 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d42d320sm66576525ad.257.2025.01.20.18.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 18:35:40 -0800 (PST)
Date: Tue, 21 Jan 2025 10:35:36 +0800
From: Zorro Lang <zlang@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH -v2] xfs/32: fix test failure on kernels which don't
 support bs > ps
Message-ID: <20250121023536.dz45c3ustuk3fddu@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250117210202.GJ3557695@frogsfrogsfrogs>
 <20250120170109.3770633-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120170109.3770633-1-tytso@mit.edu>

On Mon, Jan 20, 2025 at 12:01:09PM -0500, Theodore Ts'o wrote:
> When trying to mount a file system with a block size > page size on
> kernel which doesn't support this, suppress the error messages from
> showing up in the output file lest it cause test failures.
> 
> Fixes: 0b66f6efd669 ("xfs/032: try running on blocksize > pagesize filesystems")
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> v2:
>     As Darrick suggested redirect the output of mount(8) to $seqres.full
>     instead of /dev/null

Thanks for fixing it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  tests/xfs/032 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/032 b/tests/xfs/032
> index 41a9134d8..675881d5b 100755
> --- a/tests/xfs/032
> +++ b/tests/xfs/032
> @@ -44,7 +44,7 @@ for ((; SECTORSIZE <= 65536; SECTORSIZE *= 2)); do
>  		if [ $? -ne 0 ]; then
>  			continue
>  		fi
> -		if ! _try_scratch_mount; then
> +		if ! _try_scratch_mount >> $seqres.full 2>&1 ; then
>  			if [ $BLOCKSIZE -le $PAGESIZE ]; then
>  				_fail "mount $(_scratch_mount_options $*) failed"
>  			fi
> -- 
> 2.45.2
> 
> 

