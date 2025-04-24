Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9141E8837
	for <fstests@vger.kernel.org>; Thu, 24 Apr 2025 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745477937; cv=none; b=fuViaUEwvclz46uZTPkBQdLXgec28zL1Dv69n7FJU5wBrec/4qSN6ci0WXerK5H4ojwIOAKzH+euhrn13kCywwRH9ed2KBQ3H3SsPyhkjSDUqEpVfi2hhgS5etE7q8S3PClxRVEIrddnJs5Edkllr6gyfE7nIFqzMstkC7WwYCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745477937; c=relaxed/simple;
	bh=Mq4h5ub5qX9UA3BolJ57kzejvX3WMUGaWovCnNJjzoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhJlFSqvaIqD1eOfZo5e6kSpariC5RFgZoH40WF6N0wADmAv4yzlI3++xV8WTvpZaVVBNga1If8a/ODh9NjU1cExTDtW9XRNf5OdcQPhAS9BSkOXVGNJAYZrOC5tpgL2CDGW+89thN/4djSc1I8hT9CezHkEK2RhoOgmVxvIYkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QF33ToMb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QF33ToMb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745477934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pUbFyXJ3kCaqhmWZjfD7lwtZD5fhxv6RKAeS3TktyW4=;
	b=QF33ToMbVRmElTvpCPP5rtaqI7iaAZYZK/6fRWfrMhOFPwZup8c3KLtOajvQzQfN1DEsQm
	+HYUNePWvt8JSYJmcvD7EUSJ1M6xmZxThWZDutddnSrzBiqCGkyApXBzLZuHBULORdfXCs
	l3WV6N/2D/pmbQ2BpHwdKA3USPxnRPA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-I6MXtNu9Nx2Tsg-TTFqXiA-1; Thu, 24 Apr 2025 02:58:50 -0400
X-MC-Unique: I6MXtNu9Nx2Tsg-TTFqXiA-1
X-Mimecast-MFC-AGG-ID: I6MXtNu9Nx2Tsg-TTFqXiA_1745477929
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22406ee0243so5151625ad.3
        for <fstests@vger.kernel.org>; Wed, 23 Apr 2025 23:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745477929; x=1746082729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUbFyXJ3kCaqhmWZjfD7lwtZD5fhxv6RKAeS3TktyW4=;
        b=IXzBX4kp1fey4y+Eq7mDsJEqTYRfV6TAQuQBHY+ny2LYegqQ9Y701sU0zXb386QZNx
         9SeMlrrQpfwR+esseqV4MDs8rfoKmPU7xf/C5lgS+MPpBqIqmFONZgjhkUohPMge8mHM
         ZbBwTc30V5SP7dwTWxVc0nyDoiU+ywcSmiw8WSWm2CU9UIPT9FLHHmmbRe2cuwdJYWpf
         OONxzgSlo3W05L25Iv7AUHIwho78Lic0xWDttU4uGfiWm7fEvLE3xWIE0Xxm3icLZmPS
         olGR8n5ssTq7jThk1ChZtRqlT9Jv05ch6xpBW6qHs7qRIkwShZrKl5w7/amWp9d+mfPk
         NL4g==
X-Forwarded-Encrypted: i=1; AJvYcCVVFZOj/GM53sohAWtFNuhRyVQIJ6qLJqohjSlAX/Mq/1S3P91Y8T9M5aEoTKWU+rUtgr1ObOLs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy514dm8pHEKE8f0tdMDTgo/39IQifjDh/R8fLvATQd/Nht1OaW
	v+1xrx+YlQw/YLeMIVnqWCmQOIqUD6lvdNxwEihoHjgDO4+JTkscVE4cwgtioUcsPPhzGfVU23+
	oxx+QHaayHsXl1yP9W0VhY/wd+ef4DaAm/cTQyrPUCUXJcyZpDlmz8uw=
X-Gm-Gg: ASbGncsDVto5bwXD/iLlx04RxgfPo4Qe6Vy3Abi79vElvCKK5VFDBQON83nIPAXOGYD
	MwDAKj61lkh+ZtDkzpVrwN+0IoE4DHEfOd5YRMofwkqU0zZYn358QQc0OlctPFf31RLWUxwFhR0
	MjKUQKwQ1ngpmWzpzMNkXcEXWCi4kBf7M2JnzPRX/3qjtjl8kvOrERsdvt2xKUAmuwbeb61E6gN
	lRihVSF7tOf8TvDtmj1sByKu8DldPOvGnek35M1ZiW99a3KnTprQvjIxdZ/aKgwSp/3rGboQpe2
	CtkW0qCp8Z36PiiYtpFitxLnY/3xyNmMFUfTev6igIGKmEQfP5+3
X-Received: by 2002:a17:902:c951:b0:223:64bb:f657 with SMTP id d9443c01a7336-22db3db4372mr19910975ad.46.1745477928920;
        Wed, 23 Apr 2025 23:58:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp4F3lJehLK6fNysSSu8+KMDZHOyBGyeEI5W28spywhS1ZzLpoUglQm3vpYzEwkGCtYfmMUQ==
X-Received: by 2002:a17:902:c951:b0:223:64bb:f657 with SMTP id d9443c01a7336-22db3db4372mr19910775ad.46.1745477928477;
        Wed, 23 Apr 2025 23:58:48 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221600sm5762725ad.213.2025.04.23.23.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 23:58:48 -0700 (PDT)
Date: Thu, 24 Apr 2025 14:58:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/315: fix golden output mismatch caused by
 newer util-linux
Message-ID: <20250424065844.zl63dwo6w5hsr2ob@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250424060608.251847-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424060608.251847-1-wqu@suse.com>

On Thu, Apr 24, 2025 at 03:36:08PM +0930, Qu Wenruo wrote:
> [BUG]
> With util-linux v2.41.0 and newer, test case btrfs/315 will fail like
> the following:
> 
> btrfs/315 1s ... - output mismatch (see /home/adam/xfstests-dev/results//btrfs/315.out.bad)
>     --- tests/btrfs/315.out	2025-04-24 15:31:28.684112371 +0930
>     +++ /home/adam/xfstests-dev/results//btrfs/315.out.bad	2025-04-24 15:31:31.854883557 +0930
>     @@ -1,7 +1,7 @@
>      QA output created by 315
>      ---- seed_device_must_fail ----
>      mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
>     -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
>     +mount: TEST_DIR/315/tempfsid_mnt: () failed: File exists.
>      ---- device_add_must_fail ----
>      wrote 9000/9000 bytes at offset 0
> 
> [CAUSE]
> 
> With util-linux v2.41.0, the mount failure error message changed to the following:
> 
>   mount: /mnt/test/315/tempfsid_mnt: fsconfig() failed: File exists.
> 
> Thus the existing filter only striped the "fsconfig" part, leaving the
> "()" without changing it to " system call".
> 
> [FIX]
> The existing filter on error message is doomed from day one.
> I'm fed up with the stupid catch-up game depending on util-linux, so
> let's just stripe everything between "mount" and " failed", just leaving
> the golden output to:
> 
>   mount failed: File exists.

Hi Qu,

Thanks for helping fstests works with lastest until-linux.

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/315     | 14 +++++++++-----
>  tests/btrfs/315.out |  2 +-
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/btrfs/315 b/tests/btrfs/315
> index e6589abe..9b5bc789 100755
> --- a/tests/btrfs/315
> +++ b/tests/btrfs/315
> @@ -30,9 +30,8 @@ tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
>  
>  _filter_mount_error()

I thought it's a common helper in common/filter, but I found it's a local
function of btrfs/315 with "_" prefix ... it's not recommended using "_"
prefix for a local function.

And there's a _filter_error_mount() in common/filter, could you help to
merge this _filter_mount_error function onto common/filter:_filter_error_mount,
then turn to use the common one? Then we don't need to maintain two different
functions to filter mount errors :)

Thanks,
Zorro

>  {
> -	# There are two different errors that occur at the output when
> -	# mounting fails; as shown below, pick out the common part. And,
> -	# remove the dmesg line.
> +	# There are different errors that occur at the output when
> +	# mounting fails:
>  
>  	# mount: <mnt-point>: mount(2) system call failed: File exists.
>  
> @@ -41,10 +40,15 @@ _filter_mount_error()
>  
>  	# For util-linux v2.4 and later:
>  	# mount: <mountpoint>: mount system call failed: File exists.
> +	#
> +	# For util-linux v2.41 and later:
> +	# mount: <mountpoint>: fsconfig() failed: File exists.
> +	#
> +	# Instead of playing the stupid catchup game, removed everything
> +	# between ":" and "failed:".
>  
>  	grep -v dmesg | _filter_test_dir | \
> -		sed -e "s/mount(2)\|fsconfig//g" \
> -		    -e "s/mount\( system call failed:\)/\1/"
> +		sed -e "s/: TEST_DIR\/315\/tempfsid_mnt: .* failed:/ failed:/g"
>  }
>  
>  seed_device_must_fail()
> diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
> index 3ea7a35a..fb493e90 100644
> --- a/tests/btrfs/315.out
> +++ b/tests/btrfs/315.out
> @@ -1,7 +1,7 @@
>  QA output created by 315
>  ---- seed_device_must_fail ----
>  mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
> -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
> +mount failed: File exists.
>  ---- device_add_must_fail ----
>  wrote 9000/9000 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -- 
> 2.49.0
> 
> 

