Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A21DE4D2
	for <fstests@vger.kernel.org>; Mon,  2 Dec 2024 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167725; cv=none; b=t45cpISjM12wbvyTG47zggPrF3ZK97z6Z/NZlC22yurBob07viBprjKvJ8/mcfZhaJX1a/oinQwlJLu95ThvSMGU1wsgqrwLXS5in8YvGOGEIF55MJ9zJ4mF6JUyXKPKa5W/hV5QtxWHieQlXB4RRkgHwrV2VSRdzVsjor+qeBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167725; c=relaxed/simple;
	bh=kX3D4U38/HtHDHk2BdjPjjD6KHokXbt34k8BMT3u37g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elzj7UkiYRWeaNCTiKKVs07buw1mU3DItbi7NSDupuXDUDfGynrUZEmh+YlOxsuG78P6oQwHgXCgt3ED5QDuyQOIxBMp9ndICHPXKsYynhwxSL7IZf8kanL0kiXQh4mcn0PAtMwMw3HvxrTscwfmUv8mNmlB4czNGTkhaTSb+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kvff+y1e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kvff+y1e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733167722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bWFseO7m4ELWbMwwQF3QN9/V027VxEt3vnqTyrKXYoM=;
	b=Kvff+y1ez+gUNqEqemEU2LyatWyaSKswKjbfBqFBnKSCfhi12sLvxtYK2PkTvF+afRoCLd
	4UVlje5FTh30na0f0PpvHm2tCNODnIW2F6wKHEBFZN42kTHrB/EkBj9x0gwuWUgz1bGxdl
	GOEq9R2y3wtGyyJ+4noJR3brb1m5QjE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-vKJ-Ut9uOBORX9jAjqG9hw-1; Mon, 02 Dec 2024 14:28:41 -0500
X-MC-Unique: vKJ-Ut9uOBORX9jAjqG9hw-1
X-Mimecast-MFC-AGG-ID: vKJ-Ut9uOBORX9jAjqG9hw
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2159a817442so12990895ad.1
        for <fstests@vger.kernel.org>; Mon, 02 Dec 2024 11:28:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733167720; x=1733772520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWFseO7m4ELWbMwwQF3QN9/V027VxEt3vnqTyrKXYoM=;
        b=CKMD1WxUYPPrEN3KsvWvRi8rZ4ksUAapfv1S57qBhSPydnoGqtd55e/E4beUsiMaeD
         tS8ELUAPAFlreqo29bmy9xqGXyMAXsDu6HhwdYYmFFAUedrg3yNCJOPdHH4shRRzpjH2
         CXgleCvMDqoCIZsaosrZgd56An1reimaBvVU6UYEtuDTwOlWad0yFNK2mZqADiRfvjUJ
         Zhx4sxNzSCwJ0uceDMZtX/1WaIZtEbHGlmqq6PUk75KD84FHfjWcjXLjj+wBSOttTPuO
         KBeLcGAu8LGBZP/Q5f54Lf1uBfPoCeDHEJ7WlM7uszsOVe0mK0g3ezKN3B/wgnYprIeX
         ZD6g==
X-Forwarded-Encrypted: i=1; AJvYcCX2UGiYO4Eiz2biNTJ9GCmjCV1Ix9VrHwi/O9bvym9je9ajMcjvoP/scBMR2wduZMaSHmUo8+dK@vger.kernel.org
X-Gm-Message-State: AOJu0YxL64lSoas+SYxuM1RpvtXsPoCMda/l7JIif0Jj3ictUuAceKCc
	PhzAbDoMj/N+SGvZrUmtngV2zUVC0qRGk1TcDVZ0P3FI6eQALz4Xh1eoUGIK0w5v9jEAdtUeBrE
	N3aqSzNJvmuinf6i2bkGvZVWNeJyk2ohmcvcN4wQPcF4NSjjsqGGd0Iyy6KDKmmW0xg==
X-Gm-Gg: ASbGncsCAbakvAD1a0rrh4JJ6O3KJL3xlOXz7Q2c93q5O89h2xfho5hUHdDPyMeqPEw
	hX+Oa2oucLOKhTANZuRrxK+Ud24f/bQmnI2WXC4awDQJ/Sz0EwfRpuR3LMF9OJpT2M02+53C1gM
	JxHxccMaaaqfhNPQtFBkipQRmv+u+viqgBaxifhTJABrGNJrK2KqXSOhvYsoDMsJujpM9sSfNI8
	deijK3yUTfP1CGUlhRq1Y58MW1NyrZe5mMI6Dp8bY3MiqskubT8VBRzBM2VZwns4Tv+BIJGUEtK
	axaE1GcW5E4XK7g=
X-Received: by 2002:a17:902:f60f:b0:215:30d1:36f7 with SMTP id d9443c01a7336-21530d13a51mr267121075ad.44.1733167719871;
        Mon, 02 Dec 2024 11:28:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFK2PWyR5izKn7DroMfkC2QjzimoUXMUUI84ZLwYBgzYg3xki1hiD7a+h4DUk2el7rGPxsNhw==
X-Received: by 2002:a17:902:f60f:b0:215:30d1:36f7 with SMTP id d9443c01a7336-21530d13a51mr267120775ad.44.1733167719566;
        Mon, 02 Dec 2024 11:28:39 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21586d580a9sm28257345ad.277.2024.12.02.11.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 11:28:39 -0800 (PST)
Date: Tue, 3 Dec 2024 03:28:35 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/3] f2fs/005: update commit id in
 _fixed_by_kernel_commit line
Message-ID: <20241202192835.seditdylbigpxte5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241202114149.2666-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202114149.2666-1-chao@kernel.org>

On Mon, Dec 02, 2024 at 07:41:47PM +0800, Chao Yu wrote:
> The bug related to this regression testcase has been fixed by commit
> d5c367ef8287 ("f2fs: fix f2fs_bug_on when uninstalling filesystem call
> f2fs_evict_inode."), let's update commit id in _fixed_by_kernel_commit
> line.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/005 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/f2fs/005 b/tests/f2fs/005
> index a817d51a..33d4fdb9 100755
> --- a/tests/f2fs/005
> +++ b/tests/f2fs/005
> @@ -11,7 +11,7 @@
>  . ./common/preamble
>  _begin_fstest auto quick
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit d5c367ef8287 \
>  	"f2fs: fix f2fs_bug_on when uninstalling filesystem call f2fs_evict_inode."

I think we don't need to use 3 patches. As you just add missed commit id number,
just merge them into one and named "f2fs: add commit id to _fixed_by_kernel_commit".
Or if you hope I can do that when I merge it, feel free to tell me :)

Others look good to me, with above change:

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  _require_scratch
> -- 
> 2.40.1
> 

