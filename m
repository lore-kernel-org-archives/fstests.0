Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B07819D06A
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144767; cv=none; b=pgKp/hAqlUK8cvkDEjCV/dv74qiD44lfA55riRuz8PyHoyq7nI2d04mkhzZKu0JeJggaSy2C0psEGnQ+KZ6SD+YD3JdsK55uJRbCSBr878QrC7YSfNwCSkNY0WdYntTe/BpHCz8acxnmmtiUtdy+1R2+N8emfkUWSxDPxgojSvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144767; c=relaxed/simple;
	bh=ZrgYdKtEEmMov1IXq8Qvd/Cd4gvh0W8IsZWoEUS6lOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+0+Xao4f58+wjdInEeahIhSWhA2OjtmuSW6/fvYxyFlyCfP8bhng07iwG/UGAG9mRvXmogISCQeTu8ryQf5lP5quLeZ2IQmPihlneBe/8YPqAIzM1vB9aOB4g//wzvbjHopMzSm19PZsw+xpl2ms1iBv/vEacf8oswVLLY0gaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0lAWYrR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0lAWYrR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749144764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SbqvG8bC3Lf/tJ1TxTXVtxh04QlkVtdqv1xGSMI3+W8=;
	b=B0lAWYrREzX9kvK/Ya7AGAj5kTh6Jo//fAd7sM5LVUPQhEICGMt6AwcFx+yfClJINB/qaG
	QikjlJrqT8ceFNtBgJJI91iOHJ1DiAaGz+VPAY7uqWVMzYZjilz1ELpJyh8mwnhuvHPNft
	ERlOzMlMyr4QcOi798wI9qA4kr4L25s=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-7R_401hLPEOxjc5bR2ou_A-1; Thu, 05 Jun 2025 13:32:43 -0400
X-MC-Unique: 7R_401hLPEOxjc5bR2ou_A-1
X-Mimecast-MFC-AGG-ID: 7R_401hLPEOxjc5bR2ou_A_1749144759
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-235e3f93687so18205535ad.2
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 10:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749144759; x=1749749559;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SbqvG8bC3Lf/tJ1TxTXVtxh04QlkVtdqv1xGSMI3+W8=;
        b=XESKBIr0+OTwL21TtJOrDbuTnntNtiH5nVNv7AcWifqvPxHOjl2eWwMSii0f7GRgtJ
         40WQNbNfIeqLdbqFiJ3HTk/8nLCxZZrzrCLAH6CPiRtZA5cwvCa+6k0/VtyouhdspUEt
         xR+VRweE79laxs+QT0R2vgSHJZlnvneob6DkA/u+RQJQduGeCvIDvzeWdzBMRIigOMZS
         EFQRzzERbpZLyInlLXL9KasMjr1hVRREBWjees2NHYuII+5NCPLwiPVnaJnCucqVl7aN
         vSs+8HbvMZ2iCKEC52/ccnqxMrTTTaMUQOxYvQaJTEPG96Qa5BNbXaj5xneCYNwvdAoS
         yP/w==
X-Forwarded-Encrypted: i=1; AJvYcCVQV1749wL5PL7WGJ9Axrw+3oUqGYyPQeJB1Qczh0SW/OCbpmA1JfXeUL13jCgZUfMpDw++gIhs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8iQBmeND2SWJaRiBmFace8ZUdlTzkgtBoCXH4Xi+jTOkGNbSx
	W4ym/zzUZkZ0ygQrZXOCgTexeyaxQohLp/L197RQZ4eAKIfDqYlsMJwN7F+2KvtAqyZGGRQNQ+X
	oYZGXUhH0gM85PrLc16uLAif+WE1HUKsmL0mOTt7KacI3fDOo5Kd+jyLKUr378n1T8Ew=
X-Gm-Gg: ASbGnctEBKN7xQ9bjZnVUNNQ6kafwRdCL6P2/zn4xKxOWUQE4ScPP2r/gndIhCqDrHr
	vAbl+Ul2SSlT9uu1j1J3ZLYWF7pSlHeZwU79hCUFed1H9uQNF/xSrKM+xBTpZYgVjPBnHEQstaO
	iUrAxg7l7cccUZbHrpRuoxLa8R7H0LsCFvB9sfYgtxviE8CIRwaXnQjzGBVCUelPdnZtD34ayHs
	7fqn/Go0b/Wn+h3p8nMILwNEHQICOXHrzmH5yL27PyuqE4GsfUnHFkD+y0qQynmciFZ0M/tKf2v
	mOfrD6E4S47inFsRjVT8o8Hi67M/1Qg/5QtKyXwSnM7EA4maJdRI
X-Received: by 2002:a17:902:e88a:b0:235:ec11:f0ee with SMTP id d9443c01a7336-23601cf96d6mr3497085ad.14.1749144758965;
        Thu, 05 Jun 2025 10:32:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyFzj8ca92j9Fblwdd1kTqgenHF8POiDPCuqyb6y5JQYt5dJJLLdZNGS70UdvPO9qCqUCaNA==
X-Received: by 2002:a17:902:e88a:b0:235:ec11:f0ee with SMTP id d9443c01a7336-23601cf96d6mr3496765ad.14.1749144758613;
        Thu, 05 Jun 2025 10:32:38 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf53a9sm122147345ad.196.2025.06.05.10.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:32:38 -0700 (PDT)
Date: Fri, 6 Jun 2025 01:32:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2 4/6] generic/623: do not run with overlayfs
Message-ID: <20250605173233.ndqsjo77ds3e35p5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250603100745.2022891-1-amir73il@gmail.com>
 <20250603100745.2022891-5-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603100745.2022891-5-amir73il@gmail.com>

On Tue, Jun 03, 2025 at 12:07:43PM +0200, Amir Goldstein wrote:
> This test performs shutdown via xfs_io -c shutdown.
> 
> Overlayfs tests can use _scratch_shutdown, but they cannot use
> "-c shutdown" xfs_io command without jumping through hoops, so by
> default we do not support it.
> 
> Add this condition to _require_xfs_io_command and add the require
> statement to test generic/623 so it wont run with overlayfs.
> 
> Reported-by: André Almeida <andrealmeid@igalia.com>
> Tested-by: André Almeida <andrealmeid@igalia.com>
> Link: https://lore.kernel.org/linux-fsdevel/20250521-ovl_ro-v1-1-2350b1493d94@igalia.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  common/rc         | 8 ++++++++
>  tests/generic/623 | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index d8ee8328..bffd576a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3033,6 +3033,14 @@ _require_xfs_io_command()
>  		touch $testfile
>  		testio=`$XFS_IO_PROG -c "syncfs" $testfile 2>&1`
>  		;;
> +	"shutdown")
> +		if [ $FSTYP = "overlay" ]; then
> +			# Overlayfs tests can use _scratch_shutdown, but they
> +			# cannot use "-c shutdown" xfs_io command without jumping
> +			# through hoops, so by default we do not support it.
> +			_notrun "xfs_io $command not supported on $FSTYP"
> +		fi
> +		;;

Hmm... I'm not sure this's a good way.
For example, overlay/087 does xfs_io shutdown too, generally it should calls
_require_xfs_io_command "shutdown" although it doesn't. If someone overlay
test case hope to test as o/087 does, and it calls _require_xfs_io_command "shutdown",
then it'll be _notrun.

If g/623 is not suitable for overlay, how about skip it for overlay clearly, by
`_exclude_fs overlay` ?

Thanks,
Zorro

>  	*)
>  		testio=`$XFS_IO_PROG -c "help $command" 2>&1`
>  	esac
> diff --git a/tests/generic/623 b/tests/generic/623
> index b97e2adb..4e36daaf 100755
> --- a/tests/generic/623
> +++ b/tests/generic/623
> @@ -16,6 +16,7 @@ _begin_fstest auto quick shutdown mmap
>  
>  _require_scratch_nocheck
>  _require_scratch_shutdown
> +_require_xfs_io_command "shutdown"
>  
>  _scratch_mkfs &>> $seqres.full
>  _scratch_mount
> -- 
> 2.34.1
> 

