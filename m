Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF342063F9
	for <fstests@vger.kernel.org>; Sat, 22 Feb 2025 08:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740213484; cv=none; b=FlVHB0BnPZSTJKfDWelSxmSC/8GWScDdwDAjzNeOeOm8s6Kh9wxFNA4QxbHv2Rcgx9VAUHcredPfutExTN9ebf7cDyUgCtkVkJ6HaD4h8yiArlVRmjld4Q88R2hIpjRkE3ZSk+QKlhGRaL8kSMdRoMkB0ymMXwOKR39TmpktpOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740213484; c=relaxed/simple;
	bh=gKIikp1nkeutP68ypumD/wQtsQN6cnIA2YiRX2ZrJqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbLwYM/SS9ErghvAlh/jQUDyUvfcIbLA3nHOxMpyFTmUBdAv3kYPq7Y8T1kBe008CMoJAT5yyKEloQG5nKRAPwQ8DIujrsu9IqKQQ4Snyy/J46hPkJ0O8Rz1iw9/TCdgPYSylxymROuDR0ige+c+RE+52J/KRF2kGfo9i9oPlZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUTHk7YR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUTHk7YR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740213481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ywvo3iVMwT805pw8Dw72ePN9++qcn0USaUPpo0W9c9I=;
	b=GUTHk7YRrxJK1rv5Pr/ggDJcg+QTQHNPJ7MQsBChVm5NlOsQyuKuun1F+QZ4vdeO806x5s
	uikOEys6Md+ati9JXpdrccMxMq7TpQKkkqH/iUDcnofRrCxyCIohTC1HYPd8IUqdt7LWWy
	qOK4Or7a3NzDtnEHOmBV+r+aIwdZyvU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-d46qoZzmPSmhr12QpQguqw-1; Sat, 22 Feb 2025 03:37:58 -0500
X-MC-Unique: d46qoZzmPSmhr12QpQguqw-1
X-Mimecast-MFC-AGG-ID: d46qoZzmPSmhr12QpQguqw_1740213478
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc0bc05b36so9466695a91.3
        for <fstests@vger.kernel.org>; Sat, 22 Feb 2025 00:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740213478; x=1740818278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywvo3iVMwT805pw8Dw72ePN9++qcn0USaUPpo0W9c9I=;
        b=WFWwUTJf2R+Xdn7gdHhgzcWkfmgff3dgwp94RA3lbNVO/yXKKj7nr1rb3HWk2pUmeH
         p/+XxHA1+JGJ/kbSXhFJGxxhD90drdsduaFdhsWfBByWtrRUfHnLN7nw7ph1FtaikD6i
         liHycIavDeB8bwED1lqyAPZPJLoCYpu5Q2pyx3oOn9oCs8dW6sBfxn+q1sbmhUv5LOM2
         YluyFlRZmoCfxNKfKDZPob8KqyXyfA5wJEck5uMnx9avzLqVn6etCdp0NotzpRf4m8oW
         0rxaJgnY3A7HSVRYD3Bfsn42rgXqegwMEKSTFeg6wdlGP1dC7p4Sb3G5DIN4SZvGgPBm
         KgBw==
X-Gm-Message-State: AOJu0YxQJQ5A4Fya8oj9rSejva1ZKlhtDXgomyOBmnpjoWI3upyylm0/
	OPdkCe4OopjTcl3nLjK8P9gzMZZdGQx3TVQs8fmlZNF3RPh6Z+11wVWLJGOiFbifLcNl9NdsuEU
	o9o8/kK25qWZm3+vww07fq1XTNtk+S8NBsSIgJEYzWacoguXEfry+tb59Jbi0tSjRMQ==
X-Gm-Gg: ASbGncs/9IyMOaljZ2OanRUkXGtf9EhKAawrwtujBF4rP/QtH/gjpo6k75FoavcsXAX
	P9ke/QZkBX9Qm3+eQxZsFagbHtZrZ61RVf4AXbvjo7awDRC3OM3ZDeYZMdVMc1ItErmRzg+oN5M
	BYJsiI3rtpUZU0DK7stpOv2yx6OjGaWQmI4DMFm8jJroN31uKxBfN9s9g3ClqFKqyqdYSLMu1hc
	6FqcDqEA5INSv/cX+ly9UaWZwsXBt4q3TTCu2C3Y8m4L1izrCtnUAmaBY7LQCFUni+RxGQNomLU
	UHNNGrJlmPFhrOBixRwsY32trWJyQh6qXIZNCkoIZrzji10+DQvkzCtA
X-Received: by 2002:a05:6a00:13a4:b0:730:8768:76d1 with SMTP id d2e1a72fcca58-73426d815ccmr10663209b3a.19.1740213477692;
        Sat, 22 Feb 2025 00:37:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIHnCmIVk5lXxDmvm0NE0c2IZpd4cv0ovJ3p6kbDJr3zaOF9kjL7wlqzpzzQLJkJwekp9+ZA==
X-Received: by 2002:a05:6a00:13a4:b0:730:8768:76d1 with SMTP id d2e1a72fcca58-73426d815ccmr10663193b3a.19.1740213477400;
        Sat, 22 Feb 2025 00:37:57 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73269fa358dsm13396189b3a.91.2025.02.22.00.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 00:37:57 -0800 (PST)
Date: Sat, 22 Feb 2025 16:37:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Daniel Vacek <neelx@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/314: fix the failure when SELinux is
 enabled
Message-ID: <20250222083753.wvdw2quokicxdqoz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250220145723.1526907-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220145723.1526907-1-neelx@suse.com>

On Thu, Feb 20, 2025 at 03:57:23PM +0100, Daniel Vacek wrote:
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

Take it easy, Thanks for both of you would like to help fstests to get
better :)

Firstly, SELINUX_MOUNT_OPTIONS isn't a parameter to enable or disable
SELinux test. We just use it to avoid tons of ondisk selinux lables to
mess up the testing. So mount with a specified SELINUX_MOUNT_OPTIONS
to avoid new ondisk selinux labels always be created in each file's
extended attributes field.

Secondly, I don't want to attend the argument :) Just for this patch review,
I prefer just doing:

          _scratch_mount
  -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
  +       _mount $SELINUX_MOUNT_OPTIONS ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}

or if you concern MOUNT_OPTIONS and SELINUX_MOUNT_OPTIONS both, maybe:

          _scratch_mount
  -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
  +       _mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}

That's enough to help "_scratch_mount" and later "_mount" use same
SELINUX_MOUNT_OPTIONS, and fix the test failure you hit.

About resetting "SELINUX_MOUNT_OPTIONS", I think btrfs/314 isn't a test case
cares about SELinux labels on-disk or not. So how about don't touch it.

If you'd like to talk about if xfstests cases should test with a specified
SELINUX_MOUNT_OPTIONS mount option or not, you can send another patch to talk
about 3839d299 ("xfstests: mount xfs with a context when selinux is on").

Now let's fix this failure at first :)

Thanks,
Zorro

>  tests/btrfs/314 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/314 b/tests/btrfs/314
> index 76dccc41..cc1a2264 100755
> --- a/tests/btrfs/314
> +++ b/tests/btrfs/314
> @@ -21,6 +21,10 @@ _cleanup()
>  
>  . ./common/filter.btrfs
>  
> +# Disable the forced SELinux context. We are fine testing the
> +# security labels with this test when SELinux is enabled.
> +SELINUX_MOUNT_OPTIONS=
> +
>  _require_scratch_dev_pool 2
>  _require_btrfs_fs_feature temp_fsid
>  
> @@ -38,7 +42,7 @@ send_receive_tempfsid()
>  	# Use first 2 devices from the SCRATCH_DEV_POOL
>  	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
>  	_scratch_mount
> -	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> +	_mount ${SELINUX_MOUNT_OPTIONS} ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
>  
>  	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
>  	_btrfs subvolume snapshot -r ${src} ${src}/snap1
> -- 
> 2.48.1
> 
> 

