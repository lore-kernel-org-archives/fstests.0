Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E801F4701
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749143458; cv=none; b=noxa0Cwt42sGIigaFUC5D2giWuldFctTwlDMrTPL0S9du7Gm7y99l8PUt9Gwoc3tMqlKMC3jNy6e7fe0xge4pE0NAZ7s18X/eDGNf1gkmCK/Ryd7KjOLhku1ainmWmhNnEB+LiC4uKGM10NG9ttCtWnpstU+7OUqwXmI6ZswThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749143458; c=relaxed/simple;
	bh=9hwaIyiwubXp1KD6FvqOFtrw25kXv5+SNhuX4PHyhnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odiH1H+OJpOFVN6mzu6cXyVZ1F1KQTIyczDuPrsKMBtJBrAfQNzRuiVYPoEsmr3pWcnzsJ/SDGTZmgF/AI1DKDLhog5w7Mfb3VnmOylKvomy/+Saania2MyUUHvhHBVsbnO7uRF5ojXsYk+l7bPt/VlqzV50Qpu+0UE59betHWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WeDXB8jX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WeDXB8jX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749143454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEdrsXnDxNlF+G9Y39zkaNGpxQnvHyZVOYLvk3avuds=;
	b=WeDXB8jXd/dIbjYyjvRpBLIIfEEC+721b83RFwbWIwxjRHc1EHA/0lZaALjOB7vrxbEes6
	W6wvNYAFLTug5zmXaEM4fW1cSqBdS7UqhcHrAN85DwQGq12nqugYLQejyoUqP1LXgDwL7L
	PrN2i8tm06uoG1/fTKaE/d4enqsvMlU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-a5sIgPeBNQmeoMzgMsUF0g-1; Thu, 05 Jun 2025 13:10:53 -0400
X-MC-Unique: a5sIgPeBNQmeoMzgMsUF0g-1
X-Mimecast-MFC-AGG-ID: a5sIgPeBNQmeoMzgMsUF0g_1749143452
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7398d70abbfso1997773b3a.2
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 10:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749143452; x=1749748252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEdrsXnDxNlF+G9Y39zkaNGpxQnvHyZVOYLvk3avuds=;
        b=BjmomWFwn/CPLS7bSEUWFQ7KG3coUIkK6L++xXyyqQ+Zr3aegfVdyfL9X1uOQ4tmMb
         4N80oORkTPrgWONdiwzZbDP2SbuiYfQAjRC4J1JH0/+NO2ED4b+TWa+wjNm9LFg6+jyf
         JnpgPBKcDzHL7L5eV8ti5PKTRda+QlP8aZ4LOFmXNqxzacJSoaB5va6lY581FZR4/3hR
         YsO26Yyw8OmsTs9jUIPPSB+2N+tmY9JJV4JckaFd5l2w7glkWCShodMslRuvq8wUWVkU
         UKjSCzsKfW1atdUOgUkjIDfTHUJw1T9UEn9uGj0+T8INpGGySJP43AnzVVy3LeSZSzE/
         Tn1g==
X-Forwarded-Encrypted: i=1; AJvYcCXwLahZuU1gewF64/vrpYaPMVr7LFSxn9Hc7lpmU7js/KsL5wE8Gh62el0+zlxsLOumjw+3lT1F@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs3a9lVE0fsoTLAIGz/JyejvxRaTN9pMW3NzL0kikZcm9EaZx6
	N6BSuIIELj67yNZU18QPmorkaPLVGwztk5HaEjJRda3yNJXisD6t/OhoDPu0P2OKNXtzVGtjDb8
	NFhibUpn1HCAGHF/wxQW72j3LurlawGv5wlXo7JOfDyYbqZNRDckIRHQ7xEM=
X-Gm-Gg: ASbGncswG9xbAU06DwKJu0uDNpT9Dc3yZaOsOuEsW/6kp3LBEQm7aiDhYOA9MbaJoSC
	167z/y6UMpZkbRbSzvQgD92JPYt4GCYzcJIKcm9fwGJBs/qwEJU6k0o22GzVPbj2hHSII3SLzKZ
	IrV8lv0hVa2tPlLuci9ue9DvZs6IuIeoqJl3AmNRw0j3m/ffA2hpU+8zFDR6jp2Qgr6F+a0n+1x
	VzgvS7SVH62j5ixTaxStDTdXVahqmXgu3O+hc2Jt5ou/4cZo+VzAaE+coHhUxk6PgBFFXkUzr4q
	gpCroULkLrKscuEStgWZHnca/1bBOaGIuj85rYSGxO/x2/YacNva
X-Received: by 2002:a05:6a00:14d1:b0:740:a52f:9652 with SMTP id d2e1a72fcca58-74827e7e8f7mr691803b3a.6.1749143451938;
        Thu, 05 Jun 2025 10:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6ccaqhIYWyEadJ5C5U4dlILO+cQvFurvtNQvya77WdPeaJ0IbnOTOwAeFUC8TyVspIclYlA==
X-Received: by 2002:a05:6a00:14d1:b0:740:a52f:9652 with SMTP id d2e1a72fcca58-74827e7e8f7mr691778b3a.6.1749143451542;
        Thu, 05 Jun 2025 10:10:51 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff7388sm13461455b3a.171.2025.06.05.10.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:10:51 -0700 (PDT)
Date: Fri, 6 Jun 2025 01:10:47 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/741: make cleanup to handle test
 failure properly
Message-ID: <20250605171047.vl3u6j7yojbw6pfe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250604235524.26356-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604235524.26356-1-wqu@suse.com>

On Thu, Jun 05, 2025 at 09:25:24AM +0930, Qu Wenruo wrote:
> [BUG]
> When I was tinkering the bdev open holder parameter, it caused a bug
> that it no longer rejects mounting the underlying device of a
> device-mapper.
> 
> And the test case properly detects the regression:
> 
> generic/741 1s ... umount: /mnt/test: target is busy.
> _check_btrfs_filesystem: filesystem on /dev/mapper/test-test is inconsistent
> (see /home/adam/xfstests/results//generic/741.full for details)
> Trying to repair broken TEST_DEV file system
> _check_btrfs_filesystem: filesystem on /dev/mapper/test-scratch1 is inconsistent
> (see /home/adam/xfstests/results//generic/741.full for details)
> - output mismatch (see /home/adam/xfstests/results//generic/741.out.bad)
>     --- tests/generic/741.out	2024-04-06 08:10:44.773333344 +1030
>     +++ /home/adam/xfstests/results//generic/741.out.bad	2025-06-05 09:18:03.675049206 +0930
>     @@ -1,3 +1,2 @@
>      QA output created by 741
>     -mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
>     -mount: TEST_DIR/extra_mnt: SCRATCH_DEV already mounted or mount point busy
>     +rm: cannot remove '/mnt/test/extra_mnt': Device or resource busy
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/generic/741.out /home/adam/xfstests/results//generic/741.out.bad'  to see the entire diff)
> 
> The problem is, all later test will fail, because the $SCRATCH_DEV is
> still mounted at $extra_mnt:
> 
>  TEST_DEV=/dev/mapper/test-test is mounted but not on TEST_DIR=/mnt/test - aborting
>  Already mounted result:
>  /dev/mapper/test-test /mnt/test /dev/mapper/test-test /mnt/test
> 
> [CAUSE]
> The test case itself is doing two expected-to-fail mounts, but the
> cleanup function is only doing unmount once, if the mount succeeded
> unexpectedly, the $SCRATCH_DEV will be mounted at $extra_mnt forever.
> 
> [ENHANCEMENT]
> To avoid screwing up later test cases, do the $extra_mnt cleanup twice
> to handle the unexpected mount success.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/generic/741 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/generic/741 b/tests/generic/741
> index cac7045e..c15dc434 100755
> --- a/tests/generic/741
> +++ b/tests/generic/741
> @@ -13,6 +13,10 @@ _begin_fstest auto quick volume tempfsid
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	# If by somehow the fs mounted the underlying device (twice), we have
> +	# to  make sure $extra_mnt is not mounted, or TEST_DEV can not be
> +	# unmounted for fsck.
> +	_unmount $extra_mnt &> /dev/null

Hmm... I'm not sure a "double" (even treble) umount is good solution for
temporary "Device or resource busy" after umount. Many other cases might
hit this problem sometimes.
Maybe we can have a helper to do a certain umount which make sure the fs
is truely umounted before returning :)

Thanks,
Zorro

>  	_unmount $extra_mnt &> /dev/null
>  	rm -rf $extra_mnt
>  	_unmount_flakey
> -- 
> 2.49.0
> 
> 

