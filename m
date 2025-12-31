Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2411C7012
	for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 20:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767214757; cv=none; b=kZNJQVuAhUWSq8EnhMFHfzwQv+VLq2cHzIg6Q6h8tKML6wAyGjnkt++xt9I+R0Rk4kZqDYPtn7IlmdYsYmvckd+mBx17Y9NDz3/4gi8VL9r2KJ3+erWt+Rt9CwJJz6HQgi3AjtZzwif+bQBq08888GOsvMh+zEAk4AE8jKXP7J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767214757; c=relaxed/simple;
	bh=ARCeHK/Ce8xzSgNMcZ4ptghNxXUEPSIdDc1CGc81MKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdEQekDnaUNLu0QT/AmMJ4R9rVxk8vViJOKMZXWF8fkHyEXvCWdb6HZjRohpsZ1EhkWbJhx6kL+RJLHwAkcqqz9JNWy14HHTRJSc0GFEkEt42yNjbvzxRGa6ZRwZyXaoYsUJVhwogYu7cgtFC037zzqW4XAnt66ueYp6ZiR0HGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zc3DLkQU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/EeY9ER; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zc3DLkQU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/EeY9ER"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767214751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qNNjpiAhJ6sQwRN3nDU/VZhA1mfQoVk+dvDNYkiC98=;
	b=Zc3DLkQUVZfw7+JanMf7Y+i9/RsUySLN9Nk8k+I1bdjJmZfR8qV2v/rOGKxE3l3pePkRIi
	CREQzzQw9jMbsAs78YsUbWOgluVsuPK2iWfqo0jY8WmMWPZq1vajJ0HMb97GH9AIhDw3js
	K/5OLFWWPkayRiq/Z2kZA/qUztOth7A=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-6K0aAED1O4ysiO9LW60uKA-1; Wed, 31 Dec 2025 15:59:09 -0500
X-MC-Unique: 6K0aAED1O4ysiO9LW60uKA-1
X-Mimecast-MFC-AGG-ID: 6K0aAED1O4ysiO9LW60uKA_1767214749
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a089575ab3so143524465ad.0
        for <fstests@vger.kernel.org>; Wed, 31 Dec 2025 12:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767214748; x=1767819548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qNNjpiAhJ6sQwRN3nDU/VZhA1mfQoVk+dvDNYkiC98=;
        b=i/EeY9ERRjabCUOVtvb3B5A+tCtw+0cOHdFhKOGmzJA6bzNjQDGOWY8rzILujsHzVi
         1w3zNi2W4Q82heAd90V+BzmSc3TlI4uq5gDtTTTWJan+RaszOn6qO9rScFjqci7MN2qA
         RJdHXPK8Y8PdrWE1QvaBxNAtlgrX2QH5NcUthXtpx+fktv+/eGC5opVz2VZoIBJh8u9j
         1HE03w3aKDFnUuVAxi/yImDDFtAKUaMWYSWJjQSTCka/k2LjsRhxMsdgdRfuWdmbMtle
         SnIbPaPv2Kp3lFrVrItPSWvASUnpykH+iGbu9L7H936OmvlTrk4xW4vo0VSuZuCaqjDB
         eqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767214748; x=1767819548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qNNjpiAhJ6sQwRN3nDU/VZhA1mfQoVk+dvDNYkiC98=;
        b=iMw0Lj8gHdslFHk189eL4WaXWOLGpC5k+0sepvJFKK1wNWVdWaEkapUFFV3dUFQCgt
         ms5K0fWeZOOsm+oLxjXFhJafjoUYg0CEb5gvDPiCXZUF14j/KN3C3rWkDnDyq5gvpVN6
         4bD0AQ5GYjMMVwqFA7liySiU4azoBGYH9UoJAeRwKnRg5YD8Y75hD62FzxdmaX/6EKtJ
         sNTZJi2+0sAG4kZJjeQ7UplfD5h/BqrWv+KPaaONo/D2OtwQuf9OvHwwGb7/BiOEB3jR
         62XXwRVd5Ko50yxkw2TWH5xIaN4eIsjRSX8cs+CujYC1aEHk0V+liJQpoXXV9o0eSzWL
         cOOg==
X-Gm-Message-State: AOJu0Ywk4tEXvqBTW95KzUhcO3CPnt1r4munN2O5rXZ+YVsMqjMz6WDh
	JSrSysolPeV1ExcNakSwQakxuFyJ2HY2DPj0Ml2JV1WcEk/d2h5+RPDRt3YvbkQQawWnUjDPjt0
	0yHS2FeVYSsgaWBvBVrDGYKXcw2uaiXZo6+OBuI0gzfuDI23LKMw4doWy3TDIU8KuqhY=
X-Gm-Gg: AY/fxX7hDTtlhd2qfFucmydo0McRZIdeOYwjYzJUog6hn2lhGFRmVf9ol3X2+UozooS
	nBTTny6g5TSznccxWS8+Mnvw8vQubK9uTO50GqEKMVVswXtPpHE23/fZ8MYxXEb/tMRxfBsm7cA
	y3iFhgA/PzbFOf6HVGH48yTVivV5qAnzlpwtekDgxmA4+fypvQ5U1YpwVJGM2SFd1kOWbhwfhW0
	fv+cwE5bWxGkj/Im5xGoxq39v0WEp6HtT4munYtIMCSUZ0hsu89liYStFwLeVyFLmHgqktyeKla
	gnRC3idl2p+HBXr6te5Dg1Wi5iK5q0lf+iFNigRQVKcCMCWOHZMpXcmzmI9KF787KPKo47muJls
	tTQTv5Hux7OCSRANKgGyBShkGjEhlJDFIxGRJkHfA2VRVM2vJ8A==
X-Received: by 2002:a17:903:234f:b0:2a2:d2e7:1601 with SMTP id d9443c01a7336-2a2f283cb23mr304509535ad.48.1767214748067;
        Wed, 31 Dec 2025 12:59:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExUTQkONlTOWBI0layTJyV7dGWs0TCdtDr2fq07iNRyqvfKp8aFtKg6z8l7Rr5UuWJGf/jPQ==
X-Received: by 2002:a17:903:234f:b0:2a2:d2e7:1601 with SMTP id d9443c01a7336-2a2f283cb23mr304509475ad.48.1767214747617;
        Wed, 31 Dec 2025 12:59:07 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d77446sm339562955ad.93.2025.12.31.12.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 12:59:07 -0800 (PST)
Date: Thu, 1 Jan 2026 04:59:03 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] generic/108: fix test hand upon failure to create LV
Message-ID: <20251231205903.rrasjy7t3b42uhfc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <79202ac8855a232c678bb9bddabda8c1866bc400.1766387606.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79202ac8855a232c678bb9bddabda8c1866bc400.1766387606.git.ojaswin@linux.ibm.com>

On Mon, Dec 22, 2025 at 12:44:09PM +0530, Ojaswin Mujoo wrote:
> In case the lvcreate operation fails, we don't catch the error and
> proceed as usual. The test then tries to wait for the LV to come up
> but it never does, causing a hang.
> 
> Fix this by catching any errors while creating the LV.
> 
> Context for completeness:
> 
> This was noticed when we accidentally used CONFIG_SCSI_DEBUG=y instead
> of =m, causing it to create an 8MB SCSI debug device. This led to the
> lvcreate operation to fail with:
> 
>   Insufficient suitable allocatable extents for logical volume lv_108: 68 more required
> 
> However the test never caught this resulting in a hang.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/generic/108 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/108 b/tests/generic/108
> index 4f86ec94..308afe20 100755
> --- a/tests/generic/108
> +++ b/tests/generic/108
> @@ -60,7 +60,7 @@ $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
>  # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
>  # (like 2.02.95 in RHEL6) don't support --yes option
>  yes | $LVM_PROG lvcreate -i 2 -I 4m -L ${lvsize}m -n $lvname $vgname \
> -	>>$seqres.full 2>&1
> +	>>$seqres.full 2>&1 || _notrun "Failed to create LVM lv"

Hi,

Thanks for finding this issue. I think if the issue you hit is
"not big enough" SCSI debug device, we can _notrun after checking
the required device size. But if lvcreate fails, we'd better to
_fail the whole test directly, to help the tester notice that.

Thanks,
Zorro

>  _udev_wait /dev/mapper/$vgname-$lvname
>  
>  # _mkfs_dev exits the test on failure, this makes sure test lv is created by
> -- 
> 2.51.0
> 

