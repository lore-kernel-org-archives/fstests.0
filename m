Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06712196DA4
	for <fstests@vger.kernel.org>; Mon, 23 Sep 2024 13:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098221; cv=none; b=T9txJIOZCZAmx1KWbQmsfEn2S67SoUyD40aWay3eRVKZPrfirjVtdl7Psdw/XcfZSokVUGaNhNyKFeQzPuLvnTwGInRZWr41+qqfGNAEvEnzV7IDFIBHCDZ5XJlOzAFfdQPaY8dbDPXaKC0/9tO9ghM6VIzbCG5QY+eIiQUTmZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098221; c=relaxed/simple;
	bh=jlHg7C6osFR4OMf68Q0LoZCjJz2eDOJRWr26Zdry48o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvQSDCeNeTfkRcdke8JAxYRhS6qKw7VUwinNL1RbBc+4NpF+Av2iU4+gD7M1H7nbo/AOoNrMh8SwVwFKqn1f9NyT/46XsPVb5vsMlFJSBg3wiXZYyrX/rkKVE3QofWvbbgYiCjvnOmEygkcMrZR2CYA2VwP4bm4+Vznwu555Ung=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bC+xLcl8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bC+xLcl8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727098219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MoW3ECQhmKIKRtGGfW8NIg/GCv2sq72PchHA3Pte/6M=;
	b=bC+xLcl8notcsOXFNlZzaNM1tLPQIJfcdc1xqUa8aKXrIe9FWhufs3osXEsFdPtLIk5gFc
	c9FuQjJ+Ai5cQ0zCZIj10UQmqnz//6w/W+3sFAivtNamHRM3CGU3t3vrjCF1xpgmy+PPvy
	qdu21DzpHUG7df8efM53bpFRH3iPdcU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-GQxCz48YP5q5yUynanESKA-1; Mon, 23 Sep 2024 09:30:18 -0400
X-MC-Unique: GQxCz48YP5q5yUynanESKA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-718d6ad6105so7486785b3a.1
        for <fstests@vger.kernel.org>; Mon, 23 Sep 2024 06:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727098216; x=1727703016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoW3ECQhmKIKRtGGfW8NIg/GCv2sq72PchHA3Pte/6M=;
        b=iZiKLqe3pLwGjVeWbOLeIBlSYhfPhHy8WoqTcLKmgmQpOtFottGuphd8GmxjmXZ8rj
         yR37H2mtfY0x7NTSx1dGuX1g+GEYMBubbv8u1tOlVPLXKtQJ7xrqe7I2ZdnRDiWUomQK
         ggj2SRTkhR6gIPCub9kkh5GCaaMs0HBXwQzOVR4N/EA+iACuWGqIpQB3sNImUKpdpG49
         bufUXNKIowLLznBM9v9pwHSPLV0MHy5TziicUBkHsZtEkI2vlN7TJkoFMY7LdTX8X/WU
         NSMq9V9MzOnVFpBLcy37oBcq0UikQqYuXiBcJlWeNQ8DEmaawhQaa/dE3h7YC2l3KGms
         bdng==
X-Gm-Message-State: AOJu0YzdRwZ0IZu0W6N57NUoNeU+Cs0Rl93eomw+vajRNgn39O1fRPoS
	xWTmDR266jGM2341NbrwcXz5kqeDGwZdsD1VkhlwPwGi/fpCSWjmnsHZs1JkRsT1mcv2XXw+i1t
	3ttXlzUMu0haTXuNbPhg6iAePOdJcJlUn4dHeaNLTGfiii7gcru9b/dI=
X-Received: by 2002:a05:6a00:1702:b0:717:8f0d:ec37 with SMTP id d2e1a72fcca58-7199ca03e66mr16716089b3a.25.1727098215525;
        Mon, 23 Sep 2024 06:30:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErVRf6hr6pQAgmn7XFwNRwdykt6E6ZHAIbGQwgTdEo5blfg4/H8XTnVq4ucHrHY2fCOLTFgQ==
X-Received: by 2002:a05:6a00:1702:b0:717:8f0d:ec37 with SMTP id d2e1a72fcca58-7199ca03e66mr16716059b3a.25.1727098215170;
        Mon, 23 Sep 2024 06:30:15 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bc1554sm13871107b3a.185.2024.09.23.06.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 06:30:14 -0700 (PDT)
Date: Mon, 23 Sep 2024 21:30:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: An Long <lan@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs/315: update filter to match mount cmd
Message-ID: <20240923133011.cmv63zpd3yg37yw2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <29dc7fdf9dd8cfb05ece7d5eb07858529517022f.camel@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29dc7fdf9dd8cfb05ece7d5eb07858529517022f.camel@suse.com>

On Mon, Sep 23, 2024 at 03:57:13PM +0800, An Long wrote:
> Mount error info changed since util-linux v2.40
> (91ea38e libmount: report failed syscall name).
> So update _filter_mount_error() to match it.
> 
> Signed-off-by: An Long <lan@suse.com>
> ---
>  tests/btrfs/315 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/315 b/tests/btrfs/315
> index 5852afad..5101a9a3 100755
> --- a/tests/btrfs/315
> +++ b/tests/btrfs/315
> @@ -39,7 +39,11 @@ _filter_mount_error()
>         # mount: <mnt-point>: fsconfig system call failed: File exists.
>         # dmesg(1) may have more information after failed mount system
> call.
> 
> -       grep -v dmesg | _filter_test_dir | sed -e
> "s/mount(2)\|fsconfig//g"
> +       # For util-linux v2.4 and later:
> +       # mount: <mountpoint>: mount system call failed: File exists.
> +
> +       grep -v dmesg | _filter_test_dir | sed -e
> "s/mount(2)\|fsconfig//g" | \
> +        sed -E "s/mount( system call failed:)/\1/"

Oh, there's a local _filter_mount_error() in btrfs/315. I thought you can
change the common helper _filter_error_mount() in common/filter. So maybe
you can merge this _filter_mount_error into that common helper in another
patch, then other test cases can use it.

Thanks,
Zorro


>  }
> 
>  seed_device_must_fail()
> -- 
> 2.43.0
> 
> 

