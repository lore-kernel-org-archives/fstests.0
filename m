Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECD32111
	for <fstests@vger.kernel.org>; Sun, 23 Feb 2025 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740294480; cv=none; b=gRPooOZ8YionbY3gq4JV9YRSuJIdrNMd1ZWmrSWMrCh6zZJv126jC7TD5wYCpQrg7oJB5v6D0EkLyxhprefZzE2s6A/2vFZRDN0pEV2MCtqBHN3I35RwzS6JQdLINgkrh7gPmuwhosC1Aiaov28wRHWIjIlkIXNfpczd5A1sdC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740294480; c=relaxed/simple;
	bh=2VRPymG1U1AkeC2EOlESAMwaS1rYMcnthSiWH7Yx9Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnWVUTC++omThwPlDS4MwUGlMFuzoyhYX0wfssCpqiV7BxyRQswFpVPSTcI23MTCXZCuYmkVYSJ95+1hEhWAco4U12TgqBa515TkCOkXltCNTgARodTY/ADSY9L+zjxlwJxpIBNfPpO5+GvHubN178CvqbmESbbcKAqYVaJX4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7xANRXc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7xANRXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740294477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkWjc5e4+Oq+FwwYWxLPxh4bK4kAlysso9UshsQ7yRQ=;
	b=Y7xANRXcLacJiLr0Gp+tWcUXJ5o76PtoDoEQQTh6UyhG8EIZTTCqXO9I7z9U1BVaf0XZzJ
	6qo1+UY59Na/1/7PeizmtpO6Ga87VMmsKTy0fBgG45jADaF5kiXlyi2KHPDrWF2u4Y7Wbf
	uKTVeD70ptEVWadJg2maj7WTyM6QAc4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-5_OQZtvVNE29MPbtk4Sstw-1; Sun, 23 Feb 2025 02:07:55 -0500
X-MC-Unique: 5_OQZtvVNE29MPbtk4Sstw-1
X-Mimecast-MFC-AGG-ID: 5_OQZtvVNE29MPbtk4Sstw_1740294474
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22112e86501so66931175ad.0
        for <fstests@vger.kernel.org>; Sat, 22 Feb 2025 23:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740294474; x=1740899274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkWjc5e4+Oq+FwwYWxLPxh4bK4kAlysso9UshsQ7yRQ=;
        b=SjBqWmt7cgXQDw/0TFGb26yMxHjQmg89tqVtOyaxQvrCo2Dl/vCFGSqsocVkd6zdkJ
         cHHENK4HK6YWKWCoahs+n1MU/P4nYir7KYvdckD4UPKbINq2Uxrq0nCuo5ZCM8GP/Asv
         8zKtjh+gqJtQF1LTGh+91idT1YG2GThMGTAoEGRJUatEIq5191BXzmPBnqZweItVlGlV
         MgEIHEV2X8Wh1+ZTvI/OJnO+WOm/e+OLZt98sdRKEbu5rbnAPtjgrc4723RYrZvvVekG
         6OtKGJfvq78QxdxQpG1xiUsdRpo12FbJJKNxWWFn/IMttgQfiiN7U+aG2/N7lS3mlQmO
         u9ig==
X-Forwarded-Encrypted: i=1; AJvYcCXhV9XgzsMKhucPnrfvn2oDyxl+zluwyuZ2kS4ayAe2NCp8Iq1SZqzGBW2y7Y61IUPb93ZlW7Dq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd8UicMkltEzXhbxnRPPKZtI412riqPZOWKtR3GN1YzPLbDSyq
	mXUDkbLp8F+81rOhQDfUb2NkWnKzpSXvk8dtqtgcrucGdxcpA614h50xDo/l+9/I66iPAR8G/jL
	W1trJag/9T3G6kPPSn+AqSeZAhXygKzYSM+ftEHMGn9++RWPyg+RgVLe7YhzpQPvbzw==
X-Gm-Gg: ASbGncv24xfulrG2+oi850JcdguZGANxhGFhtMZ7kEParUEaE/NQISJhjWNRU+LDSV/
	s79V2iKCk4h4tinokBrRmQ/MJTnGjfH8QxN0SVWSIJu2wCQ1SllWdPks9eINwjis03+ptOkD5Od
	9s2cBOJwHNNmCDll/+jXtB8ROe3jhsYQjrq+e64TTLFDxryjgEgY0IxGYn9th9nda97lAr1L/4Z
	AQ3nJSqbHgBlwbRZshjNKEP1NY7Go+Ank2NNI0bbXXZaYonyCWpCG6KA7vpCAPZVGQG0Lh6PNNG
	YUo8h/MF86iR7nTJL1eSEVJ0yYqHyNl2x2XF7BjdervYJK9LIzUgYmV7
X-Received: by 2002:a05:6a00:807:b0:730:8e2c:e557 with SMTP id d2e1a72fcca58-73426ce7da9mr14938801b3a.11.1740294474035;
        Sat, 22 Feb 2025 23:07:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsXe5d81toRnfFwXrAbMbc+KTNccS5HQIYciF5hAFuZUj8NbDbhiSDvqq4YjfmwcxBnutHgw==
X-Received: by 2002:a05:6a00:807:b0:730:8e2c:e557 with SMTP id d2e1a72fcca58-73426ce7da9mr14938779b3a.11.1740294473683;
        Sat, 22 Feb 2025 23:07:53 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265098570sm14711730b3a.22.2025.02.22.23.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 23:07:53 -0800 (PST)
Date: Sun, 23 Feb 2025 15:07:49 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Daniel Vacek <neelx@suse.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/314: fix the failure when SELinux is
 enabled
Message-ID: <20250223070749.dmym2egqad4drwkc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250220145723.1526907-1-neelx@suse.com>
 <20250222083753.wvdw2quokicxdqoz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ddc27f3b-291f-43db-abfb-0f82d8c584fb@gmx.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ddc27f3b-291f-43db-abfb-0f82d8c584fb@gmx.com>

On Sun, Feb 23, 2025 at 07:56:02AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/2/22 19:07, Zorro Lang 写道:
> > On Thu, Feb 20, 2025 at 03:57:23PM +0100, Daniel Vacek wrote:
> > > When SELinux is enabled this test fails unable to receive a file with
> > > security label attribute:
> > > 
> > >      --- tests/btrfs/314.out
> > >      +++ results//btrfs/314.out.bad
> > >      @@ -17,5 +17,6 @@
> > >       At subvol TEST_DIR/314/tempfsid_mnt/snap1
> > >       Receive SCRATCH_MNT
> > >       At subvol snap1
> > >      +ERROR: lsetxattr foo security.selinux=unconfined_u:object_r:unlabeled_t:s0 failed: Operation not supported
> > >       Send:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
> > >      -Recv:	42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
> > >      +Recv:	d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
> > >      ...
> > > 
> > > Setting the security label file attribute fails due to the default mount
> > > option implied by fstests:
> > > 
> > > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sdb /mnt/scratch
> > > 
> > > See commit 3839d299 ("xfstests: mount xfs with a context when selinux is on")
> > > 
> > > fstests by default mount test and scratch devices with forced SELinux
> > > context to get rid of the additional file attributes when SELinux is
> > > enabled. When a test mounts additional devices from the pool, it may need
> > > to honor this option to keep on par. Otherwise failures may be expected.
> > > 
> > > Moreover this test is perfectly fine labeling the files so let's just
> > > disable the forced context for this one.
> > > 
> > > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > > ---
> > 
> > Take it easy, Thanks for both of you would like to help fstests to get
> > better :)
> > 
> > Firstly, SELINUX_MOUNT_OPTIONS isn't a parameter to enable or disable
> > SELinux test. We just use it to avoid tons of ondisk selinux lables to
> > mess up the testing. So mount with a specified SELINUX_MOUNT_OPTIONS
> > to avoid new ondisk selinux labels always be created in each file's
> > extended attributes field.
> > 
> > Secondly, I don't want to attend the argument :) Just for this patch review,
> > I prefer just doing:
> > 
> >            _scratch_mount
> >    -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> >    +       _mount $SELINUX_MOUNT_OPTIONS ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> > 
> > or if you concern MOUNT_OPTIONS and SELINUX_MOUNT_OPTIONS both, maybe:
> > 
> >            _scratch_mount
> >    -       _mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> >    +       _mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> > 
> > That's enough to help "_scratch_mount" and later "_mount" use same
> > SELINUX_MOUNT_OPTIONS, and fix the test failure you hit.
> > 
> > About resetting "SELINUX_MOUNT_OPTIONS", I think btrfs/314 isn't a test case
> > cares about SELinux labels on-disk or not. So how about don't touch it.
> 
> Thanks for the sane final call.
> 
> Exactly what I want in the first place.

Your suggestion is good to me, but I think you confused Daniel a bit with "overriding
the SELINUX context just means disabling SELINUX" :) Anyway, I believe both of you
know how to fix this issue and how SELinux works, maybe you're just not talking in the
same channel, so take it easy, let's over it and move on :-D

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> > 
> > If you'd like to talk about if xfstests cases should test with a specified
> > SELINUX_MOUNT_OPTIONS mount option or not, you can send another patch to talk
> > about 3839d299 ("xfstests: mount xfs with a context when selinux is on").
> > 
> > Now let's fix this failure at first :)
> > 
> > Thanks,
> > Zorro
> > 
> > >   tests/btrfs/314 | 6 +++++-
> > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/btrfs/314 b/tests/btrfs/314
> > > index 76dccc41..cc1a2264 100755
> > > --- a/tests/btrfs/314
> > > +++ b/tests/btrfs/314
> > > @@ -21,6 +21,10 @@ _cleanup()
> > > 
> > >   . ./common/filter.btrfs
> > > 
> > > +# Disable the forced SELinux context. We are fine testing the
> > > +# security labels with this test when SELinux is enabled.
> > > +SELINUX_MOUNT_OPTIONS=
> > > +
> > >   _require_scratch_dev_pool 2
> > >   _require_btrfs_fs_feature temp_fsid
> > > 
> > > @@ -38,7 +42,7 @@ send_receive_tempfsid()
> > >   	# Use first 2 devices from the SCRATCH_DEV_POOL
> > >   	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> > >   	_scratch_mount
> > > -	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> > > +	_mount ${SELINUX_MOUNT_OPTIONS} ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> > > 
> > >   	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' ${src}/foo | _filter_xfs_io
> > >   	_btrfs subvolume snapshot -r ${src} ${src}/snap1
> > > --
> > > 2.48.1
> > > 
> > > 
> > 
> > 
> 

