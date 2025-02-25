Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A037024EF96
	for <fstests@vger.kernel.org>; Tue, 25 Feb 2025 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475509; cv=none; b=hov/ANoSyaW7YgYijBfuksa6mHqb4H4x/FG3+5oK/1J0jCsApmhJnPAzedHan7JHcHTaAKG+6nIhsX+rZg5oF/fv4LSwTedBEqVwF3UC8u7ZcyyoLZAXJRU0ojYttV0Afnq6VNuZdee8ow5ydJpTV4HdEcnimtnByf5ICnX7MPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475509; c=relaxed/simple;
	bh=erj9N9Vit1eVAGakU5HYsZ3c2ok6hACcCdpNmAG1RuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ab1RSkzzCc1BQzPS+Tv798pwHPMUIWEc9O/S5HVjboKUkEx1wMb4NZoPSHIj0HASbPKMth/1J7O3R7NPWhDV3V3APf5BgHIu9wsOlBm2yz25ZZjHoBcHqUO3wSMU2yvPQfqlXDohcuun95Szsq5+sVceb1Qe6ph9HMJUeWt3gBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqO/IvxO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqO/IvxO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740475506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mankb6imwSp1UxMwbuGVJaLzZcCAIHqDBny0Cs+EpmU=;
	b=XqO/IvxOiIssYi+NhzZ2KOwdIfyNuBzeNXYmKjcCvCG5CoOXp+YBOFmCW9vMz1p5xW09dm
	dW5yAYPaqGb41sT76F5QdOGDjPuN6Z/oohkooYCyIo6ozVBu+lRsf937cNcZyxUZp6mfVL
	8CdZd23WQzYhOAxtMk87UJ5RRxfln3w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-FiMzDFNTOfuunL91X2UxbA-1; Tue, 25 Feb 2025 04:25:04 -0500
X-MC-Unique: FiMzDFNTOfuunL91X2UxbA-1
X-Mimecast-MFC-AGG-ID: FiMzDFNTOfuunL91X2UxbA_1740475504
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc2e648da3so10586722a91.3
        for <fstests@vger.kernel.org>; Tue, 25 Feb 2025 01:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740475503; x=1741080303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mankb6imwSp1UxMwbuGVJaLzZcCAIHqDBny0Cs+EpmU=;
        b=ck91kmtZQb4m65Afdff6IHasfNCjbhkXL5CKX2HUEJlfDAKBWxMvJunpCxJAvbNueL
         QIAURW1GnAr+XeAZYaQyq8KCAbOxn/Y9ezig+Z+f06W55o9h+FyjhjAHujW/bVVUBmpl
         sPCK6DelRZgbMqduVNgj1xyfUUGpHDurFyxD4LT7FzvQf9jpxO09Y9zYSmrLeB3U3DUI
         4Vx1UsE2KvgbnViBLTkymALKLpy9PHA6fAuOI0RqJo/grPai9bzx01vkxFmemV1apLCr
         9HPgTTu+JFt+GGGN+Mf2fyCD1fZjOmnAM0vZhLx6w0vCEkWHjZDPsXUUMCfgB+/JJngS
         7tBw==
X-Forwarded-Encrypted: i=1; AJvYcCVeNsG3asIt4eJ9mYdOYIEwsLvfxE8JYoj0Dx0tA3dz8nITxCD2qpRjy6MhIvouvpynaafgpNp3@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi3xohxTOBjFngKAq/m5uU+EDDdSPSVQRQKbxTk8YyAVz1xS0/
	LEpTrYEQdccQkoNU2lGnGpnq8QQRoWqdxdtGwsWTWLgprzwpla3bI7Pdbw4OC5HylXx8qqPG6AS
	yzB+AC+qV656MvPoQjrsaDxhoj6Wrs6dPmIn8JzFRYm2Rw/WwkWcWvPY=
X-Gm-Gg: ASbGncuylsGISupSGcoSkVEcfY+W/yhE09t5zgqLhtgN7xq0/cCdWuP91aBSccwNXA4
	lkv/Z4hvSbfm2Ca2BRE+bmXArW4U6ZSFnoo7ab2Kg0sjgSyAQVKq1keEngmyyLQ1pDnOG9VvCT0
	C7TJr/421mNcor/BU1xqGgJYB8JQn3uzQ+z0RwCest41NMRZOofkJd2kBNPVHnLTINBuqvGDewS
	3/ex6gg7UImlmLEwCs+V+FHJYWz1tSRw+N5NcdaK99ADi+AeKgWUQeOaq2gJhybiYdA8ynK/yTr
	efG1a/zCNMcHhT2fAVS+6lzJx3JlSxFWJhypJV5U7GSXJ4idSCd/jcDp
X-Received: by 2002:a05:6a21:700a:b0:1ee:7054:178b with SMTP id adf61e73a8af0-1eef3d90dcdmr28130650637.33.1740475503598;
        Tue, 25 Feb 2025 01:25:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFivElT9x3XxWObNvSoozQXJ8cmM0QVsoO3KYdNSyWXLZ76kROuJUG7XXuhU5Ywo0JE4oXD4A==
X-Received: by 2002:a05:6a21:700a:b0:1ee:7054:178b with SMTP id adf61e73a8af0-1eef3d90dcdmr28130622637.33.1740475503254;
        Tue, 25 Feb 2025 01:25:03 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6f9eb5sm1059933b3a.69.2025.02.25.01.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:25:02 -0800 (PST)
Date: Tue, 25 Feb 2025 17:24:58 +0800
From: Zorro Lang <zlang@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Daniel Vacek <neelx@suse.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v2] fstests: btrfs/314: fix the failure when SELinux is
 enabled
Message-ID: <20250225092458.n4lstidr3mifdrdp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250220145723.1526907-1-neelx@suse.com>
 <20250224111014.2276072-1-neelx@suse.com>
 <Z7zsIkC4SR103m0D@dread.disaster.area>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7zsIkC4SR103m0D@dread.disaster.area>

On Tue, Feb 25, 2025 at 09:01:06AM +1100, Dave Chinner wrote:
> On Mon, Feb 24, 2025 at 12:10:14PM +0100, Daniel Vacek wrote:
> > When SELinux is enabled this test fails unable to receive a file with
> > security label attribute:
> > 
> >     --- tests/btrfs/314.out
> >     +++ results//btrfs/314.out.bad
> >     @@ -17,5 +17,6 @@
> >      At subvol TEST_DIR/314/tempfsid_mnt/snap1
> >      Receive SCRATCH_MNT
> >      At subvol snap1
> >     +ERROR: lsetxattr foo security.selinux=unconfined_u:object_r:unlabeled_t:s0 failed: Operation not supported
> >      Send:	42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/314/tempfsid_mnt/foo
> >     -Recv:	42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/snap1/foo
> >     +Recv:	d41d8cd98f00b204e9800998ecf8427e  SCRATCH_MNT/snap1/foo
> >     ...
> > 
> > Setting the security label file attribute fails due to the default mount
> > option implied by fstests:
> > 
> > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sdb /mnt/scratch
> > 
> > See commit 3839d299 ("xfstests: mount xfs with a context when selinux is on")
> > 
> > fstests by default mount test and scratch devices with forced SELinux
> > context to get rid of the additional file attributes when SELinux is
> > enabled. When a test mounts additional devices from the pool, it may need
> > to honor this option to keep on par. Otherwise failures may be expected.
> > 
> > Moreover this test is perfectly fine labeling the files so let's just
> > disable the forced context for this one.
> > 
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> >  tests/btrfs/314 | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tests/btrfs/314 b/tests/btrfs/314
> > index 76dccc41..29111ece 100755
> > --- a/tests/btrfs/314
> > +++ b/tests/btrfs/314
> > @@ -38,7 +38,7 @@ send_receive_tempfsid()
> >  	# Use first 2 devices from the SCRATCH_DEV_POOL
> >  	mkfs_clone ${SCRATCH_DEV} ${SCRATCH_DEV_NAME[1]}
> >  	_scratch_mount
> > -	_mount ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> > +	_mount $(_common_dev_mount_options) ${SCRATCH_DEV_NAME[1]} ${tempfsid_mnt}
> 
> I note that there are several similar instances of this in common/,
> either as '_mount $(_common_dev_mount_options)' or as '$MOUNT_PROG
> -t $FSTYP `_common_dev_mount_options $*`'
> 
> That kinda says to me there should be a _mount_dev() wrapper,
> similar to the _mkfs_dev() wrapper like this:
> 
> _mount_dev()
> {
> 	_mount $(_common_dev_mount_options) $*
> }
> 
> And all these open coded device mounts be converted to use the
> wrapper. That way we don't have this problem of omitting
> _common_dev_mount_options when future tests open code specific device
> mounts.

OK, so we have two requirements about mount/umount now:
1) Use _mount_dev to replace _mount or even $MOUNT_PROG. But overlayfs
   tests might be special, he has to deal with underlying devices which
   is not suitable for $(_common_dev_mount_options).
2) Use _umount to replace $UMOUNT_PROG:
   https://lore.kernel.org/fstests/20250221041819.GX21799@frogsfrogsfrogs/

Thanks,
Zorro

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

