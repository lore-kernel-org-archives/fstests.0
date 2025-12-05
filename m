Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550CA26F467
	for <fstests@vger.kernel.org>; Fri,  5 Dec 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954883; cv=none; b=Rtq+6acCqTLjNSU4jjNDJjeVxfDBcewdEs1qEx8hJRaby1vOdMa80puSkMKkoPaZjt57+TkhdoImgl48NLVSOcKdpWzKCOkPqcmbI4+35Zo3ViqKTqf+tw2XUPRFewHApFEYOF8laU4Azin1qPRwdOhAGdvvKqiBQYGi+OXif/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954883; c=relaxed/simple;
	bh=h1Z+BVnBoVaSCJl0VcIXxwMnC9zg05UdlhBoero1z5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmu6oIx8IixkLn2S2YZ3D/Sg4VWcxa0H1lY2rBm+Dmcb2J8/selARe458Dt8zb6OIlJ04OxteAKM0gdsmYWGkYG2h2Bwdud5XlceLve3GqhfcJeQ8N2309LEA2LcArlcWDAjVUEBzHn9nlbPjM3/6HXoNB6l4hDTC5bhTBwemL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpnHFs0S; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Smlf3LTg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpnHFs0S";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Smlf3LTg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764954874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c3c7pkg0/S/agmiAthrU1L2DahU9Xrden1+WebcUd8U=;
	b=bpnHFs0SpuTcK4oQIVua2wNcKHaOzeKWPVL56Nyuhg0DP4TKF2WPxaF4F+WNvQcJgBaIfU
	3Uc8v4meIrDZtKs7lABHmK/LqHEbmpg81+d1iEbGz3TREogcq4z5Y9jsL7n6Wp3i2uzGQU
	IMm5YBYlftFJu6B+LEtPrNi7gFh+UTA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Ujb5pOpNNJifIlTmf4zE1g-1; Fri, 05 Dec 2025 12:14:33 -0500
X-MC-Unique: Ujb5pOpNNJifIlTmf4zE1g-1
X-Mimecast-MFC-AGG-ID: Ujb5pOpNNJifIlTmf4zE1g_1764954868
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7aa9f595688so3705261b3a.2
        for <fstests@vger.kernel.org>; Fri, 05 Dec 2025 09:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764954868; x=1765559668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c3c7pkg0/S/agmiAthrU1L2DahU9Xrden1+WebcUd8U=;
        b=Smlf3LTgRNPtTGg0238/qvV6VXoaQRbavEvP+PGVEKNZ8EWrOL4Yl4wfVnULUpznxO
         haxiwffd02ElDPx1NhAQz2NbxryUJ/krkaCSPUcVySiJCtaMVIIviZlybvtr/Vefo8G+
         TMDf4azv5ec2VwExP28TuMJdndccU3qSv9DrqZiaLEHSNJoLnuEXU4im41vZQPBNNeNN
         0LXI0m25MogB2PEAXth2PHp8jysOks9e1dAFP4Y19o9SNrYNnL4mZAcKmcBO/orCB6zI
         FvlFLuuJyKgoYxrtZNCFBhAO7zWjB7PvivUnHo+EslBr0jAMERmQTxXl4R7dZnyyJzQa
         5KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954868; x=1765559668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3c7pkg0/S/agmiAthrU1L2DahU9Xrden1+WebcUd8U=;
        b=EZbaxNblOon0OqB2FL5qPCbgC+qG+LwpwuKIxH3O2Z4rjkOq3UnXpd/KxBWA9avx3y
         s/pwVkOFvDrmCMptOAgETeYC/rlM2qlwXlN+SvPYjyf1hwmQbE20g22qjRZ1ozOJOfHL
         64QovsYZJF/ETvvzh1NYbbigWtiPMWmjgUN/MRKttulhkx6Wih34gYUVPoZID1CnStAS
         t29rFiW6WI36l7gozBMtEX6qyqPkssZOrmLmY2i56Z44olJwY1B80MagpUXbBD0EOdBM
         s88KHuSCSPJDQQAqkyr12+mS2XmeOx4s/1jr/Siwc1iFiLuZ55KYG7pKB62mKqX7HxED
         29NQ==
X-Gm-Message-State: AOJu0YxTh3niOOhBqyTbkxsAi4V/zkfXbCmy4LHfMEuuVNxetCroqIg1
	J2fBWKCHiw0ANzSjHGp5NDDDJk0Xg9075oOdU+RUgZKHbOsk1aQoSxm9J76xWp1rKw5x49PsnT6
	0xG9ACGq0dYq2ckT1Vk3/12QYtk+fz8YWJi7coCqTb78BY2vwP9EE8rVRSqw=
X-Gm-Gg: ASbGnctI2YtGQUrmdtAAoL5Gy5KbHpyLs7o4Mp9I8WYISPJr3qs+WXO3MCqIvtetvIx
	L3N8qn9zHQ9A7ZsOmNDrNhaRxVmROCB4d3C5b7qf7m2ZeKNQIIiY75NtAdmHwIWCbWNUJkN7GtK
	Mky6OMgCKfM0ucx2ZBkVvxrtbJqcQkBjRpBi0etgGkTne2r0baLCTuAXQhIxzUtxn6MRbfz53EX
	9T/83eG8taIhtaF47d1YAkUJIJMu9/8uOA3hu9r3d9GHZpuYCQYYf1XNkgaDzLXE1xMdKwerzWZ
	o4vDxRDYBwssQLf1PjlY7hqeF2U1v92bPxuFK9AGxf4zyho8alOYtsQ159Hy5LpTb7lN+4lgS3c
	hswyvpOBOOyKA3fUtZRtJ843cPf+ScC9KQW2rr2eNiz1S+ErDzA==
X-Received: by 2002:a05:6a00:2283:b0:7e8:4433:8f99 with SMTP id d2e1a72fcca58-7e8443391b8mr583955b3a.33.1764954867794;
        Fri, 05 Dec 2025 09:14:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTlg6can+HvA+4fi3e6HCk+YQednzlBI3QtVrdw1y9Yfq4QdKTK3ndJwtYc5QarvY8VO9kow==
X-Received: by 2002:a05:6a00:2283:b0:7e8:4433:8f99 with SMTP id d2e1a72fcca58-7e8443391b8mr583934b3a.33.1764954867346;
        Fri, 05 Dec 2025 09:14:27 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7e2ae03513fsm5765462b3a.43.2025.12.05.09.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:14:26 -0800 (PST)
Date: Sat, 6 Dec 2025 01:14:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH fstests v3 1/3] common/rc: clean up after the
 _require_test_fcntl_setlease() test
Message-ID: <20251205171422.u357tlxsc5ufl3ka@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251203-dir-deleg-v3-0-be55fbf2ad53@kernel.org>
 <20251203-dir-deleg-v3-1-be55fbf2ad53@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203-dir-deleg-v3-1-be55fbf2ad53@kernel.org>

On Wed, Dec 03, 2025 at 10:43:07AM -0500, Jeff Layton wrote:
> Remove setlease_testfile after validating whether a lease can be set.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Thanks Jeff, this version is good to me. As this feature has been in mainline
linux, I'd like to merge this patchset in next fstests release to get this
coverage.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/common/rc b/common/rc
> index a10ac17746a3ca4d9aca1d4ce434ccd6f39838b9..116216ca8aeb4e53f3e0d741cc99a050cb3a7462 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4656,6 +4656,7 @@ _require_test_fcntl_setlease()
>  	touch $TEST_DIR/setlease_testfile
>  	$here/src/locktest -t $TEST_DIR/setlease_testfile >/dev/null 2>&1
>  	local ret=$?
> +	rm -f $TEST_DIR/setlease_testfile
>  	[ $ret -eq 22 ] && _notrun "Require fcntl setlease support"
>  	[ "$FSTYP" == "nfs" -a $ret -eq 11 ] && \
>  		_notrun "NFS requires delegation before setlease"
> 
> -- 
> 2.52.0
> 

