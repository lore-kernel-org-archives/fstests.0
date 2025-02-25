Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE426139E
	for <fstests@vger.kernel.org>; Tue, 25 Feb 2025 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477380; cv=none; b=qdUvaJsupJ+hqFv7adDpKy0U2nh1s+2PpVwptwbUn5aOdglHUV1jzOPquqAFD8SEOF85Wsta3IYS+W1NK7BhfGTCdBOWP7dH9D/l2L7mVM/Y/SOJngTae4Kftogrw3vDjWxfqSk0mbExW14NIyFvAamGb28DP+BcmNjC6niafS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477380; c=relaxed/simple;
	bh=F7Ms5IyNWogo0LGDUGPs0GOh5EUEmq+ZYaa6ELV2U/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ectAtLc/+xLRW++d4/Q/skze68BULXibDnMwt5T0IEfE4XQE6zX8qY/34djE6J9kS2vOBkgWh4fkNaqW8o9OT3uI9PfJoE7L/yLbwEotbjvAdvQvHGzOj9vQIZc5AgE6LQbxkbHRwWVOFP2a7lggFHMbvNzunfm0fpDi61QybYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCzIhT65; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCzIhT65"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740477377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OVGqo+himr0vNqUEgygAS/1M4MrwSMcnb2QDQPm3nko=;
	b=gCzIhT65qLtFPgjyDq3X4Pz7WF0L/VCyww+VGwNUDTm4CM30JLlogC4YwzP9PtacoEv5Qh
	z8PwRQ6ACzC19IVTnswhBglOQMDW0zANgnBvY4r4mc2cvwSenhyfVal29+tPYKmog5Wgr6
	7ZpZOPaQxsulCtpqXBWi0y/FMAHVdB8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-X7P8iDuDNs6UEDpCokCOOQ-1; Tue, 25 Feb 2025 04:56:15 -0500
X-MC-Unique: X7P8iDuDNs6UEDpCokCOOQ-1
X-Mimecast-MFC-AGG-ID: X7P8iDuDNs6UEDpCokCOOQ_1740477374
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-220c1f88eb4so87874095ad.2
        for <fstests@vger.kernel.org>; Tue, 25 Feb 2025 01:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477374; x=1741082174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OVGqo+himr0vNqUEgygAS/1M4MrwSMcnb2QDQPm3nko=;
        b=MBwK1uLDUsVuyTx2II5O2o62nbg1nTDwPhb9H3o3n+esbh3Uge2LhV0nai6637RYCv
         +q+NaebjDu9tuH+2jnKMhI5J7re+QyuSdrOOUc2jEu4ZiJjezL86OJhYYMyRtU39h+Yy
         JuOK4ayYkXFphAZXYRqxTa3vDxv4G0tFr9Bkl8VFR2JYxSRBKPZl8m9H/sxhD1STha7Y
         b17DrXeIKSGoNTQLJ2KKP60m9i4yQWvYcAoKNu8jvUVmTTB/hbfntczcGrihnNlEJM/A
         7vKWQ9N/PtOq+PwAPFLOMLOUhgNghT3CCSl0Qagajdd8rAICMX9J0dxc+0IBSqiN3CNv
         sfpw==
X-Gm-Message-State: AOJu0YwAWl9Zxg60QANP82Cds6pOwRis/fmplNGoZnHRI1esX0LSgBmX
	1dvjXfxqFo5lov0eW+Ux+lYeypFDmkO3ndDIVJq1aIhPmMRJNa7vFLZ1TDEHbIowvU1ahRfjGFe
	teYJA++KL8e8bFyMaAp6jieOe7gZKwjvquFLhxNRA7COr5QECrpGDNDm2DL0dI3ZN8g==
X-Gm-Gg: ASbGncuRJB6HaKoo+mrKWIfZd1WTOOCpjeXYYQeWChZeboE/c5hH6T9AScISgtxTH3p
	chX66ZwlnjnFBJUuObcowyc86YgP9k5w3CFuyo5oBE2RHsfKYEccLBBGkurtFJmc4wtdfqIiMOy
	JoXlsNk/ndPP6f4kcilx1nk9kjx++gnafZOCS9gVaJcc5IRyfHurcQERUB3nL7gDouoNDpenefX
	ziCJfr88+8DAKxpsQ+Esbfqz/VYVjDZNoctX7BB83yRZVGAh6BRe/sg8FWVpXGuyrNC3rhPsqoO
	x66RACPjl/y0FKVCrGmjVsMrUUjtqb38w77V2bkO/JrxG0l3we/hRf58
X-Received: by 2002:a05:6a00:2441:b0:732:2170:b69a with SMTP id d2e1a72fcca58-73426d6fcb3mr25975337b3a.18.1740477374122;
        Tue, 25 Feb 2025 01:56:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgBhJn9ob4Mi17reKJgUYjpYX5Nplvab5C55kV4Ea6VfKfQJ9uUcemCsRNnoY4FLi9xgs0bw==
X-Received: by 2002:a05:6a00:2441:b0:732:2170:b69a with SMTP id d2e1a72fcca58-73426d6fcb3mr25975325b3a.18.1740477373800;
        Tue, 25 Feb 2025 01:56:13 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f8a7fsm1134152b3a.59.2025.02.25.01.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:56:13 -0800 (PST)
Date: Tue, 25 Feb 2025 17:56:09 +0800
From: Zorro Lang <zlang@redhat.com>
To: Daniel Vacek <neelx@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] fstests: btrfs/314: fix the failure when SELinux is
 enabled
Message-ID: <20250225095609.mjr2jq7l44md6p6j@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250220145723.1526907-1-neelx@suse.com>
 <20250224111014.2276072-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224111014.2276072-1-neelx@suse.com>

On Mon, Feb 24, 2025 at 12:10:14PM +0100, Daniel Vacek wrote:
> When SELinux is enabled this test fails unable to receive a file with
> security label attribute:
> 
>     --- tests/btrfs/314.out
>     +++ results//btrfs/314.out.bad
>     @@ -17,5 +17,6 @@
>      At subvol TEST_DIR/314/tempfsid_mnt/snap1
>      Receive SCRATCH_MNT
>      At subvol snap1
>     +ERROR: lsetxattr foo security.selinux=unconfined_u:object_r:unlabeled_t:s0 failed: Operation not supported
>      Send:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
>     -Recv:	42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
>     +Recv:	d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
>     ...
> 
> Setting the security label file attribute fails due to the default mount
> option implied by fstests:
> 
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sdb /mnt/scratch
> 
> See commit 3839d299 ("xfstests: mount xfs with a context when selinux is on")
> 
> fstests by default mount test and scratch devices with forced SELinux
> context to get rid of the additional file attributes when SELinux is
> enabled. When a test mounts additional devices from the pool, it may need
> to honor this option to keep on par. Otherwise failures may be expected.
> 
> Moreover this test is perfectly fine labeling the files so let's just
> disable the forced context for this one.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
>  tests/btrfs/314 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> index 76dccc41..29111ece 100755
> --- a/tests/btrfs/314
> +++ b/tests/btrfs/314
> @@ -38,7 +38,7 @@ send_receive_tempfsid()
>  	# Use first 2 devices from the SCRATCH_DEV_POOL
>  	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>  	_scratch_mount
> -	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> +	_mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}

This's good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
>  	_btrfs subvolume snapshot -r ${src} ${src}/snap1
> -- 
> 2.48.1
> 

