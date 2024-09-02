Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE791A4E99
	for <fstests@vger.kernel.org>; Mon,  2 Sep 2024 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725307542; cv=none; b=pdU4LSsM24Jl/UKwTtw1M1GecRP8/bxjA4dFdcRtRulB1eUNiNMoTNagIkXA4HfnMgMWCHxEOb5H6d+ioqnqh52LmdMgHyR6iJ4ApDccYoAGfyoHaDZpnc2vPtM7n9XQQSt7tTJ9BMoxSftYhg7A/QdDGHSddj8rDctccLIv9ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725307542; c=relaxed/simple;
	bh=65EoHY6M8fT+cDAZnuURKKXPwRIRRERpYyz5F2xrp3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWjR7J5iCbyGOfC37kd7vtFxAM6ajyhmSvTpAOmQ10QX9ifB8iQ17KNlWKOTxcYJPA+0ngzkEk/tmKc4AKsslRR1lF19tBgYFqPmFWdbC548e49j6jafzNHLfI7RMqH+vH0N2NeSVo0rkbz/KrJ8oJDowg2ESepvUWJx4SrsNGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMX3hQ85; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMX3hQ85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725307538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zdnZZn8OmtVGHQANRCcG3h4gbTYm46JDAbnL9tQ6Las=;
	b=fMX3hQ85uH7HB5lSZmOUP69eKLismrI7d3yXOzjkd3fYVZaTNY5/9nrV4f+5qmfV/goxiD
	URaKC2FdEi/5Jwgwhfhd7QDbsk8w1GF95sBmbf9+uZY8Lo7ieJNJZdJpE0Pw3YNY1XVqmj
	6GBSNSefk+2o7mmWCp9v2mILs0djmc4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-r2SZWMYmObycrv40_yjOkQ-1; Mon, 02 Sep 2024 16:05:37 -0400
X-MC-Unique: r2SZWMYmObycrv40_yjOkQ-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7cd854e1869so3507248a12.2
        for <fstests@vger.kernel.org>; Mon, 02 Sep 2024 13:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725307536; x=1725912336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdnZZn8OmtVGHQANRCcG3h4gbTYm46JDAbnL9tQ6Las=;
        b=drXawPNKByAoTSvALTXBg52Z2zKQMMJueRPBnkiiTkxmBvVsNYH5Di3gGknGWADJYt
         E8DafjOPmefMGPWY+pPuXgX9Wd72ome25VDSJhZ5L7trF91J4ad7rZIUhuvfG55Q5GEW
         Xe9wnAVYZ9Ziy8X0rfTS7gISjDP7PGMQhum3A5Cmp0zlBhs5iwvElLW8cefzOeJC43kv
         35M9mGBYjBRPh5YVNjXo4enTRgaXqnRTVPOTmuLJ4aWtrYm5KZjpHSk8oEsNss5ywYJF
         84sJ+sTo20ScHxyR+KoeTSGQfEJ9oz1JxwNu/z51MCLfiItz1ZowaTLJVPyXBCjRXDDk
         FG1w==
X-Gm-Message-State: AOJu0YzU7pvp9wLqiURafO28Itea9+fnVounjGXZacQ6dVfrRn1AXkWn
	00tSQv+LJ0zFOCWT8psmTVWGvBBg9A8lbKxRUIstg93Y6wi8MMMOKYVZ5hzdxOPh4y06A25PjNh
	OCSFvpOnG+QrpFd8Ruw/2BMIWGNBv6WbRM/LUqsWwi59BjNMp3powEXs=
X-Received: by 2002:a17:902:da8b:b0:1fc:6b8b:4918 with SMTP id d9443c01a7336-2054c249eabmr89623495ad.41.1725307536722;
        Mon, 02 Sep 2024 13:05:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE1hwuCAytS5BkE/btE6UQBX3WApVBDL8QAA3lb/hVqCTsBdHjaKLFxbNMFNQWDrw6xuaEGQ==
X-Received: by 2002:a17:902:da8b:b0:1fc:6b8b:4918 with SMTP id d9443c01a7336-2054c249eabmr89623105ad.41.1725307536106;
        Mon, 02 Sep 2024 13:05:36 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20563c5707csm26212485ad.139.2024.09.02.13.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 13:05:35 -0700 (PDT)
Date: Tue, 3 Sep 2024 04:05:31 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH] f2fs/003: add missing _fixed_by_kernel_commit line
Message-ID: <20240902200531.p2ulurifnyy7g4y7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240902101844.4042983-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902101844.4042983-1-chao@kernel.org>

On Mon, Sep 02, 2024 at 06:18:44PM +0800, Chao Yu wrote:
> The bug related to this regression testcase has been fixed by commit
> b40a2b003709 ("f2fs: use meta inode for GC of atomic file"), let's
> add missing _fixed_by_kernel_commit line for this testcase.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

Thanks for the update.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/f2fs/003 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/f2fs/003 b/tests/f2fs/003
> index 62821ed7..fbb08a3e 100755
> --- a/tests/f2fs/003
> +++ b/tests/f2fs/003
> @@ -25,6 +25,9 @@ _cleanup()
>  	rm -r -f $tmp.*
>  }
>  
> +_fixed_by_kernel_commit b40a2b003709 \
> +	"f2fs: use meta inode for GC of atomic file"
> +
>  _require_scratch
>  _require_xfs_io_command "fpunch"
>  
> -- 
> 2.40.1
> 

