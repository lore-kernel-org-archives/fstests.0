Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48E2E2836
	for <fstests@vger.kernel.org>; Mon, 11 Aug 2025 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936358; cv=none; b=TXdE/EmxC2BymCeGfvIEH2B6Fch+QBOYFBFJHbxYEiRxg17IyNfFVvvNJU8sZi+qAo8xJs8BccJ5uc04uHLVKvMUZ+LecUd7XydiUqS7jjptrC2FZzIDq6rx1mpEGzyKgqC/3DMcWrthlYeIgjGc+zUivnf+pvK+IQ0+HOu6DX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936358; c=relaxed/simple;
	bh=vVE/4ah+8NxzIhisnrx/+XJKQOTJCD6YfCCZ+D5mEtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqeVqSDAESMgO5rJflcU7ktN2NeDxOMVpJB+Zew0t9eqdvzdCjPVNksIF5D4Nd49Qor76dUQju/KOEmaiEj3j7vxGOD9zEazUTytcLYvJpbUlmaesp1yRtSTtE8uibTGV+jH1049Amx917Kw++LZo3BuKN/JoFlvz8KzvGPmJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WvgwqIKw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvgwqIKw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754936355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xk032dCPOH//Tzmtha9SFEIHYkNc5wcXK3m9ky/ZXuI=;
	b=WvgwqIKwasIpv/+SAg1NKBNwIlDLDQNmrl7ASdf/fplOIOvgMUSYnGQTO3zYSOscqZkt9o
	Ts/CX0KRxi38z/0heHSJoxRPwNn5FghWA6diKxVueQz8C+DtBR435uFH/O4K0kAT6Kfmmh
	kxeSm3fW0tc8BJsA/Xr8nVo6oxGcNmM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552--s_KVeRsM5CfCc2hDBQnKw-1; Mon, 11 Aug 2025 14:19:14 -0400
X-MC-Unique: -s_KVeRsM5CfCc2hDBQnKw-1
X-Mimecast-MFC-AGG-ID: -s_KVeRsM5CfCc2hDBQnKw_1754936353
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23fe28867b7so62065805ad.2
        for <fstests@vger.kernel.org>; Mon, 11 Aug 2025 11:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936353; x=1755541153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xk032dCPOH//Tzmtha9SFEIHYkNc5wcXK3m9ky/ZXuI=;
        b=ffiWu/pjMlKi8Q9z0eBMrRwUowReWovE71bcHWsSuFqVYrtAEhwO4gIu/xrzuH7/ch
         7sQpIzmNkLAVjF3xQUAStqmzeD1e3yKa0GiP2pro7fZVX9IswYGNh8nVmUuSpCjABWyt
         2/Fhgt8il6kxq1ImtKCFFecNlnNw1E/aLNE+ZeiMnt4J8rTFZY6TCZE0FPRDmylO24M1
         05fvdcxqRxvn8CLOkLx4PYqtlpeGyT+PglQA8P0ynFuxuHrTee4EXr1r3vYAz41if9br
         0ergCaQacRCIOV0LO9j+sDEdBZLLU4g6ePdTisgGXrlJNsYnx2r1XI3lpfTlQsFlS/aI
         8loQ==
X-Gm-Message-State: AOJu0YwuhumQ0mcg2l/8VoROmB331lHDX3qyljVLqo/hugFmHcLiW5mu
	3r16ak3RSrUzSTQYyX/S8VkzHuTNgT/eXWvQCnD4Sf9a0cbIq0MJaVKlQUYwaPCGMHn+cQbmi/2
	80mNUdXTGc/Ihsn6HepaKXyEu5M3TV6Jfm+Rh9D+me8Y2Sch20vQL048QAZqhMqrYDf4=
X-Gm-Gg: ASbGnct+jdwKk5B+xojjuHkhwMaQYpvK7Nz00ntvJ+S3gR90Pp3Si5E/F/BKaBHONIT
	g5rKRnWhL1PCHXX4myzLi+4BggeQ3+0fFCO7pQ6fa19gARWNTZwBUuYdWE3cHpNH8Ml/7gex/P0
	F3DI4lDsn1ZSUMoLb5cvvVO5AmYH+LNLTsGNPvUBOfndk9jDPRX3tHuin3jLxZwYUMa11GwhTcN
	THr6FPVNdrJBZGIZ0b44Vr1VVSxPjR2VLJ+eMfRrogHmvIgl0B05H6NzYrGUMrGsLtf1dnDT4nq
	eHuN4E6H6PRQhhrsxAg+41vnS7l9Mxvw6s8nTdq8jUb77lHKU1yfFfD68HeSaKqpfU0Q0Pvkdec
	WXVTC
X-Received: by 2002:a17:902:e84b:b0:240:483:dc3a with SMTP id d9443c01a7336-242c1fdc531mr224690095ad.12.1754936352918;
        Mon, 11 Aug 2025 11:19:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqqI6Ud3YDlbUw1rbJNKr46d3kE9SfotZ1/jcPtFCIN7s9crmy3gBuSvh1G51I0hWcSTZLMQ==
X-Received: by 2002:a17:902:e84b:b0:240:483:dc3a with SMTP id d9443c01a7336-242c1fdc531mr224689725ad.12.1754936352487;
        Mon, 11 Aug 2025 11:19:12 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b423d2f5035sm21823313a12.39.2025.08.11.11.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:19:12 -0700 (PDT)
Date: Tue, 12 Aug 2025 02:19:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/131: test iomap zero range via fsx and error tag
Message-ID: <20250811181908.xmzp5wpqg5w3tgyb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250807145626.564764-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807145626.564764-1-bfoster@redhat.com>

On Thu, Aug 07, 2025 at 10:56:26AM -0400, Brian Foster wrote:
> iomap supports a zero range operation based on buffered writes. This
> mechanism is used in limited spots, such as partial block zeroing,
> etc., because usually for larger zeroing ops it is more efficient to
> punch a hole and allocate unwritten extents.
> 
> This means iomap zero range has limited production test coverage
> even though it has some particular corner cases that warrant test
> coverage. XFS supports an error injection knob to force use of iomap
> zero range on fallocate zero range operations. Add a test to run fsx
> with this knob enabled to provide more zeroing test coverage.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
> 
> FYI, this test is intended to go along with this patch[1] that
> introduces the errortag.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20250807144711.564137-8-bfoster@redhat.com/
> 
>  tests/xfs/131     | 26 ++++++++++++++++++++++++++
>  tests/xfs/131.out |  2 ++
>  2 files changed, 28 insertions(+)
>  create mode 100755 tests/xfs/131
>  create mode 100644 tests/xfs/131.out
> 
> diff --git a/tests/xfs/131 b/tests/xfs/131
> new file mode 100755
> index 00000000..eb8882a3
> --- /dev/null
> +++ b/tests/xfs/131
> @@ -0,0 +1,26 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Red Hat, Inc..  All Rights Reserved.
> +#
> +# FS QA Test 131
> +#
> +# Run fsx with XFS force_zero_range error injection enabled. This is a proxy
> +# test for iomap zero range. Zero range is used in limited cases by default,
> +# such as EOF zeroing on file extension, etc. This error tag forces use of iomap
> +# zero range for fallocate zero range operations.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick zero
> +
> +# Import common functions.
> +. ./common/inject
> +
> +# Modify as appropriate.
> +_require_test
> +_require_xfs_io_error_injection "force_zero_range"
> +
> +_test_inject_error "force_zero_range"
> +run_fsx "-q -S 0 -N 100000"

Just check with you, if you hope to have a $TIME_FACTOR with -N at here.

This test case looks good to me with this patch:
https://lore.kernel.org/linux-xfs/20250807144711.564137-8-bfoster@redhat.com/

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
> +# success, all done
> +_exit 0
> diff --git a/tests/xfs/131.out b/tests/xfs/131.out
> new file mode 100644
> index 00000000..2ca0d932
> --- /dev/null
> +++ b/tests/xfs/131.out
> @@ -0,0 +1,2 @@
> +QA output created by 131
> +fsx -q -S 0 -N 100000
> -- 
> 2.50.1
> 
> 

