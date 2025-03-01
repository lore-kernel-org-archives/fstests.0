Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C19A936
	for <fstests@vger.kernel.org>; Sat,  1 Mar 2025 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740838786; cv=none; b=EE6E3Z0ZX4cSfER3GAyGX1cV+5y+bl9qKBpkvlXyyIKCqDqy5vpTVEzIaZRIBYV8JocHTHoalfffJURucw7uXfK0QTcDeSiqRHTNYW2Ombufg5osp26pvp1QYyONaQDV/CNlIVKlyLgCQesLLZ8FZuJhQJfCNMzackEDCpSI9y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740838786; c=relaxed/simple;
	bh=oLplx3b2fnlsEVdv45CymDentpiy4mDXKRVlgui7Z4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is72OlDjHfB2C2rk3PRzjLwciRyBis6LCSDPo+VOukKGBL3zmrLouJQbjhYv6bWh+hAuzYmO5yhJun75hQquO7i/yGN9g6rhI0j6/3kuCfD5vn4lJ1U3aizSnm4abCx7+RaASj6KL8IW6VaNNWBzA8FMIcxEcjDzt2hk59fGpis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNGvnK8N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNGvnK8N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740838783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uTUzT80pZj8f+tZw97eAHCD9PeVU/7cR+jtvp7u2tbk=;
	b=KNGvnK8N45EFU87vmjcAZe7j1uPJ9E0nhtzmpPxJnEc018ZGR4pijO4pOYUQHN2MgFG9ZW
	ZUXhA7rgbBqPINRUpiIo61seN/POLfwuFe1ZGJAd8t7UR3ASJJkc68DHZPQGBVMFAUEdna
	OLYM2QJ2+3829R3pcBfe5VqZJIGCg+8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-bA6wgkdBP-6gIOTTuid6NA-1; Sat, 01 Mar 2025 09:19:42 -0500
X-MC-Unique: bA6wgkdBP-6gIOTTuid6NA-1
X-Mimecast-MFC-AGG-ID: bA6wgkdBP-6gIOTTuid6NA_1740838781
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22379c2e96aso33263135ad.1
        for <fstests@vger.kernel.org>; Sat, 01 Mar 2025 06:19:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740838781; x=1741443581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTUzT80pZj8f+tZw97eAHCD9PeVU/7cR+jtvp7u2tbk=;
        b=XSJ5LD9mw5mPBpQguoAEF2ZRgKalgBn0s6YKItI2ZuM6YjCZgPxnZmy2NTMeQgFpm7
         MDGTcBHGlX9CzYlY/VWS/x5qxm1kPZsXrFuoeYAxh3YFBoR1X3ZdhoQ5vEQbdg5oIEHf
         mKlmh5EBahQq9Pzy+eZfCveKkF0AIF7YqQy9BVwdL8lrUTjYSSuOUMcn5dnL5tXAONmc
         X2rh5fMwevlaa4RzIxQPt5CvgPgkHSDIIz761VG0wc26DUJhnh8PUfz0+9EVO6X3JQw0
         s3Q8g4IUkcSKJEfrO5QWaO9xsEUFYaigROH+pDxb05GW+3kGheOVYKuP8OtvyC7DrKok
         wlAg==
X-Gm-Message-State: AOJu0YzHcTDUk0MjHzT2PGXqCrtIZ1lV80p/lwcUwVIsh69TgC3LrqXN
	LY4hWRBcic9W+qOt6wnEtcM+O5LAAwd9nbmJj7Oq0+O3kV47eo6hLAFOamyVTxQJBfVIx/rhO5K
	FZIltaguqH0PDURqtPWTIkbq0dCE7uoHeCeCIxDroRy7t9qxWxuKSmIkEl5R/OdoUbg==
X-Gm-Gg: ASbGncvNS3bm7t6zuss0T1eU3AI+Qb/UuqFXbTx1BLTzDj8Bz4duPacTNqzZw5ntzi/
	B4g1i33fsBS7rv+0igWuTEsiCn4dCO9Nre1ADOjiTh5P7x5dqT3uwUAGZI3OlBDqkkIOA5MCAHy
	GQb3AxqZNW+pPmcB1SRPuR/Zll0JybJ7e5a65R97Jc9ypG5QwjQ/gN0YQiPWy2XTdxjFETztIux
	aCSBurum7zCYEd1BhZMlRlNA/ML7OzNajEM0VE7OOfy770fBhE0B9MuEp/XAdBJ/0TBhqSt3jRE
	lrddMxu6TVAtz1JjEmtY5F8kvPCqMjC2FEJhGhuAQ/pE+gnackhw//DZ
X-Received: by 2002:aa7:8888:0:b0:730:8d0c:1066 with SMTP id d2e1a72fcca58-734ac400635mr13778991b3a.24.1740838780874;
        Sat, 01 Mar 2025 06:19:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRwmXoDwhIvalYbUy/k+7aZQzzmEFNiO0vg+kRWGFnQIROd27C8roBYR8KkPHMkVMgU9IeSQ==
X-Received: by 2002:aa7:8888:0:b0:730:8d0c:1066 with SMTP id d2e1a72fcca58-734ac400635mr13778971b3a.24.1740838780595;
        Sat, 01 Mar 2025 06:19:40 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe2a640sm5780845b3a.16.2025.03.01.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 06:19:40 -0800 (PST)
Date: Sat, 1 Mar 2025 22:19:36 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH V2] generic: test zero-byte writes to file
Message-ID: <20250301141936.4jm5n34blmt6iclv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <3bd585ba-fe21-4f93-802a-f32f9e0f1c61@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bd585ba-fe21-4f93-802a-f32f9e0f1c61@redhat.com>

On Fri, Feb 28, 2025 at 09:13:19AM -0600, Eric Sandeen wrote:
> A bug was recently fixed in exfat where attempting to do a zero-byte
> write would yield -EFAULT; test for that here.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> V2: remove the test that file exists, fix .out file and filter xfs_io
> 
> Zorro - If there is more debate over whether or not the file should be
> removed at the end of the test, please feel free to fix it up to
> whatever makes the most people happy. ;)

Sure Eric, thanks!

> 
> diff --git a/tests/generic/762 b/tests/generic/762
> new file mode 100755
> index 00000000..25eb88b9
> --- /dev/null
> +++ b/tests/generic/762
> @@ -0,0 +1,29 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 762
> +#
> +# test zero-byte writes
> +#
> +# exfat had a regression where a zero-byte write to a file would
> +# yield -EfAULT. Should work on all filesystems - write should
> +# succeed.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +# Import common functions.
> +. ./common/filter
> +
> +[ "$FSTYP" = "exfat" ] && _fixed_by_kernel_commit dda0407a2026 \
> +	"exfat: short-circuit zero-byte writes in exfat_file_write_iter"
> +
> +# Modify as appropriate.

I'll remove this comment ^^ when I merge it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +_require_test
> +
> +$XFS_IO_PROG -f -c "pwrite 0 0" $TEST_DIR/testfile.$seq 2>&1 | _filter_xfs_io
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/762.out b/tests/generic/762.out
> new file mode 100644
> index 00000000..918f5455
> --- /dev/null
> +++ b/tests/generic/762.out
> @@ -0,0 +1,3 @@
> +QA output created by 762
> +wrote 0/0 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> 
> 

