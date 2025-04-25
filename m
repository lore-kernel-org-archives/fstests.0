Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2B638FA6
	for <fstests@vger.kernel.org>; Fri, 25 Apr 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745583349; cv=none; b=HrVlv0tDhLfaMMESaJ1/Pp/dFmHw2ZyAhAVwn8PGF250lgolf7iOoHcTkaBmSX7iSP8FFiX9JbLVmIW6e8/5McHvov4lbUTAsVCFwmwaW1+Z7+tHeDHn9t0T401YWD71Cy9g6AvzlCP/obsHowAVS+TONN34J+Fk/wHD6J0+2l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745583349; c=relaxed/simple;
	bh=c0fubQ1snPJgd7Kvxe4e5N5UwKvBeiNmczOcJytu4vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAAXdlC7b1fYF84TWRS4fWCko0OlI96Vlf0xRwZQSnH8Vhohukr+v2g0EsUdBP///sMFM9zzdIvyEx1yF25VajSk5UUWxJIv9K+3CPzxk4hs8KHvDnx7PQ0YHTP01fXsYYrHpqA3RhF3tDL+ZbwmQc/sWjE1oJSPPVAczhCciBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXWKFtoe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXWKFtoe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745583346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BFdWNSjqC8Yl6W1s/o0EusBZu4C2kuSHFKd7PouRer8=;
	b=DXWKFtoekQDknkhRXLA6tGsOqvrzvvYzGO13iHlaQ5D1EIHyR6gkMUlS15oLe1pMo2coGn
	B1Aseb7Gzld8w2o1r7aeweu4B5BCzhj40PBqYDE5p1ekeP2s54UD8ViC6ryZm6JeWquK8b
	zMXGts/PZp7Mm05twR0vDBJRmNaPEFE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-P13lm2DFOWu-TJumboegEg-1; Fri, 25 Apr 2025 08:15:45 -0400
X-MC-Unique: P13lm2DFOWu-TJumboegEg-1
X-Mimecast-MFC-AGG-ID: P13lm2DFOWu-TJumboegEg_1745583344
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-736b2a25d9fso1572776b3a.0
        for <fstests@vger.kernel.org>; Fri, 25 Apr 2025 05:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745583344; x=1746188144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFdWNSjqC8Yl6W1s/o0EusBZu4C2kuSHFKd7PouRer8=;
        b=ZC7aUlIBqRYVqXAs9ErkcImKJtsV0XCLOGdTvPu6FoQBYXHtY+qHSGQeeh7XrdYkaS
         8SPKhb66VAs5wMwKx/aSSXT0v0laaxHWsuu9bz404Pk+QofF/ALA4Ij0GonqXotz3vv2
         coxM0drLm2ZvrIAw5ldXrlmVMeYlUFB1uZ/au8b4X2I2sYq4yayBcZF2bxckTri6m/Ue
         rUAtRj28BcfoTF2+NtvqLYvXi3aJg0rdUa4ETOSjdIgXzjeDgvHFpI145rCWHL945IgV
         Nk8gPilXIVgBJqstwh03GLrOEb3PwXHrLsbfCKNUhF00vY9UVFs5LaQUnlaiS+iwEYZ1
         QnyA==
X-Forwarded-Encrypted: i=1; AJvYcCUnRbO/ZCHCEJvfQERHawJOPLkhq81V+/Dcnt9vp9XydMuTR0/zFbTqeahoTblnZ0P1p/LZlhGa@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhUZfikDgAX/iPZ/aN7mTNerClF/jfHRHgYpM4Z8ifpYXUaZQ
	BTaVNSUWSV87k9izlkdiGOQLzMr/C1+AXOd+4PcWmR6k8u3z54mjtqE4aSfeNoVGE+jZ6hCnN+M
	yIWDrdqIibYp6Z3VEZnPe+Rq5aUVL3xk7t2ykkVv+k+1fJTrD1d+rUiA=
X-Gm-Gg: ASbGncuW1SX1prMOASTJ8JpvJTBR8zGI/zYG7Hrjjntj3zerQyV7CVqLxOD7WDN0TkK
	OLWjHqAYqZYjrCWYD0rX2sDZTYx65yUPgy+DSdfHLawbNsbr/IoWUdBAKI21v3etc7eW/wtyXxS
	KIqI4Mq78Xgd5pV01gjJI4vvOXfWfQBsoL6ELdFTdZ9rzU5BiKvgwS5njpB3oYOhwt+eHIDGcrB
	g/R9M09pAuvU3HiRVg2HSVE86A0kmSKahPnOxLuZeQsOxV+hqsREhdn4ldg1R28hEhrl23QluMb
	uc88bwbKeE/At5jAFXPxgmDKWp1gh73eBmHECsKP//ZQVwaLqfRh
X-Received: by 2002:a05:6a00:3e2a:b0:736:34a2:8a23 with SMTP id d2e1a72fcca58-73fd896a139mr2462277b3a.15.1745583344035;
        Fri, 25 Apr 2025 05:15:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFESxf06ibdHZcdom6dtC73XV7yUBCleJ9MftcqXrXQ6K6cixRMcJBjkb631qjvYgxjecLX1w==
X-Received: by 2002:a05:6a00:3e2a:b0:736:34a2:8a23 with SMTP id d2e1a72fcca58-73fd896a139mr2462251b3a.15.1745583343665;
        Fri, 25 Apr 2025 05:15:43 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9feb9sm2965593b3a.154.2025.04.25.05.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 05:15:43 -0700 (PDT)
Date: Fri, 25 Apr 2025 20:15:39 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: btrfs/315: fix golden output mismatch caused
 by newer util-linux
Message-ID: <20250425121539.ptx2v4svljmdprpl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250424072907.256692-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424072907.256692-1-wqu@suse.com>

On Thu, Apr 24, 2025 at 04:59:07PM +0930, Qu Wenruo wrote:
> [BUG]
> With util-linux v2.41.0 and newer, test case btrfs/315 will fail like
> the following:
> 
> btrfs/315 1s ... - output mismatch (see /home/adam/xfstests-dev/results//btrfs/315.out.bad)
>     --- tests/btrfs/315.out	2025-04-24 15:31:28.684112371 +0930
>     +++ /home/adam/xfstests-dev/results//btrfs/315.out.bad	2025-04-24 15:31:31.854883557 +0930
>     @@ -1,7 +1,7 @@
>      QA output created by 315
>      ---- seed_device_must_fail ----
>      mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
>     -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
>     +mount: TEST_DIR/315/tempfsid_mnt: () failed: File exists.
>      ---- device_add_must_fail ----
>      wrote 9000/9000 bytes at offset 0
> 
> [CAUSE]
> 
> With util-linux v2.41.0, the mount failure error message changed to the following:
> 
>   mount: /mnt/test/315/tempfsid_mnt: fsconfig() failed: File exists.
> 
> Thus the existing filter only striped the "fsconfig" part, leaving the
> "()" without changing it to " system call".
> 
> [FIX]
> The test case is doomed in day one by using a local filter, which
> requires stupid catch-up game against util-linux.
> 
> Meanwhile we already have a much better filter, _filter_error_mount().
> That helper can already handle the newer v2.41 output.
> 
> Let's use the superior common filter and update the golden output to:
> 
>   mount: File exists.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Remove the cursed local filter and use the generic one instead

I think this's good to me, although I've forgotten why this case didn't
use the common helper at beginning. If anyone find something wrong,
please feel free to tell me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> ---
>  tests/btrfs/315     | 22 ++--------------------
>  tests/btrfs/315.out |  2 +-
>  2 files changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/tests/btrfs/315 b/tests/btrfs/315
> index e6589abe..9071e152 100755
> --- a/tests/btrfs/315
> +++ b/tests/btrfs/315
> @@ -19,6 +19,7 @@ _cleanup()
>  }
>  
>  . ./common/filter.btrfs
> +. ./common/filter
>  
>  _require_scratch_dev_pool 3
>  _require_btrfs_fs_feature temp_fsid
> @@ -28,25 +29,6 @@ _scratch_dev_pool_get 3
>  # mount point for the tempfsid device
>  tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
>  
> -_filter_mount_error()
> -{
> -	# There are two different errors that occur at the output when
> -	# mounting fails; as shown below, pick out the common part. And,
> -	# remove the dmesg line.
> -
> -	# mount: <mnt-point>: mount(2) system call failed: File exists.
> -
> -	# mount: <mnt-point>: fsconfig system call failed: File exists.
> -	# dmesg(1) may have more information after failed mount system call.
> -
> -	# For util-linux v2.4 and later:
> -	# mount: <mountpoint>: mount system call failed: File exists.
> -
> -	grep -v dmesg | _filter_test_dir | \
> -		sed -e "s/mount(2)\|fsconfig//g" \
> -		    -e "s/mount\( system call failed:\)/\1/"
> -}
> -
>  seed_device_must_fail()
>  {
>  	echo ---- $FUNCNAME ----
> @@ -57,7 +39,7 @@ seed_device_must_fail()
>  	$BTRFS_TUNE_PROG -S 1 ${SCRATCH_DEV_NAME[1]}
>  
>  	_scratch_mount 2>&1 | _filter_scratch
> -	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_mount_error
> +	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt} 2>&1 | _filter_error_mount
>  }
>  
>  device_add_must_fail()
> diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
> index 3ea7a35a..ae77d4fd 100644
> --- a/tests/btrfs/315.out
> +++ b/tests/btrfs/315.out
> @@ -1,7 +1,7 @@
>  QA output created by 315
>  ---- seed_device_must_fail ----
>  mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
> -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
> +mount: File exists
>  ---- device_add_must_fail ----
>  wrote 9000/9000 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -- 
> 2.49.0
> 
> 

