Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D844289E21
	for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421542; cv=none; b=bhhMqRytWv+AOkMe2mUe0p48gobIZhO1SVFXaN0ioXGLxJ/sldCjKRgfRxTb+OA8+wkhNayrQMpF/rSCtbklCNaPvr54xQmPQYQMegjiQybeKBBFBHIZ4GwK3JwA/aIN/ESsK0CDdvO4hTkzzc4vXljeKD2bBrS2bjsdjF2l1eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421542; c=relaxed/simple;
	bh=oiMvz9HnuIZd2pEynsCEfl6BMQizdsQ+SWvkLutu7Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9abzhvaO7NPvfcXG1XczNEwhc/phsz1IJw/ZMyOJMJCuHyqUZMNn8FCmBkzM4xMfGC1OoryuP1K8GmP4ltW7/7ZLnrT2NT1gA/2OUUbdUupabY2uNwTXqfkrQeDLVufR+cGovlUPXqITz4PnCSAP49dnY6TEgwS/ohdGDyk5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4AWP+hd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4AWP+hd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750421540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rf5NT5lUUYL5ggTdBq3iuul/phmQD13bkzvoa3a61ZQ=;
	b=U4AWP+hdN9RSL9vMydb6AwJofM27Es8OVipKNqOuqcBKJOp3B83LyDqhP4GUNnEI7PcTTL
	Wjw8N+Kl7HP5xLSa/4TAsqPIl7Ua/YIG/7Gda8pEotC7fxGHT5CkDo8msAOfdVRR0A71Sq
	JGLvTH6gOBdpKFzsCTQVgsH6BN9+8KQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-wi1yLbRtOdW9XvLqyflO7w-1; Fri, 20 Jun 2025 08:12:18 -0400
X-MC-Unique: wi1yLbRtOdW9XvLqyflO7w-1
X-Mimecast-MFC-AGG-ID: wi1yLbRtOdW9XvLqyflO7w_1750421538
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235089528a0so14949235ad.1
        for <fstests@vger.kernel.org>; Fri, 20 Jun 2025 05:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750421537; x=1751026337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rf5NT5lUUYL5ggTdBq3iuul/phmQD13bkzvoa3a61ZQ=;
        b=gCGktnSp18hJf5SQFbUzXZu8eCDLuNA5vUsfWMJ2Ep2mrNTMmCenfdX1q8AJBT7h8N
         bwgjX+o2OOTWn46EDqxGhNBVWfMBHRJD2esYpkI0qlQ22QABgWkv39bNtg8UIZsejW7t
         EPMMErw21JKvFrDBou9THMgdVAjwBoDACPnt3D+GtXUsY5iczYDcfnAFguVB0D4GikcE
         XBSiPcIbfJKfqtkTuYkPTCG4Deo6m5b2UM7wIm+2QsrmQJaWu+MecKRq/8PsHcQFsVM5
         Y+BB0VrqcWWJJ5CjcVwoTd+e6uZliyXw/KPA9dnNrP9ZLx+5gsMDGwpd+5zgnuwJkuxi
         aUoQ==
X-Gm-Message-State: AOJu0YzJlW//Hjm/K/DXSJ/tuX7tRm1/d1p6WW4OkA8nDU2i5vZ1OL6D
	cs8F97Gq0MN1W2RWyvKR3sJTlOGrMaNv3EWWtg8YObhyDv7uEePaOY12+GW6oKxs4FtokHIY5NH
	z6Wwm9CAChf0W8wWqyaVEzxASGcX9pwr+HNNDC7FT1QKyzDDmrbUj0e754YtTgFBBydE=
X-Gm-Gg: ASbGncuS33eLYetgMdMLSalnV39WJMJDmcL540QipYshbpOH7bnggRyfyg+YewTmS1O
	gZ8WIQAEPVly0E8Wj6zts964FrivYSrtRqUZov2hXFp8aC5QvotsSzyC3iulNiVXdDgeDSMGs1D
	3QLDU9BAD7vqmPkoEAkjzUV6Lx8P/vP84A1d2BEAOX5VhkbvT+bR3kg0/FO3H2gTYI6Lsjkurf1
	wHBJ3+aInOcxSyPqm6G54KG6aMS4ofmqM6vp0xo9CFrc3i2PHY1/1diomYgrL1YTbvsrl7wD54i
	yH6X8Azg9by3spsZktQARSS2/Nab1wOpJ2ZMy/9gique66ppzUXB3v2/y6o3gvs=
X-Received: by 2002:a17:902:e78d:b0:221:1497:7b08 with SMTP id d9443c01a7336-237db0ff584mr40059295ad.23.1750421537450;
        Fri, 20 Jun 2025 05:12:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbAf0RscxI5FGm4GANNMSFKituD19q2SVlKlakAz0teG0Ntz2gm9UW6NLC6y3pT8SapyRQMg==
X-Received: by 2002:a17:902:e78d:b0:221:1497:7b08 with SMTP id d9443c01a7336-237db0ff584mr40058905ad.23.1750421537049;
        Fri, 20 Jun 2025 05:12:17 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83f1e1fsm17187225ad.83.2025.06.20.05.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 05:12:16 -0700 (PDT)
Date: Fri, 20 Jun 2025 20:12:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 06/12] generic/770: Add atomic write multi-fsblock
 O_[D]SYNC tests
Message-ID: <20250620121211.k6hbsa73m2vvupx2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <5503061a800eaff9fc182e68c3030c1ef07410f3.1749629233.git.ojaswin@linux.ibm.com>
 <20250618201711.2d6xuv6pztoj4pbn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aFUZwtzedj1EuqmF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFUZwtzedj1EuqmF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Fri, Jun 20, 2025 at 01:50:18PM +0530, Ojaswin Mujoo wrote:
> On Thu, Jun 19, 2025 at 04:17:11AM +0800, Zorro Lang wrote:
> > On Wed, Jun 11, 2025 at 03:04:49PM +0530, Ojaswin Mujoo wrote:
> > > This adds various atomic write multi-fsblock stresst tests
> > > with mixed mappings and O_SYNC, to ensure the data and metadata
> > > is atomically persisted even if there is a shutdown.
> > > 
> > > Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > ---
> > >  tests/generic/770     | 161 ++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/770.out |   2 +
> > >  2 files changed, 163 insertions(+)
> > >  create mode 100755 tests/generic/770
> > >  create mode 100644 tests/generic/770.out
> > > 
> > > diff --git a/tests/generic/770 b/tests/generic/770
> > > new file mode 100755
> > > index 00000000..2b98b3b3
> > > --- /dev/null
> > > +++ b/tests/generic/770
> > > @@ -0,0 +1,161 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > > +#
> > > +# FS QA Test 770
> > > +#
> > > +# Atomic write multi-fsblock data integrity tests with mixed mappings
> > > +# and O_SYNC
> > > +#
> > > +. ./common/preamble
> > > +. ./common/atomicwrites
> > > +_begin_fstest auto quick rw atomicwrites
> > > +
> > > +_require_scratch_write_atomic_multi_fsblock
> > > +_require_atomic_write_test_commands
> > > +
> 
> <snip>
> 
> > > +			"U")
> > > +				$XFS_IO_PROG -c "falloc $off $blksz" $testfile >> /dev/null
> > 
> > _require_xfs_io_command falloc
> > 
> > > +				;;
> > > +		esac
> > > +		off=$((off + blksz))
> > > +	done
> > > +
> > > +	echo "Mixed mapping preparation complete. Full mapping pattern: $mapping" >> $seqres.full
> > > +
> > > +	sync $testfile
> > > +
> > > +	echo "Performing O_DSYNC atomic write over the entire $awu_max region" >> $seqres.full
> > > +	bytes_written=$($XFS_IO_PROG -dc "pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
> > 
> > _require_xfs_io_command pwrite -A
> 
> Hey Zorro,
> 
> pwrite -A and falloc command are already checked for in
> _require_atomic_write_test_commands helper used on top.

Oh, sure, sorry I didn't notice that :)

Thanks,
Zorro

