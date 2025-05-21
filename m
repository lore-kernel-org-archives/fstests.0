Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193FB1A9B4C
	for <fstests@vger.kernel.org>; Wed, 21 May 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747826908; cv=none; b=b3qaiYsVG+V7RZyZOrzXcK3wTBxbgqO2lBSCguAPp2NCzbw2MGnfiMTlguga6hWTczr74ZpMLPcgcQXMRQEekGVr3HIJX0BE4ZYWWhD+OBtADPsi872RCxEDcGXAseQsMkT4vFShpHVZ20A90WpfzSF9RZ33eh9j4R9JMC6MXr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747826908; c=relaxed/simple;
	bh=7O/OBHIZtkrm0idztBmPlZgsTqfarSIIwxePJFDIMrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2YcdJUSur39fW+raNLFSgxKSQmdD/yfgr+LH7VRC+Cz+tZNWq1Hji9endWWrGAp2XokS4uXV+UhV7TD8oXjCdp0iKAPzRcDNeBp11Nd0gskNT0FjqrzVJjCe1xIjds5qjf+YltOAFbgnrQ+MMDP7lNDEc/yFQkhT1FzBDTJxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KqJ97xDN; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KqJ97xDN"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b26f01c638fso4960470a12.1
        for <fstests@vger.kernel.org>; Wed, 21 May 2025 04:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1747826906; x=1748431706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IFZuWVpnu404Wvy2nxtqjeU5OTQiZmQkmAvbu5/+VKs=;
        b=KqJ97xDNC5ElK9PI//aLIzFICGyHGsmUJCFwwqebuOO/BUU05FZrUKhpK7J2nAHkjF
         Vunl+4e20x+VPkkc3ByDs9YGOMyO8vDmcxsqXFLly7j5drfXPebavUgsTw39E80vrdlJ
         +L1Bgp3nKO/4klf5C7K7aQcOF03qwHQLVOUZi4baEyBfHBJpSPdxxZtJWiX/Abgwi9zf
         kF68E3IVQismm6sZTsCJOvrvi+CnGmKRM98KOS9XjTZn9RAzuFnf361UE65HsBRDTwjF
         9UL5mJJfZwEFnbziNZjnOOt0CyQd0P5gEetyr7rKd9+vu950FWKLDCNFOU5Elfa52zNp
         p/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747826906; x=1748431706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFZuWVpnu404Wvy2nxtqjeU5OTQiZmQkmAvbu5/+VKs=;
        b=uVyG/ijGvs5zqTZYVE+iuvN4sQJmHSx7YjkX5syQgVv4kfsADaZKeMwnzFCQNG3zVk
         rkA5jH6zknfLiMuy9ZUaiQQwh8jUAG8RJdrUf2ynSZIOHz5pgEH1TgNhjWu5C6bnmVqa
         FzICYDbfgA6PkVUY26wkULx8x2lCjYwhpR86sImuWgEjaD5OYwFIJKq7UbbUrBTfAXtM
         fm4a8zpW3eMraERwivO1ARNmosbEBqIqiFbbnJvSUsLbBzF8zNXI6V2vlhM57pm9J1Vl
         gXRmPwOYgw/aTjI/6GWkz2m4ZXNKXpvZ5J0BQqaD4mMBS6aeHNw8f/XMTJvi2qAHpAaI
         nQuQ==
X-Gm-Message-State: AOJu0YwdRqkXlt+PFstIBW2lRGy/4B0kRYGRh9Km9SBC/VtYGEdCHkpG
	dzA86HAyL3Zb8qD9xv/DGl3PkcafUOpoYXFjJkGpytgzXK99AMay3VbswfOAB8WuTtw=
X-Gm-Gg: ASbGncv+lMz4Cvrxi4E8rujxc6WSJ+QbneNxtdNgWZ5om+pbPm3VXA8h24235XhfMgA
	urh4jXa1dchqd//8b31j556NkCrX62T3wfT/o31JP/RGe6n5gLYpyFqlhbt347lJ+wN96UDA6l/
	A2mpiHteE/S7mpcPSRZKtoCub11DOQntVgMyibxxi9p3VIYjl694kgdaRK6fhfgosu9f9NI1k++
	CsiqOJ/2lGc1y4RM1CGFYJfRu6UmzOIVILq84XKopvPrAgVsn6XU68FkIdZVMc2MZFqrwbGZa9d
	9x9kv28mL2YaLycI7gHFHI9GV/RRaHD0WtLDCjzRTNax306AqemYGo4Aih4znRQeEzkR3iaYf/z
	QjJ3+4itDnJLbuTJ+cQbuVkzWAxA=
X-Google-Smtp-Source: AGHT+IER0RXq/DJ0Y3y/kpZ5GbzfdbXjUApviDGAxwddib5q5OI39uR5VinD7oxDkRFUN/13n3oeag==
X-Received: by 2002:a17:90b:28c5:b0:2fc:3264:3657 with SMTP id 98e67ed59e1d1-30e7d2ded9bmr37848846a91.0.1747826906346;
        Wed, 21 May 2025 04:28:26 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f364fff8asm3424342a91.39.2025.05.21.04.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 04:28:25 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uHhcV-00000006I0l-2VMS;
	Wed, 21 May 2025 21:28:23 +1000
Date: Wed, 21 May 2025 21:28:23 +1000
From: Dave Chinner <david@fromorbit.com>
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org, ritesh.list@gmail.com
Subject: Re: [PATCH 12/28] config: move config section code to it's own file
Message-ID: <aC24110rvoZY_uQK@dread.disaster.area>
References: <20250417031208.1852171-1-david@fromorbit.com>
 <20250417031208.1852171-13-david@fromorbit.com>
 <6b126bce9ad8bc7cf7f6e0205c905082785ef4c5.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b126bce9ad8bc7cf7f6e0205c905082785ef4c5.camel@linux.ibm.com>

On Fri, May 09, 2025 at 11:39:30AM +0530, Nirjhar Roy wrote:
> On Thu, 2025-04-17 at 13:00 +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > Move the config section parsing, checking and setup code from
> > common/config to common/config-section so that it can be included
> > directly in contexts where the rest of common/config is not needed.
> This looks okay to me. Just a couple of nits comments below.
> 
> Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
....
> > diff --git a/common/config-sections b/common/config-sections
> > new file mode 100644
> > index 000000000..69a03375a
> > --- /dev/null
> > +++ b/common/config-sections
> > @@ -0,0 +1,390 @@
> > +##/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2000-2003,2006 Silicon Graphics, Inc.  All Rights Reserved.
> > +# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# Config section parsing and setup code
> Since we want to facilitate sourcing of this file independently, should
> we at least mention in the comments some of the dependant files this
> file needs to be sourced? For example, this file uses _exit() - so
> usage of this file requires common/exit to be sourced?

The high level code should have already sourced that file.

> > +
> > +_check_device()
> > +{
> > +	local name=$1
> > +	local dev_needed=$2
> > +	local dev=$3
> > +
> > +	if [ -z "$dev" ]; then
> > +		if [ "$dev_needed" == "required" ]; then
> > +			_fatal "common/config: $name is required but not defined!"
> > +		fi
> > +		return 0
> > +	fi
> > +
> > +	if [ -b "$dev" ] || ( echo $dev | grep -qE ":|//" ); then
> > +		# block device or a network url
> > +		return 0
> > +	fi
> > +
> > +	case "$FSTYP" in
> > +	9p|fuse|tmpfs|virtiofs|afs)
> > +		# 9p, fuse, virtiofs and afs mount tags are just plain strings,
> > +		# so anything is allowed tmpfs doesn't use mount source, ignore
> > +		;;
> > +	ceph)
> > +		# ceph has two different possible syntaxes for mount devices. The
> > +		# network URL check above catches the legacy syntax. Check for the
> > +		# new-style syntax here.
> > +		if ( echo $dev | grep -qEv "=/" ); then
> > +			_fatal "common/config: $name ($dev) is not a valid ceph mount string"
> > +		fi
> > +		;;
> > +	overlay)
> > +		if [ ! -d "$dev" ]; then
> > +			_fatal "common/config: $name ($dev) is not a directory for overlay"
> > +		fi
> > +		;;
> > +	ubifs)
> > +		if [ ! -c "$dev" ]; then
> > +			_fatal "common/config: $name ($dev) is not a character device"
> > +		fi
> > +		;;
> > +	ceph-fuse)
> > +		;;
> > +	*)
> > +		_fatal "common/config: $name ($dev) is not a block device or a network filesystem"
> Nit: 80 chars limit exceed.

There are many of these in the code I moved, and there are many,
many lines that exceed 80 columns all through fstests. I don't think
this needs fixing.

Regardless, this patch is moving code from A to B, so I'm trying to
avoid mixing in formatting or bug fixes that would otherwise be
impossible to spot in the diff...

-Dave.

-- 
Dave Chinner
david@fromorbit.com
