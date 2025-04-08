Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6C29A2
	for <fstests@vger.kernel.org>; Tue,  8 Apr 2025 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744141365; cv=none; b=KsBusG+fzRM/36b+ojUbwFsV7Y/gr0B0BLXwe+Afr/2ZUd226f50Sz0zzrQlj717h7B2xnbPEE6zNyxr/s5rm+9OdvyrR7kQhX4FZOr4d2w6kcKa3zfZOZkRENo1Nw82LUwPsOGrewcbXIV4YdpJO5K2JoZYWCJJHM+VZFOO7v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744141365; c=relaxed/simple;
	bh=EfH9/NeN8Wn9mZmzc9aIIPBqa9f9401D0eIsIyPc+5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRNMOppYq5W01PmAngOn2nMjnDBmVYaBp3D5EW9AOdvbB54uOiOS5miipTl7xZJnrceOnMCG0QwITaSQfX79UwwXWE6BjiYGdAQqh/82zWpHYH5h+B6PWr1uFyoyKuBzVeEL1wAwOkgAnX84zQpMn8fVKSokFiKIX7oIcqITsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZb/3XPu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZb/3XPu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744141362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9g6bQwv7mzKc/dgYa3gePEsauo/hi2agtUzVzw00jIQ=;
	b=HZb/3XPujLvkFzTeczDZ2kNXr4NyRprYmDP/ev3ZWPFu2m2iTzyjzGkFX0/nBB/qsvlv9t
	N4DuduDhCN0cjgi4FD9oktjJyyvRre4X+ALYs+t1EyEzG86/ThSjDp5yQCzry4jXyOqy2b
	09/4o6SDgjLK6wtRKai8YTooAEGA9kE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-AYpZtw2ZMqChtGsp-yBEHA-1; Tue, 08 Apr 2025 15:42:39 -0400
X-MC-Unique: AYpZtw2ZMqChtGsp-yBEHA-1
X-Mimecast-MFC-AGG-ID: AYpZtw2ZMqChtGsp-yBEHA_1744141359
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-73009f59215so7246364b3a.1
        for <fstests@vger.kernel.org>; Tue, 08 Apr 2025 12:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744141359; x=1744746159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9g6bQwv7mzKc/dgYa3gePEsauo/hi2agtUzVzw00jIQ=;
        b=CbML0oPf4f3V8meWh2cCoNMvnBVowyFj42JJ7JezGJe2Vdf5sf/7fD8Tsoo6JuKwyN
         c74Vl9falDfJBh/CH0gF5HghmXvrGs/5BQwsCapfeJAns+jC1uNK1AQasiZWY2KTxjX2
         SyuKwKb3wwzgeNhJuxNZV6WZkLlu2Y3JlxbXW862IYbFJonsQ/Sy1zZjYyzw970pLxIT
         YViaSWVFuAfFHoEuuufvsC+qw8goG0r3cFbScPwjgW2HVc0ecUk6+Fpx/f5C545yj2S+
         IVaK7+RQWgDe5/qmTFoGjkhfqHgThHIb7RcbvuJTtwZLb+QNCl10KPPH8kIMAf8KncJV
         6RPg==
X-Gm-Message-State: AOJu0YxdJAb6CexPXlEgVkLpZz0xlxkcv9hXQrC2aOZ5LaYpIayTwVhc
	xaiZUkV/PYpw9knnCphT7y67bnEBiKJuVHHucDOx5Hb9h9KAMe/m4RwJhxZ6olAQgPJAgwVJ/UX
	6towzXZsG4ZhKBmNaorh5VDAyrrokoZdiFYpVNzoMDuyuWqbt40TljhA=
X-Gm-Gg: ASbGncu6ImVNQHjuU2e3SH9PwprjW+uBV4BpVFo0L4MFoqegQ4JiH6RXEKIfX6CCC1n
	CtWYL4bPLE9qRgNhih2pcOGU+VZMPASfBKnebHJdfjhaE871eSEYaEtYVZGrDRRxVw9DiJ9uX+q
	kBbTseswjObLuluW+WchNTiY6eI9uNjktVEzmTHIshR4LQ4Xn87o7dABMTCm1m3/+5r5EuldY3z
	Z+tbfJr/xxQ50J8iSEZ+gr54Oy2IUF9bc5c4gGrXp3SjCdEtfXcsWFk5T17ihQcYbiAG1FbsvFH
	Zlhw5uHHMJty1oxnWzqBwAjw01UKR4KKxSDX30qgZ2e0UANJ5sXGirZH
X-Received: by 2002:a05:6a00:10cb:b0:739:50c0:b3fe with SMTP id d2e1a72fcca58-73bae4b7285mr347962b3a.8.1744141358691;
        Tue, 08 Apr 2025 12:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNYZ51tzV0+jDcH1z+AzngJjetFedImLP/+0cXrDoVBIsnRYzGkZ6nP1erSoPADQ4UEdWBqg==
X-Received: by 2002:a05:6a00:10cb:b0:739:50c0:b3fe with SMTP id d2e1a72fcca58-73bae4b7285mr347941b3a.8.1744141358342;
        Tue, 08 Apr 2025 12:42:38 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc405c42sm9210915a12.62.2025.04.08.12.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 12:42:38 -0700 (PDT)
Date: Wed, 9 Apr 2025 03:42:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests <fstests@vger.kernel.org>, xfs <linux-xfs@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] xfs/801: provide missing sysfs-dump function
Message-ID: <20250408194233.3fwpiid4ochtfm6u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250408181732.GH6274@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408181732.GH6274@frogsfrogsfrogs>

On Tue, Apr 08, 2025 at 11:17:32AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This test uses sysfs-dump to capture THP diagnostic information to
> $seqres.full.  Unfortunately, that's not a standard program (it's one of
> my many tools) and I forgot to paste the script into the test.  Hence
> it's been broken since merge for everyone else.  Fix it.
> 
> Cc: <fstests@vger.kernel.org> # v2024.08.11
> Fixes: 518896a7b483c0 ("xfs: test online repair when xfiles consists of THPs")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/801 |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tests/xfs/801 b/tests/xfs/801
> index 1190cfab8a9f94..a05a6efc1a9058 100755
> --- a/tests/xfs/801
> +++ b/tests/xfs/801
> @@ -42,6 +42,18 @@ test -w "$knob" || _notrun "tmpfs transparent hugepages disabled"
>  pagesize=`getconf PAGE_SIZE`
>  pagesize_kb=$((pagesize / 1024))
>  
> +sysfs-dump() {
> +	for i in "$@"; do
> +		if [ -d "$i" ]; then
> +			for x in "$i/"*; do
> +				test -f "$x" && echo "$x: $(cat "$x")"
> +			done
> +		else
> +			test -f "$i" && echo "$i: $(cat "$i")"
> +		fi
> +	done
> +}
> +
>  echo "settings now: pagesize=${pagesize_kb}KB" >> $seqres.full
>  sysfs-dump /sys/kernel/mm/transparent_hugepage/* >> $seqres.full
>  
> 

