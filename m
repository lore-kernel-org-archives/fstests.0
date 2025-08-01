Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8C26FA7B
	for <fstests@vger.kernel.org>; Fri,  1 Aug 2025 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754074602; cv=none; b=N9r189qH8b6RsZ79YRlKvO3EordvOkDmBWbh2DD7rbD8h9XesD+Gk2Ops+CRj6ZsqAJa3uEBRQXHz0uXlHxds2WwLVZ0BkQIo0ZTPFLskpxUA1B2xWO0aL/nwVE36A2vl4dUsbP3/5zTp1CjmI+WR/5Ey6vz4rxyIbvCdsxCiCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754074602; c=relaxed/simple;
	bh=NZSjdVx87HnyrSVozT0uc3abOkujfjk601OHRy2o96Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2jPtRQfWiYvJ0UdQLx+RZycmbWKXJ/sm3FmEGBRisz3Kc44VmiNgrJapOCCu86BCcUpMAbD0IgMuPeNDMLr8/TlvIj/pxwgtuHcV9VGTtRPU8Kk4hOufQr5CxWZQkWXN6VrPUwW0GmOOLFWo9/Dxfve4lPQfhIzv66v4zmOfU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AYdJtHPu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYdJtHPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754074600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rLYdaEMzvcgs5Y4Lenm9HObKKAnQF1XP3lyqD9Xr2LY=;
	b=AYdJtHPux6AdxCQqeQGJTM5NCjZXIHVC0vgU/MFdU5XuOzeap7slNvAmhpfXHMjVdvg8A0
	ol7Qf789yzku7wwjBXxx2n6gg0bqoSU5vJZKUC+wwcUX0M86BrvGBH7k6ytHaduxX9Qmdj
	D7zOVnQhU9XTqkrql/mTQFY8n/cwpH0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-8t7fBEzXOZGT4XhWu7YDxQ-1; Fri, 01 Aug 2025 14:56:38 -0400
X-MC-Unique: 8t7fBEzXOZGT4XhWu7YDxQ-1
X-Mimecast-MFC-AGG-ID: 8t7fBEzXOZGT4XhWu7YDxQ_1754074598
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24004ac2ecdso28051735ad.0
        for <fstests@vger.kernel.org>; Fri, 01 Aug 2025 11:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754074597; x=1754679397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLYdaEMzvcgs5Y4Lenm9HObKKAnQF1XP3lyqD9Xr2LY=;
        b=ijCBCPoBSXX1ZtOqRGAZ5jQUpZvROZSy0EA0QbHsVI/t9FSRgkA4+gKomq/Ek7YZ/l
         hwQfdR6Kb48r0wpMJv1KdkgmM5AuwCVBKCApjpiwO+NRL9LlZeMlpbLua5S/BENlspk2
         RJg+CBHW29RXgtFCSe1vmMuAsUxK/ZziM9x1PAxBKj5V6ojwvDNRXe3o1ZD07iyIEiiP
         jCDdkPwNv7LVIGc4/tFMaYQpar/IYnFYPj9cUQ8BaFMf5wQ7Ll/Ds66CxuOuB+Dj5XpN
         nDBNguc4G2Nmoxkde6PHR472bF/KsYqyMf4Rid+R2mi/3eP7Z42nESFgUYGjJUeJAOnp
         BPmw==
X-Gm-Message-State: AOJu0YyLa7MkbdIKUGezOzuzkAQrEHshDWbV/5pGD9c3WSJj1x7smHCJ
	IyPWRC1gRKo8HXzMUEL5gDdPb7W9SziY6qywRRZZmydOE4l6CNAKMyykOzjhSeS3gAYcK/6w9E0
	44NZxbWP9aaXR0Ze2oNyjRICgk0e54jX9WATfmbc015myl4wY/0S5dmms9kc=
X-Gm-Gg: ASbGncvGzjwNZw1z2yMDmeg34P378Z5BWpW+21u4AOYS41xpOAdY+A0m2O3F1RaJ9uo
	mi/UQ8hRuXjxaobtc4q3C6sp7DJSm/s2SJAs8tfXzatMy/WpL/cO8q27zgQfmZWRkrL+gHvu7fL
	lB79AU9QGvC+kjCX+3VqggSs/poK+OwD1Rpwcq+ezn+RU7X79Py3bwlrCFFspguUSxdE3PmkYRt
	4i17d99JaEhf0fQDLtU9M3dWH9WDiZLxSkMngosPRtzp3UDbbPPGyahv27WcLGaTERGmjNbNrsB
	PhrX6ncTmM50Lox+FSB1O8WQSFr586wlHsofxPzDS8rXipoIzlsFXpkfcOyNi7eO4X0xLf2xnra
	5JAFa
X-Received: by 2002:a17:903:22c8:b0:234:d292:be95 with SMTP id d9443c01a7336-2424703f838mr7568865ad.42.1754074597615;
        Fri, 01 Aug 2025 11:56:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbdDKWOMveqEbR97E8SC6jcWbRc3Z47TQmEoWmo/5+dYS5uWtB0AIUOciMua+aT+b1mJs8wA==
X-Received: by 2002:a17:903:22c8:b0:234:d292:be95 with SMTP id d9443c01a7336-2424703f838mr7568645ad.42.1754074597260;
        Fri, 01 Aug 2025 11:56:37 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaac0esm49972555ad.152.2025.08.01.11.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 11:56:36 -0700 (PDT)
Date: Sat, 2 Aug 2025 02:56:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 5/7] generic/767: allow on any atomic writes filesystem
Message-ID: <20250801185633.adgwyt5qbhbs4mcf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <175381957865.3020742.6707679007956321815.stgit@frogsfrogsfrogs>
 <175381957992.3020742.8103178252494146518.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175381957992.3020742.8103178252494146518.stgit@frogsfrogsfrogs>

On Tue, Jul 29, 2025 at 01:09:32PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test now works correctly for any atomic writes geometry since we
> control all the parameters.  Remove this restriction so that we can get
> minimal testing on ext4 and fuse2fs.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Makes sense to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/767 |    1 -
>  1 file changed, 1 deletion(-)
> 
> 
> diff --git a/tests/generic/767 b/tests/generic/767
> index 161fef03825db4..558aab1e6acf34 100755
> --- a/tests/generic/767
> +++ b/tests/generic/767
> @@ -36,7 +36,6 @@ export SCRATCH_DEV=$dev
>  unset USE_EXTERNAL
>  
>  _require_scratch_write_atomic
> -_require_scratch_write_atomic_multi_fsblock
>  
>  # Check that xfs_io supports the commands needed to run this test
>  # Note: _require_xfs_io_command is not used here because we want to
> 

