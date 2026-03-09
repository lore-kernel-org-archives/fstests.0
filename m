Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF43A7F4E
	for <fstests@vger.kernel.org>; Mon,  9 Mar 2026 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075119; cv=none; b=dAlNF4nlGtFecmtkwtaD3sGGMyncyFGxHHtZKdKLQdhRxELz2mA2VfNG7Ec257DbbyNF/mD2IlBeEpoq3kKl6SFjs9YzsSwhp7qw5B1qI6T5jas8Usvm9RDpMXwXNLngORcwjiMjPgLxJM+x1LsPVgz6GOHjDCxZM7kcNYJeuNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075119; c=relaxed/simple;
	bh=pfPJGSGwLJpw6e+UV3B4HrX5vEv6FV7uTd+GSbj1eds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLqC+QJz8uvAUe9+v+PBul84h0jRdh7Ew38aIY3YdIoFmFfs9Ncfi9niVW5CC+jJg1l0uaA1shyBaRHvcfu6FAgiEqTGD0yKBX5de1wvB+Cp6OizNhxmpar8pezxowWWwDWbQhuSbREpcalm2NafC26eNw9Avc912/RW+x+6gWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8goawHZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pVw45+nY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8goawHZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pVw45+nY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773075116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25QIYSKQ8RVJbNVeADyj4xqplKGsCB0QVBu3zT5eoAo=;
	b=R8goawHZcY10TxemRIM5Z11WGW/zDbDDZv7LbFby+Odi3N+hWx8M4KQl2vkfti6ABjAPyX
	Y7QdnOD/bDZm6JTeu5lSxtkhEajW93FMKa3e135g0CktzoQpnqrQZgkN6Ggke8iYBeWvWn
	n3UDJ6pMc2KxGq0C5szwjrWD5EjNvUI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-vipszgb9N1-IqadNhF72EA-1; Mon, 09 Mar 2026 12:51:55 -0400
X-MC-Unique: vipszgb9N1-IqadNhF72EA-1
X-Mimecast-MFC-AGG-ID: vipszgb9N1-IqadNhF72EA_1773075114
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae47b3adacso79506745ad.3
        for <fstests@vger.kernel.org>; Mon, 09 Mar 2026 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773075114; x=1773679914; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=25QIYSKQ8RVJbNVeADyj4xqplKGsCB0QVBu3zT5eoAo=;
        b=pVw45+nYUYZIX2cRoIQs1dYngNBVwANh0g7rZE5mcqkLNiZM72ZNgJw9zS5gyG2A8Q
         PIYo2CNZXp+dNRxq15KLjO8wcC/Vv2MADnYHHsIjRVB/JSWxn1l3OuJmgf6JnQCZ3teZ
         b3cHn2iqkSDV3TuE4pbA/fBVxR7eSGxOkxh1IbkWUNXbQ9lUSpV+H5sb4juaTV9oG6RA
         uBefMEb9Zt9wI86XUl4pHK5X2qPpapQnJ9n0oF0dPLuU+yENS52+M0vJem00IXZPQW2y
         bokki4ESu915zMkFKu5TXVAts1Lu2csY2M+METaTcWNl0jWVaRKo91kStGP614ATSSh9
         WsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075114; x=1773679914;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25QIYSKQ8RVJbNVeADyj4xqplKGsCB0QVBu3zT5eoAo=;
        b=XMXCnll8yfA6nQ22UVwKKbcmLVy46/aa4ouunEQsmkbdfkW3B/ylRb7gIXO45+Uk2/
         iOlpIGdVI8ocqYNZsnD+k2Ag11hBP1iJX4W9q1GtfNHm8OGqp5BwcPbjYPA6kAfhuxS9
         VYTzWjeoHFgCw3L9pcFg4yVyRC/C96zph5jx2NKP82OLgI0el/Eeay4x2CMfi9FhZkok
         5hlrb+9HJwCx1pChHBoRLqKx2b6FQ8Q+yB0ONymntE1zBKJ9ETXND3qeMgcL0FDQxKqs
         n/PZX+A2GCsKcGvYt6U5PHJK7Zi7Lr9A/86cMd/RmdUfE4/dprzEt1PBvsjKoaXkh4Ka
         6gig==
X-Forwarded-Encrypted: i=1; AJvYcCXZdRtNrrZCHH4SJe3w4Wz7nI7KERV4/YvfVUZK9blEIDpnMytOe2nHNJkgLiQTVO2Fh4EjA+4y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2mYpNzIJsFlPo4ISPDtkw/GQhojCKWgzVs3tU9J8BFyg8WGvx
	Q9uvxJrO6py58jPKLcf9ukiJjIM7z7+otlP3CyJuR3X2ydbTHC924Kmui3TeQAd4m9NpRdjF8sh
	aR/JV3i9mfIXITCfTC6qZeW4ZSI+0pLuPXnuf9U4nIPWsB4MxIdjrwvuR1hk=
X-Gm-Gg: ATEYQzx+mwC5U0WQcg6ddgn67DapIkJUq8zcazGUq1AosMCiFXCAi7qYXS5imE46Iiz
	R9fLAciXU3RUtVQlADzxKhIetXUDIIepTyA4ygJlbb9NYcjER2NrRVO6NqLrYUV4N+uWerCJvCm
	A/aIJr9zJHlWBx709LFkouMHwHx9DWkVxf++XbPa9RjJIP033VKhAFq18JoZUCOnrlDZnw0tI/U
	pOuP3wasMeIWf6HOMdul2Ge0ldBKRceERRWNr+XiM6S86Gc54M0IlPCk+Z1SEaRvtz5/153YSX/
	jkKgAMWZqXr6sJs8fkLWaxusdY3qHM0fFAcJYzdZAN1n8aYqSHpTI1q3kRTXs7kXyyrl4aDWGeH
	HNGjSlKWLSb+WbsrUobf2Kp2muXrZEMQNLJEtni50/4Qcdg0Dud/XBAuoZ2UDHQ==
X-Received: by 2002:a17:902:e745:b0:2aa:d60c:d48a with SMTP id d9443c01a7336-2ae8241815emr118925395ad.7.1773075114094;
        Mon, 09 Mar 2026 09:51:54 -0700 (PDT)
X-Received: by 2002:a17:902:e745:b0:2aa:d60c:d48a with SMTP id d9443c01a7336-2ae8241815emr118925235ad.7.1773075113658;
        Mon, 09 Mar 2026 09:51:53 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e9b9c6sm137627845ad.29.2026.03.09.09.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:51:53 -0700 (PDT)
Date: Tue, 10 Mar 2026 00:51:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	Hans Holmberg <Hans.Holmberg@wdc.com>,
	Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] fstests: test premature ENOSPC in zoned garbage
 collection
Message-ID: <20260309165148.nxuukjvpizrwawft@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260210111103.265664-1-johannes.thumshirn@wdc.com>
 <20260309153136.taooohkzuc4ov56p@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <f39bb05c-f3ea-439e-8a78-71909ec3ef3e@wdc.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f39bb05c-f3ea-439e-8a78-71909ec3ef3e@wdc.com>

On Mon, Mar 09, 2026 at 03:35:56PM +0000, Johannes Thumshirn wrote:
> On 3/9/26 4:31 PM, Zorro Lang wrote:
> > On Tue, Feb 10, 2026 at 12:11:03PM +0100, Johannes Thumshirn wrote:
> >> This test stresses garbage collection in zoned file systems by
> >> constantly overwriting the same file. It is inspired by a reproducer for
> >> a btrfs bugifx.
> >>
> >> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> >> ---
> >>   tests/generic/783     | 48 +++++++++++++++++++++++++++++++++++++++++++
> >>   tests/generic/783.out |  2 ++
> >>   2 files changed, 50 insertions(+)
> >>   create mode 100755 tests/generic/783
> >>   create mode 100644 tests/generic/783.out
> >>
> >> diff --git a/tests/generic/783 b/tests/generic/783
> >> new file mode 100755
> >> index 000000000000..f996d78803a1
> >> --- /dev/null
> >> +++ b/tests/generic/783
> >> @@ -0,0 +1,48 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (c) 2026 Western Digital Corporation.  All Rights Reserved.
> >> +#
> >> +# FS QA Test 783
> >> +#
> >> +# This test stresses garbage collection in zoned file systems by constantly
> >> +# overwriting the same file. It is inspired by a reproducer for a btrfs bugifx.
> >> +
> >> +. ./common/preamble
> >> +_begin_fstest auto quick zone
> >> +
> >> +. ./common/filter
> >> +
> >> +_require_scratch_size $((16 * 1024 * 1024))
> >> +_require_zoned_device "$SCRATCH_DEV"
> >> +
> >> +# This test requires specific data space usage, skip if we have compression
> >> +# enabled.
> >> +_require_no_compress
> >> +
> >> +if [ "$FSTYP" = btrfs ]; then
> >> +	_fixed_by_kernel_commit XXXXXXXXXXXX \
> >> +		"btrfs: zoned: cap delayed refs metadata reservation to avoid overcommit"
> >> +	_fixed_by_kernel_commit XXXXXXXXXXXX \
> >> +		"btrfs: zoned: move partially zone_unusable block groups to reclaim list"
> >> +	_fixed_by_kernel_commit XXXXXXXXXXXX \
> >> +		"btrfs: zoned: add zone reclaim flush state for DATA space_info"
> > Please rebase to latest for-next branch, then change above "_fixed_by_kernel_commit"
> > to "_fixed_by_fs_commit btrfs ...."
> 
> Sure.
> 
> 
> >> +fi
> >> +
> >> +_scratch_mkfs_sized $((16 * 1024 * 1024 * 1024)) &>>$seqres.full
> >> +_scratch_mount
> >> +
> >> +blocks="$(df -TB 1G $SCRATCH_DEV |\
> >> +	$AWK_PROG -v fstyp="$FSTYP" 'match($2, fstyp) {print $3}')"
> > Wouldn’t it make more sense to get the available size here? And there's a helper
> > _get_available_space in common/rc.
> 
> I'll have a look at it and see if it fits.
> 
> 
> >> +
> >> +loops=$(echo "$blocks * 4 - 2" | bc)
> > Is $blocks a huge number? How about using $((blocks * 4 - 2)) simply?
> >
> > Can you add a comment to explain what's this "blocks * 4 - 2" for?
> Will do.
> >> +
> >> +for (( i = 0; i < $loops; i++)); do
> >> +	dd if=/dev/zero of=$SCRATCH_MNT/test bs=1M count=1024 status=none 2>&1
> > Not sure what's the "2>&1" for.
> It was there before I had status=none, I'll fix it in the next revision.
> >
> > This isn't an append write, right? So we keep writting from 0 to 1G? Can you use a
> > comment to explain why we require 16G sized SCRATCH_DEV ?
> Because of the zoned write constraints? We can't overwrite until the 
> zone is reset.

Oh, this's a zoned storage test, sure, thanks! I think we could add a comment here to
remind readers that this is actually a sequential/append write :)

Thanks,
Zorro

