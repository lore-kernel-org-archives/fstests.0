Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444013A889
	for <fstests@vger.kernel.org>; Fri, 10 May 2024 01:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715305055; cv=none; b=l5NjfLcnCEyADU3PgDukQ84BHoIK9xecJ/eFVI6bE7SDUv60BA6LV7wTN3eTC9DYP7cmfEqY3NQDS7o6THTCdBRFeoy/FiIrSW4d1OV9zxSatyNxdnh2g3zItpgbo++ZfAkgULaCRC2Nu6GKw4j4QjtGmmgRbUN3dAW+GanhCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715305055; c=relaxed/simple;
	bh=2x1QcpK3Xr4UQS/EQDFVE8Rg0s5EfpJIPBNznxJp0b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJYbQoUBv37y50Ta2seXO3z72Jo6lZQ2WiJrRWR65QCDIRCsJU0Ro/9HyZRj957YfDJ7t9RKkZYuX7kUkxa60j8zFD7y9GBvwudsu0pjQ/Zg/IFvBBuzahIaffdFQiIUeS7wQeOroyr9qwrBo2V1MOIkSV09k0QjBxgYS99b6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b4Nytnzf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4Nytnzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715305053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5mq5BCNTjbEWbMjSyCFN2M5+u34I5+NTcC/1Lb7n7C8=;
	b=b4NytnzfGJIwKJeqruJoOlLcMgYCMe7sQ6WT3EhlHuJjMbAedVygP6aj6GvyG+sOlQqgFX
	4e87LXWaW29SKhA6l5jZtpOEKkhGhMc48d6ZXf0ymMeRqGXDTY18hnoNLZWVW3DvugGW8p
	Vm8pTG15L7UNvUjRK7xA8ULImJI8JCc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-f7IFtsUzO0aea9TZnpnO2w-1; Thu, 09 May 2024 21:37:31 -0400
X-MC-Unique: f7IFtsUzO0aea9TZnpnO2w-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2b2a648f23dso1337742a91.3
        for <fstests@vger.kernel.org>; Thu, 09 May 2024 18:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715305050; x=1715909850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mq5BCNTjbEWbMjSyCFN2M5+u34I5+NTcC/1Lb7n7C8=;
        b=FodRmp5/1iT4C1hmdqj350DK2vDYfZ6HBuzSGgo8KTvBu47yEb2QIlvjo/uND1w/pN
         Xw6Gr97zNdH8xCWznklqB5nitNyfYnwBChBsF8FBNj/Qaf1yFbwEouT6pswOxyJFNRzd
         CizN4l9O7KbgFpJscXMRAQCo4ILJ+c7I1v0H9n/+YeRF5OCipDs50k9u46U3JhSoi8n6
         GVGL42TXijlH3N5ROWM2Bch+ybTroIdvFgoTg/t4CXnchJJhZHRNMmLYjuJjr+661z00
         0s+PV3AVFzrgWCLd9IomVr3hvmxOwmPe/0F7j4RiGcZkdlEDdHqph2VDyP0wEm+7RA79
         hfhA==
X-Forwarded-Encrypted: i=1; AJvYcCXp7Jyfw6PzVt6QUaSIV/7TAQpE04iWwzB6wcPJOS6wN3SEspJgrd10EGr2ETsb0d0YJOLUfyeZ5lGD21WYn+dnx1hF6b0l5g==
X-Gm-Message-State: AOJu0YyBJqCTI2HyYo9PZI95Yzecg8WUhOS5HNKP10uOVVjU8wpQnsGf
	Dbl/vU5VOmzkDSVtPV0XnAA68sEvBqqbNKmN38naFU/tJbd7dWRK2qhvmrEReXsTr9t8L0YnIA2
	CIB/4oe6uT3mGDyOV8YKuhHg7RYKfgjjA4Uo7efZ1PZ3UUgXe3orJBsE=
X-Received: by 2002:a17:90b:1058:b0:2b4:39cd:1fb8 with SMTP id 98e67ed59e1d1-2b6cc758bfdmr1344248a91.23.1715305050205;
        Thu, 09 May 2024 18:37:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGr0CbhDOnZ1kF0gHcPmzqXnfKjsfDH9t1zuh27/AtamvlVZkV3bNVBYj9G0/xiOLIPCm8gg==
X-Received: by 2002:a17:90b:1058:b0:2b4:39cd:1fb8 with SMTP id 98e67ed59e1d1-2b6cc758bfdmr1344226a91.23.1715305049580;
        Thu, 09 May 2024 18:37:29 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62886f143sm3971835a91.32.2024.05.09.18.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 18:37:29 -0700 (PDT)
Date: Fri, 10 May 2024 09:37:26 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: fix _require_debugfs and call it properly
Message-ID: <20240510013726.fp72gsarkggnnys6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240429060906.465135-1-zlang@kernel.org>
 <20240429160356.GC360908@frogsfrogsfrogs>
 <20240429185857.n32qxnmfzghd5nuf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429185857.n32qxnmfzghd5nuf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Tue, Apr 30, 2024 at 02:58:57AM +0800, Zorro Lang wrote:
> On Mon, Apr 29, 2024 at 09:03:56AM -0700, Darrick J. Wong wrote:
> > On Mon, Apr 29, 2024 at 02:09:06PM +0800, Zorro Lang wrote:
> > > The old _require_debugfs helper doesn't work now, fix it to check
> > > a system supports debugfs. And then call this helper in cases which
> > > need $DEBUGFS_MNT.
> > > 
> > > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > > ---
> > >  common/rc       | 10 ++++++++--
> > >  tests/btrfs/150 |  1 +
> > >  tests/ceph/001  |  2 +-
> > >  tests/xfs/499   |  1 +
> > >  4 files changed, 11 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 56f1afb6..6f0bdf60 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -2978,8 +2978,14 @@ _require_sparse_files()
> > >  
> > >  _require_debugfs()
> > >  {
> > > -    #boot_params always present in debugfs
> > > -    [ -d "$DEBUGFS_MNT/boot_params" ] || _notrun "Debugfs not mounted"
> > > +	local type
> > > +
> > > +	if [ -d "$DEBUGFS_MNT" ];then
> > > +		type=$(findmnt -rncv -T $DEBUGFS_MNT -S debugfs -o FSTYPE)
> > > +		[ "$type" = "debugfs" ] && return 0
> > > +	fi
> > > +
> > > +	_notrun "Cannot find debugfs on $DEBUGFS_MNT"
> > >  }
> > >  
> > >  #
> > > diff --git a/tests/btrfs/150 b/tests/btrfs/150
> > > index a02bdafc..fd386d92 100755
> > > --- a/tests/btrfs/150
> > > +++ b/tests/btrfs/150
> > > @@ -17,6 +17,7 @@ _begin_fstest auto quick dangerous read_repair compress
> > >  . ./common/fail_make_request
> > >  
> > >  _supported_fs btrfs
> > > +_require_debugfs
> > >  _require_scratch
> > >  _require_fail_make_request
> > >  _require_scratch_dev_pool 2
> > > diff --git a/tests/ceph/001 b/tests/ceph/001
> > > index 060c4c45..79a5f58a 100755
> > > --- a/tests/ceph/001
> > > +++ b/tests/ceph/001
> > > @@ -20,7 +20,7 @@ _begin_fstest auto quick copy_range
> > >  
> > >  # real QA test starts here
> > >  _supported_fs ceph
> > > -
> > > +_require_debugfs
> > >  _require_xfs_io_command "copy_range"
> > >  _exclude_test_mount_option "test_dummy_encryption"
> > >  _require_attrs
> > > diff --git a/tests/xfs/499 b/tests/xfs/499
> > > index 9672f95d..6421cc4b 100755
> > > --- a/tests/xfs/499
> > > +++ b/tests/xfs/499
> > > @@ -18,6 +18,7 @@ _register_cleanup "_cleanup" BUS
> > >  # real QA test starts here
> > >  _supported_fs xfs
> > >  _require_command "$CC_PROG" "cc"
> > > +_require_debugfs
> > 
> > This test doesn't mess around with debugfs per se; it actually wants
> > tracefs.  Perhaps this should be _require_ftrace instead?

Oh, I just found you've created a _require_ftrace helper in common/tracing:

  FTRACE_INSTANCES_DIR="/sys/kernel/debug/tracing/instances/"

  _require_ftrace() {
          test -d "$FTRACE_INSTANCES_DIR" || \
                  _notrun "kernel does not support ftrace"
  }

Newer kernel has /sys/kernel/tracing/, to avoid the dependence of debugfs.
But there's still /sys/kernel/debug/tracing/, so I'm wondering
if we should try to use /sys/kernel/debug/tracing at first?

For example:

_require_ftrace() {
	if [ -d /sys/kernel/tracing/instances/ ];then
		FTRACE_DIR="/sys/kernel/tracing"
		FTRACE_INSTANCES_DIR="/sys/kernel/tracing/instances"
	elif [ -d /sys/kernel/debug/tracing/instances/ ];then
		FTRACE_DIR="/sys/kernel/debug/tracing"
		FTRACE_INSTANCES_DIR="/sys/kernel/debug/tracing/instances"
	else
		_notrun "The ftrace is not supported, or tracefs is not mounted"
	fi
}

Thanks,
Zorro

> 
> Sure, but if it depends tracefs only, should we use /sys/kernel/debug/tracing or
> /sys/kernel/tracing ? If we use /sys/kernel/debug/tracing, is the debugfs needed
> at first?
> 
> Thanks,
> Zorro
> 
> > 
> > --D
> > 
> > >  cprog=$tmp.ftrace.c
> > >  oprog=$tmp.ftrace
> > > -- 
> > > 2.44.0
> > > 
> > > 
> > 

