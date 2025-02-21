Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6BC70807
	for <fstests@vger.kernel.org>; Fri, 21 Feb 2025 06:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740120391; cv=none; b=ior/0JN33qOXk/Um9gkgrnsr9zs+9K7/qNTbGogu2ZzW2pRGyJyG3Tt+nQ9V5vOhFze1yeN0cfLtqqsW6+03JHnLJEXx+40tqKBZMmciHDDx/xFdKnezmItvgaANESCfWuYN0LbOSLFadZ3RPj+pouoXg/F6Y3kIkLtK0zpvDuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740120391; c=relaxed/simple;
	bh=2KJcc7fWLK7+m0j8ACI1u4txHBtC3FaKyqAEy8s7WE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWrqYqJFx/pdenBwzXghsT4GttfpGUDQ06DbbYeyX/s2Z0nQdJTjQ26JVZ/SC1uMOoIDFshwWRyRCxGRJOHBpOPwUiaM/RAJB+ilYmbz3h0rDNIq1kK2WfIk4rIdZyEyAUrtxZpfgx4/6wRKQ0bfIXjeFFphodAdLj71D9v1XWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AIsVqiRX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIsVqiRX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740120388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2CF9/nae4kxQG5WaCbwczqkTclTO8vuOg6rTmkGyfo=;
	b=AIsVqiRXqAfFdZLxIP8oIyGZ1HjrYDOfVOA1wkOWmozKXb0ZQ+2gZN0fWWXK7uvtCz41yL
	62NPSpHvIxqLONjyDGD3kVHQ20f/EVYesLBpIiDzCwEI1A2Ah8rlhF0QBMjMNSyvKcn1VK
	cDQ81aRMJxW6HJk8qRPlr5DDqMtb/FM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-SayDFpeNMF-QLytYac1pVw-1; Fri, 21 Feb 2025 01:46:27 -0500
X-MC-Unique: SayDFpeNMF-QLytYac1pVw-1
X-Mimecast-MFC-AGG-ID: SayDFpeNMF-QLytYac1pVw_1740120387
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22114b800f0so55449985ad.1
        for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 22:46:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740120386; x=1740725186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2CF9/nae4kxQG5WaCbwczqkTclTO8vuOg6rTmkGyfo=;
        b=QWYpplNcUUpiKXOUOKdACcci7QVE/swrrQHqraQC/XUjvZ/A4r5CoG/swO5MaXHcL4
         gv0sUlrmW7LmQZ7JnoyWYUSbCH3p4UMD8MGa3mlheHULIzBIYuDqT8tUBAtHnc/ySbHf
         FEFy1UPuiRDQg34Q7jplYv2brVkUn5m+C+GvICwkDJEvzeje2Y4/qqR27MrmIYiWstef
         xd0C/20OXx2OoFmIne+09tUpdqdlFIev7vnYhN/SzadI5oXy8q17rmWh7mOBDUIodxnr
         NzWWCQyZDtEcl63OCTvivgXyzoaXdNaQZsNCOT8r4NdaE5OQcZ3sBfi9cbve8nVmJlRn
         IKWg==
X-Gm-Message-State: AOJu0Yzj3H3Cg1KGlft9woMFQQ0Y8ZIz9jwZaOWaLoPACLYbq6McKvR9
	R7sEppARSoDZl/KiMWV31CLqUlaFoSr6lGU/U5MWlHm3u4BtOOz95uIOr7dcAkDatXpdHF7eCZ+
	k8fyv/ibbruSTvTDssSNmYw96tC1/67ZMhIb43/cdNrYiz1U+pZnF4OOcMh10zm/ZLg==
X-Gm-Gg: ASbGncso/yeqfcjBLCOQ/iZvWBze13pB04atPRV/cLtgpNGSMyPkJPXAa69dWsiUaSP
	e3kO6srEA/2VZrAg8/hSIPj3x3c5on8xgFDFMikQQESLsr7yvqlmO4Vp5fLGwh+riEhRzjaWd1L
	TwrNaB0sNv41KygZtNvhbuRsSKRUpbFu+OmnFvBNkvObflcJfYPFVyobov0ADtYJVhx5i44oJwb
	Ayt+1aTVA+V9+zRHyk4wlHLqJggFRBaA2HsoFRmIyOIrKVdczvF4kZKPE9B9cqQ5a21pz9f1yWc
	yGjYzM0BNWch7Szgo/FfhxtAj1nQiMeUHBwgPtXisR85y8eTkyhwj5WZ
X-Received: by 2002:a17:902:e84e:b0:215:853d:38 with SMTP id d9443c01a7336-2219ff60911mr33837255ad.25.1740120386331;
        Thu, 20 Feb 2025 22:46:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfmFektLYwJBrHOep/GUqEpXM8omWPowGl73omfLWq80HPBb7xayCFTzDOIgBQL8Jc64IFBQ==
X-Received: by 2002:a17:902:e84e:b0:215:853d:38 with SMTP id d9443c01a7336-2219ff60911mr33837055ad.25.1740120385972;
        Thu, 20 Feb 2025 22:46:25 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556f967sm129969795ad.162.2025.02.20.22.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:46:25 -0800 (PST)
Date: Fri, 21 Feb 2025 14:46:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH fstests v3] generic/126: run it inside its own
 subdirectory
Message-ID: <20250221064622.to3vscytxrix6ytt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250220-generic126-v3-1-03a061b6ed50@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220-generic126-v3-1-03a061b6ed50@kernel.org>

On Thu, Feb 20, 2025 at 06:26:38AM -0500, Jeff Layton wrote:
> I had been seeing some failures in generic/126 when running on NFS under
> kdevops. The problem turned out to be that kdevops makes the root of the
> NFS export mode 01777 by default (i.e. with the sticky bit set). This
> causes some of these permission tests to fail because the open() is
> called with the O_CREAT bit set.
> 
> Make the outcome of this test not depend on the permissions on
> $TEST_DIR. Create a new directory to do these tests in, and clean it up
> when done.
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v3:
> - Add comment explaining the weird setup
> - Move all of the cleanup into _cleanup()
> - rm -rf $testdir before doing mkdir
> - add call to _require_chmod helper
> - Link to v2: https://lore.kernel.org/r/20250219-generic126-v2-1-e7537f6c9607@kernel.org
> 
> Changes in v2:
> - add commands to _cleanup() to clean up test directory (Thanks Darrick!)
> - Link to v1: https://lore.kernel.org/r/20250219-generic126-v1-1-018e4e60c811@kernel.org
> ---
>  tests/generic/126 | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/126 b/tests/generic/126
> index 142d2bb97db706bafd2152856ef0993c5c273441..97b4a07344bd5d3d5e06b36831978c9ad314b9d7 100755
> --- a/tests/generic/126
> +++ b/tests/generic/126
> @@ -13,6 +13,7 @@ _begin_fstest perms auto quick
>  _cleanup()
>  {
>      cd /
> +    test -n "$testdir" && rm -rf "$testdir"
>  }
>  
>  # Import common functions.
> @@ -20,10 +21,22 @@ _cleanup()
>  
>  _require_test
>  _require_chown
> +_require_chmod
>  
>  QA_FS_PERMS=$here/src/fs_perms
>  
> -cd $TEST_DIR
> +#
> +# This test is testing filesystem permissions. If the sticky bit is set on
> +# the directory, that can affect the outcome. Create a new directory with
> +# known permissions in which to run this test.
> +#
> +testdir="$TEST_DIR/generic-126.$$"

I'll change the 126 to ${seq}, others good to me. Thanks!

Reviewed-by: Zorro Lang <zlang@redhat.com>


> +rm -rf $testdir
> +mkdir $testdir
> +chown 0:0 $testdir
> +chmod 0755 $testdir
> +cd $testdir
> +
>  cp $here/src/testx ./testx.file
>  
>  # file_perm owner_uid owner_gid tester_uid tester_gid perm_to_test expected_result pass=1
> @@ -46,7 +59,5 @@ $QA_FS_PERMS 200 99 99 200 99 w 1
>  $QA_FS_PERMS 040 99 99 99 500 r 1
>  $QA_FS_PERMS 400 99 99 200 99 r 1
>  
> -rm -f ./testx.file
> -
>  status=0
>  exit
> 
> ---
> base-commit: 8467552f09e1672a02712653b532a84bd46ea10e
> change-id: 20250219-generic126-f81b3022c4b7
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

