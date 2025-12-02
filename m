Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C26B1DFDB8
	for <fstests@vger.kernel.org>; Tue,  2 Dec 2025 05:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764652073; cv=none; b=nRxB3sUo+C5+F4xPF7Q5E/noisP6Onl0uKm5jILRQECuhKSNk3oL3fVl9dnuW7s0NS74rztCp7jE7KBUgyJwL4+4Tdok4TVtafm51MLEAKwFQ105UI/uezYRJD5+zoJ1dQ1xc5j4R0sWa7D+KyhoZS7tJ7e7aKtiRKN6sx4mpMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764652073; c=relaxed/simple;
	bh=vDML9m+UxaGF5r1IhyFPtHXB15YBXn2gcIq2UL1CYfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsjZPp/16jt4vD3FbEL6NQboWsy47m1/HWSHLVO3DYnVw6F7rTzDwlpadytlKAHXoNccdCD2rcFOMCyMpdc2sz6Wo+mzr8nDVdwhtb9DuWEotAWD45OjWMu+cQdTuG+WNHRNl8moz/OHU+ArpCt1Ykl/xfgjefju8uYsWTBn4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQwsB9QM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jXqhEPyG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQwsB9QM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jXqhEPyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764652070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UeSHa2vVcmGoYrd3r8sFlYLUPMwEfaTwEKwTR4fP+Vo=;
	b=AQwsB9QMy81mzcpjDWHzkDjre39H5OtPT36WRdkUMaedBrj/7qyVrPiaZaFhyrWkvVkNwe
	ZrDYzsq0QD+rKiFZzx7M5B69jhwaPhmJIFzBb+Pj5+vYuX/r6Jqi/ITaxT3/b7NyKjqfPU
	IRUkXZdDnH7WQbxijeOVjqk2c9ej+so=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-HS4lmOqRMFGfYIh-vidXtA-1; Tue, 02 Dec 2025 00:07:48 -0500
X-MC-Unique: HS4lmOqRMFGfYIh-vidXtA-1
X-Mimecast-MFC-AGG-ID: HS4lmOqRMFGfYIh-vidXtA_1764652068
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2958c80fcabso105946575ad.0
        for <fstests@vger.kernel.org>; Mon, 01 Dec 2025 21:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764652067; x=1765256867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UeSHa2vVcmGoYrd3r8sFlYLUPMwEfaTwEKwTR4fP+Vo=;
        b=jXqhEPyG2MxE+HLymS2ydoXvhJE2ZZM7gCXLpR/6u7XsVX09QmDkIAAqI4Q5FcL+kK
         sRMsErwo2zk1XOD2wlitEv4JNlipLxCsAHvuKbmVtY4uFD9GABEU79Jkjmdk0UkHRMNT
         UczzAhNClObnW0BuQZavp8eqS9jrzfWpZPV47dtZwQed/LclM54dXlHBMVi4A4C/dxBc
         zWXE6WNRuk0/75fvQT37AuDTIyg7HiGxrOw8TEnbhhY9DojQReIHivlMAjC+HHsCUH0o
         5woutfL+aOE2bKpNjEjB2+/pS0kJLuo4IC4Za84eVd4viS0y0I2Ph9au05EpnR1nlIWy
         KvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764652067; x=1765256867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeSHa2vVcmGoYrd3r8sFlYLUPMwEfaTwEKwTR4fP+Vo=;
        b=gREqQHJqv9dBhnbwANZV7wBeHcxJj3KBR01eHZgmgn+WbU4sd/MMMbSrT7/oAwXABO
         heyurPtDhgTLKgo7k41voRojmXAjPUcZwu21QFGsxh50Mb1ZBbOyiyBWUtgWX8w89mR4
         AozKFPJi8NCknVapch1eb6SUYG3u4T1BrwJSkR2wY/rszd29SGnDxrhZmoigY8nSB9M+
         AS9EGDp6j5fWOmx1f9GLpgmXaPxD/d4Sm0lMj9leaaVQUFEa07HD8knUMtNaOjq71MU1
         M2iN3luP7YCgC5rkLQ32JNl3KFlLxccBsqNCXOars84OGokeQiTWWmp8t+dPaHXfqUYc
         w6BA==
X-Gm-Message-State: AOJu0YyM8di5aT3F87IlAOYzdZUkb8jFeSmBG/NF7TD60KfmTFGfPg3/
	FzvqyywmMJPVZkBw/lWqHR508/UkvPSdeMcE3bSrQf0XmCawoT1Ctjy94xA30O/zq2zHUh6Jijn
	Yap2h6O7ssssCEoh9uJMHqooVW2lx5hFzN6Opx6z1G6KDCzyJlAFWnFAjArLmFHfU59k=
X-Gm-Gg: ASbGncuczCDvQYT18RD6zFrlBE17ajMdVJvHycdC4CHeb8EPVxICexwJlxhOmmrKqjd
	+5s6EJw7/mAcjZRW8Xfozkhg9LjSwDP5TURjDFnX4aMK05pDxpZa/v9ge9EnKXraDRZ9PTqxMyZ
	jZKu++OSceKJWlIxEbuj8WdLDoLlEVIJlCJJySBySsVm/OpcS6M7cQF+1FIW0DU7HF/8h9k6Sa9
	/bMAmG3SYghomWJU7xoVtJjm9ySZPY9OktJsJ4+GzKjvW2xbGBZN4tP6K5UEKtD3EX8fyGb1FgG
	F1mEOpzhwtLZE2kSeYRaR7ykpLxwogpX2JXs0aEP277KB8VpVbtB9Q76n1u5sfb6M2BBD4bRWcR
	vccZJLXx4AkKQdZ4zcPHS5/12uS/u56yG7CWkT8/mt/qOJsCKiQ==
X-Received: by 2002:a17:903:b84:b0:290:cd9c:1229 with SMTP id d9443c01a7336-29b6bec4961mr409475565ad.19.1764652067235;
        Mon, 01 Dec 2025 21:07:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd7eTfczZwORLSJHT6qu06NI2nq5xDtGv3b8o/cmw+GmF8P8G58rrpr6KmXy+oW7FEZjWbVQ==
X-Received: by 2002:a17:903:b84:b0:290:cd9c:1229 with SMTP id d9443c01a7336-29b6bec4961mr409475245ad.19.1764652066644;
        Mon, 01 Dec 2025 21:07:46 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce2e676esm138125475ad.0.2025.12.01.21.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 21:07:46 -0800 (PST)
Date: Tue, 2 Dec 2025 13:07:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH fstests v2 2/3] generic: add test for directory
 delegations
Message-ID: <20251202050741.p6iakv5fbmnrzxmy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251119-dir-deleg-v2-0-f952ba272384@kernel.org>
 <20251119-dir-deleg-v2-2-f952ba272384@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-dir-deleg-v2-2-f952ba272384@kernel.org>

On Wed, Nov 19, 2025 at 10:43:04AM -0500, Jeff Layton wrote:
> With the advent of directory delegation support coming to the kernel,
> add support for testing them to the existing locktest.c program, and add
> testcases for all of the different ways that they can be broken.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Hi Jeff,

Glad to get you patches to fstests again :)

>  common/locktest       |  14 +-
>  common/rc             |  10 ++
>  src/locktest.c        | 423 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  tests/generic/999     |  22 +++
>  tests/generic/999.out |   2 +
>  5 files changed, 456 insertions(+), 15 deletions(-)
> 

[snip]

> diff --git a/tests/generic/999 b/tests/generic/999
> new file mode 100755
> index 0000000000000000000000000000000000000000..1392e98c937d65d2d6402f1eb5822f22bc265342
> --- /dev/null
> +++ b/tests/generic/999
> @@ -0,0 +1,22 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Intel, Corp.  All Rights Reserved.
> +#
> +# FSQA Test No. XXX

     FS QA Test No. 999

Please don't change the format which xfstests/new generate. Other
script (e.g. tools/mvtest) depends on that :)

> +#
> +# lease test
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/locktest
> +
> +_require_test
> +_require_test_fcntl_advisory_locks
> +_require_test_fcntl_setdeleg
> +
> +_run_dirleasetest
> +
> +exit

_exit 0

Oh, I guess you didn't use ./new to create this test case, you copied it from
g/131 or g/571. I'd recommend using ./new to create a new test case :)

> diff --git a/tests/generic/999.out b/tests/generic/999.out
> new file mode 100644
> index 0000000000000000000000000000000000000000..c2a252d46cdcd730cf1ed2c503fa9631e9fcdd06
> --- /dev/null
> +++ b/tests/generic/999.out
> @@ -0,0 +1,2 @@
> +QA output created by 999
> +success!
> 
> -- 
> 2.51.1
> 
> 

