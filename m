Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4902D29B8DB
	for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723205; cv=none; b=aN2oVD8tDxBksOLxuNmHgYAncVFxSivOhTWT4aS2ao5Fl73OwabC8vzAatrYNwEpFys3K+sYwiHrRpqO+3OYFAgOtNwtTouGrX+52q80bEoj4slbDIzi+Lw570cnF+RtRBnEiJUC/X29F65u5G/2CbrKfXz6px+hXS+CWI9cs5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723205; c=relaxed/simple;
	bh=+rlXMsdBVCiAGKNrtStCluWm7gAecJ+SisXX1H6GGYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdupr98TZC0yR7i2xpvqaVlQOI17tQ24RFGk44rv0IOobrDWE/R7JH95MSiXyhOqkEYN/mFo/Sls4GrxCc5AxPTxa7moOORUYN1+8mXkaXS7GwyTylCx7zuvbGaRHAJtr8SwNqAG0GfHrz7tiHyjRd892UJ7ZQ4VY7OwgrNFItI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOWMs+Ad; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOWMs+Ad"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760723203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nqAd0fHzJv/ONbqAnOwgeKtyz/JhNvYGbRvyQBkC5F8=;
	b=UOWMs+Adl4uTqQJITieNzpWew4FBGnibZsgcIfv7vC0EqOVAF6Pf8prXDmgjq4Cd4+sg6P
	IYMjIFNoygJq4WQuer78btUVDKp6GIozMSYepEhnF88qVMKO+DRPGHeS8qctwpgjPoDEak
	1l5537kNQvGcnFFk1It0lXCYZrE8sdo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-9lKTe4o5Nve3_1sEBnCZzw-1; Fri, 17 Oct 2025 13:46:41 -0400
X-MC-Unique: 9lKTe4o5Nve3_1sEBnCZzw-1
X-Mimecast-MFC-AGG-ID: 9lKTe4o5Nve3_1sEBnCZzw_1760723200
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78427dae77eso1982854b3a.3
        for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 10:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760723199; x=1761327999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqAd0fHzJv/ONbqAnOwgeKtyz/JhNvYGbRvyQBkC5F8=;
        b=ZqvHGcuEavOFGn7RRV8jXuMlroYPXiNkARW8oxTK1SHoYAA3JMABOydEVVTyEacZRY
         SkLJXzKv4PslBsLk3pftTath6na2NyJdZMxtblWDWAQSFmvBTa/ETVpThxGkrT/sWtbi
         X3XW801eB2jl14YIxnX2pNpJgOE3KSIqLX4ZSaUAjkIkNRzS5VxpCBUJxNSOoqTnVFWh
         N0hKMfDDsJ7CEg1+Q0KYIuUjKi0Waq6iobPs1yCvfgOXBKjg7ZAaxM22Ot28yZG4jgn6
         9UqAUvRJlEMBju3RX0mWEuDutt6he5hdllZr/oNL/qZKH2HgB93lCHzl+R+38W2/OEnw
         KM6A==
X-Gm-Message-State: AOJu0Yy98XwclquIqQFs+hJM1jIgPwsPvTOecdY6Y3gIPqbDksvUgsOZ
	n/KlpGe3OIPQ5/rkkHmF7gUGhgFECfUfXLRM7DygLnZClx9CsXe3O06VAEQiDWWIjQMSty5FqCV
	olyfNl0aS1HJsoVEmn38zf09dDBvQetIYjS1IKf4cn/SiYPtylKO1EkW+wgGOgdeOdGw=
X-Gm-Gg: ASbGncsFFe9+PUWyiggqyIW1TvslBtljI6uCtGjwF+614jD1XvU+6n4cI+rm3MVE8og
	AGCvXm8FZG1sjv4+8thmSj7sFTuJHk0cTgbOSGBG0uB6Q8Tqjc1SofVNnD6mA7cna2mHimW7Iod
	6LpCC5t4jGmyzSiVvjsj+GB1tWR/h/TunuD0JNiXbWt7JQsU4EV3XMLVgjf3wPXbRU6JlOkjgWw
	QVc/GygcC17V37/BbG632/Js+d6wKHVwA30PZBdW7J5SqTRXqN7ABegjeWkbz08qyOwCZmqK5gh
	7AaD7xCHZlOnNKhq0+3OedL7pzaq+HZCGU66fKQ7xTltA04GXnaSvhMPj1cdxaIpRAsGoRRZZBG
	xEjs6WJOmTPvr7+ojpIkgp8wpT+grCfSkZYKhTSs=
X-Received: by 2002:a05:6a00:1793:b0:776:12ea:c737 with SMTP id d2e1a72fcca58-7a220b06549mr4843945b3a.23.1760723199046;
        Fri, 17 Oct 2025 10:46:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe/timuZwjbKtFT1+8rRGPQgkec8Ndr9avLVggU9VbXoopwWlOx0AlvXqT8Q8E7rvXqNzdaw==
X-Received: by 2002:a05:6a00:1793:b0:776:12ea:c737 with SMTP id d2e1a72fcca58-7a220b06549mr4843913b3a.23.1760723198504;
        Fri, 17 Oct 2025 10:46:38 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff1581dsm170103b3a.12.2025.10.17.10.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 10:46:37 -0700 (PDT)
Date: Sat, 18 Oct 2025 01:46:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/8] generic/772: actually check for file_getattr special
 file support
Message-ID: <20251017174633.lvfvpv2zoauwo7s7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <176054617853.2391029.10911105763476647916.stgit@frogsfrogsfrogs>
 <176054617988.2391029.18130416327249525205.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176054617988.2391029.18130416327249525205.stgit@frogsfrogsfrogs>

On Wed, Oct 15, 2025 at 09:38:01AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> On XFS in 6.17, this test fails with:
> 
>  --- /run/fstests/bin/tests/generic/772.out	2025-10-06 08:27:10.834318149 -0700
>  +++ /var/tmp/fstests/generic/772.out.bad	2025-10-08 18:00:34.713388178 -0700
>  @@ -9,29 +9,34 @@ Can not get fsxattr on ./foo: Invalid ar
>   Can not set fsxattr on ./foo: Invalid argument
>   Initial attributes state
>   ----------------- SCRATCH_MNT/prj
>  ------------------ ./fifo
>  ------------------ ./chardev
>  ------------------ ./blockdev
>  ------------------ ./socket
>  ------------------ ./foo
>  ------------------ ./symlink
>  +Can not get fsxattr on ./fifo: Inappropriate ioctl for device
>  +Can not get fsxattr on ./chardev: Inappropriate ioctl for device
>  +Can not get fsxattr on ./blockdev: Inappropriate ioctl for device
>  +Can not get fsxattr on ./socket: Inappropriate ioctl for device
> 
> This is a result of XFS' file_getattr implementation rejecting special
> files prior to 6.18.  Therefore, skip this new test on old kernels.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/772 |    3 +++
>  tests/xfs/648     |    3 +++
>  2 files changed, 6 insertions(+)
> 
> 
> diff --git a/tests/generic/772 b/tests/generic/772
> index cc1a1bb5bf655c..e68a6724654450 100755
> --- a/tests/generic/772
> +++ b/tests/generic/772
> @@ -43,6 +43,9 @@ touch $projectdir/bar
>  ln -s $projectdir/bar $projectdir/broken-symlink
>  rm -f $projectdir/bar
>  
> +file_attr --get $projectdir ./fifo &>/dev/null || \
> +	_notrun "file_getattr not supported on $FSTYP"

I'm wondering if a _require_file_attr() is better?

Thanks,
Zorro

> +
>  echo "Error codes"
>  # wrong AT_ flags
>  file_attr --get --invalid-at $projectdir ./foo
> diff --git a/tests/xfs/648 b/tests/xfs/648
> index 215c809887b609..e3c2fbe00b666a 100755
> --- a/tests/xfs/648
> +++ b/tests/xfs/648
> @@ -47,6 +47,9 @@ touch $projectdir/bar
>  ln -s $projectdir/bar $projectdir/broken-symlink
>  rm -f $projectdir/bar
>  
> +$here/src/file_attr --get $projectdir ./fifo &>/dev/null || \
> +	_notrun "file_getattr not supported on $FSTYP"
> +
>  $XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
>  	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
>  $XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> 

