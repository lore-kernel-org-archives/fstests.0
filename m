Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324D371D04
	for <fstests@vger.kernel.org>; Tue, 31 Mar 2026 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986779; cv=none; b=VMOWxZVuqsJDGm8ntXqY822Vth+4bPU/+i9aJexmhqW9IPP+UeLm7cg4wVUZcKE+VM3ApMk672BhB/EV07BoRxuVx2lKQD1ZF7qh3O7AfU4w9tj2g87P7O3sIMOhao9rvRWBZI2B5sAw+X4YpGPaHmCVtBPknZG8s30QCPM5HSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986779; c=relaxed/simple;
	bh=oiEpSDD7kwePKlVOFoqSMUAtgM/+g6KOY4ZSd75maIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koLfMIg3DMCVdtar9bJH42eIADf3CIsDTIFUF9i5S+BIgT+Aykr/7b5x+Pu6dim4egw52UJ7pn2asH0T3riL2gk4mJs0jTa+B5fSTlQBCHiPrmW6BpJ8/rjTYlt5lUzbEVRqiW2xQAJhUr3MUCLdkuHXpSmhens7oIcPcAy+N/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h98on62A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KagnrwS6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h98on62A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KagnrwS6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774986777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zVZ3mHm+bENq3OEzNEjYRq3pU/GNx975paKJWKtsk7M=;
	b=h98on62App+oQVwqE3rp22ef44isoayuBEIvYyQcsmlYFH+CdvHybDORIemC07Z2Y7y5Lu
	jIVT0Sf0CG0m3Y6h71DcnyrYwtOPSp+NX2DQI0EmbuyMrhurV6xNqnM0hU+nNOiAR6oSup
	Kpacx7KFQIZBMS69a6SidE/YEfxa0vg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-QuNrqMZDOV6cYz1ivmG5TA-1; Tue, 31 Mar 2026 15:52:54 -0400
X-MC-Unique: QuNrqMZDOV6cYz1ivmG5TA-1
X-Mimecast-MFC-AGG-ID: QuNrqMZDOV6cYz1ivmG5TA_1774986773
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b24611696eso24277075ad.3
        for <fstests@vger.kernel.org>; Tue, 31 Mar 2026 12:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774986773; x=1775591573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zVZ3mHm+bENq3OEzNEjYRq3pU/GNx975paKJWKtsk7M=;
        b=KagnrwS6sAfDYSi0qkLfCC6fBTRjKB7+9TkfdGOqdsXsb/mHjWdfawDOESutQVe7wH
         RthXLFpJeQyL89qo8h7/9lF/6QHVEk/Yb/gTch8WnVQSuLVqHLGsGeQio4v1lLNcev6s
         LFboRbr/S2dvVlaUikcp+VIsuKOsf+TUPiiiAPFp8iitXUBjmd1FBXrnVBdpUAYU78X3
         e3dQt94GRQ+Gurqm6MuV8Mqvni3fssc5VpqaL7L6HB6zJpxi+4asozMn98yKo1fquzHx
         d5xhAMNIl3kg82+HW60Xw4MPAcU9gra3o7MDfy+PAJraZXkTKYEeiBll0Lpi0kQfuH3t
         u+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986773; x=1775591573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVZ3mHm+bENq3OEzNEjYRq3pU/GNx975paKJWKtsk7M=;
        b=QEGz2wOq5klu90KGk6e2gA0MAITJ3rBvZ2ixjHxMIztD1yCkFqsDguO4wFMygyCNNd
         HxegS0t3usUu6F5wI4mRkz0UC9yB8cQAHxG6lJhA5qYCmF8e+AHmIv3nud8zQLPSDtoT
         iJ18Vx5z3RsMhk2OnOcCTgmqNqx6NFdGH8eHpRjqtaKMZh+YMtvMdNa58rXPH7MgKeUh
         LmtOQjYkOBBu3GP6RjV4vMrmWOnSTAzR7Tej/BmwVaa636HJXw1e8YbkwjFWovR7yLDG
         Azv8Ml5jpYgtM7cqnMaQBkDWB8WlCa3R4Bd7anXlDTrKF8PrYt7gXvrOBYML7FC6UfZv
         lG5w==
X-Gm-Message-State: AOJu0YzJQOE3Q5kg5HV78fhyZs1MjC5xyP/0b7q0aK6iLpTqT5QPGf5O
	VzTIEa6u/t58nMXhI2rQo4qNSLLGEPz9mMOwKw32SlFjyXVMdhhxEyMvHuOahciXwyKeGYgGKI8
	wqhYu36FHGTKKr5pO6/mshhPBnDUAbj0YnR5RgIaKk5w3su9cbcRGFYJvRP4=
X-Gm-Gg: ATEYQzz399c21QXMVrW61FnstAbgjxTnDZXrKuHVlVi5TDWhxI57wwEyY4tfJvSMOAu
	zvl8xyU1TTNP1VGGu5jY4LHmS85Mfa3zu7/L8vMQqgfimeGaZQ/h2etAKA+QJCbPhU0XJfzdvST
	3pUQw9KL2btYMSmdR5mfEIiuhAc3lcsoFuXofWBwnDcoSenU3yNqmWkbUjWGNNCDHZOfer9rXBM
	MhaFXH4MphqwI1kG4vlkQQAWMuImDvhKXvECYvYK1KY5B6IuF78DeQQPNbrDmAOo80dep1FsXdN
	qrRPBwXYNOtqhcsjy/EYsG6vrDVafzXJ2v4JPXx0udWXz/OoxRSV3kPUEdLlYNMjmQgIGyVykYa
	B5nyJG7s4DifsRLUgjQ==
X-Received: by 2002:a17:903:3bac:b0:2b0:60b2:4f8 with SMTP id d9443c01a7336-2b269acfd91mr5049665ad.15.1774986772910;
        Tue, 31 Mar 2026 12:52:52 -0700 (PDT)
X-Received: by 2002:a17:903:3bac:b0:2b0:60b2:4f8 with SMTP id d9443c01a7336-2b269acfd91mr5049495ad.15.1774986772413;
        Tue, 31 Mar 2026 12:52:52 -0700 (PDT)
Received: from doltdoltdolt ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c5f5bsm125504325ad.82.2026.03.31.12.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 12:52:51 -0700 (PDT)
Date: Wed, 1 Apr 2026 03:52:47 +0800
From: Zorro Lang <zlang@redhat.com>
To: Disha Goel <disgoel@linux.ibm.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org
Subject: Re: [PATCH v2] generic/730: skip test if DAX mount option is enabled
Message-ID: <20260331195247.eatly5rnwlxgxk5y@doltdoltdolt>
References: <20260323124006.85176-1-disgoel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323124006.85176-1-disgoel@linux.ibm.com>

On Mon, Mar 23, 2026 at 06:10:05PM +0530, Disha Goel wrote:
> The generic/730 test utilizes the scsi_debug driver to create a
> synthetic SCSI block device. Since scsi_debug does not support
> DAX capabilities, attempting to mount it with "-o dax" results
> in failures (specifically on ext4).
> 
> Since this test is not DAX-related, exclude it when DAX is
> specified in MOUNT_OPTIONS to avoid compatibility issues with
> scsi_debug.
> 
> Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
> ---
> Changelog v1 -> v2:
> Use _exclude_scratch_mount_option instead of an ext4-specific check.

This version is good to me, although g/730 doesn't have _require_scratch :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Link to v1:
> https://lore.kernel.org/all/20260318081812.47870-1-disgoel@linux.ibm.com/
> ---
>  tests/generic/730 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/730 b/tests/generic/730
> index 6b5d3196..47073f42 100755
> --- a/tests/generic/730
> +++ b/tests/generic/730
> @@ -19,7 +19,7 @@ _cleanup()
>  
>  . ./common/filter
>  . ./common/scsi_debug
> -
> +_exclude_scratch_mount_option "dax"
>  
>  # We don't actually use the test device, but we need a block based fs
>  _require_test
> -- 
> 2.45.1
> 
> 

