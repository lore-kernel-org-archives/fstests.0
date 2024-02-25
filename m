Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CD3DDA8
	for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708878653; cv=none; b=E8rAygP08CH4BKiVJRRrgceL23rmtz9596BQ+mX31et482WOrP0mTNyI2KbA6PokgoXrLL70nNfN+hTA2MTOWtvQqsxWO9oC7c35hmgyJOM3hsHePt2pczLfB5gV+XV3xEv1N53vm2ATAEzy33edYkaNskmJGCxPJ87zvKwR7GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708878653; c=relaxed/simple;
	bh=WxiP7F68RSJ87rzcxYBpZWvoQ3nnn47X/jIvBgI4zd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ/3ZmLhvjy8JByZ/V/rKJCSNp67j9oIxwir0kniRsCkUHvhyj0YYVRkHbwGswAddH24RU5Qg/vHyv/ZmbXbV20+SYEJuACyW1ZgtzClbyl+qMpqYA8O2DKPjisW2rAXzfzJiKG6CeM21C9d+Gj76IjzMJMc61JVRBSgSY/5V9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgNH1rjh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgNH1rjh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708878650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSlJib+z8G6JyqJPxqUox75szUmw+vOptrkfrW5q6K8=;
	b=JgNH1rjhvA4M9+s4lwnzWiwrzl9FjgJQmQpUQsmlAw6uUbb1nbQC0SQz2uqMFR4T8QGc9Q
	STKwgpjlU0McgZfggXLJ7/84hYIaK1d3XpJ5OtZYsfMxcUF5DN3MLz6njbkKi6Iqa3TEfj
	8VRcM1jqjBw2pJGOUmyD8m4BeJOCevo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-lKOh6k8VNbiVRPpDnCMkkQ-1; Sun, 25 Feb 2024 11:30:48 -0500
X-MC-Unique: lKOh6k8VNbiVRPpDnCMkkQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1dc6f251034so5739055ad.1
        for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 08:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708878647; x=1709483447;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSlJib+z8G6JyqJPxqUox75szUmw+vOptrkfrW5q6K8=;
        b=pnIqfiaTEhVHEcRPYm1x6+Dg9NHRqBiE8tbAUMPh3YcurRSCZqSxyTRZj92q+8bole
         otWurvpb4I/cmq+fgb7HW/4xW1xDS4okC5NTvWSLeawHVyCFkGUl8FwZWdaOHsUjl3Lm
         5QRkgk0CuF8YT7Fn6cOjIGSSDLJc4jKUAyd4vC+yRoU5P+FUyq40Vb4kwcp0ENpAZLCb
         HaY3wKOUmmHRuH5Sy2iGISCHfDfR1bZ0DLEhOHMiUH+ta72ruuifPH5KL4YtltuC7IhS
         y15m83DTbYCK36WJYLh3A9CoLdQ+lLZeOvLUhuVtn/6Giivt/feSi3YzFTdd+9w6NDKl
         XBBg==
X-Gm-Message-State: AOJu0Yy1KMTAdYwDVDa9HTAcwx2nA5H/cHcN0il8xq33ynmoh6yQyWkt
	HiTLgNnPkZA6B9crb8EJ6Mjqkkl3+ULvq0dWDukjCPWDqxVeQLOPYB9K0/tVi3wp7kLTOvJtu8s
	imhEm1YWR7XEnGRo8tnq26/XhxLn9Ip6c8vnXxVb68F4Z+u8m4iJrFlU=
X-Received: by 2002:a17:902:9a46:b0:1dc:3402:354e with SMTP id x6-20020a1709029a4600b001dc3402354emr3869400plv.54.1708878647211;
        Sun, 25 Feb 2024 08:30:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8COilNSGsmLhlJ4fe6fbsoQz+ngPMmCyGiYXqvkzUrkm2xgLK4FLifCv1FWuNagVX2Y3hMQ==
X-Received: by 2002:a17:902:9a46:b0:1dc:3402:354e with SMTP id x6-20020a1709029a4600b001dc3402354emr3869392plv.54.1708878646853;
        Sun, 25 Feb 2024 08:30:46 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ke3-20020a170903340300b001d8aa88f59esm2427871plb.110.2024.02.25.08.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:30:46 -0800 (PST)
Date: Mon, 26 Feb 2024 00:30:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] tests/*/Makefile: make sure group.list DIRT exists
 before install
Message-ID: <20240225163042.rrb6djrhbs6e2fk5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240208225241.644701-1-martin.jansa@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208225241.644701-1-martin.jansa@gmail.com>

On Thu, Feb 08, 2024 at 11:52:41PM +0100, Martin Jansa wrote:
> * sometimes make install was failing with:
>   cp: cannot stat 'group.list': No such file or directory
>   and bunch of non-fatal messages:
>   mv: failed to preserve ownership for 'group.list': Invalid argument

I'm wondering ... isn't that expected?

Why not let "make install" fail directly, if there's not a completed "make" ?
Isn't that more familiar?

Thanks,
Zorro

> 
> * this was when tools/mkgroupfile did
>   mv -f "$new_groups" "$groupfile"
>   overwritting the group.list file while install-sh was already
>   copying it to output
> 
> * in the end easily reproducible by
>   1) removing tests/*/group.list before each make install
>   2) adding some sleep in mkgroupfile before the mv call



> 
> Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> ---
>  tests/btrfs/Makefile    | 2 +-
>  tests/ceph/Makefile     | 2 +-
>  tests/cifs/Makefile     | 2 +-
>  tests/ext4/Makefile     | 2 +-
>  tests/f2fs/Makefile     | 2 +-
>  tests/generic/Makefile  | 2 +-
>  tests/nfs/Makefile      | 2 +-
>  tests/ocfs2/Makefile    | 2 +-
>  tests/overlay/Makefile  | 2 +-
>  tests/perf/Makefile     | 2 +-
>  tests/selftest/Makefile | 2 +-
>  tests/shared/Makefile   | 2 +-
>  tests/tmpfs/Makefile    | 2 +-
>  tests/udf/Makefile      | 2 +-
>  tests/xfs/Makefile      | 2 +-
>  15 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/btrfs/Makefile b/tests/btrfs/Makefile
> index 1b72a1a1..6d9995b4 100644
> --- a/tests/btrfs/Makefile
> +++ b/tests/btrfs/Makefile
> @@ -14,7 +14,7 @@ default: $(DIRT)
>  
>  include $(BUILDRULES)
>  
> -install:
> +install: default
>  	$(INSTALL) -m 755 -d $(TARGET_DIR)
>  	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
>  	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> diff --git a/tests/ceph/Makefile b/tests/ceph/Makefile
> index 2761e1e9..5f24d518 100644
> --- a/tests/ceph/Makefile
> +++ b/tests/ceph/Makefile
> @@ -12,7 +12,7 @@ default: $(DIRT)
>  
>  include $(BUILDRULES)
>  
> -install:
> +install: default
>  	$(INSTALL) -m 755 -d $(TARGET_DIR)
>  	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
>  	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> diff --git a/tests/cifs/Makefile b/tests/cifs/Makefile
> index 62c48935..0b89a01d 100644
> --- a/tests/cifs/Makefile
> +++ b/tests/cifs/Makefile
> @@ -14,7 +14,7 @@ default: $(DIRT)
>  
>  include $(BUILDRULES)
>  
> -install:
> +install: default
>  	$(INSTALL) -m 755 -d $(TARGET_DIR)
>  	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
>  	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> diff --git a/tests/ext4/Makefile b/tests/ext4/Makefile
> index a2a0d561..296e3850 100644
> --- a/tests/ext4/Makefile
> +++ b/tests/ext4/Makefile
> @@ -14,7 +14,7 @@ default: $(DIRT)
>  
>  include $(BUILDRULES)
>  
> -install:
> +install: default
>  	$(INSTALL) -m 755 -d $(TARGET_DIR)
>  	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
>  	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> diff --git a/tests/f2fs/Makefile b/tests/f2fs/Makefile
> index 9d1ed3c6..0a90b465 100644
> --- a/tests/f2fs/Makefile
> +++ b/tests/f2fs/Makefile
> @@ -15,7 +15,7 @@ default: $(DIRT)
>  
>  include $(BUILDRULES)
>  
> -install:
> +install: default
>  	$(INSTALL) -m 755 -d $(TARGET_DIR)
>  	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
>  	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> diff --git a/tests/generic/Makefile b/tests/generic/Makefile
> index b464b22b..d6ed3e55 100644
> --- a/tests/generic/Makefile
> +++ b/tests/generic/Makefile
> @@ -14,7 +14,7 @@ default: $(DIRT)
>  
>  include $(BUILDRULES)
>  
> -install:
> +install: default
>  	$(INSTALL) -m 755 -d $(TARGET_DIR)
>  	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
>  	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> diff --git a/tests/nfs/Makefile b/tests/nfs/Makefile
> index 128d2a3a..51590b5c 100644
> --- a/tests/nfs/Makefile
> +++ b/tests/nfs/Makefile
> @@ -14,7 +14,7 @@ default: $(DIRT)
>  
>  include $(BUILDRULES)
>  
> -install:
> +install: default
>  	$(INSTALL) -m 755 -d $(TARGET_DIR)
>  	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
>  	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> diff --git a/tests/ocfs2/Makefile b/tests/ocfs2/Makefile
> index 260ad31b..17e01bf3 100644
> --- a/tests/ocfs2/Makefile
> +++ b/tests/ocfs2/Makefile
> @@ -14,7 +14,7 @@ default: $(DIRT)
>  
>  include $(BUILDRULES)
>  
> -install:
> +install: default
>  	$(INSTALL) -m 755 -d $(TARGET_DIR)
>  	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
>  	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> diff --git a/tests/overlay/Makefile b/tests/overlay/Makefile
> index 2785b94d..c71e78d6 100644
> --- a/tests/overlay/Makefile
> +++ b/tests/overlay/Makefile
> @@ -14,7 +14,7 @@ default: $(DIRT)
>  
>  include $(BUILDRULES)
>  
> -install:
> +install: default
>  	$(INSTALL) -m 755 -d $(TARGET_DIR)
>  	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
>  	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> diff --git a/tests/perf/Makefile b/tests/perf/Makefile
> index 0c74ba39..d72c04d9 100644
> --- a/tests/perf/Makefile
> +++ b/tests/perf/Makefile
> @@ -14,7 +14,7 @@ default: $(DIRT)
>  
>  include $(BUILDRULES)
>  
> -install:
> +install: default
>  	$(INSTALL) -m 755 -d $(TARGET_DIR)
>  	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
>  	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> diff --git a/tests/selftest/Makefile b/tests/selftest/Makefile
> index 3ddfca37..cabc35a9 100644
> --- a/tests/selftest/Makefile
> +++ b/tests/selftest/Makefile
> @@ -14,7 +14,7 @@ default: $(DIRT)
>  
>  include $(BUILDRULES)
>  
> -install:
> +install: default
>  	$(INSTALL) -m 755 -d $(TARGET_DIR)
>  	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
>  	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> diff --git a/tests/shared/Makefile b/tests/shared/Makefile
> index f3128714..2e6aa718 100644
> --- a/tests/shared/Makefile
> +++ b/tests/shared/Makefile
> @@ -14,7 +14,7 @@ default: $(DIRT)
>  
>  include $(BUILDRULES)
>  
> -install:
> +install: default
>  	$(INSTALL) -m 755 -d $(TARGET_DIR)
>  	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
>  	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> diff --git a/tests/tmpfs/Makefile b/tests/tmpfs/Makefile
> index 46544313..46b62dad 100644
> --- a/tests/tmpfs/Makefile
> +++ b/tests/tmpfs/Makefile
> @@ -14,7 +14,7 @@ default: $(DIRT)
>  
>  include $(BUILDRULES)
>  
> -install:
> +install: default
>  	$(INSTALL) -m 755 -d $(TARGET_DIR)
>  	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
>  	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> diff --git a/tests/udf/Makefile b/tests/udf/Makefile
> index ed4434f0..feda69a6 100644
> --- a/tests/udf/Makefile
> +++ b/tests/udf/Makefile
> @@ -14,7 +14,7 @@ default: $(DIRT)
>  
>  include $(BUILDRULES)
>  
> -install:
> +install: default
>  	$(INSTALL) -m 755 -d $(TARGET_DIR)
>  	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
>  	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> diff --git a/tests/xfs/Makefile b/tests/xfs/Makefile
> index 5f413e67..6bfafdb1 100644
> --- a/tests/xfs/Makefile
> +++ b/tests/xfs/Makefile
> @@ -14,7 +14,7 @@ default: $(DIRT)
>  
>  include $(BUILDRULES)
>  
> -install:
> +install: default
>  	$(INSTALL) -m 755 -d $(TARGET_DIR)
>  	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
>  	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> -- 
> 2.43.0
> 
> 

