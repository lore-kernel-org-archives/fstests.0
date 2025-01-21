Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DAC2CAB
	for <fstests@vger.kernel.org>; Tue, 21 Jan 2025 04:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737435448; cv=none; b=i841AbM6jxbrPBtUGbI/5dUnn6+cphPQmDIrfYKibym9zY34bJlqJmP+0k0ewFbPzxGgbyEANQmRs0lqTJ8QtKFCSMfhf/KedTWvDnP4M50/gDhz9FJixNC7qo0vhtQVKZ5S3Y5a//Q6YgUIwI7zn6sen7nfCPkK5RvoSbHnZ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737435448; c=relaxed/simple;
	bh=LzvpGy2HNylNqYLESYhqcy8f4XRjmR0j3QvxMkvSXsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/9g5xo6ayDfyXa6B7t/pImHPLtef8MlBY7C288c6VWiaPLadgczqooeCRCkThwpKNb9bSkaorSrsJ+4JAkMzH8dturdmUbEY5im9vZwSc56b8sLBmYtbo5XXnkOGBFmXbIxd8OH+WBSL7gI6nrlk7xmWb9vXyOaZD5vuZA9USY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=ikATPIqf; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="ikATPIqf"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso9510675a91.1
        for <fstests@vger.kernel.org>; Mon, 20 Jan 2025 20:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1737435446; x=1738040246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NaRd5BEXgLjUdSaPBhNbMRK8odD+++vFhADndLtd+k0=;
        b=ikATPIqf/VBJi2jHsAgiT+Sulg37Hna4OCZSsEWE0OIOu92rHGPEmek89nBozSKxgz
         F89Ezclc2GuT0z9tD5qcdCo95/7OMsyPoF1JT+RUTNDMNrXvUeuc1MRDWxn/YHD+LKP2
         IG+2fW5KbHDJ5kyEFb5pu5hpV+eM8z0bw+39LjzQi/RkF22JA8Uac/AjSvlcTglGkDsB
         u1gwqcEbKloVdljCwiBgz79QkVrl3suEW1V2VdkPco6d949cPUBA1VJprY9CrDBVJhG4
         HhaK5uwDW6+/8XuHzGBqr2FZpedjuUPk2MjYx0NzCOBBaujCKcq8HmGF0FJWms9mnxzO
         EYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737435446; x=1738040246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NaRd5BEXgLjUdSaPBhNbMRK8odD+++vFhADndLtd+k0=;
        b=iQj87iJr6ElLiXeHkdHuEWhJNaLnfgsyDKeuw0/ImG9New1k7s0xb0DXiyzL//Y9yY
         DXytyNm4knDAZuwoN25VwpCLIfOJjkU/Ee4CHeNzCOiZ87nRXJ1xkMZxHzpiDat/cywE
         blYU4mFr5eRSkYA7o/MWHTwd5qTDvXQEojVk1WzvFrNFdkgiATpp+KloccujdAzXwUdK
         lagSXlJrogoSTa8U4UfTq3/FZzB3q7L6IwV94jTr8M7OGCA6jFeiaJlB5qzawrgp67al
         4b78tbFKJkm+7cP3gJ019qU39T3Uba7mnbzfN1FISVGPtDihI7YAaoRvsNMHdTI8dHY0
         SY/g==
X-Forwarded-Encrypted: i=1; AJvYcCWaccblZIKcfSiNEZeVy/wWzhxQUNsG4Kio9q5a38Q31wdDr9aZH9hz8Kqa0nPy6KnNcG/neyS+@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/hUQt2Pt7mr/X/LMdYlIkDm5sQNYhpRdIVDpaP6KrQGXy6t8
	6r5NX6jJ86KRZpR4SaVScu/0jNAPGiG90ik/dAEqx25W74sF20o/evC1Jq7qBXY=
X-Gm-Gg: ASbGncu3hKxzOasNUokM9BSuxjOqQwpSL3ag8wCDouCMiNRwg9UOcvDxIawmoyafIkv
	Ax1zWcXSL99RZn4o8Wb6jTHc1qH4kdbNbyycwQqxgcGOlWg2ebSEeW//rnTCocAuJ1LScHmR6uW
	H7zzMXheAmoS3H2AwGEZisBKTwKz3rargBaoOhjTmbNWV/Hh5ua++ulIRZkGZ/6B4YUV8sT9gX3
	oxct++jV09Av4EbNfY9MAWy2lUqghyWOB9La7CtAAVEjkG35PYyXYYNdLy2I6UREoPawiqf2a66
	Y3PHxKu3s67YUMlF/sOs/tayqlrLOLR3xF0=
X-Google-Smtp-Source: AGHT+IHhUqsc5fp8YYPRrWEpYufjZNCM5fX19GmjtVEHcajApdFhV8lx2dEjw5EYrDkpAuYMz/bKFg==
X-Received: by 2002:a05:6a00:4c87:b0:729:1c0f:b94e with SMTP id d2e1a72fcca58-72db1b6524bmr21997706b3a.6.1737435445976;
        Mon, 20 Jan 2025 20:57:25 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab8155e5sm8098496b3a.54.2025.01.20.20.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 20:57:25 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1ta6KJ-00000008XAi-0E4i;
	Tue, 21 Jan 2025 15:57:23 +1100
Date: Tue, 21 Jan 2025 15:57:23 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, hch@lst.de, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 13/23] generic/650: revert SOAK DURATION changes
Message-ID: <Z48pM9GEhp9P_VLX@dread.disaster.area>
References: <173706974044.1927324.7824600141282028094.stgit@frogsfrogsfrogs>
 <173706974273.1927324.11899201065662863518.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173706974273.1927324.11899201065662863518.stgit@frogsfrogsfrogs>

On Thu, Jan 16, 2025 at 03:28:33PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Prior to commit 8973af00ec21, in the absence of an explicit
> SOAK_DURATION, this test would run 2500 fsstress operations each of ten
> times through the loop body.  On the author's machines, this kept the
> runtime to about 30s total.  Oddly, this was changed to 30s per loop
> body with no specific justification in the middle of an fsstress process
> management change.

I'm pretty sure that was because when you run g/650 on a machine
with 64p, the number of ops performed on the filesystem is
nr_cpus * 2500 * nr_loops.

In that case, each loop was taking over 90s to run, so the overall
runtime was up in the 15-20 minute mark. I wanted to cap the runtime
of each loop to min(nr_ops, SOAK_DURATION) so that it ran in about 5
minutes in the worst case i.e. (nr_loops * SOAK_DURATION).

I probably misunderstood how -n nr_ops vs --duration=30 interact;
I expected it to run until either were exhausted, not for duration
to override nr_ops as implied by this:

> On the author's machine, this explodes the runtime from ~30s to 420s.
> Put things back the way they were.

Yeah, OK, that's exactly waht keep_running() does - duration
overrides nr_ops.

Ok, so keeping or reverting the change will simply make different
people unhappy because of the excessive runtime the test has at
either ends of the CPU count spectrum - what's the best way to go
about providing the desired min(nr_ops, max loop time) behaviour?
Do we simply cap the maximum process count to keep the number of ops
down to something reasonable (e.g. 16), or something else?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
