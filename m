Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C2926A095
	for <fstests@vger.kernel.org>; Wed, 26 Feb 2025 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567487; cv=none; b=hl75A2HPch2XeNkEvf9XFE6sDRJ5/4vqtEyOSpN8tElaGoloKSvAv+fwlFLg9K8XW8o8m3Z5NZS9HM9pS0FuX70n5EBCWijnOGt7xj6oMIx2aQZhS/RrJWNXYrUugEZarf7EqCvtNGj9MqoUGKIsZUxL7FRcA32dNAFFJXpto1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567487; c=relaxed/simple;
	bh=G2biezqhv1eZZsdXJv8Xm5Af2wF2UZ+UoXc93NcOoSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNJZ5CLiEDoGps5Yzqhq4PIwCLjARIDt5hV2YZX5Bk7jBD31I9jTWu4/eOGFxoUe5z0rNVJQPNdOtMVrqUJKO4uG/MGD6ws+eN/6pDLLY53z8BWJIPdENNzJr4UeoJmgQYT20LhhzT6cQq5n0PvQIbLxRD5CJRyj0EoRlH9MgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WE3PedTJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WE3PedTJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740567484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pY87gcAdkmuZHjWFXkgzhswKq8QhMcQw3yqhQuIFtCw=;
	b=WE3PedTJdSmNu7AMI/a93IsIHX1hY2N4JWsRpOnz0rZbA9bx1lXCJgMRiAvojUntzZ+1Gz
	gSA0+KxXUWxchgx4winkt9uy3Ro6UIKuFuu6ZtjSl31+ZsJ3f3iNsU7D1KOl/XJ9gLkhtY
	unqB/PpJUNXLOJGNkIxOFxV9QMZqGuI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-xgBi-LxhN5-qlyX361-6hQ-1; Wed, 26 Feb 2025 05:58:03 -0500
X-MC-Unique: xgBi-LxhN5-qlyX361-6hQ-1
X-Mimecast-MFC-AGG-ID: xgBi-LxhN5-qlyX361-6hQ_1740567482
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fe8c697ec3so534862a91.1
        for <fstests@vger.kernel.org>; Wed, 26 Feb 2025 02:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740567482; x=1741172282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pY87gcAdkmuZHjWFXkgzhswKq8QhMcQw3yqhQuIFtCw=;
        b=DEsRPZL+/jl+5Xth4XgA+xjN+cB83C1YR1o2LF9gjAbSygWN5NMs59wRYsqvot7IvX
         bXlZ2aMGt2i8KqnPVz99deqvzYpvzpahAqJ0rpJEHUPgqz+SatHpq7g3VB8nY+jUOWAo
         /VKSRhMj6YejMk/NiXKHb46VTG/ttQz9itzZEcTJCdfYQiuACao5xm+NiZvQq1Jrl+Ca
         9dE567xAKtb+ItguwipFJi0MRrs58sdTFu39+jk0xVn0+tvA8VorbKkSP0jA0zis15Oh
         sQHJsC/nUsL8RKbr9hwKe1BjYB01UJHb8Dj30QeezIh0YsN2rTqcDWCeOj+0Sdgef2vr
         7lPw==
X-Forwarded-Encrypted: i=1; AJvYcCVFcIDYspFMaUyxZ/QZp5JbzyS5+Z58KlcJ7LDy+/WyE6EMvuxSglnwZraEc9O9l2H87w6/F0Ku@vger.kernel.org
X-Gm-Message-State: AOJu0YxONKehwNILDbTkHI5UDiBF0NKq2DOjCG3P8rwrBZeYhCg0Wvai
	tobyv9gNsbXSwLJm2A3YTKnH20gwZdotBTpndB54rYIP5qfl6PAafdgRQYoDo6lZPueefwKKzT6
	hlz9MnYVZA4hSnUkGd4Fo3CCPkDUJsbkM+h+P7wasPNVOCnlWT+XRJpc=
X-Gm-Gg: ASbGnct9qweeEINTHqf1QH1zw2lZvuilksPOQVvqeOQUZT9dEHHYaHInKmoe9A79N/M
	9O/kfbdbeJ7fGs/PwoeNw8v6UgQ8OQIFleVMuQrHBPz+yuGwbYoLni7ATKghwV0wwpnW16EMZeR
	ADEFIkbCEz9awMpombGEjiE3+kgYqghtSyq2req9qwWVmM/TqGdwziHymRiJ52Sj/TpP4zP2ML+
	O4/H8QhlLXshtbZkKzMqHqMwifO7dlCTg3vLNOsz8WzObMUNJ+OFOSnvqV1VPl4zyGWMyz2NzBI
	T7HW0vDhMjbU4y6/d3+M/5eovP0N29A264aQyTCdB68sx0FjliQCaAfj
X-Received: by 2002:a05:6a00:991:b0:732:6276:b46c with SMTP id d2e1a72fcca58-73425a1fab8mr35209066b3a.0.1740567482160;
        Wed, 26 Feb 2025 02:58:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8VRVWTQwXKNKiLHB4lWvRBpLVdNibQPuotxtwn11M5p+HJhPcfBc67In/gPw9ufZXIcBLQA==
X-Received: by 2002:a05:6a00:991:b0:732:6276:b46c with SMTP id d2e1a72fcca58-73425a1fab8mr35209034b3a.0.1740567481786;
        Wed, 26 Feb 2025 02:58:01 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a839ed8sm3231334b3a.175.2025.02.26.02.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 02:58:01 -0800 (PST)
Date: Wed, 26 Feb 2025 18:57:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	"Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH] generic: test zero-byte writes to new file
Message-ID: <20250226105757.i2ltr4aq5lh3jllv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <b4d76883-e58b-4db3-b7e4-7ddeb5ec7f42@redhat.com>
 <30dfe4a2d18ec2ca29d303c1f8fc943688221d59.camel@gmail.com>
 <20250221164751.GY21799@frogsfrogsfrogs>
 <58b204a2-4cf8-4110-8ac0-4543e1c4798d@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58b204a2-4cf8-4110-8ac0-4543e1c4798d@redhat.com>

On Tue, Feb 25, 2025 at 04:29:29PM -0600, Eric Sandeen wrote:
> On 2/21/25 8:47 AM, Darrick J. Wong wrote:
> > On Fri, Feb 21, 2025 at 10:44:09AM +0530, Nirjhar Roy (IBM) wrote:
> >> On Thu, 2025-02-13 at 12:06 -0600, Eric Sandeen wrote:
> >>> A bug was recently fixed in exfat where attempting to do a zero-byte
> >>> write would yield -EFAULT; test for that here.
> >>>
> >>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> >>> ---
> >>>
> >>> diff --git a/tests/generic/761 b/tests/generic/761
> >>> new file mode 100755
> >>> index 00000000..e933eb83
> >>> --- /dev/null
> >>> +++ b/tests/generic/761
> >>> @@ -0,0 +1,28 @@
> >>> +#! /bin/bash
> >>> +# SPDX-License-Identifier: GPL-2.0
> >>> +# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
> >>> +#
> >>> +# FS QA Test 761
> >>> +#
> >>> +# test zero-byte writes
> >>> +#
> >>> +# exfat had a regression where a zero-byte write to a file would
> >>> +# yield -EfAULT. Should work on all filesystems - write should
> >>> +# succeed and the zero-byte file should be created.
> >>> +#
> >>> +. ./common/preamble
> >>> +_begin_fstest auto quick
> >>> +
> >>> +[ "$FSTYP" = "exfat" ] && _fixed_by_kernel_commit dda0407a2026 \
> >>> +	"exfat: short-circuit zero-byte writes in
> >>> exfat_file_write_iter"
> >>> +
> >>> +# Modify as appropriate.
> >>> +_require_test
> >>> +
> >>> +rm -f $TEST_DIR/testfile.$seq
> >>> +$XFS_IO_PROG -f -c "pwrite 0 0" $TEST_DIR/testfile.$seq
> >>> +test -f $TEST_DIR/testfile.$seq || _fail "file not created"
> >> Minor: Maybe just remove the test file that is created above (since we
> >> are using the TEST_DIR)and not leave any test artifacts? Or, maybe use
> >> the scratch device? 
> > 
> > Agreed, the _cleanup should remove the testfile.
> 
> ok. I thought we left stuff lying around to age test, but I'll do whatever
> folks like to get this one-liner test merged :) 

Actually there's not a rule about "must remove the file your create in TEST_DIR".
And I remember the TEST_DIR was designed to keep some random files. So from my
side, if the file size isn't too large, I'm good to keep it in TEST_DIR :)

Thanks,
Zorro

> 
> -Eric
> 
> 

