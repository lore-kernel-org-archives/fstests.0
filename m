Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C712F8615A
	for <fstests@vger.kernel.org>; Tue, 11 Feb 2025 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739246813; cv=none; b=BrU+O4fFwN22iJyl1qUhuKwBWbJmL+QE8tPf1k/YtboDZQ+n5fvrK6tXHWoFvtDghetySWvEMH+SZo5GKYezmdQbp5Mo7X83nOndVqcZekpYQyP09rQw8R5jfyXN5qZxSJ2cFxgXkDaj8e4WWLOdP+qQAp8Sy5+PCZeWhQE+ZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739246813; c=relaxed/simple;
	bh=SFwBpriK6aKH76/suGo9jiL8C38OSxxV9ZD2Dh2uFn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2FJ3XRMtAPmkfyeOzbvfTRX7BqyBcvphezzbGtt4VVAVBeK/cfrjX5rlSEU9SQYD6gtoiUy6bGUmXXy1vWoGPuzmMUqskuHrkFGF2ryIfbr12CF2evsIja+BS8fVCHsJ7Cbxky7n93Qa8utscEs0Z7CrxxYS2TSGOdB2h0SQb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOMKgrEw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOMKgrEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739246810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i8K2ET0rMMayMt4C4OL5IaPRn+ANOFbJuWCLFSQnXZM=;
	b=HOMKgrEwgVykamJJdUtCsdDC+DuVXyCc8S6kdhvYTFdPnIIKePxTeMAom5oS3aS2szqRVz
	4aELWKbhznr53x+NllNiWGsMDDzKVAHC18L5ZA0PDK/djqHXFC5O1huJfH6CBECLbgj+qB
	ZPbYBFQeiTvY8bKGsnVQwas/RNC9zrE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-V_3BUNLuM8OS18QikEprcg-1; Mon, 10 Feb 2025 23:06:49 -0500
X-MC-Unique: V_3BUNLuM8OS18QikEprcg-1
X-Mimecast-MFC-AGG-ID: V_3BUNLuM8OS18QikEprcg
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f5538a2356so10918795a91.2
        for <fstests@vger.kernel.org>; Mon, 10 Feb 2025 20:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739246808; x=1739851608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8K2ET0rMMayMt4C4OL5IaPRn+ANOFbJuWCLFSQnXZM=;
        b=K0QJ5HU0zbLIcGtUJRBwQzKT9fwt/+7cbaeEoMe894dy3gvWjfPq2mQgySdjSGRz2K
         gqmMTiSMPADY+PR9+t+NRrAizbNmvjSjrRF0nM0ymaYocinmeqpyv3bNSwZmgTTtojpQ
         tQ7M6U/MqnpuO7mhlfpqH3X/ztieiloYvBnc0SSvZoTxOpHeLODLC/5zjIZLYYr3qerk
         Tmje42TJPzTXrRVEg3hkK1JfRXCrnLd4A2jY2eAuQyBOqG4lk7EwG8XVUXaNqWEJTEDj
         3HUySA3V2Os1FN69EqJ2eWxhcMXVTl0lXOTdHGjPtvZxWZRvI9EoV+EC30ANvYG3yucw
         qSAQ==
X-Gm-Message-State: AOJu0YxjmN116FzHiV42JnnRhfAFsDfRElXQ36UnFu/yycgVMB68kMkG
	+MKPIbYw3tEKt1HrriG6Fowu1iRdfxlrjzwK0e6AWK/TnkG68S+dQ8ihcPtrfMCTlK/JdFkNDbr
	2n02ad2bhrFAE65wvMfBkgQUZbGUyMHEhuwhn8Ztg0YcZDE2sd39gQwQ=
X-Gm-Gg: ASbGncu4wiK1//nknooi6UQ8UGnc+Q1MHUcZ7KzoVSNX6vP2/MRMb7pxtwwgcEcKhoy
	CNHRBpnFx2/BDCQLf/FsBzz8Vj9m7IZaZpqkWkvHLDvs1XhFDhLy0uJEnH8IUhbmUhVjh+N68yu
	Wl583iozKyAtJklw/AUZEo3Laqu6IC+PSaKTxiq5KkQkNlpfHncH8ZtM2i3ZTic9BsxkkwEyuq0
	t2eg2dlZJxvbzo6ViX52k6iAJ85ey7HxqOfGwkLtmivWsUx5R5Sp3k/NT1tLsMCUIuWOuIz3yhZ
	InIcVD+nuvEoeuRVqN0z2DM8OAN3em/eJgEka/mjNo6CPw==
X-Received: by 2002:a05:6a21:3a8d:b0:1e1:e2d9:3f31 with SMTP id adf61e73a8af0-1ee03a3d164mr26182864637.16.1739246808100;
        Mon, 10 Feb 2025 20:06:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXY4fefQ+Fei+tDRglsHR2l5WFDIfLtSWy/49QLIRJBvM1w1MvRypx1wNj+S5LzmwEgxFCxg==
X-Received: by 2002:a05:6a21:3a8d:b0:1e1:e2d9:3f31 with SMTP id adf61e73a8af0-1ee03a3d164mr26182844637.16.1739246807809;
        Mon, 10 Feb 2025 20:06:47 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf1421sm8603567b3a.101.2025.02.10.20.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 20:06:47 -0800 (PST)
Date: Tue, 11 Feb 2025 12:06:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>,
	linux-fscrypt@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Gaurav Kashyap <quic_gaurkash@quicinc.com>
Subject: Re: [xfstests PATCH] fscrypt-crypt-util: fix KDF contexts for SM8650
Message-ID: <20250211040643.jjpssyx6n76rwxfb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250118072336.605023-1-ebiggers@kernel.org>
 <20250210204039.GB348261@sol.localdomain>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210204039.GB348261@sol.localdomain>

On Mon, Feb 10, 2025 at 12:40:39PM -0800, Eric Biggers wrote:
> On Fri, Jan 17, 2025 at 11:23:36PM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Update the KDF contexts to match those actually used on SM8650.  This
> > turns out to be needed for the hardware-wrapped key tests generic/368
> > and generic/369 to pass on the SM8650 HDK (now that I have one to
> > actually test it).  Apparently the contexts changed between the
> > prototype version I tested a couple years ago and the final version.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  src/fscrypt-crypt-util.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Ping.  Zorro, could you apply this please?  Thanks!

Sure Eric. I don't have a hardware to give it a test, but other cases which
use fscrypt-crypt-util test passed. And I trust you much on this change, so

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> - Eric
> 

