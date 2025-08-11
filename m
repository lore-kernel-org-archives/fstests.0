Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBBF2E0923
	for <fstests@vger.kernel.org>; Mon, 11 Aug 2025 18:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936707; cv=none; b=Uzb5cEodFl0/yUIOEDTsXbScghy6iE67qy4a/fR+3YRg0iLoeb7qIaevE5Hqkxh9It596fh3rIV4i754sCqFu0wsZ2tZpJlgMjtV3nGBFnq7ES1a4wADzdGxgLPBHTLUjE7lYMSRnUgEfvQmoxits7JEiD0Z/2dQuF//aPWniYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936707; c=relaxed/simple;
	bh=lKAhW4oiHl3o6zVOe4zh++Nbw0JVLKK22FIHVU1HZDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4SZQEK3OQ71Dg0+hr+u+brnXezFoUB/UpD4JIpGo4XKbPdwqD/0UTHhYPaZhIsoImUUSYjtAU8dKYfiH+tR2QABnG4uxfGqHaG4NjB0H3qOebs1FrBjnCWCHL9ikOI6tEjXEIulZ30cbj1oLUflh82Pn/sB6IMPScsqQcTQF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XjKwdgpE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjKwdgpE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754936704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KG/nLK6ly9NVbJ7Ikn2khZYZtxxzIyf5Tj5gpFjXeHk=;
	b=XjKwdgpE3hROl7U3AZYRxWitPKI5XVufh75TINw9nkcpz3fmE0k/3vr6oCkTOtoQFOprqU
	Jce9Ia02OMGn8jTT07dLIMeb2FnTyvheU7QJrZLXSkX12a9JtfHug74/x/D6rX+PCcS2xf
	eRWvePkZam18VTIv8V8jMMCT7nGdVF0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-16YJduqpMrOyIhqpQcr_jQ-1; Mon, 11 Aug 2025 14:25:03 -0400
X-MC-Unique: 16YJduqpMrOyIhqpQcr_jQ-1
X-Mimecast-MFC-AGG-ID: 16YJduqpMrOyIhqpQcr_jQ_1754936702
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23fe26e5a33so70456985ad.3
        for <fstests@vger.kernel.org>; Mon, 11 Aug 2025 11:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936702; x=1755541502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KG/nLK6ly9NVbJ7Ikn2khZYZtxxzIyf5Tj5gpFjXeHk=;
        b=wkDAtewIUwQeU+ZGwVUa8r5Tt6jMQYPoc9CmcG8GXsGs4gkfhWG1tF/2FOSCytT0Eo
         wKMPkZAdlZdj5f1BUllC62Cd28SC3QZEcvt077VqZFzW6Twd5Zu3MCzbytEh/aIQClP1
         NA/gA+fQy47kgbyf2yLh09Nhju7KLY9QsZcUmGS26fPPl9CNuOx8RgmGTel98W8ojs1O
         EIdIwZ8DZbWIsIjKV9ByML2FIFlSQbtRlwbciYBMj3Dc3pCQjMLGkNZ60mpK6BjwOUq/
         PIj3KzBJTGXtrI6eCFOZPGQiWuz5eEPCPON3LYKqcuT4ESxi6JKilacZhE9/CNmZwm4v
         RVbQ==
X-Gm-Message-State: AOJu0Yy3lVQtA/NUP5l5im0RqX8+AruF/d8wb7jj+Rj4H14Rg0lcWjls
	MUIXABOn8ckOxsbO5qmSSv8x6+emjzxnMgJDM8guRwJc4dSNLICYxCNSBcR/RIj+HjanLyV3i2L
	3oxEvdxxVmvpryZv878BOi04/eATdCRJJErmRK3etkO04ZL+5nWXaPuUC6HI=
X-Gm-Gg: ASbGncv46svytDXZjINWe13IFKMqVppRkV7PR9QUyRgpFV33oDz316bA2wYNy0n1YI6
	bhXv2FpfcpBPpRAxRuRx2fbeqX+v4atn+oG9lRmAX7mtErB1d1JVnMz4372D5xOW7jdscZaqHMF
	lKw1rNbMKjHY79PR5cRxwlzjsSH5XLR+4VnRS3FM4Xr9wlDF8xMYdBAgH+6N4p2qou4BvQIAQcF
	GomZlF+FnAJ/abKUypgKjdExaUMov6Um5mcpOzuVedEHONiCKh+WLnc+jiKymSxTHTQsl2rzgY6
	YDbXS9SK0UzAmZrSPf5ekKCvYLJdRt1zPGGzWJxTceH1Ro2T1RCDAzFgLPYwczmUZz0UdmwJWis
	XbNl3
X-Received: by 2002:a17:903:41c6:b0:240:8cec:4823 with SMTP id d9443c01a7336-242fc34e3ecmr7987915ad.41.1754936701997;
        Mon, 11 Aug 2025 11:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC4uEYssl0T3sEZlEcBU5zREjO9k8JzDvY0+CcBMv910P229k+uZoqhZa4zGS8AUmGLSrS1g==
X-Received: by 2002:a17:903:41c6:b0:240:8cec:4823 with SMTP id d9443c01a7336-242fc34e3ecmr7987645ad.41.1754936701611;
        Mon, 11 Aug 2025 11:25:01 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aac9a6sm281741335ad.157.2025.08.11.11.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:25:01 -0700 (PDT)
Date: Tue, 12 Aug 2025 02:24:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/131: test iomap zero range via fsx and error tag
Message-ID: <20250811182457.z5cvwecd6yyvfges@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

Just a picky review point:

As run_fsx() function use "$@", so the double quotation marks ("-q -S 0 -N 100000")
don't make sense I think, although it works. I'll help to remove it when I merge this
patch.

Thanks,
Zorro

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

