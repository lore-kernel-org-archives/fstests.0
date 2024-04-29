Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A798839FD
	for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417146; cv=none; b=FW8Nb69YOvI9zGNqVg5CKuAU3tjzEjDnFEQYvgheWv3CjNBqFoFllpRxoccV+LPbhUSZX9Fui/inzp9sDr2m4yPgjsjUI0Xdaj+SfHIktrPvs4a/JtZNh8CtCY6ILsRT9QpQf5H6welpv1M9dLNU6x6wIXxUYPFnxA1OuijMRXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417146; c=relaxed/simple;
	bh=cQmRwTfbz0EGmsqUy9MlKtTNa13S2Q4oVHPOtYuYrAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2Ap19io53UjznTwX3NZ7zC+YGWWgR2s60eqyQImNrzi7hhCIRFYMt0DZ36rBd+LTd6MhsVKAP5xR6depg+2pplaKXF3H/QGK6DicRHArPtfeoOAoPNiePnCawGAV+kN34XWOvLwgInbEIPTdwileaTR32zFqGdBtFb5ZBgzdcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMZgvYQh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMZgvYQh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714417144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=58U6c2r6KeuDPArmwqaIX7ciqSVjY3lUXw/LCMnFwP4=;
	b=FMZgvYQht6pzg1HvTX7Ow5leOEYdwAxmoCAMiQM7OLtgmFQ3n1nWEws/0+ohH/wZVQY3DA
	SwH7I5EPV/9jJ+L3kSKV52WB2Ylq3rxaw4YwshUsVKOB+oRm8nlrMhYJyQi7iO2Eu4YdKk
	MyMde/f54Lx8DsGJwG5KZNNN+2ea+rM=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-3Ndhj-C5MMKJNEoLdPHTrQ-1; Mon, 29 Apr 2024 14:59:02 -0400
X-MC-Unique: 3Ndhj-C5MMKJNEoLdPHTrQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6ee11ae73faso2650731a34.3
        for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 11:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417141; x=1715021941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58U6c2r6KeuDPArmwqaIX7ciqSVjY3lUXw/LCMnFwP4=;
        b=xELKNgL3hmC0ybpmq7TTs2+BkiCbwnmt8tmqAmByNSBlF8r3pXgKIW4Cy940cBiHon
         JH1MNXr7K3cYBgXO9JkM0JTcKKfgk/OYRQ9JCCJ4KnzmUShwhs2oEYPm7dFqKhbmiyw5
         wo1yrMQrii8DPDPROjg8MiM24f4BAsJU+O1DiLHjNTGYHory7XlKtr/k95HJQfPDzxKm
         U4BkY3+NdbdN/fi2vfgWC3I4OwWamtIgK6mvPv03YHe+zRi6KADgnvpkxcRu5LlT5weY
         teipVV6itXK6MGJee+XK4AjCVYF5KEPaZbAH3nUK2cAsMIvWTTy93TweL2dCwXg/DBov
         L5cg==
X-Forwarded-Encrypted: i=1; AJvYcCX+2eW7wS3O9bnlRtmBpW7zkq/JcvpOV1kclwGbCuBQqKa15sQtpjwXsSYLlrk/DyCKLigPjXsqpJ/Vn2aYs3iDyX7kHTFxsw==
X-Gm-Message-State: AOJu0YyE5MGnPa90nlUjp6HV/8PZlGh0zo1DJjsMqTcKq68CGHnYX+UF
	gTR3ya2OQtiNJNc5Pug2/ihR+WuPpwa9R2ouexqyWCBThgKEp6o1KO/JRr1L/YGe2ERz3fX0gj0
	6QUrRtQY4AOVyJLte1/x8gZ+MGK9GE49Qlo4F+tEvj8yoi9DYSQSQgdI=
X-Received: by 2002:a05:6870:a107:b0:22e:ddd1:53ab with SMTP id m7-20020a056870a10700b0022eddd153abmr12017016oae.41.1714417141177;
        Mon, 29 Apr 2024 11:59:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEchsHYSOdqP8xNVy64gNR+mu6a2OaMXRAPW0U099vH8qa09C88zuxcvHHCr7Pi3yBZRgWiRQ==
X-Received: by 2002:a05:6870:a107:b0:22e:ddd1:53ab with SMTP id m7-20020a056870a10700b0022eddd153abmr12017000oae.41.1714417140728;
        Mon, 29 Apr 2024 11:59:00 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id g7-20020a62f947000000b006f3d2bd4cddsm7491812pfm.211.2024.04.29.11.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:59:00 -0700 (PDT)
Date: Tue, 30 Apr 2024 02:58:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] fstests: fix _require_debugfs and call it properly
Message-ID: <20240429185857.n32qxnmfzghd5nuf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240429060906.465135-1-zlang@kernel.org>
 <20240429160356.GC360908@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429160356.GC360908@frogsfrogsfrogs>

On Mon, Apr 29, 2024 at 09:03:56AM -0700, Darrick J. Wong wrote:
> On Mon, Apr 29, 2024 at 02:09:06PM +0800, Zorro Lang wrote:
> > The old _require_debugfs helper doesn't work now, fix it to check
> > a system supports debugfs. And then call this helper in cases which
> > need $DEBUGFS_MNT.
> > 
> > Signed-off-by: Zorro Lang <zlang@kernel.org>
> > ---
> >  common/rc       | 10 ++++++++--
> >  tests/btrfs/150 |  1 +
> >  tests/ceph/001  |  2 +-
> >  tests/xfs/499   |  1 +
> >  4 files changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index 56f1afb6..6f0bdf60 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -2978,8 +2978,14 @@ _require_sparse_files()
> >  
> >  _require_debugfs()
> >  {
> > -    #boot_params always present in debugfs
> > -    [ -d "$DEBUGFS_MNT/boot_params" ] || _notrun "Debugfs not mounted"
> > +	local type
> > +
> > +	if [ -d "$DEBUGFS_MNT" ];then
> > +		type=$(findmnt -rncv -T $DEBUGFS_MNT -S debugfs -o FSTYPE)
> > +		[ "$type" = "debugfs" ] && return 0
> > +	fi
> > +
> > +	_notrun "Cannot find debugfs on $DEBUGFS_MNT"
> >  }
> >  
> >  #
> > diff --git a/tests/btrfs/150 b/tests/btrfs/150
> > index a02bdafc..fd386d92 100755
> > --- a/tests/btrfs/150
> > +++ b/tests/btrfs/150
> > @@ -17,6 +17,7 @@ _begin_fstest auto quick dangerous read_repair compress
> >  . ./common/fail_make_request
> >  
> >  _supported_fs btrfs
> > +_require_debugfs
> >  _require_scratch
> >  _require_fail_make_request
> >  _require_scratch_dev_pool 2
> > diff --git a/tests/ceph/001 b/tests/ceph/001
> > index 060c4c45..79a5f58a 100755
> > --- a/tests/ceph/001
> > +++ b/tests/ceph/001
> > @@ -20,7 +20,7 @@ _begin_fstest auto quick copy_range
> >  
> >  # real QA test starts here
> >  _supported_fs ceph
> > -
> > +_require_debugfs
> >  _require_xfs_io_command "copy_range"
> >  _exclude_test_mount_option "test_dummy_encryption"
> >  _require_attrs
> > diff --git a/tests/xfs/499 b/tests/xfs/499
> > index 9672f95d..6421cc4b 100755
> > --- a/tests/xfs/499
> > +++ b/tests/xfs/499
> > @@ -18,6 +18,7 @@ _register_cleanup "_cleanup" BUS
> >  # real QA test starts here
> >  _supported_fs xfs
> >  _require_command "$CC_PROG" "cc"
> > +_require_debugfs
> 
> This test doesn't mess around with debugfs per se; it actually wants
> tracefs.  Perhaps this should be _require_ftrace instead?

Sure, but if it depends tracefs only, should we use /sys/kernel/debug/tracing or
/sys/kernel/tracing ? If we use /sys/kernel/debug/tracing, is the debugfs needed
at first?

Thanks,
Zorro

> 
> --D
> 
> >  cprog=$tmp.ftrace.c
> >  oprog=$tmp.ftrace
> > -- 
> > 2.44.0
> > 
> > 
> 

