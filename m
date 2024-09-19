Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75713AF2
	for <fstests@vger.kernel.org>; Thu, 19 Sep 2024 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726747325; cv=none; b=O0VMIVfI8Ud4hRfKD3qqiTnjJm4YWzQyHLjcBs2UyLAr6yvG3E4la0KZYpiRV/YeZhV95pbBp+8S4HGBdEX4F4SRxmY7jLZk4p3coUOltolwqcJfX1zliC6sCYENMAjLwzDRV2JUzuoisChoNanT08DJH4wbcJ5ddEdh//ulaMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726747325; c=relaxed/simple;
	bh=/HHoEKHdOcrMQI5TPn2DJ3BeypKCWLjmv441TafBUSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxFSrwQx/7BcpX8M84Z/npJ42qPflgaglLNu5b8nvM03JGgY/M0jRPXxh6bbp3U/+RcOsJPscP2p+w+O9UIiGu4u3FRcL/r9KBMlPr9yWQpNTBfcgXYJmH5StYut+6YEy39fARPO9b27CPTd1d2hcI9D1t5WGLy69KhZcqhugjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T13lPfeM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T13lPfeM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726747322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/C7poWDIll3s8OZ1tWewIyLZAu/DSiBRHt93J84YF9U=;
	b=T13lPfeMPgLvMCh7qHXSU+OpRepfOtM9qnd6A5vYB+HKXku9yADKjygXR0Gxu3+OiVgWos
	Wv9rJk5LKDuLx7W4iGPxLjQEFThU740RJAzFXFym5rmcqEqCx/UIJIOo0MdD9yNWR9A1kf
	+cYXoMGM7T8OEEiycc2tBvE0aQtSxek=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-aEsSJGqoPsiiJ7Gl-OjQpg-1; Thu, 19 Sep 2024 08:02:01 -0400
X-MC-Unique: aEsSJGqoPsiiJ7Gl-OjQpg-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a08f88aeceso8512205ab.0
        for <fstests@vger.kernel.org>; Thu, 19 Sep 2024 05:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726747320; x=1727352120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/C7poWDIll3s8OZ1tWewIyLZAu/DSiBRHt93J84YF9U=;
        b=YxDWzN8JpMc6mfSODUyfj7GRQFtCSDIw5fxBgOvfTDR6CX2I0WwqZvrfFN+ADkE+Ys
         Lkfu1FT71vIpv/8KAfZFkgUrIWsQ4bNK6+YHNsQZZbAEB/Wg4UMyXj+EBBE2j7xlrD94
         7krpRZzwgXxZSQVqV1aP8emIRegfrRlxMMPqMyrK+wSb3K9hQu7bFzGIxZLqEgqY95Lv
         wpSquU1oa/R1kKeHtdSFTUBxnRfJ9AULRYZhu4LiQCuw6ACr5f1VoAFpm2bMslxnDwSA
         m0B9+vpjRtBZQV3pqIRgzbxcS4ojNz3fHIp/MddSnliGrgr1NV29iY7CRKevT4Olb6Pm
         kEkg==
X-Gm-Message-State: AOJu0Yx+kYwQZWQD7YvtHeDIS8Sr2JRLOZiRW4sEzif63J/ZNjG4e11d
	7b7lGbDVavtcQseqk8N00/pa0rtu9vP2zsdUo1QZldG3YPzAowGk2+53eRg/U4jUw6doUFmWd9y
	7K1FFZ1aWuCCj8yUWON9XZwq6wcQ6+SEkGnLY4D04PQ6H0siGDoAkKSeDvIaQhdeAjg==
X-Received: by 2002:a05:6e02:1946:b0:39d:351a:d0a2 with SMTP id e9e14a558f8ab-3a084975f6fmr215270245ab.25.1726747320547;
        Thu, 19 Sep 2024 05:02:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/qglomCPgA/ng9n2DRPlPK4L47oglNwGhpqNECZEkKTFOA7ApjmWl9upUpzCG0T56cQrRbw==
X-Received: by 2002:a05:6e02:1946:b0:39d:351a:d0a2 with SMTP id e9e14a558f8ab-3a084975f6fmr215269965ab.25.1726747320176;
        Thu, 19 Sep 2024 05:02:00 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498fb73bsm9159444a12.30.2024.09.19.05.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 05:01:59 -0700 (PDT)
Date: Thu, 19 Sep 2024 20:01:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: An Long <lan@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/315: update 315.out to adapt mount cmd
Message-ID: <20240919120156.apamqapyuytpf3ii@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <bb85eb7d443b2da482b6087d8946f0efafa15f87.camel@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb85eb7d443b2da482b6087d8946f0efafa15f87.camel@suse.com>

On Thu, Sep 19, 2024 at 01:07:53AM +0800, An Long wrote:
> Mount error info changed since util-linux v2.40
> (91ea38e libmount: report failed syscall name).
> So add "mount" before "system call failed".
> 
> Signed-off-by: An Long <lan@suse.com>
> ---
>  tests/btrfs/315.out | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
> index 3ea7a35a..a19ae8d5 100644
> --- a/tests/btrfs/315.out
> +++ b/tests/btrfs/315.out
> @@ -1,7 +1,7 @@
>  QA output created by 315
>  ---- seed_device_must_fail ----
>  mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-
> only.
> -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
> +mount: TEST_DIR/315/tempfsid_mnt: mount system call failed: File

This change will bring failure to downstream distro. Please refer to
_filter_error_mount (or other filters you like), add new filter to
it to help this test passed on old and new util-linux.

Thanks,
Zorro


> exists.
>  ---- device_add_must_fail ----
>  wrote 9000/9000 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -- 
> 2.43.0
> 
> 

