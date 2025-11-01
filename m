Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF72BEC30
	for <fstests@vger.kernel.org>; Sat,  1 Nov 2025 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761988288; cv=none; b=RXgIovEDjuTKfx2dOOsgqDrsuGBv2CAWy3GkX9dzeRNcGLc0FcQiXa1DJY9V2xrQ8sHOnBtT1FYRI68ed4TffBI+4ZgCQRL3ij3Gg2KKVF5+8pLnNBT+Mwhb/pu4z9l/PTj0R7Id6QIjUrihjEbqeDCgRltDaqCDsZfDoMzKEo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761988288; c=relaxed/simple;
	bh=54URsSgFHgy4NuL24nEbHm5DaT5R5aaXnivsCjBkgDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3mKlbH9cjEEawCngoKyBzG3dy85b3rYUyXRtC3mjIXviJycwBkf+WgJN2HuJ5MF0lFSmJDZMCe2Vx9G+xESDEPEK5V8VFzPh2jikSH4p/eMRCdrj8q1Ac3Qw/bLSk1swyxc52TlbV9fh0jOSx0ZR6YKNaXUdjvccKtSioODlaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYSVDngv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWwZbBur; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYSVDngv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWwZbBur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761988285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5u2h7nShUCXQ5DsnSoUxmGzyQUroZKYr/p8OeQCjO3o=;
	b=eYSVDngvwD1HdHo2dysm1mr5gvh3mzCOxk8sR308L73sy1iEXV0CzAGMZ+DZ9GbyhF2SAK
	P5XHS2an9l9YBvbRBhglA3l7P9Q8NF6H9D2hT5ZXL6+flEBo0l0DrOKnuSN/vVqfV077Dr
	m1HtZQzoq0V1sS4X6fPL2JOMbHfbwKQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-Cm2_srLaOxqwr2E5DSiOJw-1; Sat, 01 Nov 2025 05:11:24 -0400
X-MC-Unique: Cm2_srLaOxqwr2E5DSiOJw-1
X-Mimecast-MFC-AGG-ID: Cm2_srLaOxqwr2E5DSiOJw_1761988283
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-295093f614cso29871325ad.0
        for <fstests@vger.kernel.org>; Sat, 01 Nov 2025 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1761988282; x=1762593082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5u2h7nShUCXQ5DsnSoUxmGzyQUroZKYr/p8OeQCjO3o=;
        b=LWwZbBurtpyznAfHskrsfj1uedz2d17LnrLAndjSe6UnA0Z8ET/T40GBV5exEqIPDO
         XkZFfsRNufIMimhTxNfG6jNquhr2zpuYWdq+sxhFWuL4hml4QLA59jKdali1IhvGXY5T
         IWLedWPbrrfU3Qy5aKC0ytwJubGqOGj3c0mkTvUnARMxyQExw/dNkWPntfjSS/r94Zy6
         6LGM0LYVMppVWtZamd4VkI/4qHtdKJoArVd0i85ccE5xlPkb2CR2ApCbxeb+4S98gm2r
         BGIENaytODtLrzVMnum7F8HPVAYxYEuy/mJ8rEa+yPuz9FhXvrF0VLe+kL3HbR90Moxb
         8Lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761988282; x=1762593082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5u2h7nShUCXQ5DsnSoUxmGzyQUroZKYr/p8OeQCjO3o=;
        b=tB9+b5vVuWrsHp9MIvNtDfaAhRCbJTxQqHqYJ6pGeZr3emJTBudswFTnCPmp9zHdgU
         571Z4ktiQ4G4CA/UqYmA18hzEaATNdmPh7VCwDWMN4nf0J6nBakOJfOcllNwpt8HvVzR
         6QuVQ1eQ66+uSZnJx1zmypCfZ36MaDZH+ke/cbLZbA31BZ//KwpcceMhVKHVspD0kqJN
         v9RdfsDzIA52N1kmV02FlIB0lFpA/WBTbG3Z6NzOglNEhnMY2KaHzBVhLPrNqX4zSybf
         vNMBw3mq3CiS9d0h+YmXR7+NMEzWbbDnTzyi9wZO4OLs3i0rcMNtsByO6S58gKbca9CT
         JfGg==
X-Forwarded-Encrypted: i=1; AJvYcCVLZQgoYIAzohmYQ58PrXgqiWqnq9av/57w5iLhZzIHHUsEM7mlpNmcCEdCKQkvhmbd9FidZ1Ab@vger.kernel.org
X-Gm-Message-State: AOJu0YyAWoyeVEFIx11IvExCCpgUlKaE/oud0T8inr9TCQQ0sfbys1zx
	2n9NRAw9RGHM+59d7kG95RMzDB+Uzb0TjWQgzs1ZezqL8BmbWGFIm/KamBTJnbNelwNtsogt8PA
	R1d/iq0Jl1hvew+AVJu2gNuYTO/zxI09ePCcQYnHTQriuHJLuCXEEu9KFb3BAsDpqzpQ=
X-Gm-Gg: ASbGncs8jNUyJBp5fRuwu0d/8xIN9iCXeDKH8qUSw3S+8ZnFmCmahhTha1b7LCu0mNM
	dtDgC8aQK7Pkpct3Z4JtRmaYO7SPbUzMTnB05x1y0/E+vcqsS8Nu20KNjGllYLmMQlakjtnxmpR
	ZxyUkb1MYDlwQBBq4eS2gCC8/3Yue//MwMx0jWd5t9MRnXLw2Gnmc4Y3TrBVC4UFH5NIohNopPC
	0TX0R7gzrYRafDCkaXFxz8KpZPoLIcCGg7x3XgAC1FXRVU09VZNTopNwfGOOdJRDY1MzGYYa4Ib
	4NLMYWsqtbYaesHAZaJjHgjJ4eMB5kdPkY1heHS3k1zYTVVr/mEqXVDmGOOEQXGKB/yhYh9Gs0H
	qe9vreutyyAiiYtKA/mU/3KKofCr0ywOpWXwfHeY=
X-Received: by 2002:a17:903:18e:b0:269:aba9:ffd7 with SMTP id d9443c01a7336-294ed2c3b0amr121216405ad.25.1761988282164;
        Sat, 01 Nov 2025 02:11:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH+DIOhp13qqsUAXmoawC3bB+CBlbnWT0maLvrAkQgeWP2EVykWByZcpcQrB5QYMOe7R7PHQ==
X-Received: by 2002:a17:903:18e:b0:269:aba9:ffd7 with SMTP id d9443c01a7336-294ed2c3b0amr121216255ad.25.1761988281681;
        Sat, 01 Nov 2025 02:11:21 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bdfb9sm49534635ad.103.2025.11.01.02.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:11:20 -0700 (PDT)
Date: Sat, 1 Nov 2025 17:11:15 +0800
From: Zorro Lang <zlang@redhat.com>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org, djwong@kernel.org,
	aalbersh@kernel.org
Subject: Re: [PATCH v2 1/2] generic/772: require filesystem to support
 file_[g|s]etattr
Message-ID: <20251101091115.xhdtoaq6erv3hzpt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1761838171.patch-series@thinky>
 <lwdr5ntyyszcvqe75ljcqtpcrtjioopoa3abm4fjrdupfmrmx7@2jebme2cchx7>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lwdr5ntyyszcvqe75ljcqtpcrtjioopoa3abm4fjrdupfmrmx7@2jebme2cchx7>

On Thu, Oct 30, 2025 at 04:30:20PM +0100, Andrey Albershteyn wrote:
> Add _require_* function to check that filesystem support these syscalls
> on regular and special files.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---

Thanks for doing this, that's more clear for me now:) I think this patch bases
on another patch from Darrick. I'll merge his patch at first, then merge this
one.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc         | 32 ++++++++++++++++++++++++++++++++
>  tests/generic/772 |  4 +---
>  tests/xfs/648     |  6 ++----
>  3 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 462f433197..be3cdd8d64 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -6032,6 +6032,38 @@
>  	esac
>  }
>  
> +# Require filesystem to support file_getattr()/file_setattr() syscalls on
> +# regular files
> +_require_file_attr()
> +{
> +	local test_file="$TEST_DIR/foo"
> +	touch $test_file
> +
> +	$here/src/file_attr --set --set-nodump $TEST_DIR ./foo &>/dev/null
> +	rc=$?
> +	rm -f "$test_file"
> +
> +	if [ $rc -ne 0 ]; then
> +		_notrun "file_getattr not supported for regular files on $FSTYP"
> +	fi
> +}
> +
> +# Require filesystem to support file_getattr()/file_setattr() syscalls on
> +# special files (chardev, fifo...)
> +_require_file_attr_special()
> +{
> +	local test_file="$TEST_DIR/fifo"
> +	mkfifo $test_file
> +
> +	$here/src/file_attr --set --set-nodump $TEST_DIR ./fifo &>/dev/null
> +	rc=$?
> +	rm -f "$test_file"
> +
> +	if [ $rc -ne 0 ]; then
> +		_notrun "file_getattr not supported for special files on $FSTYP"
> +	fi
> +}
> +
>  ################################################################################
>  # make sure this script returns success
>  /bin/true
> diff --git a/tests/generic/772 b/tests/generic/772
> index cdadf09ff2..dba1ee7f50 100755
> --- a/tests/generic/772
> +++ b/tests/generic/772
> @@ -17,6 +17,7 @@
>  _require_test_program "file_attr"
>  _require_symlinks
>  _require_mknod
> +_require_file_attr
>  
>  _scratch_mkfs >>$seqres.full 2>&1
>  _scratch_mount
> @@ -43,9 +44,6 @@
>  ln -s $projectdir/bar $projectdir/broken-symlink
>  rm -f $projectdir/bar
>  
> -file_attr --get $projectdir ./fifo &>/dev/null || \
> -	_notrun "file_getattr not supported on $FSTYP"
> -
>  echo "Error codes"
>  # wrong AT_ flags
>  file_attr --get --invalid-at $projectdir ./foo
> diff --git a/tests/xfs/648 b/tests/xfs/648
> index e3c2fbe00b..58e5aa8c5b 100755
> --- a/tests/xfs/648
> +++ b/tests/xfs/648
> @@ -20,7 +20,8 @@
>  _require_test_program "file_attr"
>  _require_symlinks
>  _require_mknod
> -
> +_require_file_attr
> +_require_file_attr_special
>  _scratch_mkfs >>$seqres.full 2>&1
>  _qmount_option "pquota"
>  _scratch_mount
> @@ -47,9 +48,6 @@
>  ln -s $projectdir/bar $projectdir/broken-symlink
>  rm -f $projectdir/bar
>  
> -$here/src/file_attr --get $projectdir ./fifo &>/dev/null || \
> -	_notrun "file_getattr not supported on $FSTYP"
> -
>  $XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
>  	-c "project -sp $projectdir $id" $SCRATCH_DEV | filter_quota
>  $XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid -x \
> 
> -- 
> - Andrey
> 
> 

